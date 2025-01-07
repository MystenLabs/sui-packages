module 0xef7c4ce6aab1d58b0bbabecc80b2f9aeeb1f2b44f306db5157485952bbfca40b::htr {
    struct HTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTR>(arg0, 9, b"HTR", b"Hamter", b"Let go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ac30e48-0e20-4001-b8d7-172e8878984c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

