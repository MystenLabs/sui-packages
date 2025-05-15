module 0x72fa59b87011af882441c585e3dcc1ac24de2c8b8ec1e0a11b7e69e9a4c214f9::snorlax {
    struct SNORLAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNORLAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNORLAX>(arg0, 6, b"SNORLAX", b"SNORELAX", x"24534e4f5245206973206120686967686c7920736c6565707920506f6bc3a96d6f6e2c206b6e6f776e20666f7220636f6e7374616e746c7920736c656570696e672e2057616b652068696d20757020696e20776f726c64206f6620245355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeice25lddedfpajywbmzn6miplppf3uktzl4rufnvjm5jddlmryzb4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNORLAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNORLAX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

