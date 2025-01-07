module 0x9d170a03f364041ba7125ed28965d6ed84410858bb8ce725bec6180b8535d8a4::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 6, b"GOD", b"Gallery of Doge", x"53756368206172742e204d756368206d65746176657273652e20576f772067616c6c6572792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Znjr_V_Yx5_RC_1_Yemx_J_Ka98x_Sc_Pj_Zv_Hf_Mbz8pc7b_Hvt_P9b_F_02f78a1678.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

