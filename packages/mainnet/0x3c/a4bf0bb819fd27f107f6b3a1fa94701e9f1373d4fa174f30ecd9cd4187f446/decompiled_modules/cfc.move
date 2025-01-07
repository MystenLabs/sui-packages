module 0x3ca4bf0bb819fd27f107f6b3a1fa94701e9f1373d4fa174f30ecd9cd4187f446::cfc {
    struct CFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFC>(arg0, 9, b"CFC", b"Chefscoin", b"Taste of life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce064369-b5a5-4ca6-a2f8-bff338a15f96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

