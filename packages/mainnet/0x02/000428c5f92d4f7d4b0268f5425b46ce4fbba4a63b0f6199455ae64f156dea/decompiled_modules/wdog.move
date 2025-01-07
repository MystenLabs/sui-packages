module 0x2000428c5f92d4f7d4b0268f5425b46ce4fbba4a63b0f6199455ae64f156dea::wdog {
    struct WDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOG>(arg0, 6, b"Wdog", b"Wrapped Dog", b"No tg, no twitter, much decentralised!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BE_5162_DB_6_B69_4251_A509_8_BEF_0_B2_A69_B2_9b34b3a485.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

