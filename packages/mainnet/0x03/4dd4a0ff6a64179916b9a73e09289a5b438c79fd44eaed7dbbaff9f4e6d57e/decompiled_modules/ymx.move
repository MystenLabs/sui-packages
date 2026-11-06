module 0x34dd4a0ff6a64179916b9a73e09289a5b438c79fd44eaed7dbbaff9f4e6d57e::ymx {
    struct YMX has drop {
        dummy_field: bool,
    }

    fun init(arg0: YMX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YMX>(arg0, 9, b"YMX", b"YMX", b"YMX - fixed-supply token on Sui.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<YMX>>(0x2::coin::mint<YMX>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YMX>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YMX>>(v2);
    }

    // decompiled from Move bytecode v7
}

