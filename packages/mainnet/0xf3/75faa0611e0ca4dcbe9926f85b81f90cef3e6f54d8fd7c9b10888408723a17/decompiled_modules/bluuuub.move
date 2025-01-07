module 0xf375faa0611e0ca4dcbe9926f85b81f90cef3e6f54d8fd7c9b10888408723a17::bluuuub {
    struct BLUUUUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUUUUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUUUUB>(arg0, 6, b"BLUUUUB", b"BLUUUB", b"BLUUUUUB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmcY3e7vh8uMbZrjHG9whKw22vHuAntgSFDMkUaJhm4ptU")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<BLUUUUB>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<BLUUUUB>(11601568996295318252, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

