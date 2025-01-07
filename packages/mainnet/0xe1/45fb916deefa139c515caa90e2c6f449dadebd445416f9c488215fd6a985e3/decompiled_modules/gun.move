module 0xe145fb916deefa139c515caa90e2c6f449dadebd445416f9c488215fd6a985e3::gun {
    struct GUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUN>(arg0, 6, b"GUN", b"GUNS", b"GUN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcz_Ypy_Ne_T_Cp1a_U3_S8_F_Yu_Hg_Ue_Mzybs_U1_Hz_Q_Br6_Yrf_Mdq_SU_42a58d4986.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

