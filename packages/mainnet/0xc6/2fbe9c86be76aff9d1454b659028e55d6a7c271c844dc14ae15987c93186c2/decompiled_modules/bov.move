module 0xc62fbe9c86be76aff9d1454b659028e55d6a7c271c844dc14ae15987c93186c2::bov {
    struct BOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BOV>(arg0, 6, 0x1::string::utf8(b"BOV"), 0x1::string::utf8(b"BOV bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOV>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BOV>>(0x2::coin_registry::finalize<BOV>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

