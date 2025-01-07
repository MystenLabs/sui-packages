module 0x87429cbb4f5b6bf8670382698b048f68f17ebb3bb137e892794aea97aa8d11dd::pshrimp {
    struct PSHRIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSHRIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSHRIMP>(arg0, 6, b"PSHRIMP", b"pistol shrimp", b"Pistol Shrimp: The Fastest Gun in the Sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qu12_Kzz_Bw_L_Ls86_P_Sfd2_L_Xp_W9ig_N2o_EZS_Yb_Uo_Bqou_PFY_6_78441d096b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSHRIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSHRIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

