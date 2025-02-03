module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_aggregate {
    public entry fun advance(arg0: &mut 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::Slot, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::assert_schema_version(arg0);
        let v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_advance_logic::verify(arg1, arg0, arg2);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_advance_logic::mutate(&v0, arg0, arg2);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::update_object_version(arg0);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::emit_slot_advanced(v0);
    }

    public entry fun create(arg0: u8, arg1: &0x2::clock::Clock, arg2: &mut 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotNumberTable, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_create_logic::verify(arg0, arg1, arg2, arg3);
        let v1 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_create_logic::mutate(&v0, arg2, arg3);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_slot_created_id(&mut v0, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::id(&v1));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::share_object(v1);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::emit_slot_created(v0);
    }

    public entry fun put_up_candidate(arg0: &mut 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::Slot, arg1: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::Inscription, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::assert_schema_version(arg0);
        let v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_put_up_candidate_logic::verify(arg1, arg2, arg0, arg3);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_put_up_candidate_logic::mutate(&v0, arg0, arg3);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::update_object_version(arg0);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::emit_candidate_inscription_put_up_v2(v0);
    }

    // decompiled from Move bytecode v6
}

