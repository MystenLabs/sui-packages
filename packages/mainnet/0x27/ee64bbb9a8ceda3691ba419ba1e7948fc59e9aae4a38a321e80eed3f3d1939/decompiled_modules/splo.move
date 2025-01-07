module 0x27ee64bbb9a8ceda3691ba419ba1e7948fc59e9aae4a38a321e80eed3f3d1939::splo {
    struct SPLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLO>(arg0, 6, b"SPLO", b"SPLO ON SUI", b"$SPLO , a daring tadpole with a gambling habit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P_Gk6_Phxqwf_Bx_M_Kwgydk9du_UR_7_Q_Cmdtq_NQHWWB_Tb_G9_S1_S_6b8918c948.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

