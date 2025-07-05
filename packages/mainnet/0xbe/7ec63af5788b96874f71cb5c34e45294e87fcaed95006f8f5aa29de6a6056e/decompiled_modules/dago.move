module 0xbe7ec63af5788b96874f71cb5c34e45294e87fcaed95006f8f5aa29de6a6056e::dago {
    struct DAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGO>(arg0, 6, b"DAGO", b"Dago Coin", b"Dago thr wild panda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiajp2ug6unahktn4ds6rwo5omadjsiq3sh5nokoizylyyfl5prqya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

