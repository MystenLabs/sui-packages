module 0x13b4a5f3c68e47805d1eea3c1b236be7580cb1f4e690bd71be49fa7315a28a63::feet {
    struct FEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEET>(arg0, 9, b"FEET", b"FeeTest", b"fee claim test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FEET>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEET>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

