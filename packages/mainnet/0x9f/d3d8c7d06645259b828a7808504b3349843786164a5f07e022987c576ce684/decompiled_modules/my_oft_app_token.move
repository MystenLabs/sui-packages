module 0x9fd3d8c7d06645259b828a7808504b3349843786164a5f07e022987c576ce684::my_oft_app_token {
    struct MY_OFT_APP_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_OFT_APP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_OFT_APP_TOKEN>(arg0, 6, b"MYOFTAPP", b"MyOftApp Token", b"My OFTApp Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_OFT_APP_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_OFT_APP_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

