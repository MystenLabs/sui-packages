module 0xe98e5b618ecdbb1de19451c8a6d489d1584b8b8e8e0acaf5710e78dfb1220aac::ptp1 {
    struct PTP1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTP1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PTP1>(arg0, 6, 0x1::string::utf8(b"PTP1"), 0x1::string::utf8(b"POPULAR presale test P1"), 0x1::string::utf8(b"POPULAR integration test, not a real coin"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTP1>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PTP1>>(0x2::coin_registry::finalize<PTP1>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

