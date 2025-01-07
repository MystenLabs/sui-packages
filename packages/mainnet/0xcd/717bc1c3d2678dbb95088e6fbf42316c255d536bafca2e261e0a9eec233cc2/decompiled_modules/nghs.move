module 0xcd717bc1c3d2678dbb95088e6fbf42316c255d536bafca2e261e0a9eec233cc2::nghs {
    struct NGHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGHS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<NGHS>(arg0, v0, b"NGHS", b"NAMHHAISAU", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGHS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGHS>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<NGHS>>(0x2::coin::mint<NGHS>(&mut v4, 10000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

