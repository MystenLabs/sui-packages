module 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::metadata {
    struct Metadata has copy, drop, store {
        link: 0x1::option::Option<0x1::string::String>,
        image_url: 0x1::option::Option<0x1::string::String>,
        description: 0x1::option::Option<0x1::string::String>,
        project_url: 0x1::option::Option<0x1::string::String>,
        creator: 0x1::option::Option<0x1::string::String>,
    }

    public fun creator(arg0: &Metadata) : 0x1::option::Option<0x1::string::String> {
        arg0.creator
    }

    public fun description(arg0: &Metadata) : 0x1::option::Option<0x1::string::String> {
        arg0.description
    }

    public fun image_url(arg0: &Metadata) : 0x1::option::Option<0x1::string::String> {
        arg0.image_url
    }

    public fun link(arg0: &Metadata) : 0x1::option::Option<0x1::string::String> {
        arg0.link
    }

    public fun new_metadata(arg0: 0x1::option::Option<0x1::string::String>, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>) : Metadata {
        Metadata{
            link        : arg0,
            image_url   : arg1,
            description : arg2,
            project_url : arg3,
            creator     : arg4,
        }
    }

    public fun project_url(arg0: &Metadata) : 0x1::option::Option<0x1::string::String> {
        arg0.project_url
    }

    public fun set_creator(arg0: &mut Metadata, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.creator = arg1;
    }

    public fun set_description(arg0: &mut Metadata, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.description = arg1;
    }

    public fun set_image_url(arg0: &mut Metadata, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.image_url = arg1;
    }

    public fun set_link(arg0: &mut Metadata, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.link = arg1;
    }

    public fun set_project_url(arg0: &mut Metadata, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.project_url = arg1;
    }

    // decompiled from Move bytecode v6
}

