module 0xefe6c20066ab2fd92f5f668eac07ea834e1b7fb8d391099ffd7fefa555978e14::nakamoto {
    struct NAKAMOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKAMOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKAMOTO>(arg0, 9, b"NAKAMOTO", b"Satoshi11", b"It's just a secret coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d98a4a28-7b8e-45a8-a5a1-0616a778f26d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKAMOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAKAMOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

