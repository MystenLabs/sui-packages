module 0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::gift {
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

