module 0x7f6970239a70e5668f34613be3972a4f7f643947fa05c88ec53f062839b393e4::summon {
    struct SUMMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMMON>(arg0, 6, b"SUMMON", b"Summon Fun", b"Just Summon It.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibojqkgrx66swzlcuirnq67bboj627y2uvn2keypf5tbcob474j3u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUMMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

