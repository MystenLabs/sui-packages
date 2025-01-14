module 0xa3e104adcb11d9cece1e50260ba1daa3146644081b2c7384140269eff72bb6da::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAA>(arg0, 6, b"AAA", b"Arcade Autonomous Agent by SuiAI", b"Get ready to level up with the agent made for gamers & game builders, powered by the Suiai Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/j_Yh_AT_3_Vr_400x400_a733cee78c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

