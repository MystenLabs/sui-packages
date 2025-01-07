module 0x62b38ea1667f0e511e292f253315e0042666830b32a4912e78a1d4d42d096bd1::magave {
    struct MAGAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAVE>(arg0, 6, b"MAGAVE", b"TRUMP MAGA DRIVE", b"16-BIT tribute to the Trump MAGA campaign", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yzg_Lj_D3ucd_Md_WXK_Qk_Bn_Yh_M14h_T3_Dto_C_No_AA_Js_B_Xdt_LAH_22186f3505.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

