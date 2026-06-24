module 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua {
    struct XAUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<XAUA>(arg0, 6, 0x1::string::utf8(b"XAUa"), 0x1::string::utf8(b"XAUa Gold Token"), 0x1::string::utf8(b"XAUa token represents issuer-operated tokenized gold settlement inventory."), 0x1::string::utf8(b""), arg1);
        let v2 = v0;
        0x2::coin_registry::finalize_and_delete_metadata_cap<XAUA>(v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAUA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XAUA>>(0x2::coin_registry::make_regulated<XAUA>(&mut v2, true, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

