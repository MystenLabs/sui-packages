module 0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::avatar {
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

