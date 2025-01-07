module 0x28640f90e0e8e17a7b81fb5c7d33d6f1a3f8000a08e6f5636e2e89040a9f8862::asdas {
    struct ASDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDAS>(arg0, 9, b"ASDAS", b"fgfg", b"DGFH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e49895f7-9af7-445c-99eb-6697b256f5b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

