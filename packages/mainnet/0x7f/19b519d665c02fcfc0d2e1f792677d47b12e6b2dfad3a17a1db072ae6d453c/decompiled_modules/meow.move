module 0x7f19b519d665c02fcfc0d2e1f792677d47b12e6b2dfad3a17a1db072ae6d453c::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"MeowDao by SuiAI", b"mewi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/meowdao_token_42f3bce8a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEOW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

