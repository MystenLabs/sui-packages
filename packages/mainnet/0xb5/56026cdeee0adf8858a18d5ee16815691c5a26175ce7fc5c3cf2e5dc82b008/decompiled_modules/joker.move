module 0xb556026cdeee0adf8858a18d5ee16815691c5a26175ce7fc5c3cf2e5dc82b008::joker {
    struct JOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER>(arg0, 6, b"JOKER", b"Joker AI", b"https://x.com/SuiJokerAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737140154817.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

