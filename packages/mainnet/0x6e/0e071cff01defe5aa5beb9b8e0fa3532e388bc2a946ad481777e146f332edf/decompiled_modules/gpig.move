module 0x6e0e071cff01defe5aa5beb9b8e0fa3532e388bc2a946ad481777e146f332edf::gpig {
    struct GPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPIG>(arg0, 6, b"GPIG", b"GoldPig", b"GoldPig is an AI-powered crypto investment platform designed to generate 1%+ daily returns. Whether you're starting with just $1, GoldPig provides opportunities to grow your wealth and achieve long-term prosperity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaque73vb4tkhcxwfrn4g2poapboxkmvlzgkxd5fqeq4bxje6b5ei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GPIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

