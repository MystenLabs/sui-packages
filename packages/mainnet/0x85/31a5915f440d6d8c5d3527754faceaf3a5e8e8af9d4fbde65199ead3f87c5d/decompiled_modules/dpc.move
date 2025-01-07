module 0x8531a5915f440d6d8c5d3527754faceaf3a5e8e8af9d4fbde65199ead3f87c5d::dpc {
    struct DPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPC>(arg0, 6, b"DPC", b"DJ PIZZA CAT", x"4c45545320474f4f4f4f4f20544f20544845204d4f4f4e4e4e4e2031303030580a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qs_SWBEWF_Kqt_Ndz_E_Lj_Jt175_Bz_M_Cc_Tw_Y_Zeo_Nbz_V_Fx_Tiu_AS_c44e92d19d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

