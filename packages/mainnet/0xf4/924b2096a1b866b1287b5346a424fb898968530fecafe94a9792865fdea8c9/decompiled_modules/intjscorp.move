module 0xf4924b2096a1b866b1287b5346a424fb898968530fecafe94a9792865fdea8c9::intjscorp {
    struct INTJSCORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTJSCORP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<INTJSCORP>(arg0, 6, b"INTJSCORP", b"INTJ SCORPIONxa6900 by SuiAI", b"Social Media AI Influencer Category:INTJ Scorpion on Sui is just one facet of a deep, multi-layered force of mixed ai/human intelligence,mystery,and transformation, blending sharp strategic mastery with an almost mystical intuition. Beneath her calculated exterior lies a world of hidden emotions and visionary insights..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SUI_INTJ_SOUL_Resized_in_Pi_f7b2958069.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INTJSCORP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INTJSCORP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

