module 0x997e8f454246d34136016e782ca9b9a0b62912ba68864b97afc82f2220349c92::factory_token {
    struct FACTORY_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FACTORY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACTORY_TOKEN>(arg0, 9, b"MHT", b"MemeHedge Token", b"MemeHedge bonding-curve token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x3efd8b4b7e606170f1bccd266577dfd225d79ba8ff1878b11ea90b80c7d891f8::bonding_curve::new<FACTORY_TOKEN>(@0x6961103562b944c8cabed883640cc41b07e61ac76858342d4dce81ade7a7f8e3, @0x6961103562b944c8cabed883640cc41b07e61ac76858342d4dce81ade7a7f8e3, 0x2::coin::mint<FACTORY_TOKEN>(&mut v2, 650000000000000000, arg1), 1320000000000, 780000000000000000, 650000000000000000, 6600000000000, 9, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FACTORY_TOKEN>>(0x2::coin::mint<FACTORY_TOKEN>(&mut v2, 350000000000000000, arg1), @0x6961103562b944c8cabed883640cc41b07e61ac76858342d4dce81ade7a7f8e3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACTORY_TOKEN>>(v2, @0x6961103562b944c8cabed883640cc41b07e61ac76858342d4dce81ade7a7f8e3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FACTORY_TOKEN>>(v1, @0x6961103562b944c8cabed883640cc41b07e61ac76858342d4dce81ade7a7f8e3);
    }

    // decompiled from Move bytecode v7
}

