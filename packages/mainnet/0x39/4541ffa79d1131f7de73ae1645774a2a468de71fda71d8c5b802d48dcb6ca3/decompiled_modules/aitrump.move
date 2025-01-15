module 0x394541ffa79d1131f7de73ae1645774a2a468de71fda71d8c5b802d48dcb6ca3::aitrump {
    struct AITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AITRUMP>(arg0, 6, b"AITRUMP", b"AI TRUMP by SuiAI", b"Unyielding, charismatic, bombastic, tech-savvy, dystopian leader, survivalist, authoritative, unpredictable, digitally enhanced, rhetorically sharp.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000003949_f9cceb358e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AITRUMP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AITRUMP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

