module 0x6c962f19f01c0d1e59a3429884b45bee4f76ea401d5ceccfb1c7554164ef4932::moa {
    struct MOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOA>(arg0, 9, b"MOA", b"Moai", b"It's just a rock ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58a63978-54a8-4ed2-85e1-7d14acec0f93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

