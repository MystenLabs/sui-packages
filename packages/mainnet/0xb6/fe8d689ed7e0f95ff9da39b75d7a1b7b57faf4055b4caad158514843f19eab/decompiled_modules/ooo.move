module 0xb6fe8d689ed7e0f95ff9da39b75d7a1b7b57faf4055b4caad158514843f19eab::ooo {
    struct OOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOO>(arg0, 9, b"OOO", b"O", b"Oooooooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/77688966-fc49-432a-98e9-4af1b4bbc797.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

