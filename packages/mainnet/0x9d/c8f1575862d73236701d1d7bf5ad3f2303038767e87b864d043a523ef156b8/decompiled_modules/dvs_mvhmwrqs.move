module 0x9dc8f1575862d73236701d1d7bf5ad3f2303038767e87b864d043a523ef156b8::dvs_mvhmwrqs {
    struct DVS_MVHMWRQS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVHMWRQS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVHMWRQS>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvhmwrqs"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVHMWRQS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVHMWRQS>>(0x2::coin_registry::finalize<DVS_MVHMWRQS>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

