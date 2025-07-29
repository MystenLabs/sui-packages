module 0x66b30575d0c0ef86d360bf14074c4fc5c0fb1c4a58af376e5f03e4f8d997e04::sample_share {
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

