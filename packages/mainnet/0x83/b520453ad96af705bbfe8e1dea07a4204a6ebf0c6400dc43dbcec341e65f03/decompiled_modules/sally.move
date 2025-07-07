module 0x83b520453ad96af705bbfe8e1dea07a4204a6ebf0c6400dc43dbcec341e65f03::sally {
    struct SALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALLY>(arg0, 6, b"SALLY", b"SALLY THE SALAMANDERS", b"Hi, my name is Sally. My parents adopted me on a regular Thursday afternoon. My awesomeness came from my parents. Please support and buy on moonbags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaihovubp6wrasa5gohjtruaz5k5ju7l34pvx5sh777ae4agiavnu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SALLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

