module 0x7e4c911b0003178d48cd5a484580232ec5aab5f801578208bddfe80b40b70eb::neo {
    struct NEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NEO>(arg0, 6, b"NEO", b"Agent Neo", b"An autonomous agent created on the sui blockchain destined for greatness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Unknown_2_b5740f309d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

