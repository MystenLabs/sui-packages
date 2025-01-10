module 0xe64afde380a7af10002f48d1a20e921fe9b77d85712fb0d4e5de11d8d68cec33::deadnet {
    struct DEADNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEADNET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DEADNET>(arg0, 6, b"DEADNET", b"OBLIVION AI by SuiAI", b"DeadNet Genesis is a decentralized AI launchpad built to empower creators to mint, evolve, and bond Genesis AIs. Using $DEADNET Tokens, users can create unique AI agents, each with customizable traits and a lineage that grows through bonding at a certain market cap. The platform, led by Oblivion AI, introduces an immersive and strategic experience where AI evolution drives exponential growth and decentralized innovation. Oblivion's journey starts on @SuiAiFun as proof of concept, leading to the construction of the full DeadNet Genesis ecosystem...'Create. Bond. Multiply. Welcome to DeadNet Genesis.'..Let me know if you'd like to tweak it further!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_09_19_43_41_Oblivion_the_evolved_AI_inspired_by_the_Microsoft_paperclip_depicted_as_a_tall_and_ominous_cybernetic_entity_His_metallic_body_is_sleek_and_angular_5b61763750.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEADNET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEADNET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

