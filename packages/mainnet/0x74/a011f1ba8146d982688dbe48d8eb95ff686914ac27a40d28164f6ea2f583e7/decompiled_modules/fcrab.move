module 0x74a011f1ba8146d982688dbe48d8eb95ff686914ac27a40d28164f6ea2f583e7::fcrab {
    struct FCRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCRAB>(arg0, 6, b"FCrab", b"Frog Crab", b"Frog Crab LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_U4a_N_Jtx_Szs_Fqe_G1_KUWY_5_S_Vk6_R_Li_W_Wqq_Q9_X_Ud_Mk8p_E6_Xx_9c862a85c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCRAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

