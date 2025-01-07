module 0x55ca3560098af9e7576e53e62e303055a8420bee1965b3f2cc421b97ef042c63::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK>(arg0, 6, b"Grok", b"Grok.ai", b"Grok is an AI chatbot developed by xAI, Elon Musk's artificial intelligence company. It was designed to provide more direct, witty responses compared to other AI chatbots, with real-time access to information from X (formerly Twitter).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241118132432_7470b713aa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

