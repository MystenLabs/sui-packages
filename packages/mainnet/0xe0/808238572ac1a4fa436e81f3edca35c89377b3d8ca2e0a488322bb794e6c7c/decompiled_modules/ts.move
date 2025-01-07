module 0xe0808238572ac1a4fa436e81f3edca35c89377b3d8ca2e0a488322bb794e6c7c::ts {
    struct TS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TS>(arg0, 6, b"TS", b"Turbo Soda", x"4675656c20796f75722066756e205769746820547572626f20536f6461210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmad_J_Aga8kk_G9_Gmze_FV_Qh_SS_7_A_Am_Ns_Pa6a_Yi_M_Pq_Cb3e_U_Dg_H_bca22f15ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TS>>(v1);
    }

    // decompiled from Move bytecode v6
}

