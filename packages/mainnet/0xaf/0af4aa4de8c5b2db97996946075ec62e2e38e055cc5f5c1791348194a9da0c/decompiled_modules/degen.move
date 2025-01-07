module 0xaf0af4aa4de8c5b2db97996946075ec62e2e38e055cc5f5c1791348194a9da0c::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 6, b"$Degen", b"Sui degen Apes", b"Degen Apes wanting to degen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmYeV5vyP5ePiWtDZAZWY2dUHBY3qc1FXtETUArGhY5uYi")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<DEGEN>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<DEGEN>(2320613859358741038, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://degenapes.io"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

