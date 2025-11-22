module 0x3c86a28af3f4d768c7253bd727c3055270fe3734316d6b94960f26d04f1bf394::pvp_vs_ai {
    struct PVP_VS_AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVP_VS_AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PVP_VS_AI>(arg0, 6, b"PVA", b"PVP VS AI", b"PVP VS AI is the future of decentralized finance. Community driven and transparent.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PVP_VS_AI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVP_VS_AI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

