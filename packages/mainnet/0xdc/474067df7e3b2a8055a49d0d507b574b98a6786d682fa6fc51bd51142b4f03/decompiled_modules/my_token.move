module 0xdc474067df7e3b2a8055a49d0d507b574b98a6786d682fa6fc51bd51142b4f03::my_token {
    struct MY_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_TOKEN>, arg1: 0x2::coin::Coin<MY_TOKEN>) {
        0x2::coin::burn<MY_TOKEN>(arg0, arg1);
    }

    fun init(arg0: MY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_TOKEN>(arg0, 9, b"MTK", b"My Token", b"A simple token for testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MY_TOKEN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MY_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

