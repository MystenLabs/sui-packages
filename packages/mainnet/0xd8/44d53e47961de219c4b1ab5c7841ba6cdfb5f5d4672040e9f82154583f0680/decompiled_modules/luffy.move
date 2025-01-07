module 0xd844d53e47961de219c4b1ab5c7841ba6cdfb5f5d4672040e9f82154583f0680::luffy {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LUFFY>(arg0, 6, b"LUFFY", b"Luffy in action", x"5374726574636820796f7572206761696e73206c696b652072756262657220616e64207361696c20746f20746865206d6f6f6e2120f09f8c95e29a93", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/onepiec_9529076031.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUFFY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

