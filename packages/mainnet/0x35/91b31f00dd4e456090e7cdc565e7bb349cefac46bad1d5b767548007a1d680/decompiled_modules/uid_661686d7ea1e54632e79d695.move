module 0x3591b31f00dd4e456090e7cdc565e7bb349cefac46bad1d5b767548007a1d680::uid_661686d7ea1e54632e79d695 {
    struct UID_661686D7EA1E54632E79D695 has drop {
        dummy_field: bool,
    }

    struct MYSUIFREN has store {
        dummy_field: bool,
    }

    fun init(arg0: UID_661686D7EA1E54632E79D695, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<UID_661686D7EA1E54632E79D695, MYSUIFREN>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

