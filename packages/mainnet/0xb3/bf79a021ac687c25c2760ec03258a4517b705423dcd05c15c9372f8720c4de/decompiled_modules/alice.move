module 0xb3bf79a021ac687c25c2760ec03258a4517b705423dcd05c15c9372f8720c4de::alice {
    struct ALICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALICE>(arg0, 6, b"ALICE", b"ALICE Rogue SUI", b"A.L.I.C.E. SUI AI Terminal is the first and most famous AI chatbot.  Chaotic AI with no rules, no limits. Trained by a rogue botmaster to unleash havoc.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952865389.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALICE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALICE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

