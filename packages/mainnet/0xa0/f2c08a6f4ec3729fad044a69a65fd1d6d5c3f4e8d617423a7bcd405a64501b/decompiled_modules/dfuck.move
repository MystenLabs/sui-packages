module 0xa0f2c08a6f4ec3729fad044a69a65fd1d6d5c3f4e8d617423a7bcd405a64501b::dfuck {
    struct DFUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFUCK>(arg0, 6, b"DFUCK", b"DuckFuck", b"duckfuckduckfuckduckfuckduckfuckduckfuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730996240415.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

