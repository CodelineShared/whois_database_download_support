src_root_dir="$1"
tld="$2"
version="$3"
db_username="$4"
db_password="$5"

if [ ! -d "$src_root_dir" ]; then
    echo "src_root_dir $src_root_dir is not valid"
    exit
fi
if [ -z "$tld" ]; then
    echo "tld is missing"
    exit
fi
if [ -z "$version" ]; then
    echo "version is missing"
    exit
fi

schema_file="$src_root_dir/$tld/whoiscrawler_"$version"_$tld"_mysql_schema.sql.gz
schema_file2="$src_root_dir/$tld/whoiscrawler_$tld"_mysql_schema.sql.gz

if [ ! -f "$schema_file" ] && [ ! -f "$schema_file2" ]; then
    echo "invalid schema file $schema_file";
    exit
fi
tables_dir=$src_root_dir/$tld/tables

if [ ! -d "$tables_dir" ]; then
    echo "no valid tables dir $tables_dir"
    exit
fi
db=whoiscrawler_$version"_$tld"
if [ ! -f "$schema_file" ]; then
    schema_file=$schema_file2
fi
if [ ! -f "$dump_file" ]; then
    dump_file="$dump_file2"
fi
./load_mysql_data_per_tables.sh $schema_file $tables_dir $db $db_username $db_password