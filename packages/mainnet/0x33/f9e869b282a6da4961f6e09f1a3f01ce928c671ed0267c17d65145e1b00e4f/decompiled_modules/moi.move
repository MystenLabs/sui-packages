module 0x33f9e869b282a6da4961f6e09f1a3f01ce928c671ed0267c17d65145e1b00e4f::moi {
    struct MOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<MOI>(arg0, v0, b"MOI", b"MOI", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOI>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<MOI>>(0x2::coin::mint<MOI>(&mut v4, 100 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

