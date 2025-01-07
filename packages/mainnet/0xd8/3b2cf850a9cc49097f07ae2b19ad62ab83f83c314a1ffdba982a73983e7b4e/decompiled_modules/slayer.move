module 0xd83b2cf850a9cc49097f07ae2b19ad62ab83f83c314a1ffdba982a73983e7b4e::slayer {
    struct SLAYER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAYER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAYER>(arg0, 6, b"SLAYER", b"Don't mess with me or I will kill you", b"Cute on the outside, dangerous on the inside. This feathered friend is ready to slice through the competition and rule the meme world. Don't underestimate the bird.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ag_AC_Ag_IA_Axk_BAA_Fcjndn_YW_i_Eup_GV_7_U_Oh_QIJ_Ju_T63_Fq1_SQAC_Mv_Ix_G1u5_C_Uu5_XT_5m_W1_Ficg_EA_Aw_IAA_3g_A_Az_YE_335e96201d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAYER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAYER>>(v1);
    }

    // decompiled from Move bytecode v6
}

