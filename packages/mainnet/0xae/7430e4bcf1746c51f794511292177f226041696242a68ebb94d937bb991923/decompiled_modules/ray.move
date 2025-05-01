module 0xae7430e4bcf1746c51f794511292177f226041696242a68ebb94d937bb991923::ray {
    struct RAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAY>(arg0, 6, b"RAY", b"RAY MOON BOY", b"Rays flying. Youre tapping. The moon waiting. RAY is next.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicsbn73k3kj2hm2ftzyvg42nkulg3om2uon6sqn36ijea2zbulq5q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

