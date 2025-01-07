module 0xb2782eea3a62544ca072328846fcbb2bbb303192987429f502991a60b9c1f04d::fiona {
    struct FIONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIONA>(arg0, 6, b"FIONA", b"SUI FIONA", b"SUI FIONA MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uq_FS_Ci_Lk29_T77_K_Kh_Bs_X_Fmb_FKW_Errw_Qanpv_Ht_ZYH_82m_QL_e385d09fdc.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

