module 0x50d57ad2c90d48b9c94134ed10480727ba7ed0d24d90b2d336a7894757069cb8::learnai {
    struct LEARNAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEARNAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEARNAI>(arg0, 6, b"LEARNAI", b"LEARN AI", b"introduces Learn AI as a versatile learning assistant that responds to questions, adapts to the user's needs, and facilitates learning interactively. It emphasizes the AI's role in providing answers and supporting the learning process.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R_Mm_Eap_H9y3fe_P_Ma7_E8ri_P5i_Q_Sp2trtr_Lju_RJ_Zr_Wow_U_Cv_b7ec8022b0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEARNAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEARNAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

