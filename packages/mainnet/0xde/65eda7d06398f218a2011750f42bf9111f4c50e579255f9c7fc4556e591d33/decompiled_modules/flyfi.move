module 0xde65eda7d06398f218a2011750f42bf9111f4c50e579255f9c7fc4556e591d33::flyfi {
    struct FLYFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLYFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYFI>(arg0, 6, b"FLYFI", b"Flyfi sui", b"FlyFi  like DeFi, but with wings", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibb5vvvnlqclalwk7bwbkqgzkfx3gdylccomkoou72fkywej63go4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLYFI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

