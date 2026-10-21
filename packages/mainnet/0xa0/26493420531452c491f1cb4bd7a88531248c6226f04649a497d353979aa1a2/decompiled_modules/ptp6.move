module 0xa026493420531452c491f1cb4bd7a88531248c6226f04649a497d353979aa1a2::ptp6 {
    struct PTP6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTP6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PTP6>(arg0, 6, 0x1::string::utf8(b"PTP6"), 0x1::string::utf8(b"POPULAR presale test P6"), 0x1::string::utf8(b"POPULAR integration test, not a real coin"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTP6>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PTP6>>(0x2::coin_registry::finalize<PTP6>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

