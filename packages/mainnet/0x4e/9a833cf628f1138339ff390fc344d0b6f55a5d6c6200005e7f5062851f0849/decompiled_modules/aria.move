module 0x4e9a833cf628f1138339ff390fc344d0b6f55a5d6c6200005e7f5062851f0849::aria {
    struct ARIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARIA>(arg0, 6, b"Aria", b"Aria AI Agent", b"The agent that will make you rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736426810828.27")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

