module 0xd2128e334868de4b449e6b5eb6d60c42396e71330f5a0a65f955ee60b4f3152::piko {
    struct PIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKO>(arg0, 9, b"PIKO", b"piko", b"?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e52ef22-9c08-47b1-9b45-d1aa8839f1ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

