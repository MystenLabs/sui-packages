module 0x52c27544d53c48a7b62210f7867da5ac53192c8ac475dea15e4763a87fe1f57b::terio {
    struct TERIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERIO>(arg0, 6, b"TERIO", b"TERIO THE COMMANDER", b"Command and conquer. Blue or red. Terio has arrived to dominate. The unknown species from the outer world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiehvmdj6nkbcnn2otwcwofp3mj4xrsnfx5v6wcnymcnn6ogn4x36y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TERIO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

