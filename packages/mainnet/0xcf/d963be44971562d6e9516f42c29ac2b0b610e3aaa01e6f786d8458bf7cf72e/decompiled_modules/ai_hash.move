module 0xcfd963be44971562d6e9516f42c29ac2b0b610e3aaa01e6f786d8458bf7cf72e::ai_hash {
    struct AI_HASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI_HASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI_HASH>(arg0, 6, b"AI Hash", b"Hash AI", b"Trade computing power on the first truly decentralized hash marketplace. Secure, efficient, and powered by blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidvwrz6aqbb3bqiga5ffc6slj2llw7nocihpvcxszpwukvbnkreou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI_HASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AI_HASH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

