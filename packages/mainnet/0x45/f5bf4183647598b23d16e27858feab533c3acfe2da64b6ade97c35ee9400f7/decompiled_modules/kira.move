module 0x45f5bf4183647598b23d16e27858feab533c3acfe2da64b6ade97c35ee9400f7::kira {
    struct KIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRA>(arg0, 6, b"KIRA", b"light yagami", b"Soda boku ga kira da", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih2ch2qivlif47dpbyi5vnwkxqg2les5btw5l4dgq67tohemjp34q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KIRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

