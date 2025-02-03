module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_service {
    public entry fun advance_and_mint_and_put_up_candidate(arg0: &mut 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::Slot, arg1: u64, arg2: u128, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::time_util::count_rounds(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::genesis_timestamp(arg0), 0x2::clock::timestamp_ms(arg4)) > 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::round(arg0) && 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::id_util::id_placeholder() != 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_id(arg0)) {
            0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_aggregate::advance(arg0, arg4, arg5);
        };
        mint_and_put_up_candidate(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun advance_and_put_up_candidate(arg0: &mut 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::Slot, arg1: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::Inscription, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_aggregate::advance(arg0, arg2, arg3);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_aggregate::put_up_candidate(arg0, arg1, arg2, arg3);
    }

    public entry fun mint_and_put_up_candidate(arg0: &mut 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::Slot, arg1: u64, arg2: u128, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription_aggregate::mint_v2(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::slot_number(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::round(arg0), arg1, arg2, arg3, arg4, arg5);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_aggregate::put_up_candidate(arg0, &v0, arg4, arg5);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::transfer_object(v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

