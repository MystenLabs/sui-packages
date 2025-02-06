module 0x153a64e14a0b5868aee1351b85e55df9205fbf03c0aca6990aec008ed94ed19c::onai {
    struct ONAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONAI>(arg0, 6, b"ONAI", b"Onchain AI", b"Onchain AI lets you create smart agents for tracking wallets, analyzing tokenomics, and spotting trends with real-time insights and custom alerts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738808309678.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

