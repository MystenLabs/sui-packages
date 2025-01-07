module 0xa8c1af846c81c394ab6d4a7edd010192852358297c7aa62005512951e5c39fec::maba {
    struct MABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MABA>(arg0, 6, b"MABA", b"Make America Based Again", x"4d616b6520416d657269636120426173656420416761696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V3szm_Nj9_R_Ptr_WG_Wkk_RGNH_9_K_Xx7p_Z5_R5_Cvp_WQ_Niyxrk_Kd_3e03c79e7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

