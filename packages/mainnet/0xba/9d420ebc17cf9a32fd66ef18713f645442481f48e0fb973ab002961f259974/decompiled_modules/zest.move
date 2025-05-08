module 0xba9d420ebc17cf9a32fd66ef18713f645442481f48e0fb973ab002961f259974::zest {
    struct ZEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEST>(arg0, 6, b"ZEST", b"Zest Sui", b"ZEST is a fresh and daring token symbolized by a vibrant bird rocking an eye-catching orange hoodie. Dressed in the iconic colors of the SUI Chain, ZEST stands as the creative and rebellious spirit of the ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigcmn6gt2skjj6pa5clmyltx53hheimj5gnirkjmcwjpt5myp7dia")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

