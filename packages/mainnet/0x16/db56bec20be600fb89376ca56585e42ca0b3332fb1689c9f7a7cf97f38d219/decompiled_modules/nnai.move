module 0x16db56bec20be600fb89376ca56585e42ca0b3332fb1689c9f7a7cf97f38d219::nnai {
    struct NNAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNAI>(arg0, 6, b"NNAI", b"NeuralNetAI", b"NeuralNetAI is a breakthrough technology that transforms complex neural networks into intuitive 3D visualizations. Through its advanced modular engine, users can observe real-time neural network behavior with dynamic Wave, Spiral, and Pulse patterns. The platform combines cutting-edge visualization technology with customizable parameters, making AI architecture more accessible and understandable than ever before.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_G_Bccok_L6_Lt4eu_Ujn_A1_Zv_Sa53_Jy74x9_Ee_Ld4_B9_J_Lnhr_K_94d176bdde.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NNAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

