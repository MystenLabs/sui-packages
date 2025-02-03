module 0x1ca4b2d8aeec2ef031090525cf12aa2332c9b647af1ceae65a22af3e770222fa::race {
    struct Race has copy, drop, store {
        category: 0x1::string::String,
        desc: 0x1::string::String,
    }

    public fun category(arg0: &Race) : 0x1::string::String {
        arg0.category
    }

    public fun none() : Race {
        Race{
            category : 0x1::string::utf8(b""),
            desc     : 0x1::string::utf8(b""),
        }
    }

    // decompiled from Move bytecode v6
}

