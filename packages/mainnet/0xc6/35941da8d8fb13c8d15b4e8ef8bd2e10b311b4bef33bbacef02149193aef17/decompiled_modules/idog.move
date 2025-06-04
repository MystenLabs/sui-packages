module 0xc635941da8d8fb13c8d15b4e8ef8bd2e10b311b4bef33bbacef02149193aef17::idog {
    struct IDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDOG>(arg0, 6, b"IDOG", b"Idog sui", b"Introducing iDOG, the iconic toy robot dog now the official mascot of the SUI blockchain. With global recognition as an advanced tech companion, iDOG is stepping into Web3 to lead the next wave of community driven tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic65jxqrzlkqbkfzq4cpi4yqayz5qekp2a6tso7kcunrdova4nazu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

