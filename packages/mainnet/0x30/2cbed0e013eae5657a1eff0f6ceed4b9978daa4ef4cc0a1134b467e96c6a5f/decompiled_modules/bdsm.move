module 0x302cbed0e013eae5657a1eff0f6ceed4b9978daa4ef4cc0a1134b467e96c6a5f::bdsm {
    struct BDSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDSM>(arg0, 6, b"BDSM", b"bench driving smoking monkey", x"6661737420616620626f690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Umf_S_Bxg5uv_Wd1_Lu_XVF_8hko_Jx_Lg_EEW_9_V7qb2_J_Yxn_Yc2_VH_c3e5ea6c9d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

