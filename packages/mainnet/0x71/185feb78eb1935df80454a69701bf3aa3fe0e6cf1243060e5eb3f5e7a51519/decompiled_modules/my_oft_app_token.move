module 0x71185feb78eb1935df80454a69701bf3aa3fe0e6cf1243060e5eb3f5e7a51519::my_oft_app_token {
    struct MY_OFT_APP_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_OFT_APP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MY_OFT_APP_TOKEN>(arg0, 6, b"MYOFTAPP", b"MyOftApp Token", b"My OFTApp Token", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_OFT_APP_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MY_OFT_APP_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_OFT_APP_TOKEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

