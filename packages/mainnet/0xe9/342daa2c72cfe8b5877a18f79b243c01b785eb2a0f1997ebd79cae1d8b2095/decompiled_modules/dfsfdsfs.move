module 0xe9342daa2c72cfe8b5877a18f79b243c01b785eb2a0f1997ebd79cae1d8b2095::dfsfdsfs {
    struct DFSFDSFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFSFDSFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFSFDSFS>(arg0, 9, b"DFSFDSFS", b"SDDFDFD", b"ASDDSGFDSVCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1002eeae-0818-43b7-8774-aaf2f8554851.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFSFDSFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFSFDSFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

