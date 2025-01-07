module 0x8004f90969b4741715e4e45eba360437841b56717194bc6e29d5188412a5b6cc::pete {
    struct PETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETE>(arg0, 6, b"PETE", b"PETE ON SUI", x"506570652773206361740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zz_Sgvrn8ms_V_Yvsu_CT_Rrz_DD_3pt_N59_Cjj_Za_HS_9b_J5_Zc_T41_9e63ce96f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETE>>(v1);
    }

    // decompiled from Move bytecode v6
}

