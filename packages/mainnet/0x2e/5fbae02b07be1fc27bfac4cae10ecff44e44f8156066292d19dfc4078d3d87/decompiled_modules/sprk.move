module 0x2e5fbae02b07be1fc27bfac4cae10ecff44e44f8156066292d19dfc4078d3d87::sprk {
    struct SPRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SPRK>(arg0, 6, b"SPRK", b"SuiSparkAi by SuiAI", b"SuiSparkAi is the pioneering AI agent on the SUI blockchain, designed to ignite innovation, foster community engagement, and facilitate seamless transactions. It's not just an agent; it's a spark of creativity and efficiency, aimed at enhancing the user experience on the SUI platform through AI-driven insights and automation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Leonardo_Phoenix_09_Create_an_avatar_of_a_vibrant_futuristic_A_3_b2918e57cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPRK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

