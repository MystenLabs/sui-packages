module 0x57ae2d9ef2aa568aaee3a63bb58d9276c36dc0cc696ab317ee7e7dcb105edd61::skibiwave {
    struct SKIBIWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIBIWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIBIWAVE>(arg0, 9, b"SKIBIWAVE", b"SKIBIDI Wave", b"The word \"skibidi\" has no inherent meaning, but can be used as an adjective to express something cool, bad, or stupid, depending on the context", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d254353e-9a68-45bc-ab72-218e1eb2c3fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIBIWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKIBIWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

