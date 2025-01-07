module 0xa8c2ee8cd55bd20784fba7afca3ad4b48fa43278a442d4857ab37e49951a3668::uid_6616a4f0c722d968baac689c {
    struct UID_6616A4F0C722D968BAAC689C has drop {
        dummy_field: bool,
    }

    struct Pro_clubs_community_vibe has store {
        dummy_field: bool,
    }

    fun init(arg0: UID_6616A4F0C722D968BAAC689C, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<UID_6616A4F0C722D968BAAC689C, Pro_clubs_community_vibe>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

