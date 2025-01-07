module 0x3b1786211de84d96f14d38c737e2be4b20c0f48b10a20c147222a786f9211198::zaza {
    struct ZAZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAZA>(arg0, 9, b"ZAZA", b"ZAZA VOU", b"TEAM WORK IS KEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca452772-8c16-4a4e-af47-f8669d930659.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

