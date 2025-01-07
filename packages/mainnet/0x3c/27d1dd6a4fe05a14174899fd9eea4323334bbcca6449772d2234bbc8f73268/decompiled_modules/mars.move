module 0x3c27d1dd6a4fe05a14174899fd9eea4323334bbcca6449772d2234bbc8f73268::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARS>(arg0, 9, b"MARS", b"Martin ", b"This meme go to Mars civilization ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a193c42-b38b-4ebe-aa80-df603138d0aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

