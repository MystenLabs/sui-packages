module 0x5cee0ad643ff57a1e8e2222eb3caa518be7492c84832f32255335a230e14a4aa::ptp3 {
    struct PTP3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTP3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PTP3>(arg0, 6, 0x1::string::utf8(b"PTP3"), 0x1::string::utf8(b"POPULAR presale test P3"), 0x1::string::utf8(b"POPULAR integration test, not a real coin"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTP3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PTP3>>(0x2::coin_registry::finalize<PTP3>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

