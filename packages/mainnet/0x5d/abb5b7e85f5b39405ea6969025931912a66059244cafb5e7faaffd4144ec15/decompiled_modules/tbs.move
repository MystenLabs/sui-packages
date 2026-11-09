module 0x5dabb5b7e85f5b39405ea6969025931912a66059244cafb5e7faaffd4144ec15::tbs {
    struct TBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TBS>(arg0, 6, 0x1::string::utf8(b"TBS"), 0x1::string::utf8(b"TBS bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TBS>>(0x2::coin_registry::finalize<TBS>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

