module 0x81009f9e7b2385b5293c910a60a4935f931e362c6109f7a253b9d9879df5ecff::my_test_meta_yes {
    struct MY_TEST_META_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_TEST_META_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_TEST_META_YES>(arg0, 0, b"MY_TEST_META_YES", b"MY_TEST_META YES", b"MY_TEST_META YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MY_TEST_META_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_TEST_META_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

