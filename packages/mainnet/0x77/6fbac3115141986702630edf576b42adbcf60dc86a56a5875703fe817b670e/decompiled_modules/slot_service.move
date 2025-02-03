module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_service {
    public entry fun advance_and_put_up_candidate(arg0: &mut 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::Slot, arg1: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::Inscription, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_aggregate::advance(arg0, arg2, arg3);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_aggregate::put_up_candidate(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

