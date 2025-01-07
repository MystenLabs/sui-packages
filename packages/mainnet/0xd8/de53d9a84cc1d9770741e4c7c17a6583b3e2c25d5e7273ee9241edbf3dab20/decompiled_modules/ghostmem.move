module 0xd8de53d9a84cc1d9770741e4c7c17a6583b3e2c25d5e7273ee9241edbf3dab20::ghostmem {
    struct GHOSTMEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOSTMEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOSTMEM>(arg0, 9, b"GHOSTMEM", b"Ghost", b"Nsjjdvsv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e41e6c1-c61a-4ccb-b579-2bf155b4d293.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOSTMEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHOSTMEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

