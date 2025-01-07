module 0x25a5067fe76bd40c6cd2f7ba2a04d45477cf7a49e375e80def752ce125e624fd::lfog {
    struct LFOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFOG>(arg0, 6, b"LFOG", b"Light Dog", b"Light on the Innu Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmXy5wRB1PFZqGBJCigqXdww5izCsU6DG2AuUdqJds4m7R")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<LFOG>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<LFOG>(5116612950181085040, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

