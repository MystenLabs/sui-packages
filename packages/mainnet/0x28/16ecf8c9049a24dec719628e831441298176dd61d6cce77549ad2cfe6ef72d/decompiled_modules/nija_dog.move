module 0x2816ecf8c9049a24dec719628e831441298176dd61d6cce77549ad2cfe6ef72d::nija_dog {
    struct NIJA_DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIJA_DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIJA_DOG>(arg0, 6, b"Nija dog", b"Dogelangelo", b"Dogelangelo meme from Ninja Turtles. Will land on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicu6r45z6tpmynfi6t6t2gofih6qk54gitczhgitqiedhdzclagqe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIJA_DOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NIJA_DOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

