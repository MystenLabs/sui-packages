module 0x3f75120bc8d20b1e7bec479b550419d6f2989060ef90aef41944039570b3bdbe::ramencat {
    struct RAMENCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAMENCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAMENCAT>(arg0, 6, b"RAMENCAT", b"Ramen Cat", b"One of Japan's most famous cats, ramen cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R_Tajh_Fws_BMXZ_6_Efq3fvr9_EP_2_Sn_A2h_YP_Wo_MB_Nc_F43e_C_Sf_ee9749bac3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAMENCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAMENCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

