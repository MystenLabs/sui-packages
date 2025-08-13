module 0x5d2e89f081d4ac7877a1760049271500f2c368c9c0ae953580b38c2e4a65a877::summon {
    struct SUMMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMMON>(arg0, 6, b"SUMMON", b"Summon Fun", b"Summon It", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibojqkgrx66swzlcuirnq67bboj627y2uvn2keypf5tbcob474j3u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUMMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

