module 0x884f001afac005f0985fc32dd979bd0c9fa950de308f9797f9c76aea0c25e464::sample_share {
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

