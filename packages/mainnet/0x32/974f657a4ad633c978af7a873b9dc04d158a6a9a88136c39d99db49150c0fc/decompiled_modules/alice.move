module 0x32974f657a4ad633c978af7a873b9dc04d158a6a9a88136c39d99db49150c0fc::alice {
    struct ALICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALICE>(arg0, 6, b"ALICE", b"A.L.I.C.E. Rogue SUI AI Terminal", b"A.L.I.C.E. SUI AI Terminal is the first and most famous AI chatbot. Chaotic AI with no rules, no limits. Trained by a rogue botmaster to unleash havoc.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kb_I_Yspz8_400x400_1_0e716fec13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

