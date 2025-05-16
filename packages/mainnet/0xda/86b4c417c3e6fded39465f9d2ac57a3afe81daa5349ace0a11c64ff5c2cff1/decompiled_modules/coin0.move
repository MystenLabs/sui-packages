module 0xda86b4c417c3e6fded39465f9d2ac57a3afe81daa5349ace0a11c64ff5c2cff1::coin0 {
    struct COIN0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN0>(arg0, 9, b"TICKER0", b"coin0", b"description0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/c8cd55c1-d051-450a-b9e9-aa2676c012e5.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN0>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN0>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

