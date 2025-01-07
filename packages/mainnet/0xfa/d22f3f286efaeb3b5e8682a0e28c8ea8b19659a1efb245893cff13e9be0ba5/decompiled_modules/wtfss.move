module 0xfad22f3f286efaeb3b5e8682a0e28c8ea8b19659a1efb245893cff13e9be0ba5::wtfss {
    struct WTFSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTFSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTFSS>(arg0, 9, b"WTFSS", b"WTFS", b"wtf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc2fa392-6223-417e-9478-6cc1eb53c2e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTFSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTFSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

