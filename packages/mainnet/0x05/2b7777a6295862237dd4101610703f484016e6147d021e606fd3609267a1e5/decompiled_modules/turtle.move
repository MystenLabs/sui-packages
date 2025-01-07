module 0x52b7777a6295862237dd4101610703f484016e6147d021e606fd3609267a1e5::turtle {
    struct TURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTLE>(arg0, 6, b"TURTLE", b"BabyTurtle", b"TURTLE Token: Secure, Stable, and Sustainable Cryptocurrency* TURTLE is a revolutionary cryptocurrency designed for long-term wealth creation, prioritizing stability, security, and sustainability. *Key Features:* 1. Stablecoin Integration: Minimizes price fluctuations 2. Decentralized Finance (DeFi) Platform: Low-risk yield farming and lending 3. Expert-Managed Investment Funds: Diversified portfolios 4. Community Governance: Transparent decision-making 5. Advanced Security: Multi-layer encryption and regular audits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vas_Mh1_CWH_Qife_H_Bwhe_ZC_3_Z7227a_Md_ES_Wo6c9_BE_Vi7a_Cq_4b73db2d25.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

