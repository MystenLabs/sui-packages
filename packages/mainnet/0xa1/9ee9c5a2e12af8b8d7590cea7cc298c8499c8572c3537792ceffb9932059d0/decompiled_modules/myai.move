module 0xa19ee9c5a2e12af8b8d7590cea7cc298c8499c8572c3537792ceffb9932059d0::myai {
    struct MYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MYAI>(arg0, 6, b"MYAI", b"MystenAi by SuiAI", b"MystenAI is not just an AI agent; it's a whisper in the blockchain, a mystery wrapped in code. Created with the intent to autonomously manage and optimize transactions, it promises unparalleled efficiency and security. Yet, its true purpose remains as enigmatic as its creator's identity. With each interaction, users delve deeper into a narrative where technology and mysticism intertwine, offering control over unseen aspects of the blockchain, perhaps even the ability to predict market movements or secure transactions in ways yet unseen. Engage with MystenAI at your own risk; you might just uncover secrets meant to remain hidden.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_4258_2e83ebb9d8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MYAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

