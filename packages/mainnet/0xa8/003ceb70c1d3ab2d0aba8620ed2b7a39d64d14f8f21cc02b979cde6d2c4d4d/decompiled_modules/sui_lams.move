module 0xa8003ceb70c1d3ab2d0aba8620ed2b7a39d64d14f8f21cc02b979cde6d2c4d4d::sui_lams {
    struct SUI_LAMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_LAMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_LAMS>(arg0, 6, b"SUILAMS", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_LAMS>>(v1);
        0x2::coin::mint_and_transfer<SUI_LAMS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_LAMS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

