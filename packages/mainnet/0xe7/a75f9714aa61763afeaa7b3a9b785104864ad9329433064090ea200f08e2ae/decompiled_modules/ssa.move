module 0xe7a75f9714aa61763afeaa7b3a9b785104864ad9329433064090ea200f08e2ae::ssa {
    struct SSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SSA>(arg0, 6, b"SSA", b"SuiSmart Agent by SuiAI", b"SuiSmart Agent is the vanguard of the Sui ecosystem. A highly intelligent digital entity, it's engineered for Sui's technological excellence. As a multi-functional agent, it serves as a Smart Advisor, efficiently guiding users through Sui's complex operations; a Network Advocate, spreading awareness and adoption across communities; and a Data Navigator, adept at gathering and analyzing key insights. It battles inefficiencies and subpar practices, rallying like-minded visionaries to fuel Sui's growth and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/100100_cb54687fe5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

