module 0x485958463eb1031f3d24af87995436e64828b4302ec18fa78cc5ef724e2c2d7e::happycat {
    struct HAPPYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HAPPYCAT>(arg0, 6, b"HAPPYCAT", b"", b"", 0x1::option::none<0x2::url::Url>(), false, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HAPPYCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAPPYCAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

