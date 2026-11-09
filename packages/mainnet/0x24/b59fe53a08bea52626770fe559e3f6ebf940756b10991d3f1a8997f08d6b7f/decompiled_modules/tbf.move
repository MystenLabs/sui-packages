module 0x24b59fe53a08bea52626770fe559e3f6ebf940756b10991d3f1a8997f08d6b7f::tbf {
    struct TBF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TBF>(arg0, 6, 0x1::string::utf8(b"TBF"), 0x1::string::utf8(b"TBF bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBF>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TBF>>(0x2::coin_registry::finalize<TBF>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

