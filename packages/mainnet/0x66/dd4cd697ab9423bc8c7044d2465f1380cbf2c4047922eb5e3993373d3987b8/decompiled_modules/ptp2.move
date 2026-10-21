module 0x66dd4cd697ab9423bc8c7044d2465f1380cbf2c4047922eb5e3993373d3987b8::ptp2 {
    struct PTP2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTP2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PTP2>(arg0, 6, 0x1::string::utf8(b"PTP2"), 0x1::string::utf8(b"POPULAR presale test P2"), 0x1::string::utf8(b"POPULAR integration test, not a real coin"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTP2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PTP2>>(0x2::coin_registry::finalize<PTP2>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

