module 0xc4a7b41e1f0bb4b67f51942323419282b96923bc7ae9f051ca1c2a24cddd0f26::quby {
    struct QUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUBY>(arg0, 6, b"QUBY", b"Quby", b"Quby Coin, inspired by the iconic Quby character from Mainland China, brings its beloved rosy cheeks and playful spirit to the crypto world. Capturing hearts globally, Quby Coin aims to spread joy and happiness across the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b016da01_fa7a_4256_b066_1b78a6a3e882_958ea7f4e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

