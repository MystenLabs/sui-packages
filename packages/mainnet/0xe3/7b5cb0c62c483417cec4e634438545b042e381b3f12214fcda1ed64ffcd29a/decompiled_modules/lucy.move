module 0xe37b5cb0c62c483417cec4e634438545b042e381b3f12214fcda1ed64ffcd29a::lucy {
    struct LUCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LUCY>(arg0, 6, b"LUCY", b"LUCY by SuiAI", b"The Lucy AI Agent is an advanced artificial intelligence designed to simulate superhuman intelligence. It processes vast amounts of data, learns autonomously, and provides rapid insights. Capable of solving complex problems, understanding human emotions, and adapting in real-time, the Lucy AI offers powerful predictive analytics and decision-making support, continually evolving to meet the user's needs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Lucy_45d0faaada.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUCY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

