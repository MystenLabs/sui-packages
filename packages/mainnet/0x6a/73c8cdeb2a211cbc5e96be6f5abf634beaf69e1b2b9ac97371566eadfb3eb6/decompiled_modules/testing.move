module 0x6a73c8cdeb2a211cbc5e96be6f5abf634beaf69e1b2b9ac97371566eadfb3eb6::testing {
    struct TESTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTING>(arg0, 9, b"TESTING                           ", b"testing                                                           ", b"testing                                                                                                                                                                                                                                                                                                                                                                                                                                                               ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://flopfun.vercel.app/icon/8f45ba72-7f10-4567-808b-5b210e3c142b.png                                                                                                                                            ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

