module 0x4565882c395b6be9a9e2368a69a90fc1b2fbe38194c424192888806d93017c4a::eliza {
    struct ELIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ELIZA>(arg0, 6, b"ELIZA", b"ElizaOS by SuiAI", b"THE OPERATING SYSTER FOR AI AGENTS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2162_f9dc12cff8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELIZA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELIZA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

