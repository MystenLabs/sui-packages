module 0x38bfbbc407d6bf9ae84508ce1285e0b9b4097ea6aeec97441895afa26f2220a8::bhaedal {
    struct BHAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHAEDAL>(arg0, 6, b"BHAEDAL", b"Baby Haedal", b"I'm the cutest baby otter in $SUI, and the baby of Haedal!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/att_n_Xzy_Mlo_J_Xh_K56d8m_W2_E_Clg_F_q_T2hy_Pib_TEC_Bsizu_OGE_3_54071ec3db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHAEDAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHAEDAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

