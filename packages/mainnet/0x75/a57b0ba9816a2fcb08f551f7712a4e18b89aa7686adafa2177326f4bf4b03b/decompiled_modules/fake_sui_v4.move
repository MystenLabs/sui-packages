module 0x75a57b0ba9816a2fcb08f551f7712a4e18b89aa7686adafa2177326f4bf4b03b::fake_sui_v4 {
    struct FAKE_SUI_V4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKE_SUI_V4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_SUI_V4>(arg0, 9, b"SUI", b"Sui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE_SUI_V4>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE_SUI_V4>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

