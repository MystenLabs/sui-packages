module 0xe25f17ee165c55718f849d0f37cedd26fe192f5c03a9c0e12274a33ba5dfa051::idxs {
    struct IDXS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDXS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<IDXS>(arg0, 6, 0x1::string::utf8(b"IDXS"), 0x1::string::utf8(b"IDXS index staging"), 0x1::string::utf8(b"Staging share coin of popular_index. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDXS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<IDXS>>(0x2::coin_registry::finalize<IDXS>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

