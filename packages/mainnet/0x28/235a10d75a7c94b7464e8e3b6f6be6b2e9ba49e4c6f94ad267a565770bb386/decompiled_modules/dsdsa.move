module 0x28235a10d75a7c94b7464e8e3b6f6be6b2e9ba49e4c6f94ad267a565770bb386::dsdsa {
    struct DSDSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSDSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSDSA>(arg0, 6, b"dsdsa", b"asaaa", b"sadsadad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBGJB20BZT7YN0G058SNDBT3/01JBGJDZK5ZXHK6ZA8ZA0BPMFV")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSDSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DSDSA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

