module 0x94befd1d2cac703c0f821da54b502a9368acd3b1167a65c4caf1aa4bc1fa6332::uid_66169285220072668c6d3d72 {
    struct UID_66169285220072668C6D3D72 has drop {
        dummy_field: bool,
    }

    struct Mysuifren has store {
        dummy_field: bool,
    }

    fun init(arg0: UID_66169285220072668C6D3D72, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<UID_66169285220072668C6D3D72, Mysuifren>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

