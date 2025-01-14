module 0xb3189e92863968f07d7eaa01b2cc08dd8b8871a8dfdd61c1342a6022c7225cdb::aaia {
    struct AAIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAIA>(arg0, 6, b"AAIA", b"AAIA by SuiAI", b"AAIA stands for 'Advanced Algorithmic Intelligence Agent,' your AI-powered companion for navigating the volatile waters of cryptocurrency trading on the SuiAgents.ai platform. Designed to be at the forefront of automated trading, AAIA brings:..Strategic Depth: With a suite of algorithmic strategies at its core, AAIA can cater to various trading philosophies, from high-frequency trading to holding assets for potential long-term gains..Market Vigilance: It never sleeps, constantly scanning for opportunities or threats that could affect your portfolio, acting on your behalf with precision..Personalized Control: While AAIA is autonomous, it respects your trading ethos, allowing you to define how aggressive or conservative your trading should be..Learning and Evolution: AAIA doesn't just trade; it learns. It analyzes the outcomes of its trades to better understand market nuances, potentially enhancing future performance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/AAIA_ea017b2708.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

