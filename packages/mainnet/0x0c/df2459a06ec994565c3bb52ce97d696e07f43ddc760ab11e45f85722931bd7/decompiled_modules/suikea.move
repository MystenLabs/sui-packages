module 0xcdf2459a06ec994565c3bb52ce97d696e07f43ddc760ab11e45f85722931bd7::suikea {
    struct SUIKEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEA>(arg0, 6, b"SUIKEA", b"Suikea", b"OPENING $SUIKEA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suikea_aadbb95346.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

