module 0xabf45e70d136ef3760fb37237e29a96ec4d7d9992b96dfc45dfa53876c51c423::gilx {
    struct GILX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GILX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"";
        let v2 = @0x5667295fdc3e4ff8a6a9f4807dab36d3ba9d33a3ab55ceefc6dc9ed87e94742f;
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v3, v4) = 0x2::coin::create_currency<GILX>(arg0, v0, b"GILX", b"GILX", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GILX>>(v4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GILX>>(v5, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<GILX>>(0x2::coin::mint<GILX>(&mut v5, 100000000 * 0x2::math::pow(10, v0), arg1), v2);
    }

    // decompiled from Move bytecode v6
}

