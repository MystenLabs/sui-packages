module 0xc500f9888f6fbb46f220ab5b8c7f79b22f20b9de7711ecfadcb04fd3282d4307::suime {
    struct SUIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIME>(arg0, 6, b"SUIME", b"SUIMeme on Sui", b"SUIMEME on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihkpwnz2ggroaqpdravf2xl4jfe5ly652oxeep3sjkqhzwszsmqqm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

