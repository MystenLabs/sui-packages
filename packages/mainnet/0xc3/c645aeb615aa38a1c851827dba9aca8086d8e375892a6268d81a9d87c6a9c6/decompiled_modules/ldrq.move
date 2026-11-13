module 0xc3c645aeb615aa38a1c851827dba9aca8086d8e375892a6268d81a9d87c6a9c6::ldrq {
    struct LDRQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDRQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LDRQ>(arg0, 6, 0x1::string::utf8(b"LDRQ"), 0x1::string::utf8(b"LDRQ bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDRQ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LDRQ>>(0x2::coin_registry::finalize<LDRQ>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

