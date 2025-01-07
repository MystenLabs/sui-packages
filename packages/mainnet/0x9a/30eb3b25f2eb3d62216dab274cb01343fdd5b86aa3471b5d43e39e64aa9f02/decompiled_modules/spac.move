module 0x9a30eb3b25f2eb3d62216dab274cb01343fdd5b86aa3471b5d43e39e64aa9f02::spac {
    struct SPAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAC>(arg0, 9, b"SPAC", b"SPACE X", b"SPACEAX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3319ceb1-d890-44b1-aa7c-e88117ca6c7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

