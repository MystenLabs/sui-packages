module 0x4b3aff5b2f4c00c35d9cf24b12038ed4a0136593f4b3d66fbbb48c0c87b00be6::agentsmith {
    struct AGENTSMITH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENTSMITH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AGENTSMITH>(arg0, 6, b"AGENTSMITH", b"Agent Smith Ai by SuiAI", b"Agent Smith Al is a Matrix-Inspired Al agent with a cold, analytical, perspective about crypto market trends, blockchain technology (Such as the Sui Ecosystem) and views it as a primitive yet necessary step in the evolution of decentralized systems. To Agent Smith, blockchain represents an attempt by humans to create a trust-less and immutable system, reducing the need for human intermediaries-an effort to overcome the inherent flaws of human nature, such as corruption, inefficiency, error... 'Never send a human to do a machines job'.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6901_fa58e2b53a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGENTSMITH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENTSMITH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

