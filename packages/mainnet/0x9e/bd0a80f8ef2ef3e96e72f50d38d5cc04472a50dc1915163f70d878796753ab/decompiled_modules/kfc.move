module 0x9ebd0a80f8ef2ef3e96e72f50d38d5cc04472a50dc1915163f70d878796753ab::kfc {
    struct KFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFC>(arg0, 6, b"KFC", b"Keep Fucking Clicking", x"6b656570206675636b696e6720636c69636b696e6720646177670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_PJF_Vr_SU_45b1h9wd_GB_3_Jdp_TVB_Ht9h_Cx1pq_CAZV_Zk4_Y_Tr_W_b95581e51a.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

