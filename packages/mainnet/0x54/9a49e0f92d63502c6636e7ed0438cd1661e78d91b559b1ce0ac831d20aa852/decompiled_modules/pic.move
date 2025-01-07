module 0x549a49e0f92d63502c6636e7ed0438cd1661e78d91b559b1ce0ac831d20aa852::pic {
    struct PIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIC>(arg0, 9, b"PIC", b"Picker", b"The Dev's pav ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e0b42df-0a31-49b7-96e0-cbe3ad5aa4ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

