module 0x134b0c4cff35a510a44d120012daa6b29fc627e7bf15735f4ae4b62bfc88a8a1::testing {
    struct TESTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTING>(arg0, 6, b"Testing", b"Test", b"Testing123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie2s2vm4m6kxcbq5jf4ybegayvh4w2af5b5aqx5lxiwi6zdol3kqi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

