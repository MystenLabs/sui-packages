module 0xdfa852d02b9078a271ea073ce313c8f28b5f64fbc2119796a6311cefdc8c39be::MY_COIN_NEW {
    struct MY_COIN_NEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_COIN_NEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MY_COIN_NEW>(arg0, 6, 0x1::string::utf8(b"MY_COIN"), 0x1::string::utf8(b"My Coin"), 0x1::string::utf8(b"Standard Unregulated Coin"), 0x1::string::utf8(b"https://cryptologos.cc/logos/bitcoin-btc-logo.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN_NEW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MY_COIN_NEW>>(0x2::coin_registry::finalize<MY_COIN_NEW>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

