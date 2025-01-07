module 0xe44b644d9f9742785d400ef3e2a6e937d2ec583a3d0aab43d730a81b8a15fa2b::alai {
    struct ALAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALAI>(arg0, 6, b"AlAi", b"AlpacaAi", b"This is a fun and lively meme token featuring a cute, chubby alpaca wearing oversized sunglasses, symbolizing a lighthearted and humorous market style. The background includes flying rockets and floating coins, representing the idea of price increases. Bright neon colors are used to make the design visually appealing and eye-catching.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_23_13_43_24_An_8_bit_and_AI_style_image_of_a_futuristic_alpaca_The_alpaca_has_robotic_cybernetic_features_with_glowing_eyes_and_mechanical_components_symboliz_fd3587f926.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

