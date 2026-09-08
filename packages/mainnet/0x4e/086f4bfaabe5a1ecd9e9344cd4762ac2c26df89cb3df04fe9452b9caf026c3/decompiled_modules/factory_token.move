module 0x4e086f4bfaabe5a1ecd9e9344cd4762ac2c26df89cb3df04fe9452b9caf026c3::factory_token {
    struct FACTORY_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FACTORY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACTORY_TOKEN>(arg0, 9, b"MHT", b"MemeHedge Token", b"MemeHedge bonding-curve token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FACTORY_TOKEN>>(0x2::coin::mint<FACTORY_TOKEN>(&mut v2, 1000000000000000000, arg1), @0x6961103562b944c8cabed883640cc41b07e61ac76858342d4dce81ade7a7f8e3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACTORY_TOKEN>>(v2, @0x6961103562b944c8cabed883640cc41b07e61ac76858342d4dce81ade7a7f8e3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FACTORY_TOKEN>>(v1, @0x6961103562b944c8cabed883640cc41b07e61ac76858342d4dce81ade7a7f8e3);
    }

    // decompiled from Move bytecode v6
}

