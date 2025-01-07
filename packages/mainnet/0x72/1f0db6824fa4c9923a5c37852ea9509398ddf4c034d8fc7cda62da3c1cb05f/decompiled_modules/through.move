module 0x721f0db6824fa4c9923a5c37852ea9509398ddf4c034d8fc7cda62da3c1cb05f::through {
    struct THROUGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: THROUGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THROUGH>(arg0, 9, b"THROUGH", b"SLILPIING", b"Sing alone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d99a87cb-3b60-42ba-97c4-068d1a6f9973.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THROUGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THROUGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

