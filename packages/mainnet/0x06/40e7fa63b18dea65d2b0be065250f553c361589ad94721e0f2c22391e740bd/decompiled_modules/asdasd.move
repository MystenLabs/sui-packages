module 0x640e7fa63b18dea65d2b0be065250f553c361589ad94721e0f2c22391e740bd::asdasd {
    struct ASDASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDASD>(arg0, 9, b"ASDASD", b"ASADS", b"CVBCVBDFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/888db7b5-f8a4-4c35-927a-38cf20ff3c12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDASD>>(v1);
    }

    // decompiled from Move bytecode v6
}

