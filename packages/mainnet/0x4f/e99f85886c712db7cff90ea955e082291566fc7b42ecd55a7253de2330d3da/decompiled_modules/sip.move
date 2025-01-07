module 0x4fe99f85886c712db7cff90ea955e082291566fc7b42ecd55a7253de2330d3da::sip {
    struct SIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SIP>(arg0, 6, b"SIP", b"BOUNCEBIT BIRD (SKY INTELLIGENCE PROTOCOL) by SuiAI", b"Bouncebit Bird was once a playful, carefree digital bird hopping across blockchain skies. However, after encountering a mysterious AI entity called 'The EtherMind,' it gained the ability to analyze and adapt to blockchain ecosystems. Migrating to SUI, Bouncebit Bird now acts as a guide for users navigating decentralized applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1001192528_6f1fe2dee0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

