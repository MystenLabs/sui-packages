module 0x3df4f56dc1a8a936e0138286b45227d602582b337cc16c1d3c69906a063cf296::regi {
    struct REGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGI>(arg0, 9, b"REGI", b"REGI", b"REGI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REGI>(&mut v2, 123123123000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

