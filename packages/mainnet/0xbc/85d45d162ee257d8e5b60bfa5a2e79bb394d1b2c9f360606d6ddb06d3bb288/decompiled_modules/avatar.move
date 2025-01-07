module 0xbc85d45d162ee257d8e5b60bfa5a2e79bb394d1b2c9f360606d6ddb06d3bb288::avatar {
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

