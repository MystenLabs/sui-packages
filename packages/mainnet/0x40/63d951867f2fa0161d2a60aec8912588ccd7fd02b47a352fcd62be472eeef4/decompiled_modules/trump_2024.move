module 0x4063d951867f2fa0161d2a60aec8912588ccd7fd02b47a352fcd62be472eeef4::trump_2024 {
    struct TRUMP_2024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP_2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP_2024>(arg0, 9, b"TRUMP_2024", b"Trump ", b"In solidarity to the next US president ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6ba3b800-3318-480a-a052-5732023d6768.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP_2024>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP_2024>>(v1);
    }

    // decompiled from Move bytecode v6
}

