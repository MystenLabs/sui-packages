module 0x2745f7dcbeb7663dbf347d97ec61f0a8559f9272ebef0e7492c30503127034d2::tkmo {
    struct TKMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<TKMO>(arg0, v0, b"TKMO", b"TOKENMOI", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKMO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKMO>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<TKMO>>(0x2::coin::mint<TKMO>(&mut v4, 12355 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

