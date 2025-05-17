module 0x75436ef5829317487434b4b390674f65075da535670367a6d6b202c8d27381ac::truth_social {
    struct TRUTH_SOCIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUTH_SOCIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUTH_SOCIAL>(arg0, 6, b"Truth social", b"truth social trump", b"the truth social is a meme token launched by President  Donald Trump on his Truth Social account. It is a SUI meme coin that allows users to trade and invest in it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibfivlpvoynidsipgkptnwq2osqmk3umuleyhdkfyyexxa4wxw4lm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUTH_SOCIAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUTH_SOCIAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

