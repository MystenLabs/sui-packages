module 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::memo {
    public fun donate() : 0x1::string::String {
        0x1::string::utf8(b"cdp_donate")
    }

    public fun interest() : 0x1::string::String {
        0x1::string::utf8(b"cdp_interest")
    }

    public fun liquidate() : 0x1::string::String {
        0x1::string::utf8(b"cdp_liquidate")
    }

    public fun manage() : 0x1::string::String {
        0x1::string::utf8(b"cdp_manage")
    }

    // decompiled from Move bytecode v6
}

