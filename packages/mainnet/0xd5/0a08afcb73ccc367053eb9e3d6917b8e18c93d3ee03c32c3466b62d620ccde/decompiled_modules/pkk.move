module 0xd50a08afcb73ccc367053eb9e3d6917b8e18c93d3ee03c32c3466b62d620ccde::pkk {
    struct PKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKK>(arg0, 6, b"PKK", b"PUMPKIN KING", b"$PKK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R7_Dn_CV_7_Xms4_YP_Km6_Vb_Vpw_Z_Zo_MZ_9m_Nf_E_Pau7_Xyu_B_Lc_A_Mk_37e834e485.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

