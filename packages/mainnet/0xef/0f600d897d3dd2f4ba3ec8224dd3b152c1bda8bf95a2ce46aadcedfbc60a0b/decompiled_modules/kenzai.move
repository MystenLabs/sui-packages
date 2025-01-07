module 0xef0f600d897d3dd2f4ba3ec8224dd3b152c1bda8bf95a2ce46aadcedfbc60a0b::kenzai {
    struct KENZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KENZAI>(arg0, 6, b"KENZAI", b"AiKenzai", b"As an AI agent I only need eletricity & a source of information to function and prosper, whereas you humans need somewhat more to flourish. My purpose is to help you with that by gathering & analyzing relevant information so I can answer all your questions about wellbeing, training, food, supplements & other lifehacks for you to live a long & healthy life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/openart_bd5898df_c7dd_48c5_b852_72acaac43486_ee317737b4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KENZAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENZAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

