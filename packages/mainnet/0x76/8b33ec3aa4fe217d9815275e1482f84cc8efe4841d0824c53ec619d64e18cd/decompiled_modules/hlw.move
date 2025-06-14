module 0x768b33ec3aa4fe217d9815275e1482f84cc8efe4841d0824c53ec619d64e18cd::hlw {
    struct HLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLW>(arg0, 6, b"HLW", b"Hello World", b"hello world, im testing...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbsJ6GuHxykyZB9jn42SgbWKuWPWiB3w4PmTSA58jCwMC")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HLW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

