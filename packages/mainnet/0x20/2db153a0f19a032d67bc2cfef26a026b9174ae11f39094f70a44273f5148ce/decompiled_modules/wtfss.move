module 0x202db153a0f19a032d67bc2cfef26a026b9174ae11f39094f70a44273f5148ce::wtfss {
    struct WTFSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTFSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTFSS>(arg0, 9, b"WTFSS", b"WTFS", b"wtf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/acc1b231-0f5c-4842-96a1-5c520ddca403.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTFSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTFSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

