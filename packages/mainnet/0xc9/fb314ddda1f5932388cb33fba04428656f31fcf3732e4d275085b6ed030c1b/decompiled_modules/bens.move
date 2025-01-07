module 0xc9fb314ddda1f5932388cb33fba04428656f31fcf3732e4d275085b6ed030c1b::bens {
    struct BENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENS>(arg0, 6, b"BenS", b"Ben", b"Ben sat on the floor sadly, he wanted to go to ray.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wo_Q_Pjh_Lv1_Bnm_P_Ekvvi_S6_Z66v_L7ke_Ka_Rg3u8kj_Rs_Yvd1j_00e6ac18a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

