module 0x9f17aa94ec1fe2367f9dd7a76f9968e4b7af817d0d8eccbe8dbc5bef016c3069::ybc {
    struct YBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YBC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 8;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<YBC>(arg0, v0, b"YBC", b"YOUBBACOIN", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YBC>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YBC>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<YBC>>(0x2::coin::mint<YBC>(&mut v4, 1000000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

