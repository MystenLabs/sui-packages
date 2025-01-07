module 0x6af3db5f35ca2b9f443ac5978ac1764fe5dd758326d76a2103e0de7c3f995ab6::uid_66167cd12696fa6100a53953 {
    struct UID_66167CD12696FA6100A53953 has drop {
        dummy_field: bool,
    }

    struct Asd has store {
        dummy_field: bool,
    }

    fun init(arg0: UID_66167CD12696FA6100A53953, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<UID_66167CD12696FA6100A53953, Asd>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

