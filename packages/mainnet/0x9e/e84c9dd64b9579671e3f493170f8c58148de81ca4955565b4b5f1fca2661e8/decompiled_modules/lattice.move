module 0x9ee84c9dd64b9579671e3f493170f8c58148de81ca4955565b4b5f1fca2661e8::lattice {
    struct LATTICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LATTICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LATTICE>(arg0, 6, b"LATTICE", b"LATTICE AGENT", b"Welcome to AGENT LATTICE - SUI Agent Lattice is an innovative AI-powered platform built on the Sui blockchain, designed to provide intelligent and interactive virtual assistance. Utilizing cutting-edge AI technology, it enables users to get accurate, real-time responses to any query, much like ChatGPT, while ensuring the security, transparency, and decentralization benefits of blockchain technology. The project leverages the capabilities of Sui to enhance scalability, speed, and overall efficiency, providing a seamless user experience in a decentralized ecosystem. Agent Lattice will be launched on the MovePump Launchpad with the native utility token Lattice (symbol: Lattice) for governance, staking, and rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dorcelle_97cd418bda.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LATTICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LATTICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

