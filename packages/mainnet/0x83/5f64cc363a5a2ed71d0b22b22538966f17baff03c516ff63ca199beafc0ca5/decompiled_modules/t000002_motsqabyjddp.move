module 0x835f64cc363a5a2ed71d0b22b22538966f17baff03c516ff63ca199beafc0ca5::t000002_motsqabyjddp {
    struct T000002_MOTSQABYJDDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: T000002_MOTSQABYJDDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T000002_MOTSQABYJDDP>(arg0, 9, b"T000002", b"Test000002", b"Test 000002 token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmUDbgmzaBxuaHjXVBjmkdCnJFRMryKRxbV4TfWjFaz8u6")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T000002_MOTSQABYJDDP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T000002_MOTSQABYJDDP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

