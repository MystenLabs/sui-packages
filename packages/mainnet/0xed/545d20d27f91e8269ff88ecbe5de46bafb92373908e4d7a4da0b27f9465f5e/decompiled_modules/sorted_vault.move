module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::sorted_vault {
    struct VaultRedemptionList has store, key {
        id: 0x2::object::UID,
        head: 0x1::option::Option<0x2::object::ID>,
        tail: 0x1::option::Option<0x2::object::ID>,
        nodes: 0x2::object_table::ObjectTable<0x2::object::ID, VaultRedemptionData>,
    }

    struct VaultRedemptionData has store, key {
        id: 0x2::object::UID,
        last_update_timestamp: u64,
        interest_rate: u64,
        vault_id: 0x2::object::ID,
        next_vault_id: 0x1::option::Option<0x2::object::ID>,
        prev_vault_id: 0x1::option::Option<0x2::object::ID>,
    }

    public(friend) fun create_sorted_vault(arg0: &mut 0x2::tx_context::TxContext) : VaultRedemptionList {
        VaultRedemptionList{
            id    : 0x2::object::new(arg0),
            head  : 0x1::option::none<0x2::object::ID>(),
            tail  : 0x1::option::none<0x2::object::ID>(),
            nodes : 0x2::object_table::new<0x2::object::ID, VaultRedemptionData>(arg0),
        }
    }

    fun find_insertion_points(arg0: &VaultRedemptionList, arg1: u64, arg2: u64, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<0x2::object::ID>) : (0x1::option::Option<0x2::object::ID>, 0x1::option::Option<0x2::object::ID>) {
        let v0 = if (0x1::option::is_some<0x2::object::ID>(&arg3) && 0x2::object_table::contains<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&arg3))) {
            let v1 = 0x2::object_table::borrow<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&arg3));
            v1.interest_rate < arg2 || v1.interest_rate == arg2 && v1.last_update_timestamp <= arg1
        } else {
            false
        };
        let v2 = if (0x1::option::is_some<0x2::object::ID>(&arg4) && 0x2::object_table::contains<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&arg4))) {
            let v3 = 0x2::object_table::borrow<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&arg4));
            v3.interest_rate > arg2 || v3.interest_rate == arg2 && v3.last_update_timestamp >= arg1
        } else {
            false
        };
        let v4 = if (v0) {
            arg3
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        let v5 = v4;
        let v6 = if (v2) {
            arg4
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        let v7 = v6;
        if (0x1::option::is_some<0x2::object::ID>(&v5) && 0x1::option::is_some<0x2::object::ID>(&v7)) {
            let v8 = *0x1::option::borrow<0x2::object::ID>(&v5);
            let v9 = *0x1::option::borrow<0x2::object::ID>(&v7);
            if (0x2::object_table::contains<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, v8) && 0x2::object_table::contains<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, v9)) {
                let v10 = 0x2::object_table::borrow<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, v8);
                let v11 = 0x2::object_table::borrow<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, v9);
                if (v10.interest_rate < arg2 && arg2 < v11.interest_rate) {
                    if (v10.next_vault_id == 0x1::option::some<0x2::object::ID>(v11.vault_id) && v11.prev_vault_id == 0x1::option::some<0x2::object::ID>(v10.vault_id)) {
                        return (0x1::option::some<0x2::object::ID>(v8), 0x1::option::some<0x2::object::ID>(v9))
                    };
                } else {
                    if (v10.interest_rate == arg2) {
                        return traverse_down(arg0, v8, arg2, arg1)
                    };
                    if (v11.interest_rate == arg2) {
                        return traverse_up(arg0, v9, arg2, arg1)
                    };
                };
            };
        } else if (0x1::option::is_some<0x2::object::ID>(&v5)) {
            let v12 = *0x1::option::borrow<0x2::object::ID>(&v5);
            if (0x2::object_table::contains<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, v12)) {
                return traverse_down(arg0, v12, arg2, arg1)
            };
        } else if (0x1::option::is_some<0x2::object::ID>(&v7)) {
            let v13 = *0x1::option::borrow<0x2::object::ID>(&v7);
            if (0x2::object_table::contains<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, v13)) {
                return traverse_up(arg0, v13, arg2, arg1)
            };
        } else if (0x1::option::is_some<0x2::object::ID>(&arg0.head) && 0x1::option::is_some<0x2::object::ID>(&arg0.tail)) {
            let v14 = *0x1::option::borrow<0x2::object::ID>(&arg0.tail);
            if (0x2::object_table::contains<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, v14)) {
                return traverse_up(arg0, v14, arg2, arg1)
            };
        };
        (0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>())
    }

    fun insert_between(arg0: &mut VaultRedemptionList, arg1: VaultRedemptionData, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<0x2::object::ID>) {
        let v0 = arg1.vault_id;
        0x2::object_table::add<0x2::object::ID, VaultRedemptionData>(&mut arg0.nodes, v0, arg1);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, VaultRedemptionData>(&mut arg0.nodes, v0);
        v1.prev_vault_id = arg2;
        v1.next_vault_id = arg3;
        if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            0x2::object_table::borrow_mut<0x2::object::ID, VaultRedemptionData>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&arg2)).next_vault_id = 0x1::option::some<0x2::object::ID>(v0);
        } else {
            arg0.head = 0x1::option::some<0x2::object::ID>(v0);
        };
        if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
            0x2::object_table::borrow_mut<0x2::object::ID, VaultRedemptionData>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&arg3)).prev_vault_id = 0x1::option::some<0x2::object::ID>(v0);
        } else {
            arg0.tail = 0x1::option::some<0x2::object::ID>(v0);
        };
    }

    public(friend) fun intern_add_node(arg0: &mut VaultRedemptionList, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::object_table::contains<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, arg1), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EVaultIdAlreadyExistInRedemptionList());
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = VaultRedemptionData{
            id                    : 0x2::object::new(arg6),
            last_update_timestamp : v0,
            interest_rate         : arg3,
            vault_id              : arg1,
            next_vault_id         : 0x1::option::none<0x2::object::ID>(),
            prev_vault_id         : 0x1::option::none<0x2::object::ID>(),
        };
        let (v2, v3) = find_insertion_points(arg0, v0, arg3, arg4, arg5);
        insert_between(arg0, v1, v2, v3);
    }

    public fun intern_get_redemption_list_head(arg0: &VaultRedemptionList) : 0x1::option::Option<0x2::object::ID> {
        arg0.head
    }

    public fun intern_get_redemption_list_tail(arg0: &VaultRedemptionList) : 0x1::option::Option<0x2::object::ID> {
        arg0.tail
    }

    public fun intern_get_redemption_node(arg0: &VaultRedemptionList, arg1: 0x1::option::Option<0x2::object::ID>) : (0x1::option::Option<0x2::object::ID>, 0x1::option::Option<0x2::object::ID>) {
        let v0 = if (0x1::option::is_some<0x2::object::ID>(&arg1)) {
            *0x1::option::borrow<0x2::object::ID>(&arg1)
        } else if (0x1::option::is_some<0x2::object::ID>(&arg0.head)) {
            *0x1::option::borrow<0x2::object::ID>(&arg0.head)
        } else {
            return (0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>())
        };
        if (!0x2::object_table::contains<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, v0)) {
            return (0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>())
        };
        let v1 = 0x2::object_table::borrow<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, v0);
        (0x1::option::some<0x2::object::ID>(v1.vault_id), v1.next_vault_id)
    }

    public fun intern_get_vault_redemption_node(arg0: &VaultRedemptionList, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (!0x2::object_table::contains<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, arg1)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        0x1::option::some<0x2::object::ID>(0x2::object_table::borrow<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, arg1).vault_id)
    }

    public(friend) fun intern_reinsert_node(arg0: &mut VaultRedemptionList, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<0x2::object::ID>) {
        let v0 = 0x2::object_table::remove<0x2::object::ID, VaultRedemptionData>(&mut arg0.nodes, arg1);
        let v1 = v0.prev_vault_id;
        let v2 = v0.next_vault_id;
        if (0x1::option::is_some<0x2::object::ID>(&v1)) {
            0x2::object_table::borrow_mut<0x2::object::ID, VaultRedemptionData>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&v1)).next_vault_id = v2;
        } else {
            arg0.head = v2;
        };
        if (0x1::option::is_some<0x2::object::ID>(&v2)) {
            0x2::object_table::borrow_mut<0x2::object::ID, VaultRedemptionData>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&v2)).prev_vault_id = v1;
        } else {
            arg0.tail = v1;
        };
        let v3 = 0x2::clock::timestamp_ms(arg2);
        v0.last_update_timestamp = v3;
        v0.next_vault_id = 0x1::option::none<0x2::object::ID>();
        v0.prev_vault_id = 0x1::option::none<0x2::object::ID>();
        v0.interest_rate = arg3;
        let (v4, v5) = find_insertion_points(arg0, v3, arg3, arg4, arg5);
        insert_between(arg0, v0, v4, v5);
    }

    public(friend) fun intern_remove_node(arg0: &mut VaultRedemptionList, arg1: 0x2::object::ID) {
        if (!0x2::object_table::contains<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, arg1)) {
            return
        };
        let v0 = 0x2::object_table::remove<0x2::object::ID, VaultRedemptionData>(&mut arg0.nodes, arg1);
        let v1 = v0.prev_vault_id;
        let v2 = v0.next_vault_id;
        if (0x1::option::is_some<0x2::object::ID>(&v1)) {
            0x2::object_table::borrow_mut<0x2::object::ID, VaultRedemptionData>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&v1)).next_vault_id = v2;
        } else {
            arg0.head = v2;
        };
        if (0x1::option::is_some<0x2::object::ID>(&v2)) {
            0x2::object_table::borrow_mut<0x2::object::ID, VaultRedemptionData>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&v2)).prev_vault_id = v1;
        } else {
            arg0.tail = v1;
        };
        let VaultRedemptionData {
            id                    : v3,
            last_update_timestamp : _,
            interest_rate         : _,
            vault_id              : _,
            next_vault_id         : _,
            prev_vault_id         : _,
        } = v0;
        0x2::object::delete(v3);
    }

    fun traverse_down(arg0: &VaultRedemptionList, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : (0x1::option::Option<0x2::object::ID>, 0x1::option::Option<0x2::object::ID>) {
        let v0 = 0x1::option::none<0x2::object::ID>();
        while (0x2::object_table::contains<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, arg1)) {
            let v1 = 0x2::object_table::borrow<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, arg1);
            if (v1.interest_rate > arg2 || v1.interest_rate == arg2 && v1.last_update_timestamp > arg3) {
                return (v0, 0x1::option::some<0x2::object::ID>(arg1))
            };
            v0 = 0x1::option::some<0x2::object::ID>(arg1);
            if (0x1::option::is_some<0x2::object::ID>(&v1.next_vault_id)) {
                arg1 = *0x1::option::borrow<0x2::object::ID>(&v1.next_vault_id);
            } else {
                break
            };
        };
        (v0, 0x1::option::none<0x2::object::ID>())
    }

    fun traverse_up(arg0: &VaultRedemptionList, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : (0x1::option::Option<0x2::object::ID>, 0x1::option::Option<0x2::object::ID>) {
        let v0 = 0x1::option::none<0x2::object::ID>();
        while (0x2::object_table::contains<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, arg1)) {
            let v1 = 0x2::object_table::borrow<0x2::object::ID, VaultRedemptionData>(&arg0.nodes, arg1);
            if (v1.interest_rate < arg2 || v1.interest_rate == arg2 && v1.last_update_timestamp < arg3) {
                return (0x1::option::some<0x2::object::ID>(arg1), v0)
            };
            v0 = 0x1::option::some<0x2::object::ID>(arg1);
            if (0x1::option::is_some<0x2::object::ID>(&v1.prev_vault_id)) {
                arg1 = *0x1::option::borrow<0x2::object::ID>(&v1.prev_vault_id);
            } else {
                break
            };
        };
        (0x1::option::none<0x2::object::ID>(), v0)
    }

    // decompiled from Move bytecode v6
}

