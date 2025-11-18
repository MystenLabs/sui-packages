module 0x743f4ef1f0f05d8af8ad9849de16051544a178a15d001d27989045057b2f0bee::WFLCN {
    struct WFLCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFLCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WFLCN>(arg0, 9, 0x1::string::utf8(b"WFLCN"), 0x1::string::utf8(b"WorkflowCoin"), 0x1::string::utf8(b"Batch deploy test"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<WFLCN>>(0x2::coin_registry::finalize<WFLCN>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WFLCN>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFLCN>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFLCN>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

