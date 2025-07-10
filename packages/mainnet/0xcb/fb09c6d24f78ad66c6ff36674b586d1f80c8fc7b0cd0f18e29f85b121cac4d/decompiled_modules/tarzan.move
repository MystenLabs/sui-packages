module 0xcbfb09c6d24f78ad66c6ff36674b586d1f80c8fc7b0cd0f18e29f85b121cac4d::tarzan {
    struct TARZAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARZAN>(arg0, 6, b"TARZAN", b"TARZAN ON SUI", b"Tarzan on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib4ryj3zsl7yendbynnnfhyq2hzauh56vnce6ylxenv5jfqiy27gq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TARZAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

