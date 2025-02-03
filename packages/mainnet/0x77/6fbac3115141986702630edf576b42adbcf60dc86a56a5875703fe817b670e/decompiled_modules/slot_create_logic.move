module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_create_logic {
    public(friend) fun mutate(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotCreated, arg1: &mut 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotNumberTable, arg2: &mut 0x2::tx_context::TxContext) : 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::Slot {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::create_slot(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_created::slot_number(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_created::genesis_timestamp(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_created::slot_max_amount(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::id_util::id_placeholder(), 0x1::vector::empty<u8>(), 0, 256 * 1000000, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::id_util::id_placeholder(), 0x1::vector::empty<u8>(), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::id_util::address_placeholder(), 0, 0, 0, 256 * 1000000, 0x1::string::utf8(b""), arg1, arg2)
    }

    public(friend) fun verify(arg0: u8, arg1: &0x2::clock::Clock, arg2: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotNumberTable, arg3: &mut 0x2::tx_context::TxContext) : 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::SlotCreated {
        assert!(arg0 <= 209, 100);
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::asset_slot_number_not_exists(arg0, arg2);
        let v0 = if (arg0 == 209) {
            9999999996480 + 739200
        } else {
            9999999996480
        };
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::new_slot_created(arg0, 0x2::clock::timestamp_ms(arg1), v0)
    }

    // decompiled from Move bytecode v6
}

