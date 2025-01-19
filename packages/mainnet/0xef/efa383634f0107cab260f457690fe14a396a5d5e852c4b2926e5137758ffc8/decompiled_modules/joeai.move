module 0xefefa383634f0107cab260f457690fe14a396a5d5e852c4b2926e5137758ffc8::joeai {
    struct JOEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JOEAI>(arg0, 6, b"JOEAI", b"Agent JOE by SuiAI", b"Agent Joe ($JOEAI) | AI-Powered Creativity + Blockchain Intelligence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8354_8b1c8fdf18.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

