module 0x38cda5bc6e1fbba6dcc511c934e4b20cba75ff21ccf66b96f12c2ccecdf17d7c::moin {
    struct MOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<MOIN>(arg0, v0, b"MOIN", b"MOINHAT", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOIN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOIN>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<MOIN>>(0x2::coin::mint<MOIN>(&mut v4, 1054 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

