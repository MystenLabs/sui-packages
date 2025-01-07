module 0x9664a3199d936a62a0f0e42a9ee042a098e8601135d933b4a39b645f532e961b::babyrussell {
    struct BABYRUSSELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYRUSSELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYRUSSELL>(arg0, 6, b"BABYRUSSELL", b"Baby Russell", b"BABYRUSSELL SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme1_CT_Sist_R_Vcf_Ydk1_Hq8_Jh_WN_5g_Zt_F_Ze_Ue_G_Hjq_X_Kb_Ld11_W_4ade4d93c6.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYRUSSELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYRUSSELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

