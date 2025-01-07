module 0x9759bbcf7690bd60c32c0540e23611d41fcc5e6c985a7aadb1e04ab6100995f7::tadz {
    struct TADZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TADZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TADZ>(arg0, 6, b"TADZ", b"Agent Tadz", b"Your AI-powered assistant for Solana blockchain analysis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdzesox_GA_8eg_Dhg39_SA_Mm_Q_Ph_Y1p_Fg8w_Fxi_X_Wxa_M99o_E1f_43483bfa9d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TADZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TADZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

