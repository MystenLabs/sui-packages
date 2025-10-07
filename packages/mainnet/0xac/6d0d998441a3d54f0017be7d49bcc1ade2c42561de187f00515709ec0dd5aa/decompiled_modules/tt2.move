module 0xac6d0d998441a3d54f0017be7d49bcc1ade2c42561de187f00515709ec0dd5aa::tt2 {
    struct TT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT2>(arg0, 9, b"TT2", b"Test Token V2", b"Token on mainnet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TT2>>(v1);
    }

    // decompiled from Move bytecode v6
}

