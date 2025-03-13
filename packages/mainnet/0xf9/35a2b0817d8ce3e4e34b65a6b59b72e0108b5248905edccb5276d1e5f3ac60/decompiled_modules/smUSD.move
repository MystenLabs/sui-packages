module 0xf935a2b0817d8ce3e4e34b65a6b59b72e0108b5248905edccb5276d1e5f3ac60::smUSD {
    struct SMUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUSD>(arg0, 6, b"sysmUSD", b"SY smUSD", b"SY scallop smUSD", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

