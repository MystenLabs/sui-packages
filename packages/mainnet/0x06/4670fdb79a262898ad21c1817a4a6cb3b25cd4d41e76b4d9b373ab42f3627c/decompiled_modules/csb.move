module 0x64670fdb79a262898ad21c1817a4a6cb3b25cd4d41e76b4d9b373ab42f3627c::csb {
    struct CSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CSB>(arg0, 6, 0x1::string::utf8(b"CSB"), 0x1::string::utf8(b"CSB bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CSB>>(0x2::coin_registry::finalize<CSB>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

