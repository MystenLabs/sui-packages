module 0xcef48c63e82d575b183d5ab68466161fbea86b55b324b7e5b2fa59a43fed583f::my_test_meta_2_yes {
    struct MY_TEST_META_2_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_TEST_META_2_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_TEST_META_2_YES>(arg0, 0, b"MY_TEST_META_2_YES", b"MY_TEST_META_2 YES", b"MY_TEST_META_2 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MY_TEST_META_2_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_TEST_META_2_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

