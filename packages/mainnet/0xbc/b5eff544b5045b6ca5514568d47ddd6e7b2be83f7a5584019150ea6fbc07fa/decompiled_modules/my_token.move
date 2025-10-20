module 0xbcb5eff544b5045b6ca5514568d47ddd6e7b2be83f7a5584019150ea6fbc07fa::my_token {
    struct MY_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_TOKEN>(arg0, 6, b"MYTOKEN", b"My Token", b"My custom token on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

