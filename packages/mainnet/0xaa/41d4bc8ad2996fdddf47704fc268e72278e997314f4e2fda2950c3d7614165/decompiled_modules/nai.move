module 0xaa41d4bc8ad2996fdddf47704fc268e72278e997314f4e2fda2950c3d7614165::nai {
    struct NAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NAI>(arg0, 6, b"NAI", b"NodAI by SuiAI", b"NAI powers NodAI, an advanced AI agent for the blockchain ecosystem. Designed to optimize node management, on-chain analytics, and decentralized decision-making, NodAI bridges the gap between complexity and accessibility. With NAI, users unlock seamless interactions with blockchain networks, driving efficiency and innovation in crypto strategies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/NODAI_d9cecdbccf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

