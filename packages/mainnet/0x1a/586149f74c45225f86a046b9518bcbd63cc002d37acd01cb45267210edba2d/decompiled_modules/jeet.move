module 0x1a586149f74c45225f86a046b9518bcbd63cc002d37acd01cb45267210edba2d::jeet {
    struct JEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEET>(arg0, 6, b"Jeet", b"Jeet Club", b"Jeeters NFTs on $SUI . do you jeet enough Annon?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiayuqbeusitcqvysnhtjwotqlcito6bqfowkz7jflhbc56y3qaqiu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JEET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

