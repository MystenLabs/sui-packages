module 0x7d2cee2123591cc8d4f49ab0dbfb17c3250113fbc32367974a4df5474082cac7::pplapras {
    struct PPLAPRAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPLAPRAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPLAPRAS>(arg0, 6, b"Pplapras", b"Lapras on sui", b"Here to protect SUI with my water gun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie5jk5yyaurmpcohezxvksmh4v2wtbl4k5m7zffzexgahc4ntany4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPLAPRAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PPLAPRAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

