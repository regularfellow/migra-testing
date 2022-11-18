### Create database and separate user
```
psql -U postgres -h localhost -c "CREATE DATABASE testdb;"
psql -U postgres -h localhost -c "CREATE ROLE testuser WITH LOGIN PASSWORD 'testuser';"
psql -U postgres -h localhost -c "GRANT ALL PRIVILEGES ON DATABASE testdb TO testuser;"
psql -U postgres -h localhost -c "CREATE ROLE testsuper WITH SUPERUSER LOGIN PASSWORD 'testsuper';"
```

### Add functions
```
psql -U postgres -h localhost -f schema.sql testdb
```

### Does not find changes
```
migra postgresql://postgres:postgres@localhost:5432/testdb postgresql://postgres:postgres@localhost:5432/testdb
migra postgresql://postgres:postgres@localhost:5432/testdb postgresql://testsuper:testsuper@localhost:5432/testdb
```

### Finds changes
```
migra postgresql://postgres:postgres@localhost:5432/testdb postgresql://testuser:testuser@localhost:5432/testdb
```

### Log
```
vscode ➜ /testing $ psql -U postgres -h localhost -c "CREATE DATABASE testdb;"
CREATE DATABASE
vscode ➜ /testing $ psql -U postgres -h localhost -c "CREATE ROLE testuser WITH LOGIN PASSWORD 'testuser';"
CREATE ROLE
vscode ➜ /testing $ psql -U postgres -h localhost -c "GRANT ALL PRIVILEGES ON DATABASE testdb TO testuser;"
GRANT
vscode ➜ /testing $ psql -U postgres -h localhost -c "CREATE ROLE testsuper WITH SUPERUSER LOGIN PASSWORD 'testsuper';"
CREATE ROLE
vscode ➜ /testing $ psql -U postgres -h localhost -f schema.sql testdb
CREATE FUNCTION
vscode ➜ /testing $ migra postgresql://postgres:postgres@localhost:5432/testdb postgresql://postgres:postgres@localhost:5432/testdb
vscode ➜ /testing $ migra postgresql://postgres:postgres@localhost:5432/testdb postgresql://testsuper:testsuper@localhost:5432/testdb
vscode ➜ /testing $ migra postgresql://postgres:postgres@localhost:5432/testdb postgresql://testuser:testuser@localhost:5432/testdb
set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.notify()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    PERFORM pg_notify('notify', 'message');
    RETURN NEW;
END;
$function$
;
```
