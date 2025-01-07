module 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::avatar {
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

