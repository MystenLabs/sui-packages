module 0xbbf11b449fa3d419f9f93b128945d151e7b19722603f4cba77b7b7efd049b136::pibit {
    struct PIBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIBIT>(arg0, 9, b"PIBIT", b"pinkRabbit", b"FOLLOW THE PINK RABBIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d494190-a64b-43f1-83a1-45e477c992f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

