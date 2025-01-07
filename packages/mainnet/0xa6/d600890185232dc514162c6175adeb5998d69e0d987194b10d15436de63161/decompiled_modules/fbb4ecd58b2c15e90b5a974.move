module 0xa6d600890185232dc514162c6175adeb5998d69e0d987194b10d15436de63161::fbb4ecd58b2c15e90b5a974 {
    struct FBB4ECD58B2C15E90B5A974 has drop {
        dummy_field: bool,
    }

    struct Aa3123123 has store {
        dummy_field: bool,
    }

    fun init(arg0: FBB4ECD58B2C15E90B5A974, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<FBB4ECD58B2C15E90B5A974, Aa3123123>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

