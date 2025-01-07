module 0x631b2cd0b7736ad4c2ef693b9cc040914d2763dfa1501ec45c2dd9d9de4878c1::ppp {
    struct PPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<PPP>(arg0, v0, b"PPP", b"PPP", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPP>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<PPP>>(0x2::coin::mint<PPP>(&mut v4, 100 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

