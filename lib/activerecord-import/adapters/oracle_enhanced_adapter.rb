module ActiveRecord::Import::OracleEnhancedAdapter
  include ActiveRecord::Import::ImportSupport

  def insert_many( sql, values, options = {}, *args ) # :nodoc:
    number_of_inserts = 0

    base_sql, post_sql = if sql.is_a?( String )
      [sql, '']
    elsif sql.is_a?( Array )
      [sql.shift, sql.join( ' ' )]
    end

    # Tweak base_sql
    base_sql.gsub!(/VALUES /, '')

    value_sets = ::ActiveRecord::Import::ValueSetsRecordsParser.parse(values,
      max_records: max_allowed_packet)

    transaction(requires_new: true) do
      value_sets.each do |value_set|
        number_of_inserts += 1
        sql2insert = base_sql + value_set.map { |values| "SELECT #{values[1..-2]} FROM DUAL" }.join( ' ' ) + post_sql
        insert( sql2insert, *args )
      end
    end

    ActiveRecord::Import::Result.new([], number_of_inserts, [], [])
  end

  def next_value_for_sequence(sequence_name)
    %{NULL}
  end

  def max_allowed_packet
    1000
  end
end
