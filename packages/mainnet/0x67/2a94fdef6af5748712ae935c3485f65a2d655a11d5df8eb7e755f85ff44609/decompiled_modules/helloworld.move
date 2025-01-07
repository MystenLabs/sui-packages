module 0x672a94fdef6af5748712ae935c3485f65a2d655a11d5df8eb7e755f85ff44609::helloworld {
    struct HELLOWORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLOWORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLOWORLD>(arg0, 6, b"helloworld", b"hello", b"hellohellohello", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBGJB20BZT7YN0G058SNDBT3/01JBGJB3SRMPM84GXD7PVSD9EY")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLOWORLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELLOWORLD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

