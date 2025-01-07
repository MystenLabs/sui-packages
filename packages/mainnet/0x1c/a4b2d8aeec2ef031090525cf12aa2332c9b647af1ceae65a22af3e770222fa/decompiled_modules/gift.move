module 0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::gift {
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

