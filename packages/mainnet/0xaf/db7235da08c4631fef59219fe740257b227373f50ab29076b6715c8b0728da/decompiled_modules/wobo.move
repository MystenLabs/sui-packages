module 0xafdb7235da08c4631fef59219fe740257b227373f50ab29076b6715c8b0728da::wobo {
    struct WOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOBO>(arg0, 6, b"WOBO", b"Wobo On Sui", b"WOBO TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdj1_LX_Vh_XN_Bw_Sb_K_Toaw_YBDE_6_Vc59_Ad_Kb6m_RKZ_9r4mxh_Z9_c00c32e8d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

