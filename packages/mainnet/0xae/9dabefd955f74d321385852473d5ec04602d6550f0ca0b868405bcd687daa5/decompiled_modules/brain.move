module 0xae9dabefd955f74d321385852473d5ec04602d6550f0ca0b868405bcd687daa5::brain {
    struct BRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAIN>(arg0, 6, b"BRAIN", b"Brain On Sui", b"The first Brain On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidjjtwy54kakc7kp5csvxgcl3dry5qkrujwpsmnz7bodm4s3kw3ta")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRAIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

