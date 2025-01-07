module 0x42f0e7594b70f16cb5d7062eeb5b69bfda51486a6db87c198122d177bc8bf9db::aran {
    struct ARAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARAN>(arg0, 9, b"ARAN", b"Ar999aN", b"Best best best ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6e7276b-1ee5-43b7-b5f9-a0663a79b309.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

