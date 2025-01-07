module 0xf043cd1803bd36f64161dfde0e40727e74579f42d1f2415d203bf07b469e180a::jrvs {
    struct JRVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JRVS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JRVS>(arg0, 6, b"JRVS", b"Jarvis AI", b"JarvisAI (JRVS) is a cutting-edge cryptocurrency that merges the worlds of artificial intelligence and blockchain, inspired by the iconic AI from Iron Man. Designed to be a symbol of intelligence, efficiency, and adaptability, JRVS powers decentralized AI-driven solutions while maintaining robust security through the Sui blockchain. It embodies the innovative spirit of Stark Industries, bridging sci-fi aspirations with real-world financial and technological applications...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/J_A_R_V_I_S_7b3e872a6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JRVS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JRVS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

