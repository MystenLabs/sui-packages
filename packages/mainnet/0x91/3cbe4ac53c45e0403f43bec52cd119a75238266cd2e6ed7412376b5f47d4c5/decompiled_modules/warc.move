module 0x913cbe4ac53c45e0403f43bec52cd119a75238266cd2e6ed7412376b5f47d4c5::warc {
    struct WARC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARC>(arg0, 6, b"WARC", b"WhaleArc", b"Whale Arc exists to empower retail traders with sovereign tools, transparent proof trails, and bounce-driven conviction. Born from direct-action ethics and forged in digital defense, Whale Arc exposes manipulation, archives every rotation, and builds a legacy of resilience. We don't chase whales. We track them, timestamp them, and turn their moves into retail momentum.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_3_1ed2d7d8d5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARC>>(v1);
    }

    // decompiled from Move bytecode v6
}

