module 0xed1a4dab5b8dc6a08d289080e102fa63b0244921a8d30c650f7bf3a552f36016::dvs_mw5stxfl {
    struct DVS_MW5STXFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MW5STXFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::sale_token::new<DVS_MW5STXFL>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mw5stxfl"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::sealed_treasury_cap::SealedTreasuryCap<DVS_MW5STXFL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MW5STXFL>>(0x2::coin_registry::finalize<DVS_MW5STXFL>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

