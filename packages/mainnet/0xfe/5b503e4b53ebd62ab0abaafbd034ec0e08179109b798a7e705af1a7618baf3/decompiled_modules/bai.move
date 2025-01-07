module 0xfe5b503e4b53ebd62ab0abaafbd034ec0e08179109b798a7e705af1a7618baf3::bai {
    struct BAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAI>(arg0, 6, b"BAI", b"Blaze Ai", x"f09f94a520426c617a65204149204d656d6520436f696e206973206e6f77206f6e20536f6c616e612026205375692120f09f9a8020576527726520657870616e64696e6720746f206861726e65737320626f7468206e6574776f726b732720706f7765722c20737072656164696e67206f7572206272616e6420676c6f62616c6c7920f09f8c8d2e2050726f75642073706f6e736f72206f6620426c617a652e61692c207468652041492d64726976656e20636f6e74656e74206372656174696f6e20706c6174666f726d2120f09fa496204a6f696e20746865207265766f6c7574696f6e20746f6461792120f09f998c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735681107036.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

