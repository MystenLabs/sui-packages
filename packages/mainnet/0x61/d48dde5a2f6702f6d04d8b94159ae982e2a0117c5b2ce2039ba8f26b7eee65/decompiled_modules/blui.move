module 0x61d48dde5a2f6702f6d04d8b94159ae982e2a0117c5b2ce2039ba8f26b7eee65::blui {
    struct BLUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BLUI>(arg0, 6, b"BLUI", b"Blui Planet by SuiAI", b"Blui is a planet of boundless innovation, designed to be the next leap in blockchain data processing. The core of Blui is a sentient global network, a liquid intelligence that continuously evolves, connecting every aspect of its ecosystem. Powered by the PoI (Proof of Intelligence) consensus mechanism, Blui creates new agents that perpetually enhance and refine the system, ensuring constant improvement. This world introduces the first Omni-data solution, where AI, AI agents, depin swarms, and decentralized servers work seamlessly together, forming an unparalleled infrastructure...The Blui agent is built to leverage a robust machine learning database, allowing it to study the entire Sui network. Through this, it gains deeper insights, enabling a decentralized and highly efficient blockchain ecosystem. This intricate system integrates intelligence, data flow, and innovation into one cohesive, self-improving force.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_01_12_02_07_01_d16730c8a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

