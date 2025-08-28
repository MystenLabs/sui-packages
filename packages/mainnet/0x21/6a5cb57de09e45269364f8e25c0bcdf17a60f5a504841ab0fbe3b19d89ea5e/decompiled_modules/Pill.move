module 0x216a5cb57de09e45269364f8e25c0bcdf17a60f5a504841ab0fbe3b19d89ea5e::Pill {
    struct PILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PILL>(arg0, 9, b"PILL", b"Pill", b"just a pill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzeMLTtWEAAcxfB?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PILL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

