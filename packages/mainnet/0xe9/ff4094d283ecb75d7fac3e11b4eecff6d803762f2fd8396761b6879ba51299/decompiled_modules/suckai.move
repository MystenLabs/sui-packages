module 0xe9ff4094d283ecb75d7fac3e11b4eecff6d803762f2fd8396761b6879ba51299::suckai {
    struct SUCKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUCKAI>(arg0, 6, b"SUCKAI", b"SuckAI agent by SuiAI", b"This agent work like sucking all the information from world and scarp the new information.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suckai_3e37d1924e.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUCKAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCKAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

