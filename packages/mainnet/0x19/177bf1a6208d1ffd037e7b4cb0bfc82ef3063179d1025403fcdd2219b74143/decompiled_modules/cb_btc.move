module 0x19177bf1a6208d1ffd037e7b4cb0bfc82ef3063179d1025403fcdd2219b74143::cb_btc {
    struct CB_BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CB_BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CB_BTC>(arg0, 8, 0x1::string::utf8(b"cbBTC"), 0x1::string::utf8(b"Coinbase Wrapped BTC"), 0x1::string::utf8(b"Test Coinbase Wrapped BTC for the su protocol"), 0x1::string::utf8(b"https://assets.coingecko.com/coins/images/40143/large/cbbtc.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CB_BTC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CB_BTC>>(0x2::coin_registry::finalize<CB_BTC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

