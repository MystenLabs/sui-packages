module 0x8c9b578a0eca6bd2b735fd3e8a8594e326bf07ae8b036dbcf794b11e9658717d::my_coin_new {
    struct MY_COIN_NEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_COIN_NEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MY_COIN_NEW>(arg0, 6, 0x1::string::utf8(b"MY_COIN"), 0x1::string::utf8(b"My Coin"), 0x1::string::utf8(b"Standard Unregulated Coin"), 0x1::string::utf8(b"https://example.com/my_coin.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN_NEW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MY_COIN_NEW>>(0x2::coin_registry::finalize<MY_COIN_NEW>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

