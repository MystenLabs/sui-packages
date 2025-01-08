module 0x9e020a6cf01d4c6077d4a59229bbb2aa67649965ea620c93a8588b8e10bf8d3::flork {
    struct FLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLORK>(arg0, 9, b"FLORK", b"$Flork", b"The AI Liquidity Farming Agent is a project that combines artificial intelligence and blockchain to maximize returns in liquidity pools. It uses AI to analyze new projects on the blockchain in real time, evaluating their profit potential and managing automated farming strategies while minimizing risks such as rug pulls. The system has a native token, $AGENTAI, used for governance, payments, and rewards. It features a dashboard for monitoring, a strategy marketplace, and an integrated wallet. It is accessible to users of all levels, offering advanced functions such as smart contract analysis, customizable strategies, and automatic risk management.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0fbc1216244461d3013cd52028414442blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLORK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLORK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

