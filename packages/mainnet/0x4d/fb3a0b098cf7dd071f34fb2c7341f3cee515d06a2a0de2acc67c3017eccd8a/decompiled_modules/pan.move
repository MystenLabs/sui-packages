module 0x4dfb3a0b098cf7dd071f34fb2c7341f3cee515d06a2a0de2acc67c3017eccd8a::pan {
    struct PAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAN>(arg0, 9, b"PAN", b"Pandora", b"Meme coin with no utility ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/286a2f1d-d0ab-4f26-b389-aa3051306a01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

