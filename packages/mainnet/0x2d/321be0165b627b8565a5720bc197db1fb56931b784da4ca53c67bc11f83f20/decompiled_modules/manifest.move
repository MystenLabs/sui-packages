module 0x2d321be0165b627b8565a5720bc197db1fb56931b784da4ca53c67bc11f83f20::manifest {
    struct MANIFEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANIFEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANIFEST>(arg0, 6, b"MANIFEST", b"Manifest", b"Make your dream become your reality", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_Sexb_C6p_UH_Tz_T_Dfe_G_Nwzs_Did4_Cm_Cqa_WL_Tiv_Ca1ew1_Ke_P_239fe3357b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANIFEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANIFEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

