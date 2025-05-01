module 0xcd15353e08cbe509f2dd41cbe52665f90a1ed63da5fa361696369711e5fff868::pmi {
    struct PMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMI>(arg0, 6, b"PMI", b"Palma", b"Lets go on tusich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiggbeshwvrcvyo35h42h2o7rovkmnvsab36kp42625pwe5cwamo7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PMI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

