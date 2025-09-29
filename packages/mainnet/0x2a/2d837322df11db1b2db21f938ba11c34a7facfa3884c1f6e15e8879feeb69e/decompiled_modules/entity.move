module 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::entity {
    struct Entity has key {
        id: 0x2::object::UID,
        table: 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::Table<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>,
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = Entity{
            id    : v0,
            table : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::new<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&v1),
        };
        0x2::transfer::share_object<Entity>(v2);
        v1
    }

    fun create_imp(arg0: &mut Entity, arg1: &address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource, address) {
        let v0 = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::new(arg3);
        let v1 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource>(&v0);
        let v2 = 0x1::option::some<address>(v1);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::add<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, *arg1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_new1(&v2, arg2));
        let v3 = 0x1::option::some<address>(v1);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::NewEntityEvent_emit(&v3, arg1);
        (v0, v1)
    }

    public fun description_set(arg0: &mut Entity, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(&arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, v0)) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_description_set(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, v0), &arg1);
        } else {
            let v1 = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::new(arg3);
            let v2 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource>(&v1);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::create(v1, arg3);
            let v3 = 0x1::option::some<address>(v2);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::add<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, v0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_new2(&v3, &arg1, arg2));
            let v4 = 0x1::option::some<address>(v2);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::NewEntityEvent_emit(&v4, &v0);
        };
    }

    public fun dislike(arg0: &mut Entity, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource, arg2: address, arg3: &0x2::clock::Clock) : u32 {
        let v0 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::ENTITY_Dislike());
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, arg2)) {
            return 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_dislike_set(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, arg2), 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::switch(arg1, &arg2, &v0))
        };
        if (0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::switch(arg1, &arg2, &v0)) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::add<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, arg2, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_new3(0, 1, arg3));
            let v1 = 0x1::option::none<address>();
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::NewEntityEvent_emit(&v1, &arg2);
        };
        1
    }

    public fun guard_query(arg0: &Entity, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport) {
        let v0 = 0x2::object::id_address<Entity>(arg0);
        let (v1, v2, _) = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 200) {
            let v4 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v4);
        } else if (v2 == 201) {
            let v5 = (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_like(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1))) as u64);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v5);
        } else if (v2 == 202) {
            let v6 = (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_dislike(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1))) as u64);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v6);
        } else if (v2 == 203) {
            let v7 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_size(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1)));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v7);
        } else if (v2 == 204) {
            let v8 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_resource(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1)));
            let v9 = 0x1::option::is_some<address>(&v8);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v9);
        } else if (v2 == 205) {
            let v10 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_resource(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1)));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&v10));
        } else if (v2 == 206) {
            let v11 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1);
            let v12 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1));
            let v13 = info_get(arg0, &v11, &v12);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), &v13);
        } else if (v2 == 207) {
            let v14 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_time(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1)));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v14);
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::Q_CMD_NOT_MATCH();
        };
    }

    public fun info_add(arg0: &mut Entity, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::KEY_VALUE_LENGTH_NOT_MATCH(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2));
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, v0)) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_info_set(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, v0), &arg1, &arg2);
        } else {
            let v1 = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::new(arg4);
            let v2 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource>(&v1);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::create(v1, arg4);
            let v3 = 0x1::option::some<address>(v2);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::add<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, v0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_new4(&v3, &arg1, &arg2, arg3));
            let v4 = 0x1::option::some<address>(v2);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::NewEntityEvent_emit(&v4, &v0);
        };
    }

    fun info_get(arg0: &Entity, arg1: &address, arg2: &0x1::string::String) : 0x1::string::String {
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, *arg1)) {
            return 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_info_get(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, *arg1), arg2)
        };
        0x1::string::utf8(b"")
    }

    public fun info_remove(arg0: &mut Entity, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, v0)) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_info_remove(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, v0), &arg1);
        };
    }

    public fun info_removeall(arg0: &mut Entity, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, v0)) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_info_removeall(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, v0));
        };
    }

    public fun like(arg0: &mut Entity, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource, arg2: address, arg3: &0x2::clock::Clock) : u32 {
        let v0 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::ENTITY_Like());
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, arg2)) {
            return 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_like_set(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, arg2), 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::switch(arg1, &arg2, &v0))
        };
        if (0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::switch(arg1, &arg2, &v0)) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::add<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, arg2, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_new3(1, 0, arg3));
            let v1 = 0x1::option::none<address>();
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::NewEntityEvent_emit(&v1, &arg2);
        };
        1
    }

    public fun resource_create(arg0: &mut Entity, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, v0)) {
            let v1 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, v0);
            let v2 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_resource(v1);
            if (0x1::option::is_some<address>(&v2)) {
                return *0x1::option::borrow<address>(&v2)
            };
            let v3 = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::new(arg2);
            let v4 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource>(&v3);
            let v5 = 0x1::option::some<address>(v4);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_resource_set(v1, &v5);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::create(v3, arg2);
            return v4
        };
        let (v6, v7) = create_imp(arg0, &v0, arg1, arg2);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::create(v6, arg2);
        v7
    }

    public fun resource_create2(arg0: &mut Entity, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, v0)) {
            let v1 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, v0);
            let v2 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_resource(v1);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::RESOURCE_EXISTED(&v2);
            let v3 = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::new(arg2);
            let v4 = 0x1::option::some<address>(0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource>(&v3));
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_resource_set(v1, &v4);
            return v3
        };
        let (v5, _) = create_imp(arg0, &v0, arg1, arg2);
        v5
    }

    public fun resource_destroy(arg0: &mut Entity, arg1: 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, v0)) {
            let v1 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource>(&arg1);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_resource_clear(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, v0), &v1);
        };
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::destroy(arg1);
    }

    public fun resource_transfer(arg0: &mut Entity, arg1: 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, v0)) {
            let v1 = 0x1::option::none<address>();
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_resource_set(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, v0), &v1);
        };
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::transfer(arg1, arg2);
    }

    public fun resource_use(arg0: &mut Entity, arg1: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource::Resource>(arg1);
        if (!0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&arg0.id, &arg0.table, v0)) {
            let v2 = 0x1::option::some<address>(v1);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::add<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, v0, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_new1(&v2, arg2));
            let v3 = 0x1::option::some<address>(v1);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::NewEntityEvent_emit(&v3, &v0);
        } else {
            let v4 = 0x1::option::some<address>(v1);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent_resource_set(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::entity::Ent>(&mut arg0.id, &mut arg0.table, v0), &v4);
        };
    }

    // decompiled from Move bytecode v6
}

