module 0xeaee57ce21068869d579bd0be55d9aaf6a8711a923d6d97836eb1769dc6e22d5::romacis {
    struct ROMACIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROMACIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROMACIS>(arg0, 9, b"ROMACIS", b"romabis", b"the new", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65bf7882-9d78-46db-bdec-94d7d54bac6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROMACIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROMACIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

