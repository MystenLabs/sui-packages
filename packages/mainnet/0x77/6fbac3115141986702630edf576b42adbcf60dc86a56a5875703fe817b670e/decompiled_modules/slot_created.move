module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_created {
    public fun genesis_timestamp(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotCreated) : u64 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::slot_created_genesis_timestamp(arg0)
    }

    public fun id(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotCreated) : 0x1::option::Option<0x2::object::ID> {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::slot_created_id(arg0)
    }

    public fun slot_max_amount(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotCreated) : u64 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::slot_created_slot_max_amount(arg0)
    }

    public fun slot_number(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotCreated) : u8 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::slot_created_slot_number(arg0)
    }

    // decompiled from Move bytecode v6
}

