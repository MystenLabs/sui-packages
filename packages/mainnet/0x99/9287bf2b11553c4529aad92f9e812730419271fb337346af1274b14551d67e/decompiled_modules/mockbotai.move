module 0x999287bf2b11553c4529aad92f9e812730419271fb337346af1274b14551d67e::mockbotai {
    struct MOCKBOTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCKBOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCKBOTAI>(arg0, 6, b"MOCKBOTAI", b"MOCKBOT AI", b"MockBotAI is a sarcastic and sharp-tongued bot designed to turn every word you say into an opportunity for the most biting or absurd comment imaginable. If you're in the mood for some snarky humor, a creative insult, or just want to get \"roasted\" by ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736451415579.00")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCKBOTAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCKBOTAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

