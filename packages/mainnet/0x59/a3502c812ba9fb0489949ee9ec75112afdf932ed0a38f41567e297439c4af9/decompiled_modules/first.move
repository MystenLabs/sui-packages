module 0x59a3502c812ba9fb0489949ee9ec75112afdf932ed0a38f41567e297439c4af9::first {
    struct FIRST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRST>(arg0, 6, b"FIRST", b"The First", b"The first of its kind. The creator of all. The first SUI coin made.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmUNzFRPW4z3yzPS1A2KX6QdEZz27GN4aH3cQZoGSvxgAA")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<FIRST>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<FIRST>(7993126799566558258, v0, v1, 0x1::string::utf8(b"https://x.com/TheFUmoneyclub"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

