module 0x534a73c106860825dc4f93f6804e283e807c1c2391507b8c1aa5d90595ce742d::ncsui {
    struct NCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCSUI>(arg0, 6, b"NCSUI", b"Nodecoin on SUI", b"Nodepay is a platform for AI trading and development. The mission is to provide an ecosystem for users to own and access AI with real time data intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc3fq_BWF_He77_V_Rs1388_Mgs83_VDZ_Wm_M_Da_LLJYZA_5g_FA_7_NM_efd04b9b97.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

