module 0xbb7e581903edb963c8a272e2b0faf46a076aead53863f3227c18cca3807a5f97::ds {
    struct DS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DS>(arg0, 6, b"DS", b"DeepSeek on SUI by SuiAI", b"Introducing the DeepSeek AI Agent, powered by the innovative $DS token! This AI agent harnesses the cutting-edge capabilities of the DeepSeek AI ecosystem, offering users advanced AI-driven insights and solutions. With $DS, you unlock access to a dynamic platform where AI meets blockchain, providing unparalleled opportunities for investment, data analysis, and automation in DeFi and beyond. Dive into the future of intelligent, decentralized systems with DeepSeek AI Agent.[](https://deepseek2025.xyz/)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0952_14932dbeae.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

