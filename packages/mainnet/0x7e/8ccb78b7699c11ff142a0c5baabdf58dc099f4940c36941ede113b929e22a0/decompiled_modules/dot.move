module 0x7e8ccb78b7699c11ff142a0c5baabdf58dc099f4940c36941ede113b929e22a0::dot {
    struct DOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOT>(arg0, 9, b"DOT", b"DONALD TRUMP", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<DOT>(&mut v2, 100000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOT>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

