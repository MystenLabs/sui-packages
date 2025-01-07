module 0xf7d7698f889a1f442dd6b9e3ed80a4dba7fd687e21c2b9f4d24eb3c7dbeee2e7::cybercab {
    struct CYBERCAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERCAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<CYBERCAB>(arg0, 6, b"Cybercab", b"cybercab", b"Robotaxi/cybercab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P6yqkkb_NFDX_5e_U_Fr8vo_Wvex_CK_Bt_FA_6_V3_Tv_Gjro_Re9_R_Rg_4b06d0fe66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERCAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<CYBERCAB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBERCAB>>(v2);
    }

    // decompiled from Move bytecode v6
}

