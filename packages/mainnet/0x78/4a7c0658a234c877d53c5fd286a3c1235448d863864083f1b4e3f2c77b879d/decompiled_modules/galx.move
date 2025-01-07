module 0x784a7c0658a234c877d53c5fd286a3c1235448d863864083f1b4e3f2c77b879d::galx {
    struct GALX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GALX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<GALX>(arg0, v0, b"GALX", b"GALXE", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GALX>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GALX>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<GALX>>(0x2::coin::mint<GALX>(&mut v4, 10000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

