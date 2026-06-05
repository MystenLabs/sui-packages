module 0x9594875f94e0a8d8c4e4e9aba8cc69596555ae91be2d98de6dafbb55fe4586ad::samtest {
    struct SAMTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMTEST>(arg0, 6, b"samUSDCt", b"Sam USDC test", b"multi-market test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMTEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMTEST>>(v1);
    }

    // decompiled from Move bytecode v7
}

