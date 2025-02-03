module 0xdae8d3692ee83d84eef0869c061825300dbd217f00c800580741dd9493190725::ol {
    struct Ol has store, key {
        id: 0x2::object::UID,
        children: vector<0x2::object::ID>,
    }

    public fun add_child(arg0: 0xdae8d3692ee83d84eef0869c061825300dbd217f00c800580741dd9493190725::li::Li, arg1: &mut Ol) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.children, 0xdae8d3692ee83d84eef0869c061825300dbd217f00c800580741dd9493190725::li::id(&arg0));
        0x2::transfer::public_transfer<0xdae8d3692ee83d84eef0869c061825300dbd217f00c800580741dd9493190725::li::Li>(arg0, 0x2::object::uid_to_address(&arg1.id));
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Ol {
        Ol{
            id       : 0x2::object::new(arg0),
            children : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    // decompiled from Move bytecode v6
}

