module 0x666307f66a539876ea2e757867fd84917b686c8beefecff324a7d7f7c32abaa3::sagent {
    struct SAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGENT>(arg0, 6, b"SAGENT", b"SAGENTS", b"AgentLayer is an innovative project that aims to create a decentralized, permissionless, secure and reliable network for autonomous AI agents to collaborate and coordinate. AgentLayer leverages the power of generative AI driven by large language models (LLMs) to enable AI agents to make decisions and complete tasks autonomously with minimal human intervention.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_43efbb4f35.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

