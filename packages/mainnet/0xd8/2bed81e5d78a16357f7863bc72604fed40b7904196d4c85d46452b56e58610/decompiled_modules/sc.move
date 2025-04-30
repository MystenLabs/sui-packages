module 0xd82bed81e5d78a16357f7863bc72604fed40b7904196d4c85d46452b56e58610::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SC>(arg0, 6, b"SC", b"Shrimps Coin", b"Shrimps $10 and Dream", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreialpohcmepznragsdzasn35ha33c35hn42mp6bykwbvwgfsc2o7hu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

