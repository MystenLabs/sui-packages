module 0x224df8ab45b40066c92074560dfe4b3c1316d079bc794ccb6bf9eb2e7c6883f8::dung {
    struct DUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<DUNG>(arg0, v0, b"DUNG", b"DUNG", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUNG>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUNG>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<DUNG>>(0x2::coin::mint<DUNG>(&mut v4, 100000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

