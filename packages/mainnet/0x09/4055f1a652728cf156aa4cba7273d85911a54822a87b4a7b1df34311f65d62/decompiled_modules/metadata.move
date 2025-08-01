module 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::metadata {
    struct Metadata has copy, drop, store {
        description: 0x1::option::Option<0x1::string::String>,
        tags: 0x1::option::Option<vector<0x1::string::String>>,
        data_type: 0x1::string::String,
        data_size: u64,
        data_count: u64,
        creator: 0x1::option::Option<0x1::string::String>,
        license: 0x1::option::Option<0x1::string::String>,
    }

    public fun creator(arg0: &Metadata) : 0x1::option::Option<0x1::string::String> {
        arg0.creator
    }

    public fun data_count(arg0: &Metadata) : u64 {
        arg0.data_count
    }

    public fun data_size(arg0: &Metadata) : u64 {
        arg0.data_size
    }

    public fun data_type(arg0: &Metadata) : 0x1::string::String {
        arg0.data_type
    }

    public fun description(arg0: &Metadata) : 0x1::option::Option<0x1::string::String> {
        arg0.description
    }

    public fun license(arg0: &Metadata) : 0x1::option::Option<0x1::string::String> {
        arg0.license
    }

    public fun new_metadata(arg0: 0x1::option::Option<0x1::string::String>, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<vector<0x1::string::String>>) : Metadata {
        Metadata{
            description : arg0,
            tags        : arg6,
            data_type   : arg1,
            data_size   : arg2,
            data_count  : arg3,
            creator     : arg4,
            license     : arg5,
        }
    }

    public fun set_creator(arg0: &mut Metadata, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.creator = arg1;
    }

    public fun set_data_size(arg0: &mut Metadata, arg1: u64) {
        arg0.data_size = arg1;
    }

    public fun set_data_type(arg0: &mut Metadata, arg1: 0x1::string::String) {
        arg0.data_type = arg1;
    }

    public fun set_description(arg0: &mut Metadata, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.description = arg1;
    }

    public fun set_license(arg0: &mut Metadata, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.license = arg1;
    }

    public fun set_tags(arg0: &mut Metadata, arg1: 0x1::option::Option<vector<0x1::string::String>>) {
        arg0.tags = arg1;
    }

    public fun tags(arg0: &Metadata) : 0x1::option::Option<vector<0x1::string::String>> {
        arg0.tags
    }

    // decompiled from Move bytecode v6
}

