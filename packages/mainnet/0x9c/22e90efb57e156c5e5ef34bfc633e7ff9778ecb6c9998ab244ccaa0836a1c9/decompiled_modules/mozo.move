module 0x9c22e90efb57e156c5e5ef34bfc633e7ff9778ecb6c9998ab244ccaa0836a1c9::mozo {
    struct MOZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZO>(arg0, 9, b"MOZO", b"MOZO AI", b"Self-improving Knowledge Hub for Al Join now and start to earn:", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc9e7f8b-7d48-4af2-8c3f-e4d0de3902ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

