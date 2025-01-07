module 0x8da2d8b41820b663ce892372b3b7bb6d1bd819ae509afb4b6d84deda8e612c81::iai {
    struct IAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IAI>(arg0, 6, b"IAI", b"Infinity Ai Agent", b"Infinity AI Agent is a cutting-edge artificial intelligence model designed to engage in natural-sounding conversations, answer questions, and provide information on a wide range of topics...Some key features of Infinity AI Agent include:..1.  Advanced Natural Language Processing (NLP) capabilities.2.  Ability to understand and respond to context-dependent queries.3.  Knowledge base updated continuously through web crawling and user interactions.4.  Enhanced contextual understanding for more accurate responses.5.  Support for multiple languages", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DC_98_B04_A_B308_4558_8327_51_A579_C55341_bcee1f6c64.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

