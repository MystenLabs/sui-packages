module 0xdc67ccc0b84eb0f50da15a6d629308195e4d621a115ea28cad97cd6cd5bd6f66::uid_66307c99d7bf27c696445087 {
    struct UID_66307C99D7BF27C696445087 has drop {
        dummy_field: bool,
    }

    struct Gamers_x_playground_pass has store {
        dummy_field: bool,
    }

    fun init(arg0: UID_66307C99D7BF27C696445087, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<UID_66307C99D7BF27C696445087, Gamers_x_playground_pass>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

