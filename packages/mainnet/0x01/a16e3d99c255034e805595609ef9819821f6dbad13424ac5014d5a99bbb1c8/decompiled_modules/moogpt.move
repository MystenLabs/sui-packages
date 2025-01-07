module 0x1a16e3d99c255034e805595609ef9819821f6dbad13424ac5014d5a99bbb1c8::moogpt {
    struct MOOGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOGPT>(arg0, 6, b"MooGPT", b"Moodeng GPT", b"Moodeng GPT_", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdb_N9_EA_Prgig_Xzz_T9d_Pf_JEF_Jk1pi_U8x7p7_Nv_QL_4_Jd_L_Wk3_93e8af672c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOGPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOGPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

