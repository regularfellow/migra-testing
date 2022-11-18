CREATE OR REPLACE FUNCTION notify()
RETURNS trigger AS $$
BEGIN
    PERFORM pg_notify('notify', 'message');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
