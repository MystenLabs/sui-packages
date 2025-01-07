module 0x29e6132acfe83a1392216166e200c29d45f5c47d865f0e37996e87df3cb83b2b::pikkywat {
    struct PIKKYWAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKKYWAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKKYWAT>(arg0, 9, b"PIKKYWAT", b"Green", b"Green is a meme inspired by the atmosphere of natural growth and adventure. With Green, we are not just mastering the waves, we are making formation. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c203fad5-c142-46ed-a409-2966bd2e17a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKKYWAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKKYWAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

