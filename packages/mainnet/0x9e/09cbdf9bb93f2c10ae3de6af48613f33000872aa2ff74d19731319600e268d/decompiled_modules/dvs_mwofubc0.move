module 0x9e09cbdf9bb93f2c10ae3de6af48613f33000872aa2ff74d19731319600e268d::dvs_mwofubc0 {
    struct DVS_MWOFUBC0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MWOFUBC0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::sale_token::new<DVS_MWOFUBC0>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mwofubc0"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::sealed_treasury_cap::SealedTreasuryCap<DVS_MWOFUBC0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MWOFUBC0>>(0x2::coin_registry::finalize<DVS_MWOFUBC0>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

