module 0xc532a51906b679933b4481c4eda32e8733612e15373912ff7bfa51439f22d2cb::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASH>(arg0, 6, b"SPLASH", b"Splash Network", x"68747470733a2f2f73706c6173687375692e76657263656c2e6170702f0a68747470733a2f2f782e636f6d2f73706c617368646f7466756e0a68747470733a2f2f646973636f72642e67672f59654d33337735390a0a46756c6c2064657461696c73206f6e20646973636f72642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihkfdciqxa2c4yzb5e25rwlra6tfgq7yc3tk56fhvyzmayrtzlxhi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPLASH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

