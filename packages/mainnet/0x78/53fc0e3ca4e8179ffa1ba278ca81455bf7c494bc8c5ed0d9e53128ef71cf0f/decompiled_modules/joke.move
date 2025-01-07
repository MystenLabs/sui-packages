module 0x7853fc0e3ca4e8179ffa1ba278ca81455bf7c494bc8c5ed0d9e53128ef71cf0f::joke {
    struct JOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKE>(arg0, 9, b"JOKE", b"A joke ", b"How much are you willing to pay to laugh HA Ha Ha Ha Ha Ha Ha Ha Ha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e43b7748-474d-4a5c-952b-4c1c6b8a2034.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

