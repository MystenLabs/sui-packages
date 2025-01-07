module 0x2810f8b35cf06da2a5ae5f07d1fc7187d5efa1632c28e7d0c41924bdd72b1033::dream_100x {
    struct DREAM_100X has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREAM_100X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREAM_100X>(arg0, 9, b"DREAM_100X", b"Dream", x"f09fa7bff09fa7bff09fa7bf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/57747b2e-a028-420f-8c25-b9367efc2e87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREAM_100X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DREAM_100X>>(v1);
    }

    // decompiled from Move bytecode v6
}

