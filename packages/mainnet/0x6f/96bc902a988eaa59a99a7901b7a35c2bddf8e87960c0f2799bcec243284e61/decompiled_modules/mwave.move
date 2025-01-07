module 0x6f96bc902a988eaa59a99a7901b7a35c2bddf8e87960c0f2799bcec243284e61::mwave {
    struct MWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWAVE>(arg0, 9, b"MWAVE", b"Memewave", b"Dive into the future of the crypto with Memewave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c820a0f3-eefc-448c-acfa-8e03e55d08c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

