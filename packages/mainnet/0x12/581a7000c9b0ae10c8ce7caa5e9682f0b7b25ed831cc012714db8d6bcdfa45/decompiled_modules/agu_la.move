module 0x12581a7000c9b0ae10c8ce7caa5e9682f0b7b25ed831cc012714db8d6bcdfa45::agu_la {
    struct AGU_LA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGU_LA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGU_LA>(arg0, 9, b"AGU_LA", b"AguilarSha", b"coin for trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09b83da1-0f4f-4c6f-9849-e53ad3fba06b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGU_LA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGU_LA>>(v1);
    }

    // decompiled from Move bytecode v6
}

