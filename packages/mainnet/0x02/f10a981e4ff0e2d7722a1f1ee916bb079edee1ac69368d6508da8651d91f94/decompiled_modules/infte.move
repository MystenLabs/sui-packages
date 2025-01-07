module 0x2f10a981e4ff0e2d7722a1f1ee916bb079edee1ac69368d6508da8651d91f94::infte {
    struct INFTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFTE>(arg0, 9, b"INFTE", b"INFENETE", b"Let's create a token to help us make a profit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dfbde5f1-1dec-48d6-9fbb-a64707bd1e31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INFTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

