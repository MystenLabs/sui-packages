module 0xd205e6d70b74d37851dc4c2b51719e8746c0c08eb48d5e80d77f75ab91d5682c::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: 0x2::coin::Coin<MY_COIN>) {
        0x2::coin::burn<MY_COIN>(arg0, arg1);
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 9, b"MYC", b"My Custom Coin", b"This is my custom coin on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

