module 0xd7f5a9c48008fccebd2f895d104317085382add7ef0475d1c4e06bc3e6ea284d::gens {
    struct GENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<GENS>(arg0, v0, b"GENS", b"GENESIS", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENS>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<GENS>>(0x2::coin::mint<GENS>(&mut v4, 100000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

