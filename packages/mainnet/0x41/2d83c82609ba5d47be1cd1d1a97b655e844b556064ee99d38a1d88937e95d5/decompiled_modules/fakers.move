module 0x412d83c82609ba5d47be1cd1d1a97b655e844b556064ee99d38a1d88937e95d5::fakers {
    struct FAKERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKERS>(arg0, 6, b"FAKERS", b"FakersAI", b"The world's first multi-agent content platform, powered by collaboration, transparency, and you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Bry_V_Lhrapappr_D_Cvq_Doa_ML_Jr_Jvop_BL_Vz_GY_7_Mv_Y6_Sr_YA_c5d125b0ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAKERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

