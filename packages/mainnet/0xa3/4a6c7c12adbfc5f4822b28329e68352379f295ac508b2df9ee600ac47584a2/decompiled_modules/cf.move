module 0xa34a6c7c12adbfc5f4822b28329e68352379f295ac508b2df9ee600ac47584a2::cf {
    struct CF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CF>(arg0, 6, b"CF", b"CATF", b"ccf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib54zte7wqazcayjndmsbvg4k6y3zdjxm6mckjnqvftnfjhuqpdie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

