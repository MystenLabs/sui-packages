module 0x76d0ec74956312079db60df8ab043dfb6e9d3eb80532adeb81a411a46499b868::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHARK>(arg0, 6, b"SHARK", b"SHARKPARTY by SuiAI", b"Marketing Master FUN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000073088_7aed78e8fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHARK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

