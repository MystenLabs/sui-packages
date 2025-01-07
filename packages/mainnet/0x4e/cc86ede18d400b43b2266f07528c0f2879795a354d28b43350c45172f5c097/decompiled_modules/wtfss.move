module 0x4ecc86ede18d400b43b2266f07528c0f2879795a354d28b43350c45172f5c097::wtfss {
    struct WTFSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTFSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTFSS>(arg0, 9, b"WTFSS", b"WTFS", b"wtf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b50f30a1-9e3d-493f-83ac-47e3868aa155.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTFSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTFSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

