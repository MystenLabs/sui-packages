module 0xfaf56ebc77e53c7d167e8c7715e319d8be642a1cf4c70f2adcc0a156082c4405::bcs {
    struct BCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BCS>(arg0, 6, 0x1::string::utf8(b"BCS"), 0x1::string::utf8(b"BCS bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BCS>>(0x2::coin_registry::finalize<BCS>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

