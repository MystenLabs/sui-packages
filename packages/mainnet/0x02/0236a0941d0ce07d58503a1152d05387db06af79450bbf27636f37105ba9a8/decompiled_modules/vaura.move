module 0x20236a0941d0ce07d58503a1152d05387db06af79450bbf27636f37105ba9a8::vaura {
    struct VAURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAURA>(arg0, 6, b"VAURA", b"Villain AURA", b"Villain AURA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ra48_L5yp_Rf8n4_Nwu4_Ho4f_Z_Gs_NZP_4_B_Zb_L_Xa6i_Pk_VG_Lkaq_3b2a5382fb.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

