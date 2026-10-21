module 0xcce5d169bfd9976b4120a744650e62f2fe2d6b3aea60d5bea498a1e290bba56a::ptp4 {
    struct PTP4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTP4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PTP4>(arg0, 6, 0x1::string::utf8(b"PTP4"), 0x1::string::utf8(b"POPULAR presale test P4"), 0x1::string::utf8(b"POPULAR integration test, not a real coin"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTP4>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PTP4>>(0x2::coin_registry::finalize<PTP4>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

