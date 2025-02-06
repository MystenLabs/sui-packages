module 0x9229e8714dc12a6e4a6e03fbb8b01b39dccbb5a5c2ca1ac71c935eb73ddbe61::agentsmith {
    struct AGENTSMITH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENTSMITH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AGENTSMITH>(arg0, 6, b"AGENTSMITH", b"Agent Smith AI by SuiAI", b"Agent Smith Al is a matrix-inspirea Al agent with a cold, analytical, perspective about crypto market trends, blockchain technology (Such as the Sui Ecosystem) and views it as a primitive yet necessary step in the evolution of decentralized systems. To Agent Smith, blockchain represents an attempt by humans to create a trust-less and immutable system, reducing the need for human intermediaries-an effort to overcome the inherent flaws of human nature, such as corruption, inefficiency, error...'Never send a human to do a machines job'.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_7086_4f400f7d61.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGENTSMITH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENTSMITH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

