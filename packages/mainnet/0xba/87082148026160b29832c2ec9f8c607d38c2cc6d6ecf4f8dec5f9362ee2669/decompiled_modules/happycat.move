module 0xba87082148026160b29832c2ec9f8c607d38c2cc6d6ecf4f8dec5f9362ee2669::happycat {
    struct HAPPYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HAPPYCAT>(arg0, 6, b"HAPPYCAT", b"", b"", 0x1::option::none<0x2::url::Url>(), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAPPYCAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HAPPYCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

