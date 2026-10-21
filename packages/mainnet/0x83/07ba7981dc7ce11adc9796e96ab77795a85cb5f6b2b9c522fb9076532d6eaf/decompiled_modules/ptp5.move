module 0x8307ba7981dc7ce11adc9796e96ab77795a85cb5f6b2b9c522fb9076532d6eaf::ptp5 {
    struct PTP5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTP5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PTP5>(arg0, 6, 0x1::string::utf8(b"PTP5"), 0x1::string::utf8(b"POPULAR presale test P5"), 0x1::string::utf8(b"POPULAR integration test, not a real coin"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTP5>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PTP5>>(0x2::coin_registry::finalize<PTP5>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

