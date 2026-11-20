module 0xf9af17ecbc8bdc1682f1c40dd0821a2576ff029f24fb0abc0aed5f4d69d590dc::dvs_mwoga64r {
    struct DVS_MWOGA64R has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MWOGA64R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::sale_token::new<DVS_MWOGA64R>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mwoga64r"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::sealed_treasury_cap::SealedTreasuryCap<DVS_MWOGA64R>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MWOGA64R>>(0x2::coin_registry::finalize<DVS_MWOGA64R>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

