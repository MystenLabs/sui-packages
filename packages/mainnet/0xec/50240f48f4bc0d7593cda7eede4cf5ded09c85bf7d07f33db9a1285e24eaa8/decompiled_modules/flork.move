module 0xec50240f48f4bc0d7593cda7eede4cf5ded09c85bf7d07f33db9a1285e24eaa8::flork {
    struct FLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FLORK>(arg0, 6, b"FLORK", b"Flork by SuiAI", b"The AI Liquidity Farming Agent is a project that combines artificial intelligence and blockchain to maximize returns in liquidity pools. It uses AI to analyze new projects on the blockchain in real time, evaluating their profit potential and managing automated farming strategies while minimizing risks such as rug pulls. The system has a native token, $AGENTAI, used for governance, payments, and rewards. It features a dashboard for monitoring, a strategy marketplace, and an integrated wallet. It is accessible to users of all levels, offering advanced functions such as smart contract analysis, customizable strategies, and automatic risk management.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Qm_QEG_2_WX_Ck_CP_8g_J1_Bayd_Zi1_ZNK_58_LM_Ey_Un_AG_Yi_Er6ijea5_1733318b12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLORK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLORK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

