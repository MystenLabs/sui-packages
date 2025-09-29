module 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::repository {
    struct PolicyGuard has copy, drop, store {
        guard: address,
        witness_ids: vector<u8>,
    }

    struct PolicyRule has copy, drop, store {
        description: 0x1::string::String,
        permission_index: 0x1::option::Option<u16>,
        guard: 0x1::option::Option<PolicyGuard>,
        value_type: u8,
    }

    struct DataKey has copy, drop, store {
        id: address,
        key: 0x1::string::String,
    }

    struct Repository has key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        policies: 0x2::vec_map::VecMap<0x1::string::String, PolicyRule>,
        data: 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::Table<DataKey, vector<u8>>,
        permission: address,
        type: u8,
        policy_mode: u8,
        guard: 0x1::option::Option<address>,
        reference: vector<address>,
    }

    public fun remove(arg0: &mut Repository, arg1: vector<address>, arg2: 0x1::string::String, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        ASSERT_ACTOR(arg0, &arg2, arg3, arg4);
        data_remove_imp(arg0, &arg1, &arg2);
    }

    public fun new(arg0: 0x1::string::String, arg1: u8, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) : Repository {
        let v0 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission>(arg2);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &v0, 100, arg3);
        new_imp(&arg0, arg1, &v0, arg3)
    }

    public fun get(arg0: &Repository, arg1: address, arg2: 0x1::string::String) : vector<u8> {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::NEED_PASSPORT(0x1::option::is_none<address>(&arg0.guard));
        let v0 = DataKey{
            id  : arg1,
            key : arg2,
        };
        *0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<DataKey, vector<u8>>(&arg0.id, &arg0.data, v0)
    }

    fun ASSERT_ACTOR(arg0: &Repository, arg1: &0x1::string::String, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<u8> {
        if (0x2::vec_map::contains<0x1::string::String, PolicyRule>(&arg0.policies, arg1)) {
            let v0 = 0x2::vec_map::get<0x1::string::String, PolicyRule>(&arg0.policies, arg1);
            if (0x1::option::is_some<u16>(&v0.permission_index)) {
                0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, *0x1::option::borrow<u16>(&v0.permission_index), arg3);
            };
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::NEED_PASSPORT(0x1::option::is_none<PolicyGuard>(&v0.guard));
            return 0x1::option::some<u8>(v0.value_type)
        };
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::STRICT(arg0.policy_mode);
        0x1::option::none<u8>()
    }

    fun ASSERT_ACTOR_WITH_PASSPORT(arg0: bool, arg1: &vector<u8>, arg2: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg3: &Repository, arg4: &0x1::string::String, arg5: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg6: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<u8>, vector<address>) {
        if (0x2::vec_map::contains<0x1::string::String, PolicyRule>(&arg3.policies, arg4)) {
            let v0 = 0x2::vec_map::get<0x1::string::String, PolicyRule>(&arg3.policies, arg4);
            if (0x1::option::is_some<u16>(&v0.permission_index)) {
                0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg2, arg5, &arg3.permission, *0x1::option::borrow<u16>(&v0.permission_index), arg6);
            };
            if (0x1::option::is_some<PolicyGuard>(&v0.guard)) {
                let v1 = 0x1::option::borrow<PolicyGuard>(&v0.guard);
                let v2 = 0x1::vector::length<u8>(arg1);
                let v3 = 0;
                if (arg0) {
                    if (0x1::vector::length<u8>(&v1.witness_ids) > 0) {
                        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::WINESS_NOT_IN_POLICY(v2 > 0);
                        while (v3 < v2) {
                            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::WINESS_NOT_IN_POLICY(0x1::vector::contains<u8>(&v1.witness_ids, 0x1::vector::borrow<u8>(arg1, v3)));
                            v3 = v3 + 1;
                        };
                        return (0x1::option::some<u8>(v0.value_type), 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ASSERT_PASSPORT_AND_VALUE(&v1.guard, arg2, arg1, true, arg6))
                    };
                    0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::WINESS_NOT_IN_POLICY(v2 == 0);
                } else {
                    0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ASSERT_PASSPORT(&v1.guard, arg2, arg6);
                };
            };
            return (0x1::option::some<u8>(v0.value_type), 0x1::vector::empty<address>())
        };
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::STRICT(arg3.policy_mode);
        (0x1::option::none<u8>(), 0x1::vector::empty<address>())
    }

    public fun add(arg0: &mut Repository, arg1: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::RepRecord, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::RepRecord_borrow(arg1);
        if (0x1::vector::length<address>(v1) > 0) {
            let v3 = ASSERT_ACTOR(arg0, v0, arg2, arg3);
            data_add_imp(arg0, v0, &v3, v1, v2);
        };
    }

    public fun addWitness_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::RepWitness, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::RepWitness_borrow(arg2);
        if (0x1::vector::length<u8>(v1) > 0) {
            let (v3, v4) = ASSERT_ACTOR_WITH_PASSPORT(true, v1, arg0, arg1, v0, arg3, arg4);
            let v5 = v4;
            let v6 = v3;
            data_add_imp(arg1, v0, &v6, &v5, v2);
        };
    }

    public fun add_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::RepRecord, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::RepRecord_borrow(arg2);
        let v3 = 0x1::vector::empty<u8>();
        let (v4, _) = ASSERT_ACTOR_WITH_PASSPORT(true, &v3, arg0, arg1, v0, arg3, arg4);
        let v6 = v4;
        data_add_imp(arg1, v0, &v6, v1, v2);
    }

    public fun create(arg0: Repository) : address {
        0x2::transfer::share_object<Repository>(arg0);
        0x2::object::id_address<Repository>(&arg0)
    }

    public(friend) fun data_add_imp(arg0: &mut Repository, arg1: &0x1::string::String, arg2: &0x1::option::Option<u8>, arg3: &vector<address>, arg4: &vector<vector<u8>>) {
        let v0 = 0x1::vector::length<address>(arg3);
        let v1 = 0;
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::WITNESS_COUNT_NOT_MATCH(v0 == 0x1::vector::length<vector<u8>>(arg4));
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<vector<u8>>(arg4, v1);
            if (0x1::option::is_some<u8>(arg2)) {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::VALUE_TYPE_NOT_MATCH(v2, arg2);
            };
            let v3 = DataKey{
                id  : *0x1::vector::borrow<address>(arg3, v1),
                key : *arg1,
            };
            if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<DataKey, vector<u8>>(&arg0.id, &arg0.data, v3)) {
                *0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<DataKey, vector<u8>>(&mut arg0.id, &mut arg0.data, v3) = *v2;
            } else {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::add<DataKey, vector<u8>>(&mut arg0.id, &mut arg0.data, v3, *v2);
            };
            v1 = v1 + 1;
        };
    }

    public fun data_contains_value(arg0: &Repository, arg1: address, arg2: 0x1::string::String) : bool {
        let v0 = DataKey{
            id  : arg1,
            key : arg2,
        };
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<DataKey, vector<u8>>(&arg0.id, &arg0.data, v0)
    }

    fun data_remove_imp(arg0: &mut Repository, arg1: &vector<address>, arg2: &0x1::string::String) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            let v1 = DataKey{
                id  : *0x1::vector::borrow<address>(arg1, v0),
                key : *arg2,
            };
            if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<DataKey, vector<u8>>(&arg0.id, &arg0.data, v1)) {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::remove<DataKey, vector<u8>>(&mut arg0.id, &mut arg0.data, v1);
            };
            v0 = v0 + 1;
        };
    }

    fun data_type(arg0: &Repository, arg1: &mut vector<vector<u8>>, arg2: &mut vector<address>) : u8 {
        let v0 = DataKey{
            id  : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(arg1),
            key : 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(arg1)),
        };
        let v1 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<DataKey, vector<u8>>(&arg0.id, &arg0.data, v0);
        0x1::vector::push_back<vector<u8>>(arg1, *v1);
        if (0x1::option::is_some<address>(&arg0.guard)) {
            let v2 = 0x1::option::borrow<address>(&arg0.guard);
            if (!0x1::vector::contains<address>(arg2, v2)) {
                0x1::vector::push_back<address>(arg2, *v2);
            };
        };
        *0x1::vector::borrow<u8>(v1, 0)
    }

    public fun description_set(arg0: &mut Repository, arg1: 0x1::string::String, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 101, arg3);
        description_set_imp(arg0, &arg1);
    }

    fun description_set_imp(arg0: &mut Repository, arg1: &0x1::string::String) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(arg1);
        arg0.description = *arg1;
    }

    public fun description_set_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: 0x1::string::String, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 101, arg4);
        description_set_imp(arg1, &arg2);
    }

    public fun get_with_passport(arg0: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &Repository, arg2: address, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) : vector<u8> {
        if (0x1::option::is_some<address>(&arg1.guard)) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ASSERT_PASSPORT(0x1::option::borrow<address>(&arg1.guard), arg0, arg4);
        };
        let v0 = DataKey{
            id  : arg2,
            key : arg3,
        };
        *0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<DataKey, vector<u8>>(&arg1.id, &arg1.data, v0)
    }

    public fun guard_none(arg0: &mut Repository, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg1, &arg0.permission, 105, arg2);
        arg0.guard = 0x1::option::none<address>();
    }

    public fun guard_none_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 105, arg3);
        arg1.guard = 0x1::option::none<address>();
    }

    public fun guard_query(arg0: &Repository, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport) {
        let v0 = 0x2::object::id_address<Repository>(arg0);
        let (v1, v2, v3) = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 100) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &arg0.permission);
        } else if (v2 == 101) {
            let v4 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1));
            let v5 = 0x2::vec_map::contains<0x1::string::String, PolicyRule>(&arg0.policies, &v4);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v5);
        } else if (v2 == 102) {
            let v6 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1));
            if (0x2::vec_map::contains<0x1::string::String, PolicyRule>(&arg0.policies, &v6)) {
                let v7 = 0x1::option::is_some<u16>(&0x2::vec_map::get<0x1::string::String, PolicyRule>(&arg0.policies, &v6).permission_index);
                0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v7);
            } else {
                let v8 = false;
                0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v8);
            };
        } else if (v2 == 103) {
            let v9 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1));
            if (0x2::vec_map::contains<0x1::string::String, PolicyRule>(&arg0.policies, &v9)) {
                let v10 = 0x1::option::is_some<PolicyGuard>(&0x2::vec_map::get<0x1::string::String, PolicyRule>(&arg0.policies, &v9).guard);
                0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v10);
            } else {
                let v11 = false;
                0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v11);
            };
        } else if (v2 == 104) {
            let v12 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1));
            if (0x2::vec_map::contains<0x1::string::String, PolicyRule>(&arg0.policies, &v12)) {
                if (0x1::option::is_some<PolicyGuard>(&0x2::vec_map::get<0x1::string::String, PolicyRule>(&arg0.policies, &v12).guard)) {
                    let v13 = 0x1::vector::length<u8>(&0x1::option::borrow<PolicyGuard>(&0x2::vec_map::get<0x1::string::String, PolicyRule>(&arg0.policies, &v12).guard).witness_ids);
                    0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v13);
                } else {
                    let v14 = 0;
                    0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v14);
                };
            } else {
                let v15 = 0;
                0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v15);
            };
        } else if (v2 == 105) {
            let v16 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u16>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U16(), 0x1::option::borrow<u16>(&0x2::vec_map::get<0x1::string::String, PolicyRule>(&arg0.policies, &v16).permission_index));
        } else if (v2 == 106) {
            let v17 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &0x1::option::borrow<PolicyGuard>(&0x2::vec_map::get<0x1::string::String, PolicyRule>(&arg0.policies, &v17).guard).guard);
        } else if (v2 == 107) {
            let v18 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1));
            let v19 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1);
            let v20 = 0x1::vector::contains<u8>(&0x1::option::borrow<PolicyGuard>(&0x2::vec_map::get<0x1::string::String, PolicyRule>(&arg0.policies, &v18).guard).witness_ids, &v19);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v20);
        } else if (v2 == 108) {
            let v21 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u8>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U8(), &0x2::vec_map::get<0x1::string::String, PolicyRule>(&arg0.policies, &v21).value_type);
        } else if (v2 == 109) {
            let v22 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), &0x2::vec_map::get<0x1::string::String, PolicyRule>(&arg0.policies, &v22).description);
        } else if (v2 == 110) {
            let v23 = data_contains_value(arg0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1), 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1)));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v23);
        } else if (v2 == 111) {
            let v24 = 0x1::option::is_some<address>(&arg0.guard);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v24);
        } else if (v2 == 112) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&arg0.guard));
        } else if (v2 == 113) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u8>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U8(), &arg0.type);
        } else if (v2 == 114) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u8>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U8(), &arg0.policy_mode);
        } else if (v2 == 115) {
            let v25 = 0x1::vector::length<address>(&arg0.reference);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v25);
        } else if (v2 == 116) {
            let v26 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1);
            let v27 = 0x1::vector::contains<address>(&arg0.reference, &v26);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v27);
        } else if (v2 == 117) {
            let v28 = data_type(arg0, v1, v3);
            let v29 = if (v28 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U8()) {
                true
            } else if (v28 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL()) {
                true
            } else if (v28 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64()) {
                true
            } else if (v28 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U128()) {
                true
            } else {
                v28 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U256()
            };
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::TYPE(v29);
        } else if (v2 == 118) {
            let v30 = data_type(arg0, v1, v3);
            let v31 = v30 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING() || v30 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U8();
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::TYPE(v31);
        } else if (v2 == 119) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::TYPE(data_type(arg0, v1, v3) == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS());
        } else if (v2 == 120) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::TYPE(data_type(arg0, v1, v3) == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL());
        } else if (v2 == 121) {
            let v32 = data_type(arg0, v1, v3);
            let v33 = if (v32 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U8()) {
                true
            } else if (v32 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_BOOL()) {
                true
            } else if (v32 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U64()) {
                true
            } else if (v32 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U128()) {
                true
            } else {
                v32 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U256()
            };
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::TYPE(v33);
        } else if (v2 == 122) {
            let v34 = data_type(arg0, v1, v3);
            let v35 = v34 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_STRING() || v34 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_VEC_U8();
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::TYPE(v35);
        } else if (v2 == 123) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::TYPE(data_type(arg0, v1, v3) == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_ADDRESS());
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::Q_CMD_NOT_MATCH();
        };
    }

    public fun guard_set(arg0: &mut Repository, arg1: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 105, arg3);
        arg0.guard = 0x1::option::some<address>(0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg1));
    }

    public fun guard_set_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 105, arg4);
        arg1.guard = 0x1::option::some<address>(0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg2));
    }

    public fun mode_set(arg0: &mut Repository, arg1: u8, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 102, arg3);
        mode_set_imp(arg0, arg1);
    }

    fun mode_set_imp(arg0: &mut Repository, arg1: u8) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::MODE(arg1);
        arg0.policy_mode = arg1;
    }

    public fun mode_set_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: u8, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 102, arg4);
        mode_set_imp(arg1, arg2);
    }

    fun new_imp(arg0: &0x1::string::String, arg1: u8, arg2: &address, arg3: &mut 0x2::tx_context::TxContext) : Repository {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::MODE(arg1);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(arg0);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_address(&v0);
        Repository{
            id          : v0,
            description : *arg0,
            policies    : 0x2::vec_map::empty<0x1::string::String, PolicyRule>(),
            data        : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::new<DataKey, vector<u8>>(&v1),
            permission  : *arg2,
            type        : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::TYPE_NORMAL(),
            policy_mode : arg1,
            guard       : 0x1::option::none<address>(),
            reference   : 0x1::vector::empty<address>(),
        }
    }

    public fun new_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: 0x1::string::String, arg2: u8, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) : Repository {
        let v0 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission>(arg3);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &v0, 100, arg4);
        new_imp(&arg1, arg2, &v0, arg4)
    }

    public fun permission_set(arg0: &mut Repository, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_CREATOR(arg1, arg3);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_ADMIN(arg2, arg3);
        arg0.permission = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission>(arg2);
    }

    public fun policy_add(arg0: &mut Repository, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::option::Option<u16>, arg4: u8, arg5: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg6: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg5, &arg0.permission, 103, arg6);
        let v0 = 0x1::option::none<PolicyGuard>();
        policy_add_imp(arg0, &arg1, &arg2, arg3, &v0, arg4);
    }

    public fun policy_add2(arg0: &mut Repository, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::option::Option<u16>, arg4: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg5: vector<u8>, arg6: u8, arg7: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg8: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg7, &arg0.permission, 103, arg8);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::POLICY_WITNESS_COUNT(0x1::vector::length<u8>(&arg5));
        let v0 = PolicyGuard{
            guard       : 0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg4),
            witness_ids : arg5,
        };
        let v1 = 0x1::option::some<PolicyGuard>(v0);
        policy_add_imp(arg0, &arg1, &arg2, arg3, &v1, arg6);
    }

    public fun policy_add2_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<u16>, arg5: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg6: vector<u8>, arg7: u8, arg8: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg9: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg8, &arg1.permission, 103, arg9);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::POLICY_WITNESS_COUNT(0x1::vector::length<u8>(&arg6));
        let v0 = PolicyGuard{
            guard       : 0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg5),
            witness_ids : arg6,
        };
        let v1 = 0x1::option::some<PolicyGuard>(v0);
        policy_add_imp(arg1, &arg2, &arg3, arg4, &v1, arg7);
    }

    public(friend) fun policy_add_imp(arg0: &mut Repository, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: 0x1::option::Option<u16>, arg4: &0x1::option::Option<PolicyGuard>, arg5: u8) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::POLICY_TYPE(arg5);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_REPOSITORY_POLICY(arg1, arg2);
        if (0x2::vec_map::contains<0x1::string::String, PolicyRule>(&arg0.policies, arg1)) {
            let v0 = PolicyRule{
                description      : *arg2,
                permission_index : arg3,
                guard            : *arg4,
                value_type       : arg5,
            };
            *0x2::vec_map::get_mut<0x1::string::String, PolicyRule>(&mut arg0.policies, arg1) = v0;
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository::POLICY_COUNT(0x2::vec_map::size<0x1::string::String, PolicyRule>(&arg0.policies));
            let v1 = PolicyRule{
                description      : *arg2,
                permission_index : arg3,
                guard            : *arg4,
                value_type       : arg5,
            };
            0x2::vec_map::insert<0x1::string::String, PolicyRule>(&mut arg0.policies, *arg1, v1);
        };
    }

    public fun policy_add_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<u16>, arg5: u8, arg6: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg7: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg6, &arg1.permission, 103, arg7);
        let v0 = 0x1::option::none<PolicyGuard>();
        policy_add_imp(arg1, &arg2, &arg3, arg4, &v0, arg5);
    }

    public fun policy_description_set(arg0: &mut Repository, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg3, &arg0.permission, 103, arg4);
        policy_description_set_imp(arg0, &arg1, &arg2);
    }

    fun policy_description_set_imp(arg0: &mut Repository, arg1: &0x1::string::String, arg2: &0x1::string::String) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(arg2);
        if (0x2::vec_map::contains<0x1::string::String, PolicyRule>(&arg0.policies, arg1)) {
            0x2::vec_map::get_mut<0x1::string::String, PolicyRule>(&mut arg0.policies, arg1).description = *arg2;
        };
    }

    public fun policy_description_set_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, &arg1.permission, 103, arg5);
        policy_description_set_imp(arg1, &arg2, &arg3);
    }

    public fun policy_permission_set(arg0: &mut Repository, arg1: 0x1::string::String, arg2: 0x1::option::Option<u16>, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg3, &arg0.permission, 103, arg4);
        policy_permission_set_imp(arg0, &arg1, arg2);
    }

    fun policy_permission_set_imp(arg0: &mut Repository, arg1: &0x1::string::String, arg2: 0x1::option::Option<u16>) {
        if (0x2::vec_map::contains<0x1::string::String, PolicyRule>(&arg0.policies, arg1)) {
            0x2::vec_map::get_mut<0x1::string::String, PolicyRule>(&mut arg0.policies, arg1).permission_index = arg2;
        };
    }

    public fun policy_permission_set_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: 0x1::string::String, arg3: 0x1::option::Option<u16>, arg4: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, &arg1.permission, 103, arg5);
        policy_permission_set_imp(arg1, &arg2, arg3);
    }

    public fun policy_remove(arg0: &mut Repository, arg1: vector<0x1::string::String>, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 103, arg3);
        policy_remove_imp(arg0, &arg1);
    }

    fun policy_remove_imp(arg0: &mut Repository, arg1: &vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg1)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(arg1, v0);
            if (0x2::vec_map::contains<0x1::string::String, PolicyRule>(&arg0.policies, v1)) {
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, PolicyRule>(&mut arg0.policies, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun policy_remove_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: vector<0x1::string::String>, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 103, arg4);
        policy_remove_imp(arg1, &arg2);
    }

    public fun policy_removeall(arg0: &mut Repository, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg1, &arg0.permission, 103, arg2);
        policy_removeall_imp(arg0);
    }

    fun policy_removeall_imp(arg0: &mut Repository) {
        arg0.policies = 0x2::vec_map::empty<0x1::string::String, PolicyRule>();
    }

    public fun policy_removeall_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 103, arg3);
        policy_removeall_imp(arg1);
    }

    public fun policy_rename(arg0: &mut Repository, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg3, &arg0.permission, 103, arg4);
        policy_rename_imp(arg0, &arg1, &arg2);
    }

    fun policy_rename_imp(arg0: &mut Repository, arg1: &0x1::string::String, arg2: &0x1::string::String) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_NAMELEN(arg2);
        if (0x2::vec_map::contains<0x1::string::String, PolicyRule>(&arg0.policies, arg1) && !0x2::vec_map::contains<0x1::string::String, PolicyRule>(&arg0.policies, arg2)) {
            let (_, v1) = 0x2::vec_map::remove<0x1::string::String, PolicyRule>(&mut arg0.policies, arg1);
            0x2::vec_map::insert<0x1::string::String, PolicyRule>(&mut arg0.policies, *arg2, v1);
        };
    }

    public fun policy_rename_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, &arg1.permission, 103, arg5);
        policy_rename_imp(arg1, &arg2, &arg3);
    }

    public fun reference_add(arg0: &mut Repository, arg1: vector<address>, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 104, arg3);
        reference_add_imp(arg0, &arg1);
    }

    public(friend) fun reference_add_f(arg0: &mut Repository, arg1: &address) {
        if (!0x1::vector::contains<address>(&arg0.reference, arg1)) {
            0x1::vector::push_back<address>(&mut arg0.reference, *arg1);
        };
    }

    fun reference_add_imp(arg0: &mut Repository, arg1: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            reference_add_f(arg0, 0x1::vector::borrow<address>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun reference_add_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: vector<address>, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 104, arg4);
        reference_add_imp(arg1, &arg2);
    }

    public fun reference_remove(arg0: &mut Repository, arg1: vector<address>, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg2, &arg0.permission, 104, arg3);
        reference_remove_imp(arg0, &arg1);
    }

    public(friend) fun reference_remove_f(arg0: &mut Repository, arg1: &address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.reference, arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.reference, v1);
        };
    }

    fun reference_remove_imp(arg0: &mut Repository, arg1: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            reference_remove_f(arg0, 0x1::vector::borrow<address>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun reference_remove_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: vector<address>, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 104, arg4);
        reference_remove_imp(arg1, &arg2);
    }

    public fun reference_removeall(arg0: &mut Repository, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT(arg1, &arg0.permission, 104, arg2);
        reference_removeall_imp(arg0);
    }

    fun reference_removeall_imp(arg0: &mut Repository) {
        arg0.reference = 0x1::vector::empty<address>();
    }

    public fun reference_removeall_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 104, arg3);
        reference_removeall_imp(arg1);
    }

    public fun remove_with_passport(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: &mut Repository, arg2: vector<address>, arg3: 0x1::string::String, arg4: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        let (_, _) = ASSERT_ACTOR_WITH_PASSPORT(false, &v0, arg0, arg1, &arg3, arg4, arg5);
        data_remove_imp(arg1, &arg2, &arg3);
    }

    public(friend) fun wowok(arg0: &0x1::string::String, arg1: u8, arg2: u8, arg3: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) : Repository {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_address(&v0);
        Repository{
            id          : v0,
            description : *arg0,
            policies    : 0x2::vec_map::empty<0x1::string::String, PolicyRule>(),
            data        : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::new<DataKey, vector<u8>>(&v1),
            permission  : 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::permission::Permission>(arg3),
            type        : arg1,
            policy_mode : arg2,
            guard       : 0x1::option::none<address>(),
            reference   : 0x1::vector::empty<address>(),
        }
    }

    public(friend) fun wowok_create(arg0: Repository) {
        0x2::transfer::share_object<Repository>(arg0);
    }

    // decompiled from Move bytecode v6
}

