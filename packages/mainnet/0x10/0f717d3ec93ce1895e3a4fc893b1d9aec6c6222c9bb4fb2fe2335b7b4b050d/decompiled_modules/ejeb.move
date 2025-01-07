module 0x100f717d3ec93ce1895e3a4fc893b1d9aec6c6222c9bb4fb2fe2335b7b4b050d::ejeb {
    struct EJEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: EJEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EJEB>(arg0, 9, b"EJEB", b"hejd", b"jrnr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e4215b0-1ddc-4dc3-8342-4c6f43b012c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EJEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EJEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

