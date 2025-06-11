module 0x4578738a2d5234385b5d46bce5a902b6ea93d1d211df576d5468afd3c3e6c470::kira {
    struct KIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRA>(arg0, 6, b"KIRA", b"Light Yagami", b"Soda boku ga kira da", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih2ch2qivlif47dpbyi5vnwkxqg2les5btw5l4dgq67tohemjp34q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KIRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

