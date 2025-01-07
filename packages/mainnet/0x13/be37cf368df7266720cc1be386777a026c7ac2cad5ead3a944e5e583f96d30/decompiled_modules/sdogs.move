module 0x13be37cf368df7266720cc1be386777a026c7ac2cad5ead3a944e5e583f96d30::sdogs {
    struct SDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGS>(arg0, 9, b"SDOGS", b"Sui dogs", b"It is a fun token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ab346e9-f3d5-4894-8c9d-1f95439ae566.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

