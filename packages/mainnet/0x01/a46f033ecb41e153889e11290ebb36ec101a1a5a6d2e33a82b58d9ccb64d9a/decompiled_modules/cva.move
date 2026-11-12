module 0x1a46f033ecb41e153889e11290ebb36ec101a1a5a6d2e33a82b58d9ccb64d9a::cva {
    struct CVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CVA>(arg0, 6, 0x1::string::utf8(b"CVA"), 0x1::string::utf8(b"CVA bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CVA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CVA>>(0x2::coin_registry::finalize<CVA>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

