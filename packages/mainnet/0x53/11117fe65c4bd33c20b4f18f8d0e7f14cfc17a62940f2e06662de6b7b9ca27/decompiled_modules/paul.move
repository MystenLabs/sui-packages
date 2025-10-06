module 0x5311117fe65c4bd33c20b4f18f8d0e7f14cfc17a62940f2e06662de6b7b9ca27::paul {
    struct PAUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PAUL>(arg0, 9, 0x1::string::utf8(b"CAT"), 0x1::string::utf8(b"Cat"), 0x1::string::utf8(b"11111"), 0x1::string::utf8(b"222.jpg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PAUL>>(0x2::coin_registry::finalize<PAUL>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAUL>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<PAUL>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<PAUL>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

