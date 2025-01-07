module 0xa01d955de73d0e32b7fc28a9edc3caaf32e3ee6b90a105454fb91f51d887d532::mr66 {
    struct MR66 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MR66, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MR66>(arg0, 6, b"MR66", b"SUIMR.66", b"@dogssaveworld", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R2t_Nf_Po_UK_Rujfinz_Tnr_Nua_C4_FU_Js_T_Wg_DUW_Fxrxumeud_S_d3cdb809c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MR66>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MR66>>(v1);
    }

    // decompiled from Move bytecode v6
}

