module 0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::race {
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

