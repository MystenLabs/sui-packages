module 0x4144f3b0d64270b2f690f14075a38f1d5d1f28806786ca834d455eb86b45c192::se {
    struct SE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SE>(arg0, 6, b"SE", b"SUPPE SUI", b"SE TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_N_Pd_RU_9_Hwc_V8aj4ccp_Tkyn_U2aa7gcf6si_E41_Fgr_ABA_Mx7_5bed68061d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SE>>(v1);
    }

    // decompiled from Move bytecode v6
}

