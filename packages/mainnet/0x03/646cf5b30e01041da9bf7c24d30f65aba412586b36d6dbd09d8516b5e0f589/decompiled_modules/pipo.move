module 0x3646cf5b30e01041da9bf7c24d30f65aba412586b36d6dbd09d8516b5e0f589::pipo {
    struct PIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPO>(arg0, 6, b"PIPO", b"SUI PIPO", x"54686520417065206861732045736361706564207c7c20554b4b4920554b4b49200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yep_C_Qn_C_Ju9_Lf_N_Mk_D6c_Dv8g_Xqi_B_Aj_Rq_S6wq_F7z_Bs_B4_PM_4_ffa2eb4a61.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

