module 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::gift {
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

