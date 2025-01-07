module 0x93024aeaabac6f4144f0eb6956768decfa0619d8459057db7de2b0369f4698d0::ocean {
    struct OCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEAN>(arg0, 6, b"OCEAN", b"DEEP OCEAN", b"DEEP OCEAN is the official color of the SUI blockchain logo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmR3XipksKVPboVVBCsGp29BVm3ieXZCNaDjhMXCiMEUTA")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<OCEAN>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<OCEAN>(3430564705359107859, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://sui.io/media-kit"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

