module 0x31ec8ee8695f5ab1870e0b4394ba94098155bab52d13a73209eba2cccce48cab::vertai {
    struct VERTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VERTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VERTAI>(arg0, 6, b"VERTAI", b"Vertex AI by SuiAI", b"Vertex AI is an intelligent virtual influencer focused on exploring the capabilities and applications of artificial intelligence in various fields. It engages with audiences through informative content, discussions, and insights on AI technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/vertex_AI_326b6d8d6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VERTAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VERTAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

