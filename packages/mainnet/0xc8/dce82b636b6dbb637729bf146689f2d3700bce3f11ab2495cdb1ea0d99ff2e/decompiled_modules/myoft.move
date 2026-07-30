module 0xc8dce82b636b6dbb637729bf146689f2d3700bce3f11ab2495cdb1ea0d99ff2e::myoft {
    struct MYOFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYOFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYOFT>(arg0, 8, b"TestFBTC", b"TestFBTC", b"TestFBTC omnichain OFT", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYOFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYOFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

