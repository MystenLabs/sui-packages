module 0x7e1affb0f1b07585e41f1580ad78c81c71553495a12dfbec0b96db3218d2e9bd::nsui {
    struct NSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSUI>(arg0, 6, b"nSUI", b"First Nigga To Launch", b"FIRST NIGGA TO LAUNCH ON HOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmWCKj4rcA3wktrD2dJ6edJBmGhvBSAxhjDsqvDbZ7FefK")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<NSUI>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<NSUI>(14253763226777170345, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

