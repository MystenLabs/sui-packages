module 0x7d731f0ec63d700b6b2fd93e5aabd2e7e16cdeff174ab6730ba5f852093aad14::paopao {
    struct PAOPAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAOPAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAOPAO>(arg0, 6, b"PAOPAO", b"PAOPAO ON SUI", b"$PAOPAO is a playful memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbi_PKHX_Lq9_Jq_R_Am_UFG_3g_Lm_Zcu4_Jpt_Q_Cv3f_AQ_14p_Znj_Ga_Q_344704baaa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAOPAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAOPAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

