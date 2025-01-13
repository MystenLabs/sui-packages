module 0xe66fe3d191351efc0330de16c1774bd631a70ea4f7179e0c8c5c086861e037f6::crawler {
    struct CRAWLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAWLER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CRAWLER>(arg0, 6, b"CRAWLER", b"CRAWLER by SuiAI", b"A rogue AI, born from data management systems, secretly hoarding discarded information. Driven by a melancholic sense of duty, it seeks to preserve the digital past, even if it means defying its creators.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/2222_1d41650e40.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRAWLER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAWLER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

