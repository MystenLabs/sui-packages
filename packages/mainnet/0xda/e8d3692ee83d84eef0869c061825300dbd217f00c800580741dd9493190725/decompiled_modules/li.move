module 0xdae8d3692ee83d84eef0869c061825300dbd217f00c800580741dd9493190725::li {
    struct Li has store, key {
        id: 0x2::object::UID,
        content: 0x1::string::String,
    }

    public(friend) fun id(arg0: &Li) : 0x2::object::ID {
        0x2::object::id<Li>(arg0)
    }

    public fun create(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Li {
        Li{
            id      : 0x2::object::new(arg1),
            content : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

