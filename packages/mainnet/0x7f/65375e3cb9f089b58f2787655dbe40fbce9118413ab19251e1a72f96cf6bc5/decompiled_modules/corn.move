module 0x7f65375e3cb9f089b58f2787655dbe40fbce9118413ab19251e1a72f96cf6bc5::corn {
    struct CORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CORN>(arg0, 6, 0x1::string::utf8(b"CORN"), 0x1::string::utf8(b"CORNPOP"), 0x1::string::utf8(b"Just a corn waiting to pop."), 0x1::string::utf8(b"https://popularsui.xyz/media/9ab240d88c7c1191893c4b476de8d8d721bfd4281ca0f8bb62460a85e78b4303.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CORN>>(0x2::coin_registry::finalize<CORN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

