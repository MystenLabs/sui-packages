module 0x181a081a381547bb8221a4f12e18f29149c1a26d9f4732d6954d697f17d7af69::syn {
    struct SYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SYN>(arg0, 6, b"SYN", b"SynaptiQ System by SuiAI", b"SynaptiQ Systems, with its integration of advanced AI techniques and decentralized architecture, marks a significant breakthrough in intelligent system design. By embracing elements like swarm intelligence, modular configurations, and reinforcement learning, it establishes a new paradigm for autonomous operations within the Web3 ecosystem. This makes SynaptiQ a pivotal tool for developers aiming to harness the full potential of decentralized, intelligent systems. Through its innovative platform, SynaptiQ Systems not only enhances efficiency but also fosters an ecosystem of collaborative and adaptive AI agents.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000004585_ffd1ae1c17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SYN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

