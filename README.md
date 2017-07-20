# activerecord-import-oracle_enhanced

activerecord-import-oracle_enhanced is an extension for activerecord-import to provide support for the activerecord-oracle_enhanced-adapter.

It uses Oracle multitable insert and assumes that you have a DML trigger setup for the targeting table before inserting.

## DML Trigger

Since Oracle needs to prefetch the primary key and a call to `<sequence_name>.nextval` will always return the same value in an INSERT ALL statement. Consequently, if you want to properly use this gem and bulk insert data into tables which have a primary key without providing said key, you have to create a DML trigger which fires before inserting a row into your table and setting your primary key if it is not set. Such a trigger could be written as such (replacing `<table_name>` and `<sequence_name>` with the proper values) :

```sql
CREATE OR REPLACE trigger <table_name>_trg
    before insert on <table_name>
    for each row
BEGIN
    IF :new.id IS NULL THEN :new.id := <sequence_name>.nextval;
    END IF;
END;
/
```

Bear in mind that you have to respect Oracle limitations of 30 characters for the trigger name.

## License

Copyright (c) 2017 Félix Bellanger <felix.bellanger@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.