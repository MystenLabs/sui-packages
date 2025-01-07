module 0x485e9192a0cd203d05cce3aba681d7a5de24a6c0a5f3660a736072ab028d4a43::faker {
    struct FAKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKER>(arg0, 9, b"FAKER", b"SNOOP", b"Keera", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e221de3e-9431-447a-aacb-b635e5fd7395.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

