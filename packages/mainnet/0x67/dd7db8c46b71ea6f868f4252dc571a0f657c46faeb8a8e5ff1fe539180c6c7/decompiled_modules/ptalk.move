module 0x67dd7db8c46b71ea6f868f4252dc571a0f657c46faeb8a8e5ff1fe539180c6c7::ptalk {
    struct PTALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTALK>(arg0, 9, b"PTALK", b"PitchTalk", b"18", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78b726f5-1342-4a17-8da8-45dd8d2e3c5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

