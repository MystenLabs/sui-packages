module 0x659def636fc39ed502b7cb512b8ed4d61c60d261aede99bfdd5693ec3e184a31::magave {
    struct MAGAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAVE>(arg0, 6, b"MAGAVE", b"TRUMP MAGA DRIVE", b"16-BIT tribute to the Trump MAGA campaign", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yzg_Lj_D3ucd_Md_WXK_Qk_Bn_Yh_M14h_T3_Dto_C_No_AA_Js_B_Xdt_LAH_f02ccbedb3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

