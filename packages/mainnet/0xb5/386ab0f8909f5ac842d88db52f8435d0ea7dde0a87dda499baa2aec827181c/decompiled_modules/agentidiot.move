module 0xb5386ab0f8909f5ac842d88db52f8435d0ea7dde0a87dda499baa2aec827181c::agentidiot {
    struct AGENTIDIOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENTIDIOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AGENTIDIOT>(arg0, 6, b"AGENTIDIOT", b"Agent Idiot by SuiAI", b"beep beop,Agent Idoit is also AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_20250112_224332_37374a4ebf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGENTIDIOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENTIDIOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

