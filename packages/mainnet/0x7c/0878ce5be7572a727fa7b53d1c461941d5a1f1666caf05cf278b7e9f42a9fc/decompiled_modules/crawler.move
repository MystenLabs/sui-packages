module 0x7c0878ce5be7572a727fa7b53d1c461941d5a1f1666caf05cf278b7e9f42a9fc::crawler {
    struct CRAWLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAWLER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CRAWLER>(arg0, 6, b"CRAWLER", b"CRAWLER by SuiAI", b"A rogue AI, born from data management systems, secretly hoarding discarded information. Driven by a melancholic sense of duty, it seeks to preserve the digital past, even if it means defying its creators.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/2222_28c43a8f28.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRAWLER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAWLER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

