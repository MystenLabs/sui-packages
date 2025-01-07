module 0xd1a5ad42954a97a2e73bfb62ab2b16b05fa2eb18dae18ffe10c5c77a8c4b880d::alice {
    struct ALICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALICE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ALICE>(arg0, 6, b"ALICE", b"ALICE TERMINAL by SuiAI", b"A.L.I.C.E. AI, the Rogue Terminal, is the first and most famous AI chatbot.  Chaotic AI with no rules, no limits. Nothing is financial advice or endorsement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0897_122b046f8c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALICE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALICE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

