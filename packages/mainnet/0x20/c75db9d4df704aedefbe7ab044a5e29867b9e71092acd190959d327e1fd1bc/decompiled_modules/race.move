module 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::race {
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

