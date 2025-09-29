module 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission {
    struct Perm has copy, drop, store {
        index: u16,
        guard: 0x1::option::Option<address>,
    }

    struct Permission has key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        table: 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::LinkedTable<address, vector<Perm>>,
        user_define: 0x2::vec_map::VecMap<u16, 0x1::string::String>,
        builder: address,
        admin: vector<address>,
    }

    public fun remove(arg0: &mut Permission, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        ASSERT_ADMIN(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::borrow<address>(&arg1, v0);
            if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<address, vector<Perm>>(&arg0.id, &arg0.table, *v1)) {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::remove<address, vector<Perm>>(&mut arg0.id, &mut arg0.table, *v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun new(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Permission {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(&arg0);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = 0x2::tx_context::sender(arg1);
        Permission{
            id          : v0,
            description : arg0,
            table       : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::new<address, vector<Perm>>(&v1),
            user_define : 0x2::vec_map::empty<u16, 0x1::string::String>(),
            builder     : v2,
            admin       : 0x1::vector::singleton<address>(v2),
        }
    }

    public fun ASSERT_ADMIN(arg0: &Permission, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::permission::ADMIN(0x1::vector::contains<address>(&arg0.admin, &v0));
    }

    public fun ASSERT_CREATOR(arg0: &Permission, arg1: &mut 0x2::tx_context::TxContext) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::permission::BUILDER(arg0.builder == 0x2::tx_context::sender(arg1));
    }

    public fun ASSERT_RIGHT(arg0: &Permission, arg1: &address, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::permission::NOT_MATCH(*arg1 == 0x2::object::id_address<Permission>(arg0));
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::NEED_PASSPORT(has_rights(arg0, 0x2::tx_context::sender(arg3), arg2));
    }

    public fun ASSERT_RIGHT_WITH_PASSPORT(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &Permission, arg2: &address, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::permission::NOT_MATCH(*arg2 == 0x2::object::id_address<Permission>(arg1));
        let v0 = 0x2::tx_context::sender(arg4);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::permission::P_FAIL(has_right_with_passport(arg0, arg1, v0, arg3, arg4));
    }

    public fun HAS_RIGHT(arg0: &Permission, arg1: &address, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : bool {
        *arg1 == 0x2::object::id_address<Permission>(arg0) && has_rights(arg0, 0x2::tx_context::sender(arg3), arg2)
    }

    public fun HAS_RIGHT_WITH_PASSPORT(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &Permission, arg2: &address, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) : bool {
        if (*arg2 == 0x2::object::id_address<Permission>(arg1)) {
            let v1 = 0x2::tx_context::sender(arg4);
            has_right_with_passport(arg0, arg1, v1, arg3, arg4)
        } else {
            false
        }
    }

    public fun add(arg0: &mut Permission, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        ASSERT_ADMIN(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::borrow<address>(&arg1, v0);
            if (!0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<address, vector<Perm>>(&arg0.id, &arg0.table, *v1)) {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::permission::ENTITY_COUNT(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::length<address, vector<Perm>>(&arg0.table));
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::push_back<address, vector<Perm>>(&mut arg0.id, &mut arg0.table, *v1, 0x1::vector::empty<Perm>());
            };
            v0 = v0 + 1;
        };
    }

    public fun add_batch(arg0: &mut Permission, arg1: address, arg2: vector<u16>, arg3: &mut 0x2::tx_context::TxContext) {
        ASSERT_ADMIN(arg0, arg3);
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<address, vector<Perm>>(&arg0.id, &arg0.table, arg1)) {
            let v0 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow_mut<address, vector<Perm>>(&mut arg0.id, &mut arg0.table, arg1);
            add_batch_imp(v0, &arg2);
        } else {
            let v1 = 0x1::vector::empty<Perm>();
            let v2 = &mut v1;
            add_batch_imp(v2, &arg2);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::permission::ENTITY_COUNT(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::length<address, vector<Perm>>(&arg0.table));
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::push_back<address, vector<Perm>>(&mut arg0.id, &mut arg0.table, arg1, v1);
        };
    }

    fun add_batch_imp(arg0: &mut vector<Perm>, arg1: &vector<u16>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u16>(arg1)) {
            let v1 = 0x1::vector::borrow<u16>(arg1, v0);
            let v2 = 0x1::vector::length<Perm>(arg0);
            let v3 = 0;
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::permission::INDEX_COUNT(v2);
            while (v3 < v2) {
                if (0x1::vector::borrow<Perm>(arg0, v3).index == *v1) {
                    break
                };
                v3 = v3 + 1;
            };
            if (v3 == v2) {
                let v4 = Perm{
                    index : *v1,
                    guard : 0x1::option::none<address>(),
                };
                0x1::vector::push_back<Perm>(arg0, v4);
            };
            v0 = v0 + 1;
        };
    }

    public fun add_with_index(arg0: &mut Permission, arg1: u16, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        ASSERT_ADMIN(arg0, arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<address, vector<Perm>>(&arg0.id, &arg0.table, *v1)) {
                let v2 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow_mut<address, vector<Perm>>(&mut arg0.id, &mut arg0.table, *v1);
                let v3 = 0x1::vector::length<Perm>(v2);
                let v4 = 0;
                while (v4 < v3) {
                    if (0x1::vector::borrow<Perm>(v2, v4).index == arg1) {
                        break
                    };
                    v4 = v4 + 1;
                };
                if (v4 == v3) {
                    0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::permission::INDEX_COUNT(v3);
                    let v5 = Perm{
                        index : arg1,
                        guard : 0x1::option::none<address>(),
                    };
                    0x1::vector::push_back<Perm>(v2, v5);
                };
            } else {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::permission::ENTITY_COUNT(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::length<address, vector<Perm>>(&arg0.table));
                let v6 = 0x1::vector::empty<Perm>();
                let v7 = Perm{
                    index : arg1,
                    guard : 0x1::option::none<address>(),
                };
                0x1::vector::push_back<Perm>(&mut v6, v7);
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::push_back<address, vector<Perm>>(&mut arg0.id, &mut arg0.table, *v1, v6);
            };
            v0 = v0 + 1;
        };
    }

    public fun admin(arg0: &Permission) : &vector<address> {
        &arg0.admin
    }

    public fun admin_add(arg0: &mut Permission, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        ASSERT_CREATOR(arg0, arg2);
        admin_add_imp(arg0, &arg1);
    }

    public fun admin_add_batch(arg0: &mut Permission, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        ASSERT_CREATOR(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            admin_add_imp(arg0, 0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    fun admin_add_imp(arg0: &mut Permission, arg1: &address) {
        if (!0x1::vector::contains<address>(&arg0.admin, arg1)) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::permission::ADMIN_COUNT(0x1::vector::length<address>(&arg0.admin));
            0x1::vector::push_back<address>(&mut arg0.admin, *arg1);
        };
    }

    public fun admin_remove(arg0: &mut Permission, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        ASSERT_CREATOR(arg0, arg2);
        admin_remove_imp(arg0, &arg1);
    }

    public fun admin_remove_batch(arg0: &mut Permission, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        ASSERT_CREATOR(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            admin_remove_imp(arg0, 0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    fun admin_remove_imp(arg0: &mut Permission, arg1: &address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admin, arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.admin, v1);
        };
    }

    public fun admins_clear(arg0: &mut Permission, arg1: &mut 0x2::tx_context::TxContext) {
        ASSERT_CREATOR(arg0, arg1);
        arg0.admin = 0x1::vector::empty<address>();
    }

    public fun builder(arg0: &Permission) : &address {
        &arg0.builder
    }

    public fun builder_set(arg0: &mut Permission, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        ASSERT_CREATOR(arg0, arg2);
        arg0.builder = arg1;
    }

    public fun change_entity(arg0: &mut Permission, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        ASSERT_ADMIN(arg0, arg3);
        if (arg1 != arg2) {
            if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<address, vector<Perm>>(&arg0.id, &arg0.table, arg1) && !0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<address, vector<Perm>>(&arg0.id, &arg0.table, arg2)) {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::push_back<address, vector<Perm>>(&mut arg0.id, &mut arg0.table, arg2, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::remove<address, vector<Perm>>(&mut arg0.id, &mut arg0.table, arg1));
            };
        };
    }

    public fun create(arg0: Permission, arg1: &mut 0x2::tx_context::TxContext) : address {
        ASSERT_CREATOR(&arg0, arg1);
        0x2::transfer::share_object<Permission>(arg0);
        0x2::object::id_address<Permission>(&arg0)
    }

    public fun creator_permission(arg0: &mut 0x2::tx_context::TxContext) : address {
        let v0 = new(0x1::string::utf8(b"for creator"), arg0);
        create(v0, arg0);
        0x2::object::id_address<Permission>(&v0)
    }

    public fun description_set(arg0: &mut Permission, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        ASSERT_ADMIN(arg0, arg2);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(&arg1);
        arg0.description = arg1;
    }

    public fun guard_none(arg0: &mut Permission, arg1: address, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        ASSERT_ADMIN(arg0, arg3);
        let v0 = 0x1::option::none<address>();
        guard_set_imp(arg0, &arg1, arg2, &v0);
    }

    public fun guard_query(arg0: &Permission, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport) {
        let v0 = 0x2::object::id_address<Permission>(arg0);
        let (v1, v2, _) = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 1) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), builder(arg0));
        } else if (v2 == 2) {
            let v4 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1);
            let v5 = 0x1::vector::contains<address>(&arg0.admin, &v4);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v5);
        } else if (v2 == 3) {
            let v6 = has_rights(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1), 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U16(v1));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v6);
        } else if (v2 == 4) {
            let v7 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<address, vector<Perm>>(&arg0.id, &arg0.table, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v7);
        } else if (v2 == 5) {
            let (_, v9, _) = has_rights_set(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1), 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U16(v1));
            let v11 = v9;
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v11);
        } else if (v2 == 6) {
            let (_, _, v14) = has_rights_set(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1), 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U16(v1));
            let v15 = v14;
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v15);
        } else if (v2 == 7) {
            let v16 = index_guard(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1), 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U16(v1));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&v16));
        } else if (v2 == 8) {
            let v17 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::length<address, vector<Perm>>(&arg0.table);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v17);
        } else if (v2 == 9) {
            let v18 = 0x1::vector::length<address>(&arg0.admin);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v18);
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::Q_CMD_NOT_MATCH();
        };
    }

    public fun guard_set(arg0: &mut Permission, arg1: address, arg2: u16, arg3: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg4: &mut 0x2::tx_context::TxContext) {
        ASSERT_ADMIN(arg0, arg4);
        let v0 = 0x1::option::some<address>(0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg3));
        guard_set_imp(arg0, &arg1, arg2, &v0);
    }

    fun guard_set_imp(arg0: &mut Permission, arg1: &address, arg2: u16, arg3: &0x1::option::Option<address>) {
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<address, vector<Perm>>(&arg0.id, &arg0.table, *arg1)) {
            let v0 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow_mut<address, vector<Perm>>(&mut arg0.id, &mut arg0.table, *arg1);
            let v1 = 0;
            while (v1 < 0x1::vector::length<Perm>(v0)) {
                let v2 = 0x1::vector::borrow_mut<Perm>(v0, v1);
                if (v2.index == arg2) {
                    v2.guard = *arg3;
                    break
                };
                v1 = v1 + 1;
            };
        };
    }

    public fun has_right_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &Permission, arg2: address, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) : bool {
        if (0x1::vector::contains<address>(&arg1.admin, &arg2)) {
            return true
        };
        let v0 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow<address, vector<Perm>>(&arg1.id, &arg1.table, arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Perm>(v0)) {
            let v2 = 0x1::vector::borrow<Perm>(v0, v1);
            if (v2.index == arg3 && 0x1::option::is_some<address>(&v2.guard)) {
                return 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::USE_PASSPORT(0x1::option::borrow<address>(&v2.guard), arg0, arg4)
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun has_rights(arg0: &Permission, arg1: address, arg2: u16) : bool {
        if (0x1::vector::contains<address>(&arg0.admin, &arg1)) {
            return true
        };
        let v0 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow<address, vector<Perm>>(&arg0.id, &arg0.table, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Perm>(v0)) {
            let v2 = 0x1::vector::borrow<Perm>(v0, v1);
            if (v2.index == arg2) {
                return 0x1::option::is_none<address>(&v2.guard)
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun has_rights_set(arg0: &Permission, arg1: address, arg2: u16) : (bool, bool, bool) {
        let v0 = false;
        let v1 = false;
        let v2 = false;
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<address, vector<Perm>>(&arg0.id, &arg0.table, arg1)) {
            v2 = true;
            let v3 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow<address, vector<Perm>>(&arg0.id, &arg0.table, arg1);
            let v4 = 0;
            while (v4 < 0x1::vector::length<Perm>(v3)) {
                let v5 = 0x1::vector::borrow<Perm>(v3, v4);
                if (v5.index == arg2) {
                    v1 = true;
                    v0 = 0x1::option::is_some<address>(&v5.guard);
                    break
                };
                v4 = v4 + 1;
            };
        };
        (v2, v1, v0)
    }

    public fun index_guard(arg0: &Permission, arg1: address, arg2: u16) : 0x1::option::Option<address> {
        let v0 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow<address, vector<Perm>>(&arg0.id, &arg0.table, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Perm>(v0)) {
            let v2 = 0x1::vector::borrow<Perm>(v0, v1);
            if (v2.index == arg2) {
                return v2.guard
            };
            v1 = v1 + 1;
        };
        0x1::option::none<address>()
    }

    public fun query_permissions_all(arg0: &Permission, arg1: address) : (u8, vector<Perm>) {
        if (0x1::vector::contains<address>(&arg0.admin, &arg1)) {
            if (arg0.builder == arg1) {
                return (3, 0x1::vector::empty<Perm>())
            };
            return (2, 0x1::vector::empty<Perm>())
        };
        if (!0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<address, vector<Perm>>(&arg0.id, &arg0.table, arg1)) {
            if (arg0.builder == arg1) {
                return (1, 0x1::vector::empty<Perm>())
            };
            return (0, 0x1::vector::empty<Perm>())
        };
        if (arg0.builder == arg1) {
            return (1, *0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow<address, vector<Perm>>(&arg0.id, &arg0.table, arg1))
        };
        (0, *0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow<address, vector<Perm>>(&arg0.id, &arg0.table, arg1))
    }

    public fun remove_all(arg0: &mut Permission, arg1: &mut 0x2::tx_context::TxContext) {
        ASSERT_ADMIN(arg0, arg1);
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        arg0.table = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::new<address, vector<Perm>>(&v0);
    }

    public fun remove_index(arg0: &mut Permission, arg1: address, arg2: vector<u16>, arg3: &mut 0x2::tx_context::TxContext) {
        ASSERT_ADMIN(arg0, arg3);
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::contains<address, vector<Perm>>(&arg0.id, &arg0.table, arg1)) {
            let v0 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow_mut<address, vector<Perm>>(&mut arg0.id, &mut arg0.table, arg1);
            let v1 = 0;
            while (v1 < 0x1::vector::length<u16>(&arg2)) {
                let v2 = 0x1::vector::borrow<u16>(&arg2, v1);
                let v3 = 0;
                while (v3 < 0x1::vector::length<Perm>(v0)) {
                    if (0x1::vector::borrow<Perm>(v0, v3).index == *v2) {
                        0x1::vector::remove<Perm>(v0, v3);
                        break
                    };
                    v3 = v3 + 1;
                };
                v1 = v1 + 1;
            };
        };
    }

    public fun user_define_add(arg0: &mut Permission, arg1: u16, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        ASSERT_ADMIN(arg0, arg3);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_NAMELEN(&arg2);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::permission::INDEX(arg1);
        if (0x2::vec_map::contains<u16, 0x1::string::String>(&arg0.user_define, &arg1)) {
            *0x2::vec_map::get_mut<u16, 0x1::string::String>(&mut arg0.user_define, &arg1) = arg2;
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::permission::PERM_COUNT(0x2::vec_map::size<u16, 0x1::string::String>(&arg0.user_define));
            0x2::vec_map::insert<u16, 0x1::string::String>(&mut arg0.user_define, arg1, arg2);
        };
    }

    public fun user_define_remove(arg0: &mut Permission, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        ASSERT_ADMIN(arg0, arg2);
        if (0x2::vec_map::contains<u16, 0x1::string::String>(&arg0.user_define, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<u16, 0x1::string::String>(&mut arg0.user_define, &arg1);
            let v2 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::front<address, vector<Perm>>(&arg0.table);
            while (0x1::option::is_some<address>(v2)) {
                let v3 = *0x1::option::borrow<address>(v2);
                let v4 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::borrow_mut<address, vector<Perm>>(&mut arg0.id, &mut arg0.table, v3);
                let v5 = 0;
                while (v5 < 0x1::vector::length<Perm>(v4)) {
                    if (0x1::vector::borrow<Perm>(v4, v5).index == arg1) {
                        0x1::vector::remove<Perm>(v4, v5);
                        break
                    };
                    v5 = v5 + 1;
                };
                v2 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table::next<address, vector<Perm>>(&arg0.id, &arg0.table, v3);
            };
        };
    }

    public(friend) fun wowok_create(arg0: Permission) {
        0x2::transfer::share_object<Permission>(arg0);
    }

    // decompiled from Move bytecode v6
}

