module 0xce5d72a079da74261ad6e4a0d662e7a5f8247d57e69a9ede45bbfb1af9755535::sukablyat {
    struct SUKABLYAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKABLYAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKABLYAT>(arg0, 9, b"SUKABLYAT", b"Pidaras", x"d0af20d182d0b2d0bed0b920d180d0bed18220d0b2d18bd0b9d0b1d18320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5bc11bcd-e8a0-4bb9-8b8b-4ff5251d29e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKABLYAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUKABLYAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

