module 0x5fc7bab1bfeb8a1f971164cdce6d8c6c73f1674367ad52265c2c1bce8dd42f59::rtest {
    struct RTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RTEST>(arg0, 9, 0x1::string::utf8(b"RTEST"), 0x1::string::utf8(b"Rehearsal test (no value)"), 0x1::string::utf8(b"Test token for a blast.fun presale migration rehearsal. It has no value and is never sold."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<RTEST>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

