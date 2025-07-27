module 0xb089f223d3d15ed5f4f9170ef301fc3ea5ba287afa1585fd0d8c0cf9bea26c12::sample_share {
    struct SAMPLE_SHARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMPLE_SHARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMPLE_SHARE>(arg0, 9, b"Sample", b"Sample Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMPLE_SHARE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMPLE_SHARE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

