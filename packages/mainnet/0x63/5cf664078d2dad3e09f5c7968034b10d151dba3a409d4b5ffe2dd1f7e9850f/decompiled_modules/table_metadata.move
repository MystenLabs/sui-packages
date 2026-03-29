module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::table_metadata {
    struct TableMetadata has store {
        type_: 0x1::ascii::String,
        key_schemas: vector<0x1::ascii::String>,
        key_names: vector<0x1::ascii::String>,
        value_schemas: vector<0x1::ascii::String>,
        value_names: vector<0x1::ascii::String>,
        offchain: bool,
    }

    public fun get_key_names(arg0: &TableMetadata) : vector<0x1::ascii::String> {
        arg0.key_names
    }

    public fun get_key_schemas(arg0: &TableMetadata) : vector<0x1::ascii::String> {
        arg0.key_schemas
    }

    public fun get_offchain(arg0: &TableMetadata) : bool {
        arg0.offchain
    }

    public fun get_type_(arg0: &TableMetadata) : 0x1::ascii::String {
        arg0.type_
    }

    public fun get_value_names(arg0: &TableMetadata) : vector<0x1::ascii::String> {
        arg0.value_names
    }

    public fun get_value_schemas(arg0: &TableMetadata) : vector<0x1::ascii::String> {
        arg0.value_schemas
    }

    public fun new(arg0: 0x1::ascii::String, arg1: vector<0x1::ascii::String>, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: bool) : TableMetadata {
        TableMetadata{
            type_         : arg0,
            key_schemas   : arg1,
            key_names     : arg2,
            value_schemas : arg3,
            value_names   : arg4,
            offchain      : arg5,
        }
    }

    public(friend) fun set_key_names(arg0: &mut TableMetadata, arg1: vector<0x1::ascii::String>) {
        arg0.key_names = arg1;
    }

    public(friend) fun set_key_schemas(arg0: &mut TableMetadata, arg1: vector<0x1::ascii::String>) {
        arg0.key_schemas = arg1;
    }

    public(friend) fun set_offchain(arg0: &mut TableMetadata, arg1: bool) {
        arg0.offchain = arg1;
    }

    public(friend) fun set_type_(arg0: &mut TableMetadata, arg1: 0x1::ascii::String) {
        arg0.type_ = arg1;
    }

    public(friend) fun set_value_names(arg0: &mut TableMetadata, arg1: vector<0x1::ascii::String>) {
        arg0.value_names = arg1;
    }

    public(friend) fun set_value_schemas(arg0: &mut TableMetadata, arg1: vector<0x1::ascii::String>) {
        arg0.value_schemas = arg1;
    }

    // decompiled from Move bytecode v6
}

