module 0x7db2d08896f064c8abac8cab1c06df82e8b939a85e89bded6b8031754d4601e5::avatar {
    struct Avatar has copy, drop, store {
        url: 0x1::string::String,
    }

    public fun get_icon(arg0: &Avatar) : 0x1::string::String {
        arg0.url
    }

    public fun new_icon(arg0: 0x1::string::String) : Avatar {
        Avatar{url: arg0}
    }

    public fun none() : Avatar {
        Avatar{url: 0x1::string::utf8(b"")}
    }

    public fun set_icon(arg0: &mut Avatar, arg1: 0x1::string::String) {
        arg0.url = arg1;
    }

    // decompiled from Move bytecode v6
}

