module 0x60e57138d122b5d4b1957b121fb9d06867f2902394a34a6e5efa7a2f2f6e2e05::gyarados {
    struct GYARADOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GYARADOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYARADOS>(arg0, 6, b"GYARADOS", b"gyarados on sui", b"From Pokemon fans", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeideaeetau5x5ihhkxfrcv6p35x3gs5k7qynwybup64weepez2igfy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GYARADOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GYARADOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

