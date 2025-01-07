module 0x5ed98dce84201e15d61c51fef407fcb3c9334ef80dccd437a73141042c8d00c4::wavepump {
    struct WAVEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEPUMP>(arg0, 9, b"WAVEPUMP", b"Wave", b"Wave is the best project for telegram ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c3ce74bb-cade-4c35-878e-fd99e58559f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

