module 0x398e363d2b93ecb615ca36687657d71bd5cb590b5ebd6c3033ad6956a62b1ca4::aave {
    struct AAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAVE>(arg0, 8, b"AAVE", b"Aave", b"ZO Virtual Coin for Aave", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAVE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AAVE>>(v0);
    }

    // decompiled from Move bytecode v6
}

