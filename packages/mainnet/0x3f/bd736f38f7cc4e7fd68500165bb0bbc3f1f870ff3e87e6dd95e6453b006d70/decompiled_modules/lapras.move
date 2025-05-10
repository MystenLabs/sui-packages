module 0x3fbd736f38f7cc4e7fd68500165bb0bbc3f1f870ff3e87e6dd95e6453b006d70::lapras {
    struct LAPRAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAPRAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAPRAS>(arg0, 6, b"Lapras", b"Lapras on sui", b"Here to protect SUI with my water gun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie5jk5yyaurmpcohezxvksmh4v2wtbl4k5m7zffzexgahc4ntany4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAPRAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAPRAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

