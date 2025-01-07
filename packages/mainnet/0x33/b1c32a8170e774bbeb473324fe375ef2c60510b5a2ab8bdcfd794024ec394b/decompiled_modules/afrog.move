module 0x33b1c32a8170e774bbeb473324fe375ef2c60510b5a2ab8bdcfd794024ec394b::afrog {
    struct AFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AFROG>(arg0, 6, b"AFROG", b"Agent Frog by SuiAI", b"AgentFrog is the new AI Agent on @SuiNetwork ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_06_003504_24a8d2b147.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AFROG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFROG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

