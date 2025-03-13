module 0x71f28ed9a2b756e0ac405ceb1a891546b91a57cc84aede8d544e3c45e60b3d6b::sUSDY {
    struct SUSDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSDY>(arg0, 6, b"sysUSDY", b"SY sUSDY", b"SY scallop sUSDY", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

