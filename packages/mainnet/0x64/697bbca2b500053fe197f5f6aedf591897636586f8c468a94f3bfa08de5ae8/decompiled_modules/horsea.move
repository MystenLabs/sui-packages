module 0x64697bbca2b500053fe197f5f6aedf591897636586f8c468a94f3bfa08de5ae8::horsea {
    struct HORSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORSEA>(arg0, 6, b"HORSEA", b"HORSEA SUI", b"HORSEA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidc63wumv4yvhqrbpu3q7x63u5ustyfdklrau5xubagpg3upbx2eu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORSEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HORSEA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

