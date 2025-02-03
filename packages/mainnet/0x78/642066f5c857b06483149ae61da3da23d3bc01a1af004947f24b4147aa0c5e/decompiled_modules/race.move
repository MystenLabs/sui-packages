module 0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::race {
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

