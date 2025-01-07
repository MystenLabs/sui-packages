module 0xf9152ced40b45ffba35f377ddf071575d860b5f11859e8849371ac3c48670ee1::memek {
    struct MEMEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK>(arg0, 9, b"MEMEK", b"Memek", b"Memek are the greatest hole in the world, and all the creatures was deployed by MEMEK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d90e151d-4c1a-47c8-bd79-a33197ef1974.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

