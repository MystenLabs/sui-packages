module 0x6b2c5120c8c8fed9336e40a932f9fbfa05065be998f1be6dfee68ef0a73e3085::act {
    struct ACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACT>(arg0, 6, b"ACT", b"Act I : The AI Prophecy", x"4163742049203a205468652041492050726f70686563790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ufr_HN_Lqia7_Nmqgbz_HYGF_4rt_X75n_Ewuk_PFFU_1_Ysc_K_Kqu_L_02445152a4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACT>>(v1);
    }

    // decompiled from Move bytecode v6
}

