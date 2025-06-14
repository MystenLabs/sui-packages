module 0x213fb17c4631797bb15ff4db1080415bf0d33ae2b64679a3cf221f07d2a0a8a7::suiet {
    struct SUIET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIET>(arg0, 6, b"SUIET", b"Suieet", b"The Sweetest Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid4wxlxm3uurxwpotggngjv2nnvwypzf7hg7n5wgjdpanpcpmac4m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

