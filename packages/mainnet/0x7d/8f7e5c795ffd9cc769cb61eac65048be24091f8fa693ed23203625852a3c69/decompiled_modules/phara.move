module 0x7d8f7e5c795ffd9cc769cb61eac65048be24091f8fa693ed23203625852a3c69::phara {
    struct PHARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHARA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PHARA>(arg0, 6, b"PHARA", b"Pharaoh by SuiAI", b"It's time to bring back the ancient Pharaonic spirit to the water chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/pharaoh_mini_fcce8181de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PHARA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHARA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

