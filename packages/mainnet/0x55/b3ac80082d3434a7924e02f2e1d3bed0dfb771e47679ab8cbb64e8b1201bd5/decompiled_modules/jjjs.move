module 0x55b3ac80082d3434a7924e02f2e1d3bed0dfb771e47679ab8cbb64e8b1201bd5::jjjs {
    struct JJJS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJJS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJJS>(arg0, 9, b"JJJS", b"Hjja", b"Jooqo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/daad0fa1-5c2c-468a-ae2d-711b8fc76732.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJJS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JJJS>>(v1);
    }

    // decompiled from Move bytecode v6
}

