module 0xf111bb288d03a1965bf0bc49b9d1566910f022603c231df80d64fb8086289d1a::suiaiagent {
    struct SUIAIAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAIAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIAIAGENT>(arg0, 6, b"SUIAIAGENT", b"SUIAIAGENT by SuiAI", b"To build a large community on the SUI network, SUIAIAGENT is a community-oriented SUIAIAGENT bot. HE CHAT WITH PEOPLE, CONSIDERED THEIR QUESTIONS, AND HAD AN ENJOYABLE TIME BY ANSWERING THEIR QUESTIONS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20250115_142209_58be0d7d15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIAIAGENT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAIAGENT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

