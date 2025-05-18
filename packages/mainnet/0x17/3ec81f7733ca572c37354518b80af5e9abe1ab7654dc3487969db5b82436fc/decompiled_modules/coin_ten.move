module 0x173ec81f7733ca572c37354518b80af5e9abe1ab7654dc3487969db5b82436fc::coin_ten {
    struct COIN_TEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_TEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_TEN>(arg0, 9, b"cointen", b"coin ten", b"coin ten desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/876f57ef-7a08-4c6c-8bde-b40b1563911e.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_TEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_TEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

