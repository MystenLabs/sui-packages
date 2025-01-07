module 0x911dd323016515f68059fd6dfeef4285ad4e606475796d2dc85c4299880e86df::dogi {
    struct DOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGI>(arg0, 9, b"DOGI", b"Dogi", x"24444f47492e2ee29c82efb88f2e2e4e414c532069732074686520464952535420746f6b656e206f6e2023445243323020436f6d6d756e69747920746f6b656e207c206e6f207465616d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/963939ae-69d4-42d5-b6c8-8b011c57da51.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

