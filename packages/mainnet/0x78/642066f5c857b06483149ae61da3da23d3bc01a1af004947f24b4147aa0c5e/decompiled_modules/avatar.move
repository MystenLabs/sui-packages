module 0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::avatar {
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

