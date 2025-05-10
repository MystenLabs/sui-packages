module 0xeb2caaabc2f331ad80fc8f208265b2f69bb1ed2e185ff76f0044f413e6033ed8::btm {
    struct BTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTM>(arg0, 6, b"BTM", b"Bitmoon", b"Bitmoon a coin for the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibx6x4wenjynvaatydktzido5knkpcpnsculle2cj6qg3fuxkq4um")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BTM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

