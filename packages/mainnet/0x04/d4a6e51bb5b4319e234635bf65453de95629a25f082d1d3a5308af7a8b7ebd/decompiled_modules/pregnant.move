module 0x4d4a6e51bb5b4319e234635bf65453de95629a25f082d1d3a5308af7a8b7ebd::pregnant {
    struct PREGNANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PREGNANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PREGNANT>(arg0, 6, b"Pregnant", b"Pregnant Man", x"424954434f494e20494e534352495054494f4e202331323420534f4c4420464f5220302e3934202442544320287e2435394b290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R1_M3k_HVCE_Gu_Rj_Fk_Mw3g_Tt_J_Vu_UE_946_K_Tw9_RP_Vij_Km6_Co_Y_9dbad4f439.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PREGNANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PREGNANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

