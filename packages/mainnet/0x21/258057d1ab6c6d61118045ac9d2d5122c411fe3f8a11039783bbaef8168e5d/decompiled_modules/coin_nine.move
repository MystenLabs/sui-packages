module 0x21258057d1ab6c6d61118045ac9d2d5122c411fe3f8a11039783bbaef8168e5d::coin_nine {
    struct COIN_NINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_NINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_NINE>(arg0, 9, b"coinnine", b"coin nine", b"coin nine description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/ab7a327b-c90d-40a9-be95-e96f9110dc75.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_NINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_NINE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

