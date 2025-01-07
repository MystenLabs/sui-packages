module 0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::gift {
    struct Gift has copy, drop, store {
        gift: 0x1::string::String,
    }

    public fun get_gift(arg0: &Gift) : 0x1::string::String {
        arg0.gift
    }

    public entry fun new_gift(arg0: 0x1::string::String) : Gift {
        Gift{gift: arg0}
    }

    public entry fun none() : Gift {
        Gift{gift: 0x1::string::utf8(b"")}
    }

    // decompiled from Move bytecode v6
}

