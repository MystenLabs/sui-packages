module 0x7581fddaa878e2ea6d553aab3ada9acf825f40caaa22fca21f52f79799c39e75::nigga {
    struct NIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGA>(arg0, 6, b"Nigga", b"Nigga AI", b"Nigga Artificial Intelligence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uv_Zm_Vd7z69hu_Viz_T_Gvnur8_AE_2_Qm_V_Jo_Spd_EM_Vv_VX_Jw_Vqw_acf06205e9.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

