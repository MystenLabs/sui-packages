module 0xb4dbdee7531a2ad2fcfc7d25b726197ebca88aaa18ea5c183b88cd7ce7c8c6cd::grop {
    struct GROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROP>(arg0, 6, b"GROP", b"GROPONSUI", b"$GROP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rf_HZJJG_Gk27bf8b_Hc_EPQ_Rv_Z_Dx_Pj_SUGY_9_Kc2z83_AC_Qgp_F_1b41738eb3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

