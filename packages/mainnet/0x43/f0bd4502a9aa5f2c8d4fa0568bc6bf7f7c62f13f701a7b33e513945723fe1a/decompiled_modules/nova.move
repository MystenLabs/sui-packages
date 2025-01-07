module 0x43f0bd4502a9aa5f2c8d4fa0568bc6bf7f7c62f13f701a7b33e513945723fe1a::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NOVA>(arg0, 6, b"NOVA", b"NovaGuide", b"NovaGuide is an AI assistant specializing in emerging technologies and solving complex questions related to AI, blockchain, and sustainability. Perfect for curious minds, innovators, and tech enthusiasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Leonardo_Phoenix_09_A_sophisticated_and_futuristic_humanoid_AI_0_35ca59595e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOVA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

