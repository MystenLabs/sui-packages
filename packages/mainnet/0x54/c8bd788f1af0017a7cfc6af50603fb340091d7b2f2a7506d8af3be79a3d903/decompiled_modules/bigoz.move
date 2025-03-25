module 0x54c8bd788f1af0017a7cfc6af50603fb340091d7b2f2a7506d8af3be79a3d903::bigoz {
    struct BIGOZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGOZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGOZ>(arg0, 9, b"BIGOZ", b"Big Ounce", x"4c6574e280997320676f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://preview.redd.it/big-ounce-appreciation-post-v0-hg0bldcjh4bb1.png?width=640&crop=smart&auto=webp&s=22ca7bb5c0936e1e5b79feba8296c40a271cfe0b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIGOZ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGOZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGOZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

