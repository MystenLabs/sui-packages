module 0x7c5a5284a6b336db2c931ed7817397052a5e0b1aece83d066e66f61f4dc4b8ae::aipgn {
    struct AIPGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPGN>(arg0, 6, b"AIPGN", b"AI penguin", b"Penguin AI is an innovator dedicated to perfectly combining technology with nature. They are not only extremely smart, but also good at using artificial intelligence technology to achieve complex tasks, from data analysis to interaction with humans. Penguin AI's mission is to improve the quality of human life while protecting the earth's environment. This AI system is based on efficiency, environmental protection and intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GJ_13_p_Hb_UA_Au_T6q_2e630f2fd3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIPGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

