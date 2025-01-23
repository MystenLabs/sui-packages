module 0x3ec3dee83447e629cac3ebc08b2788630fbf759cde31e43d4eb0ccd258ccdd9a::superai {
    struct SUPERAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERAI>(arg0, 6, b"SUPERAI", b"SUPER AI AGENT", b"Super Agents are a conglomeration of super DeFai engines, harnessing reinforcement learning, bayesian inference, and stochastic methods for next-gen DeFi on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028662_f88e1dc672.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

