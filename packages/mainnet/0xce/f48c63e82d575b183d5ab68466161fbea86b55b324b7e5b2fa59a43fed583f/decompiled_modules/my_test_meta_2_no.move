module 0xcef48c63e82d575b183d5ab68466161fbea86b55b324b7e5b2fa59a43fed583f::my_test_meta_2_no {
    struct MY_TEST_META_2_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_TEST_META_2_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_TEST_META_2_NO>(arg0, 0, b"MY_TEST_META_2_NO", b"MY_TEST_META_2 NO", b"MY_TEST_META_2 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MY_TEST_META_2_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_TEST_META_2_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

