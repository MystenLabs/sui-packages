module 0x610280d0c4b0edcb1b6c48c153513dd41bb90abebd11f1c05471254e628ade9::cb_btc {
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

