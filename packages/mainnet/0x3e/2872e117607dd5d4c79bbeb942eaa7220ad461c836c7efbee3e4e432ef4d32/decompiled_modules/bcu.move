module 0x3e2872e117607dd5d4c79bbeb942eaa7220ad461c836c7efbee3e4e432ef4d32::bcu {
    struct BCU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BCU>(arg0, 6, 0x1::string::utf8(b"BCU"), 0x1::string::utf8(b"BCU bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BCU>>(0x2::coin_registry::finalize<BCU>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

