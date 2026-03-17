module 0xd625cb470573402f5eb041fc56cf8b245170832ccbb6d89ae18403c2a23ee794::toilet2 {
    struct TOILET2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOILET2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOILET2>(arg0, 6, b"Toilet2", b"Toilet dust 2.0", b"Toilet Dust 2.0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifjbsfwlzggnzclp5wroeaxpmhnvk5p5shfqainwmrrukz7alnoqm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOILET2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOILET2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

