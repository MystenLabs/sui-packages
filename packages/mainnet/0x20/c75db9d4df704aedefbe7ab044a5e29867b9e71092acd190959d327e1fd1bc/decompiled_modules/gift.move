module 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::gift {
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

