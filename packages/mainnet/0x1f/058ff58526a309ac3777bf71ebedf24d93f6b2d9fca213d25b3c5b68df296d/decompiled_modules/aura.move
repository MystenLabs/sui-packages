module 0x1f058ff58526a309ac3777bf71ebedf24d93f6b2d9fca213d25b3c5b68df296d::aura {
    struct AURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURA>(arg0, 6, b"AURA", b"Aura SUI", b"Aura surpasses everything anon. Do you have $AURA ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P3_L7t_Wyc_Yn_ZH_9sc_Hq_JC_Ynp_St_Q_Muum_Dt_Cc_Zw_Vjo_Ds_Es5o_5b5553f0b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

