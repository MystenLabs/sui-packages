module 0x7b25cfc7f9e9b6ec9e90224c36496b22419edaa4e527b04c3c4eccd13d4aedfe::cb_btc {
    struct CB_BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CB_BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CB_BTC>(arg0, 8, 0x1::string::utf8(b"cbBTC"), 0x1::string::utf8(b"Coinbase Wrapped BTC"), 0x1::string::utf8(b"Test Coinbase Wrapped BTC for the su protocol"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CB_BTC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CB_BTC>>(0x2::coin_registry::finalize<CB_BTC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

