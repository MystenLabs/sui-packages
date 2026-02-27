module 0x582099c773c962b78729f319a29bf4f803fb1d67724271aadfbe8e10486c6f1::itoft {
    struct ITOFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITOFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITOFT>(arg0, 6, b"ITOFT", b"ItsTimeToOFT", b"Omnichain token deployed via LayerZero V2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ITOFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITOFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

