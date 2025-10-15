module 0x852914eea46ef585a661e827afe67d3ca6e4c6f1817a320b08cc0c6255efb081::ging {
    struct GING has drop {
        dummy_field: bool,
    }

    fun init(arg0: GING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GING>(arg0, 9, 0x1::string::utf8(b"GING"), 0x1::string::utf8(b"GTing"), 0x1::string::utf8(b"GT"), 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/4eJHkzHW-iylwaX5TpkfwedvTfm1-SnmwZXMo9-YQoI"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GING>>(0x2::coin_registry::finalize<GING>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GING>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<GING>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<GING>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

