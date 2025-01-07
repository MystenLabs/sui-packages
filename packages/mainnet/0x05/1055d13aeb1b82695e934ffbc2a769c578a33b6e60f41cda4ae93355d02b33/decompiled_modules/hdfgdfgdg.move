module 0x51055d13aeb1b82695e934ffbc2a769c578a33b6e60f41cda4ae93355d02b33::hdfgdfgdg {
    struct HDFGDFGDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDFGDFGDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDFGDFGDG>(arg0, 9, b"HDFGDFGDG", b"fdsfsdf", b"gfhghghghg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23cc53a7-de7c-45af-985c-944f38f88221.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDFGDFGDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDFGDFGDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

