module 0xa0e938037b3b7629e433e77a75cbdf8b1c3a01c85ab54be9a847ec6c0296b0b2::dsadsad {
    struct DSADSAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSADSAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSADSAD>(arg0, 6, b"dsadsad", b"ffffff", b"2131223123213", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBVAXGHYNH66D7XPCXRWZ3M9/01JBXM9AGB0WSEFEYX2CY2JB8D")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSADSAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DSADSAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

