module 0xe20674148febf27bb18d593c90dd16da7418adcf4966fe10ebcec99473aa1900::lil {
    struct LIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<LIL>(arg0, v0, b"LIL", b"LIL", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIL>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<LIL>>(0x2::coin::mint<LIL>(&mut v4, 1000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

