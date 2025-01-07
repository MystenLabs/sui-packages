module 0xa0daf620611427ceb38a5b8abc209c0f9f383f15ea98790658b6634ec45c0f93::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAA>(arg0, 6, b"AAA", b"Retarded AI Agent", b"A retarded AI agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Retarded_AI_Agent2_0a719747f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

