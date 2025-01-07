module 0x8265864481e639184eb47fdee4911d449124684ba70e49933bccbedc80b7ee9b::magnet {
    struct MAGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNET>(arg0, 6, b"Magnet", b"Magnet Sui", b"Magnet on Movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R1_M3k_HVCE_Gu_Rj_Fk_Mw3g_Tt_J_Vu_UE_946_K_Tw9_RP_Vij_Km6_Co_Y_58d60cf98e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

