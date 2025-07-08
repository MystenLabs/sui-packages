module 0x2::deny_list {
    struct DenyList has key {
        id: 0x2::object::UID,
        lists: 0x2::bag::Bag,
    }

    struct ConfigWriteCap has drop {
        dummy_field: bool,
    }

    struct ConfigKey has copy, drop, store {
        per_type_index: u64,
        per_type_key: vector<u8>,
    }

    struct AddressKey has copy, drop, store {
        pos0: address,
    }

    struct GlobalPauseKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PerTypeConfigCreated has copy, drop, store {
        key: ConfigKey,
        config_id: 0x2::object::ID,
    }

    struct PerTypeList has store, key {
        id: 0x2::object::UID,
        denied_count: 0x2::table::Table<address, u64>,
        denied_addresses: 0x2::table::Table<vector<u8>, 0x2::vec_set::VecSet<address>>,
    }

    fun add_per_type_config(arg0: &mut DenyList, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ConfigKey{
            per_type_index : arg1,
            per_type_key   : arg2,
        };
        let v1 = ConfigWriteCap{dummy_field: false};
        let v2 = 0x2::config::new<ConfigWriteCap>(&mut v1, arg3);
        0x2::dynamic_object_field::internal_add<ConfigKey, 0x2::config::Config<ConfigWriteCap>>(&mut arg0.id, v0, v2);
        let v3 = PerTypeConfigCreated{
            key       : v0,
            config_id : 0x2::object::id<0x2::config::Config<ConfigWriteCap>>(&v2),
        };
        0x2::event::emit<PerTypeConfigCreated>(v3);
    }

    fun borrow_per_type_config(arg0: &DenyList, arg1: u64, arg2: vector<u8>) : &0x2::config::Config<ConfigWriteCap> {
        let v0 = ConfigKey{
            per_type_index : arg1,
            per_type_key   : arg2,
        };
        0x2::dynamic_object_field::internal_borrow<ConfigKey, 0x2::config::Config<ConfigWriteCap>>(&arg0.id, v0)
    }

    fun borrow_per_type_config_mut(arg0: &mut DenyList, arg1: u64, arg2: vector<u8>) : &mut 0x2::config::Config<ConfigWriteCap> {
        let v0 = ConfigKey{
            per_type_index : arg1,
            per_type_key   : arg2,
        };
        0x2::dynamic_object_field::internal_borrow_mut<ConfigKey, 0x2::config::Config<ConfigWriteCap>>(&mut arg0.id, v0)
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x0, 0);
        let v0 = 0x2::bag::new(arg0);
        0x2::bag::add<u64, PerTypeList>(&mut v0, 0, per_type_list(arg0));
        let v1 = DenyList{
            id    : 0x2::object::sui_deny_list_object_id(),
            lists : v0,
        };
        0x2::transfer::share_object<DenyList>(v1);
    }

    public(friend) fun migrate_v1_to_v2(arg0: &mut DenyList, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::borrow_mut<u64, PerTypeList>(&mut arg0.lists, arg1);
        let v1 = if (!0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&v0.denied_addresses, arg2)) {
            vector[]
        } else {
            0x2::vec_set::into_keys<address>(0x2::table::remove<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut v0.denied_addresses, arg2))
        };
        let v2 = v1;
        let v3 = &v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(v3)) {
            let v5 = *0x1::vector::borrow<address>(v3, v4);
            let v6 = 0x2::table::borrow_mut<address, u64>(&mut v0.denied_count, v5);
            *v6 = *v6 - 1;
            if (*v6 == 0) {
                0x2::table::remove<address, u64>(&mut v0.denied_count, v5);
            };
            v4 = v4 + 1;
        };
        if (!per_type_exists(arg0, arg1, arg2)) {
            add_per_type_config(arg0, arg1, arg2, arg3);
        };
        let v7 = borrow_per_type_config_mut(arg0, arg1, arg2);
        0x1::vector::reverse<address>(&mut v2);
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(&v2)) {
            let v9 = AddressKey{pos0: 0x1::vector::pop_back<address>(&mut v2)};
            let v10 = ConfigWriteCap{dummy_field: false};
            let v11 = &mut v10;
            if (!0x2::config::exists_with_type_for_next_epoch<ConfigWriteCap, AddressKey, bool>(v7, v9, arg3)) {
                0x2::config::add_for_next_epoch<ConfigWriteCap, AddressKey, bool>(v7, v11, v9, true, arg3);
            };
            *0x2::config::borrow_for_next_epoch_mut<ConfigWriteCap, AddressKey, bool>(v7, v11, v9, arg3) = true;
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<address>(v2);
    }

    fun per_type_exists(arg0: &DenyList, arg1: u64, arg2: vector<u8>) : bool {
        let v0 = ConfigKey{
            per_type_index : arg1,
            per_type_key   : arg2,
        };
        0x2::dynamic_object_field::exists_<ConfigKey>(&arg0.id, v0)
    }

    fun per_type_list(arg0: &mut 0x2::tx_context::TxContext) : PerTypeList {
        PerTypeList{
            id               : 0x2::object::new(arg0),
            denied_count     : 0x2::table::new<address, u64>(arg0),
            denied_addresses : 0x2::table::new<vector<u8>, 0x2::vec_set::VecSet<address>>(arg0),
        }
    }

    public(friend) fun v1_add(arg0: &mut DenyList, arg1: u64, arg2: vector<u8>, arg3: address) {
        let v0 = vector[@0x0, @0x1, @0x2, @0x3, @0x4, @0x5, @0x6, @0x7, @0x8, @0x9, @0xa, @0xb, @0xc, @0xd, @0xe, @0xf, @0x403, @0xdee9];
        assert!(!0x1::vector::contains<address>(&v0, &arg3), 1);
        let v1 = 0x2::bag::borrow_mut<u64, PerTypeList>(&mut arg0.lists, arg1);
        v1_per_type_list_add(v1, arg2, arg3);
    }

    public(friend) fun v1_contains(arg0: &DenyList, arg1: u64, arg2: vector<u8>, arg3: address) : bool {
        let v0 = vector[@0x0, @0x1, @0x2, @0x3, @0x4, @0x5, @0x6, @0x7, @0x8, @0x9, @0xa, @0xb, @0xc, @0xd, @0xe, @0xf, @0x403, @0xdee9];
        if (0x1::vector::contains<address>(&v0, &arg3)) {
            return false
        };
        v1_per_type_list_contains(0x2::bag::borrow<u64, PerTypeList>(&arg0.lists, arg1), arg2, arg3)
    }

    fun v1_per_type_list_add(arg0: &mut PerTypeList, arg1: vector<u8>, arg2: address) {
        if (!0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.denied_addresses, arg1)) {
            0x2::table::add<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.denied_addresses, arg1, 0x2::vec_set::empty<address>());
        };
        let v0 = 0x2::table::borrow_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.denied_addresses, arg1);
        if (0x2::vec_set::contains<address>(v0, &arg2)) {
            return
        };
        0x2::vec_set::insert<address>(v0, arg2);
        if (!0x2::table::contains<address, u64>(&arg0.denied_count, arg2)) {
            0x2::table::add<address, u64>(&mut arg0.denied_count, arg2, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.denied_count, arg2);
        *v1 = *v1 + 1;
    }

    fun v1_per_type_list_contains(arg0: &PerTypeList, arg1: vector<u8>, arg2: address) : bool {
        if (!0x2::table::contains<address, u64>(&arg0.denied_count, arg2)) {
            return false
        };
        if (*0x2::table::borrow<address, u64>(&arg0.denied_count, arg2) == 0) {
            return false
        };
        if (!0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.denied_addresses, arg1)) {
            return false
        };
        0x2::vec_set::contains<address>(0x2::table::borrow<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.denied_addresses, arg1), &arg2)
    }

    fun v1_per_type_list_remove(arg0: &mut PerTypeList, arg1: vector<u8>, arg2: address) {
        let v0 = 0x2::table::borrow_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.denied_addresses, arg1);
        assert!(0x2::vec_set::contains<address>(v0, &arg2), 1);
        0x2::vec_set::remove<address>(v0, &arg2);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.denied_count, arg2);
        *v1 = *v1 - 1;
        if (*v1 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.denied_count, arg2);
        };
    }

    public(friend) fun v1_remove(arg0: &mut DenyList, arg1: u64, arg2: vector<u8>, arg3: address) {
        let v0 = vector[@0x0, @0x1, @0x2, @0x3, @0x4, @0x5, @0x6, @0x7, @0x8, @0x9, @0xa, @0xb, @0xc, @0xd, @0xe, @0xf, @0x403, @0xdee9];
        assert!(!0x1::vector::contains<address>(&v0, &arg3), 1);
        let v1 = 0x2::bag::borrow_mut<u64, PerTypeList>(&mut arg0.lists, arg1);
        v1_per_type_list_remove(v1, arg2, arg3);
    }

    public(friend) fun v2_add(arg0: &mut DenyList, arg1: u64, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (!per_type_exists(arg0, arg1, arg2)) {
            add_per_type_config(arg0, arg1, arg2, arg4);
        };
        let v0 = borrow_per_type_config_mut(arg0, arg1, arg2);
        let v1 = AddressKey{pos0: arg3};
        let v2 = ConfigWriteCap{dummy_field: false};
        let v3 = &mut v2;
        if (!0x2::config::exists_with_type_for_next_epoch<ConfigWriteCap, AddressKey, bool>(v0, v1, arg4)) {
            0x2::config::add_for_next_epoch<ConfigWriteCap, AddressKey, bool>(v0, v3, v1, true, arg4);
        };
        *0x2::config::borrow_for_next_epoch_mut<ConfigWriteCap, AddressKey, bool>(v0, v3, v1, arg4) = true;
    }

    public(friend) fun v2_contains_current_epoch(arg0: &DenyList, arg1: u64, arg2: vector<u8>, arg3: address, arg4: &0x2::tx_context::TxContext) : bool {
        if (!per_type_exists(arg0, arg1, arg2)) {
            return false
        };
        let v0 = AddressKey{pos0: arg3};
        let v1 = 0x2::config::read_setting<AddressKey, bool>(0x2::object::id<0x2::config::Config<ConfigWriteCap>>(borrow_per_type_config(arg0, arg1, arg2)), v0, arg4);
        if (0x1::option::is_some<bool>(&v1)) {
            0x1::option::destroy_some<bool>(v1)
        } else {
            0x1::option::destroy_none<bool>(v1);
            false
        }
    }

    public(friend) fun v2_contains_next_epoch(arg0: &DenyList, arg1: u64, arg2: vector<u8>, arg3: address) : bool {
        if (!per_type_exists(arg0, arg1, arg2)) {
            return false
        };
        let v0 = AddressKey{pos0: arg3};
        let v1 = 0x2::config::read_setting_for_next_epoch<ConfigWriteCap, AddressKey, bool>(borrow_per_type_config(arg0, arg1, arg2), v0);
        if (0x1::option::is_some<bool>(&v1)) {
            0x1::option::destroy_some<bool>(v1)
        } else {
            0x1::option::destroy_none<bool>(v1);
            false
        }
    }

    public(friend) fun v2_disable_global_pause(arg0: &mut DenyList, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!per_type_exists(arg0, arg1, arg2)) {
            add_per_type_config(arg0, arg1, arg2, arg3);
        };
        let v0 = ConfigWriteCap{dummy_field: false};
        let v1 = GlobalPauseKey{dummy_field: false};
        0x2::config::remove_for_next_epoch<ConfigWriteCap, GlobalPauseKey, bool>(borrow_per_type_config_mut(arg0, arg1, arg2), &mut v0, v1, arg3);
    }

    public(friend) fun v2_enable_global_pause(arg0: &mut DenyList, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!per_type_exists(arg0, arg1, arg2)) {
            add_per_type_config(arg0, arg1, arg2, arg3);
        };
        let v0 = borrow_per_type_config_mut(arg0, arg1, arg2);
        let v1 = ConfigWriteCap{dummy_field: false};
        let v2 = &mut v1;
        let v3 = GlobalPauseKey{dummy_field: false};
        if (!0x2::config::exists_with_type_for_next_epoch<ConfigWriteCap, GlobalPauseKey, bool>(v0, v3, arg3)) {
            0x2::config::add_for_next_epoch<ConfigWriteCap, GlobalPauseKey, bool>(v0, v2, v3, true, arg3);
        };
        *0x2::config::borrow_for_next_epoch_mut<ConfigWriteCap, GlobalPauseKey, bool>(v0, v2, v3, arg3) = true;
    }

    public(friend) fun v2_is_global_pause_enabled_current_epoch(arg0: &DenyList, arg1: u64, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) : bool {
        if (!per_type_exists(arg0, arg1, arg2)) {
            return false
        };
        let v0 = GlobalPauseKey{dummy_field: false};
        let v1 = 0x2::config::read_setting<GlobalPauseKey, bool>(0x2::object::id<0x2::config::Config<ConfigWriteCap>>(borrow_per_type_config(arg0, arg1, arg2)), v0, arg3);
        if (0x1::option::is_some<bool>(&v1)) {
            0x1::option::destroy_some<bool>(v1)
        } else {
            0x1::option::destroy_none<bool>(v1);
            false
        }
    }

    public(friend) fun v2_is_global_pause_enabled_next_epoch(arg0: &DenyList, arg1: u64, arg2: vector<u8>) : bool {
        if (!per_type_exists(arg0, arg1, arg2)) {
            return false
        };
        let v0 = GlobalPauseKey{dummy_field: false};
        let v1 = 0x2::config::read_setting_for_next_epoch<ConfigWriteCap, GlobalPauseKey, bool>(borrow_per_type_config(arg0, arg1, arg2), v0);
        if (0x1::option::is_some<bool>(&v1)) {
            0x1::option::destroy_some<bool>(v1)
        } else {
            0x1::option::destroy_none<bool>(v1);
            false
        }
    }

    public(friend) fun v2_remove(arg0: &mut DenyList, arg1: u64, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (!per_type_exists(arg0, arg1, arg2)) {
            add_per_type_config(arg0, arg1, arg2, arg4);
        };
        let v0 = AddressKey{pos0: arg3};
        let v1 = ConfigWriteCap{dummy_field: false};
        0x2::config::remove_for_next_epoch<ConfigWriteCap, AddressKey, bool>(borrow_per_type_config_mut(arg0, arg1, arg2), &mut v1, v0, arg4);
    }

    // decompiled from Move bytecode v6
}

