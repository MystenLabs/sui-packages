module 0x98e0833e2bdfe21b849e37314920dbe0b82845374081e32efa887b271d3ee602::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 6, b"Q3W", b"qqqsw2768", b"Coin deployed by qqqsw2768", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
    }

    public entry fun mint_for(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MY_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

