module 0x2531fac16e7f261869d07351a11aeccad32a8f52ad08bf27b1bf03c6ef5770cf::my_test_coin {
    struct MY_TEST_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_TEST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_TEST_COIN>(arg0, 11, b"MY_TEST_COIN", b"my test coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MY_TEST_COIN>(&mut v2, 9999999900000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_TEST_COIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MY_TEST_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

