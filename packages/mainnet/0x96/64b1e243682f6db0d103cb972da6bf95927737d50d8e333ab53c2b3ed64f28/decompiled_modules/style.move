module 0x9664b1e243682f6db0d103cb972da6bf95927737d50d8e333ab53c2b3ed64f28::style {
    struct Style has copy, drop, store {
        background_color: 0x1::string::String,
        title_color: 0x1::string::String,
        package_color: 0x1::string::String,
    }

    public fun default() : Style {
        new(0x1::string::utf8(b"CDE7FF"), 0x1::string::utf8(b"000f1c"), 0x1::string::utf8(b"00427f"))
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : Style {
        Style{
            background_color : arg0,
            title_color      : arg1,
            package_color    : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

