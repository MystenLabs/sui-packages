module 0xd15d43ad9d36244563a7aa0cf520743034c18beb5602b3f7ffbd05393ab9e624::ponzi {
    struct PONZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONZI>(arg0, 6, b"PONZI", b"Just A Ponzi", x"54484953204953204120504f4e5a490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P_Wm_Cwu_Hnc_Hfhnm_Fvi8_Aqk_S7ggu93_QL_6jrv_D7qr_Kb_MP_Kg_00594a8190.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

