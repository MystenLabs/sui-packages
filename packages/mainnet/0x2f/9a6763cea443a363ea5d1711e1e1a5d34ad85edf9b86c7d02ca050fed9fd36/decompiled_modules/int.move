module 0x2f9a6763cea443a363ea5d1711e1e1a5d34ad85edf9b86c7d02ca050fed9fd36::int {
    struct INT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INT>(arg0, 6, b"INT", b"AIINT", b"This is the biggest conspiracy memecoin has ever seen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yk_Lguq_Zks_D_Jg_Lq_KEZ_66m_J_Mxvt_C4_Md_S29_SDU_Eq6w_Fj_MTM_fdc6b70dbd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INT>>(v1);
    }

    // decompiled from Move bytecode v6
}

