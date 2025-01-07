module 0xc60a3d48a68625c44b4337a5a7c2c9a5534b9a9ecadc4f58c3f1fe294404ed73::mewii {
    struct MEWII has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWII>(arg0, 9, b"MEWII", b"Mewmew", b"Haha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a76dd1cb-1ae3-4df1-ab4e-139605ddcbfc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWII>>(v1);
    }

    // decompiled from Move bytecode v6
}

