module 0x169729e0411b64e18d15cd520982924ae19ded1045179b95f75fcdf9392f05c7::ctx {
    struct CTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<CTX>(arg0, v0, b"CTX", b"CTX", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTX>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTX>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<CTX>>(0x2::coin::mint<CTX>(&mut v4, 1000000000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

