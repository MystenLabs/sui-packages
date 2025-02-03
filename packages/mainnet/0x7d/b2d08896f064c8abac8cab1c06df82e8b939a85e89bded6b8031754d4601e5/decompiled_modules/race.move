module 0x7db2d08896f064c8abac8cab1c06df82e8b939a85e89bded6b8031754d4601e5::race {
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

