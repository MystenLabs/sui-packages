module 0x4ed3289dade63ec300105f4a984466d4e5101477a1bc3c24a51fdcfec860a10f::squidwart {
    struct SQUIDWART has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDWART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDWART>(arg0, 6, b"SquidwART", b"Bold and Brash", b"At the Adult Learning Center, Squidward gets a job as an art teacher. The art collector, Monty P. Moneybags, arrives, and one of the pieces that Squidward shows him is Bold and Brash. Mocking Squidward, Monty remarks, \"More like, belongs in the trash!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaq6dphrcmmqmkr5bugsmnnwicb3ecsczktp7vtn7oczjxzvmcviu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDWART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUIDWART>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

