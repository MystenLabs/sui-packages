module 0x932e838c0e1a660d185f487aab2ad22ca4c20d9ab1734fbb3b9ff2bb1083d430::pwne {
    struct PWNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWNE>(arg0, 9, b"PWNE", b"hejd", b"bdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d45d846d-1064-43e4-9fcd-a0a807c8a0cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

