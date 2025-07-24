module 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::node_metadata {
    struct NodeMetadata has copy, drop, store {
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        description: 0x1::string::String,
        extra_fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun default() : NodeMetadata {
        NodeMetadata{
            image_url    : 0x1::string::utf8(b""),
            project_url  : 0x1::string::utf8(b""),
            description  : 0x1::string::utf8(b""),
            extra_fields : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public fun description(arg0: &NodeMetadata) : 0x1::string::String {
        arg0.description
    }

    public fun extra_fields(arg0: &NodeMetadata) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.extra_fields
    }

    public fun image_url(arg0: &NodeMetadata) : 0x1::string::String {
        arg0.image_url
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : NodeMetadata {
        NodeMetadata{
            image_url    : arg0,
            project_url  : arg1,
            description  : arg2,
            extra_fields : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public fun project_url(arg0: &NodeMetadata) : 0x1::string::String {
        arg0.project_url
    }

    public fun set_description(arg0: &mut NodeMetadata, arg1: 0x1::string::String) {
        arg0.description = arg1;
    }

    public fun set_extra_fields(arg0: &mut NodeMetadata, arg1: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        arg0.extra_fields = arg1;
    }

    public fun set_image_url(arg0: &mut NodeMetadata, arg1: 0x1::string::String) {
        arg0.image_url = arg1;
    }

    public fun set_project_url(arg0: &mut NodeMetadata, arg1: 0x1::string::String) {
        arg0.project_url = arg1;
    }

    // decompiled from Move bytecode v6
}

