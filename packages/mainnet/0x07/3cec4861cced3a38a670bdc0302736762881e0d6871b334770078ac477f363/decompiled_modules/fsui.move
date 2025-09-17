module 0x73cec4861cced3a38a670bdc0302736762881e0d6871b334770078ac477f363::fsui {
    struct FSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSUI>(arg0, 9, b"FSUI", b"Fake SUI", b"Fake SUI for testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FSUI>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

