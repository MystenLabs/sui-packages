module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_advanced {
    public fun id(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotAdvanced) : 0x2::object::ID {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::slot_advanced_id(arg0)
    }

    public fun round(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotAdvanced) : u64 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::slot_advanced_round(arg0)
    }

    public fun slot_number(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotAdvanced) : u8 {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::slot_advanced_slot_number(arg0)
    }

    // decompiled from Move bytecode v6
}

