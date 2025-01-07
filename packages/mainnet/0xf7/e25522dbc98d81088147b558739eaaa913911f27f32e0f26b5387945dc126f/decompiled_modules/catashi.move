module 0xf7e25522dbc98d81088147b558739eaaa913911f27f32e0f26b5387945dc126f::catashi {
    struct CATASHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATASHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATASHI>(arg0, 6, b"CATASHI", b"Catashi Nakamoto", b"Catashi Nakamoto on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zw_Dq7_M83_Dj5_E_Kz_YZ_Gd_NH_Cxr4fu_V_Zj_C_Uc_Mwxr8pj83_EFZ_e6e07b06bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATASHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATASHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

