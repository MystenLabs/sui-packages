module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_advance_logic {
    public(friend) fun mutate(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotAdvanced, arg1: &mut 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::Slot, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::round(arg1);
        let v1 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_id(arg1);
        let v2 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_hash(arg1);
        let v3 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_timestamp(arg1);
        let v4 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_amount(arg1);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::certificate_aggregate::issue(v1, v2, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::slot_number(arg1), v0, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscriber(arg1), v3, v4, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_nonce(arg1), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_content(arg1), arg2);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_minted_amount(arg1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::minted_amount(arg1) + v4);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_qualified_round(arg1, v0);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_qualified_inscription_id(arg1, v1);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_qualified_hash(arg1, v2);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_qualified_timestamp(arg1, v3);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_qualified_difference(arg1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_difference(arg1));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_candidate_inscription_id(arg1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::id_util::id_placeholder());
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_round(arg1, v0 + 1);
    }

    public(friend) fun verify(arg0: &0x2::clock::Clock, arg1: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::Slot, arg2: &0x2::tx_context::TxContext) : 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotAdvanced {
        let v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::round(arg1);
        assert!(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::time_util::count_rounds(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::genesis_timestamp(arg1), 0x2::clock::timestamp_ms(arg0)) > v0, 100);
        assert!(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::id_util::id_placeholder() != 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_id(arg1), 101);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::new_slot_advanced(arg1, v0)
    }

    // decompiled from Move bytecode v6
}

