module 0x8d1d57531f8c2d9db96bb6349137f84d264eeec04ccb0f0c46e06e770e53f7a3::cfc {
    struct CFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFC>(arg0, 9, b"CFC", b"Chefscoin", b"Taste of life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7089df5-8cdf-4614-b0b2-905b30722b01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

