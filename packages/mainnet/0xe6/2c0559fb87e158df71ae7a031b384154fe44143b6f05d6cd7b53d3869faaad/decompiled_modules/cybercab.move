module 0xe62c0559fb87e158df71ae7a031b384154fe44143b6f05d6cd7b53d3869faaad::cybercab {
    struct CYBERCAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERCAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERCAB>(arg0, 6, b"Cybercab", b"cybercab", b"Robotaxi/cybercab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P6yqkkb_NFDX_5e_U_Fr8vo_Wvex_CK_Bt_FA_6_V3_Tv_Gjro_Re9_R_Rg_8f75e71b0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERCAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBERCAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

