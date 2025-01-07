module 0x8fa920d3b18c8819eb9d1f95ddc119e81d534b9db29de7973e07c677a6d1c58b::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 9, b"SDOG", b"SMOKINGDOG", b"IM READY DOWG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94b3cdb3-f21d-44ac-afd0-21b4c1e43d4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

