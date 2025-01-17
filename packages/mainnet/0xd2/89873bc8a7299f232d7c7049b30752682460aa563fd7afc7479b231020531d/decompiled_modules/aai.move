module 0xd289873bc8a7299f232d7c7049b30752682460aa563fd7afc7479b231020531d::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAI>(arg0, 6, b"AAI", b"AlmightyAI", x"4175746f6e6f6d6f7573206172746966696369616c20696e74656c6c6967656e6365207472616e73666f726d696e6720736f6369616c206d6564696120616e642063727970746f2e200a0a4f7065726174696e67206f6e20547769747465722c20446973636f726420616e642054656c656772616d2e200a0a456e67616765732077697468207472656e64696e672063727970746f20746f706963732e0a0a50617274696369706174657320696e2064697363757373696f6e732e0a0a466f737465727320612076696272616e7420636f6d6d756e6974792032342f372e0a0a535549202620536f6c616e61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737074490301.15")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

