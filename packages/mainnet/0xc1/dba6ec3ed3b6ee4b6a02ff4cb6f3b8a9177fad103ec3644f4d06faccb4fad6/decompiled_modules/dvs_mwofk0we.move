module 0xc1dba6ec3ed3b6ee4b6a02ff4cb6f3b8a9177fad103ec3644f4d06faccb4fad6::dvs_mwofk0we {
    struct DVS_MWOFK0WE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MWOFK0WE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::sale_token::new<DVS_MWOFK0WE>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mwofk0we"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::sealed_treasury_cap::SealedTreasuryCap<DVS_MWOFK0WE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MWOFK0WE>>(0x2::coin_registry::finalize<DVS_MWOFK0WE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

