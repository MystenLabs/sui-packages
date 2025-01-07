module 0xb373962785a5cdd56f238bde84c972b0179fb072d4543c3a835f26f763cfedd6::hiep {
    struct HIEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIEP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<HIEP>(arg0, v0, b"HIEP", b"HIEP", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIEP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIEP>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<HIEP>>(0x2::coin::mint<HIEP>(&mut v4, 1000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

