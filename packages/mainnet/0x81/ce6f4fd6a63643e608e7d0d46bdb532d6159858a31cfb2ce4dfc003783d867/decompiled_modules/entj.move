module 0x81ce6f4fd6a63643e608e7d0d46bdb532d6159858a31cfb2ce4dfc003783d867::entj {
    struct ENTJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENTJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENTJ>(arg0, 6, b"ENTJ", b"ENTJ Coin", b"ENTJ-A / ENTJ-T Commander Bold and strategic leaders, always seeking to overcome challenges and achieve their vision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wh_E_Lf_Rt_F_Rk_D_Fz_Y_Enur6a_N8yea_Tu_Mk_Bmx8_Qn32_X9u_M4_Pf_ca7fefad90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENTJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENTJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

