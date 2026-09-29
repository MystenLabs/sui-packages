module 0x9092e364c5d451f629d0bf955c36c65aa0cf62dffab62f49dd21b75e7eb2f54c::cosky {
    struct COSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COSKY>(arg0, 9, b"COSKY", b"Cosky", b"Cosky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/3441c5bf5d3f2f236c657c29eff770fc2c5beaf5251ce3984e6f476cd23bef5d")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<COSKY>>(0x2::coin::mint<COSKY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COSKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COSKY>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

