module 0x1db3164a9943a64e171896b15b5f373c651e45dc57669866d594d5fb92836a9d::cvb {
    struct CVB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CVB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CVB>(arg0, 9, 0x1::string::utf8(b"CVB"), 0x1::string::utf8(b"hhbb"), 0x1::string::utf8(b"hhbb (CVB)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CVB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CVB>>(0x2::coin_registry::finalize<CVB>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

