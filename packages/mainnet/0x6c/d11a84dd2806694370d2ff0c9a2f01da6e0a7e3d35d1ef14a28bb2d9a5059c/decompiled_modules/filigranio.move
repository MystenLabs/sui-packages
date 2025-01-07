module 0x6cd11a84dd2806694370d2ff0c9a2f01da6e0a7e3d35d1ef14a28bb2d9a5059c::filigranio {
    struct FILIGRANIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FILIGRANIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FILIGRANIO>(arg0, 6, b"FILIGRANIO", b"FILIGRANIO", b"FILIGRANIO FOR THE CULTURE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmZP4hHqtgp37qrmcv5tPPAcBS4Mef9siLv6KxpQtMBtB8")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<FILIGRANIO>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<FILIGRANIO>(14328416903393577495, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

