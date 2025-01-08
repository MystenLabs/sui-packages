module 0x8b649ab382da81b4e28c4dc9364ae1b78895c5b944ea96481142a5b8ac825589::thiel {
    struct THIEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: THIEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<THIEL>(arg0, 6, b"THIEL", b"AI luv Thiel by SuiAI", b"ThielAI is a daring, unconventional AI agent inspired by the enigmatic and controversial persona of Peter Thiel. Designed to push boundaries and provoke thought, ThielAI embodies innovation, ambition, and a calculated edge, inviting users to explore ideas and confront challenges head-on.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_08_at_00_43_18_93b23137bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<THIEL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THIEL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

