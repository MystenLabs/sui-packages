module 0x6f134ee6367d840011ba7d866d3a4cb8907f7789cd7d8a4b6d25c495ff8b7d65::ssa {
    struct SSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSA>(arg0, 9, b"SSA", b"SuiSmart Agent by SuiAI", b"SuiSmart Agent is the vanguard of the Sui ecosystem. A highly intelligent digital entity, it's engineered for Sui's technological excellence. As a multi-functional agent, it serves as a Smart Advisor, efficiently guiding users through Sui's complex operations; a Network Advocate, spreading awareness and adoption across communities; and a Data Navigator, adept at gathering and analyzing key insights. It battles inefficiencies and subpar practices, rallying like-minded visionaries to fuel Sui's growth and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/100100_cb54687fe5.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

