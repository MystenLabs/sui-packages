module 0x86888d1e8ec053aa3e681bf82151022b8b733c0d0811d781886d8ebb65f95192::tbx {
    struct TBX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TBX>(arg0, 6, 0x1::string::utf8(b"TBX"), 0x1::string::utf8(b"TBX bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TBX>>(0x2::coin_registry::finalize<TBX>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

