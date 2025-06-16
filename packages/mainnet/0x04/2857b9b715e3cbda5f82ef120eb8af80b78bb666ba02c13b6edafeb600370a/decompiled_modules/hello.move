module 0x42857b9b715e3cbda5f82ef120eb8af80b78bb666ba02c13b6edafeb600370a::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO>(arg0, 6, b"HELLO", b"Hello World", b"Hello World Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibbw5hxopvvuuyxvvfbyzjp4u3hamirlpqh2eryacdbhxzflgds3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELLO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

