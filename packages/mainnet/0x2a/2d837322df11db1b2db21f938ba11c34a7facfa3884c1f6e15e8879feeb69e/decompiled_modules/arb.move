module 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::arb {
    struct Arb<phantom T0> has key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        order: address,
        arbitration: address,
        voted: 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::Table<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted>,
        proposition: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        fee: 0x2::balance::Balance<T0>,
        bWithdrawed: bool,
        feedback: 0x1::string::String,
        indemnity: 0x1::option::Option<u64>,
        time: u64,
    }

    public(friend) fun new<T0>(arg0: &address, arg1: &address, arg2: &0x1::string::String, arg3: &vector<0x1::string::String>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Arb<T0> {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(arg2);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::PROPOSITION_COUNT(0x1::vector::length<0x1::string::String>(arg3));
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(arg3)) {
            let v2 = 0x1::vector::borrow<0x1::string::String>(arg3, v1);
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_NAMELEN_ANDNOT_EMPTY(v2);
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, *v2, 0);
            v1 = v1 + 1;
        };
        let v3 = 0x2::object::new(arg6);
        let v4 = 0x2::object::uid_to_address(&v3);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::NewArbEvent_emit(&v4, arg0, arg1);
        Arb<T0>{
            id          : v3,
            description : *arg2,
            order       : *arg1,
            arbitration : *arg0,
            voted       : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::new<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted>(&v4),
            proposition : v0,
            fee         : 0x2::coin::into_balance<T0>(arg4),
            bWithdrawed : false,
            feedback    : 0x1::string::utf8(b""),
            indemnity   : 0x1::option::none<u64>(),
            time        : 0x2::clock::timestamp_ms(arg5),
        }
    }

    public(friend) fun arbitration<T0>(arg0: &mut Arb<T0>, arg1: &0x1::string::String, arg2: 0x1::option::Option<u64>) {
        arg0.feedback = *arg1;
        arg0.indemnity = arg2;
    }

    public fun arbitration_address<T0>(arg0: &Arb<T0>) : &address {
        &arg0.arbitration
    }

    public fun create<T0>(arg0: Arb<T0>) : address {
        0x2::transfer::share_object<Arb<T0>>(arg0);
        0x2::object::id_address<Arb<T0>>(&arg0)
    }

    public fun guard_query<T0>(arg0: &Arb<T0>, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport) {
        let v0 = 0x2::object::id_address<Arb<T0>>(arg0);
        let (v1, v2, _) = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 1600) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &arg0.order);
        } else if (v2 == 1601) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &arg0.arbitration);
        } else if (v2 == 1602) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), &arg0.feedback);
        } else if (v2 == 1603) {
            let v4 = 0x1::option::is_some<u64>(&arg0.indemnity);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v4);
        } else if (v2 == 1604) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), 0x1::option::borrow<u64>(&arg0.indemnity));
        } else if (v2 == 1605) {
            let v5 = 0x2::balance::value<T0>(&arg0.fee);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v5);
        } else if (v2 == 1606) {
            let v6 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::length<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted>(&arg0.voted);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v6);
        } else if (v2 == 1607) {
            let v7 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted>(&arg0.id, &arg0.voted, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v7);
        } else if (v2 == 1608) {
            let v8 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted_weight(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted>(&arg0.id, &arg0.voted, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1)));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v8);
        } else if (v2 == 1609) {
            let v9 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted_time(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted>(&arg0.id, &arg0.voted, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1)));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v9);
        } else if (v2 == 1610) {
            let v10 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1);
            let v11 = 0x1::vector::contains<u8>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted_agrees(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted>(&arg0.id, &arg0.voted, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1))), &v10);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v11);
        } else if (v2 == 1611) {
            let v12 = 0x1::vector::length<u8>(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted_agrees(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted>(&arg0.id, &arg0.voted, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1))));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v12);
        } else if (v2 == 1612) {
            let v13 = 0x2::vec_map::size<0x1::string::String, u64>(&arg0.proposition);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v13);
        } else if (v2 == 1613) {
            let (_, v15) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, u64>(&arg0.proposition, (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U8(v1) as u64));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), v15);
        } else if (v2 == 1614) {
            let v16 = 0x1::type_name::get<T0>();
            let v17 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v16));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), &v17);
        } else if (v2 == 1615) {
            let v18 = 0x1::type_name::get_with_original_ids<T0>();
            let v19 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v18));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), &v19);
        } else if (v2 == 1616) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &arg0.time);
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::Q_CMD_NOT_MATCH();
        };
    }

    public fun indemnity<T0>(arg0: &Arb<T0>) : &0x1::option::Option<u64> {
        &arg0.indemnity
    }

    public fun order<T0>(arg0: &Arb<T0>) : &address {
        &arg0.order
    }

    public fun query_voted<T0>(arg0: &Arb<T0>, arg1: address) : vector<u8> {
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted>(&arg0.id, &arg0.voted, arg1)) {
            return *0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted_agrees(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted>(&arg0.id, &arg0.voted, arg1))
        };
        0x1::vector::empty<u8>()
    }

    public(friend) fun vote<T0>(arg0: &mut Arb<T0>, arg1: &address, arg2: &vector<u8>, arg3: u64, arg4: &0x2::clock::Clock) {
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted>(&arg0.id, &arg0.voted, *arg1)) {
            let v0 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted>(&mut arg0.id, &mut arg0.voted, *arg1);
            let v1 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted_agrees(v0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<u8>(v1)) {
                let (_, v4) = 0x2::vec_map::get_entry_by_idx_mut<0x1::string::String, u64>(&mut arg0.proposition, (*0x1::vector::borrow<u8>(v1, v2) as u64));
                *v4 = *v4 - 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted_weight(v0);
                v2 = v2 + 1;
            };
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted_update(v0, arg2, 0x2::clock::timestamp_ms(arg4), arg3);
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::add<address, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted>(&mut arg0.id, &mut arg0.voted, *arg1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::Voted_new(arg2, arg3, 0x2::clock::timestamp_ms(arg4)));
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(arg2)) {
            let (_, v7) = 0x2::vec_map::get_entry_by_idx_mut<0x1::string::String, u64>(&mut arg0.proposition, (*0x1::vector::borrow<u8>(arg2, v5) as u64));
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_U64_ADD_UPFLOW(*v7, arg3);
            *v7 = *v7 + arg3;
            v5 = v5 + 1;
        };
    }

    public(friend) fun withdraw<T0>(arg0: &mut Arb<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::PENDING(0x1::option::is_some<u64>(&arg0.indemnity));
        arg0.bWithdrawed = true;
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.fee), arg1)
    }

    public fun witness<T0, T1>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: &Arb<T0>, arg5: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::order::Order<T1>) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::arb::ARB_ORDER_NOT_MATCH(arg4.order == 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::order::Order<T1>>(arg5));
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        while (v0 < 0x1::vector::length<u8>(&arg3)) {
            let v2 = 0x1::vector::borrow<u8>(&arg3, v0);
            if (*v2 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_ARB_ARBITRATION()) {
                0x1::vector::push_back<address>(&mut v1, arg4.arbitration);
            } else if (*v2 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_ARB_ORDER()) {
                0x1::vector::push_back<address>(&mut v1, arg4.order);
            } else if (*v2 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_ARB_MACHINE()) {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::OBJECT_INVALID_WITH_TYPE(0x1::option::is_some<address>(0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::order::machine<T1>(arg5)));
                0x1::vector::push_back<address>(&mut v1, *0x1::option::borrow<address>(0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::order::machine<T1>(arg5)));
            } else if (*v2 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_ARB_PROGRESS()) {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::OBJECT_INVALID_WITH_TYPE(0x1::option::is_some<address>(0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::order::progress<T1>(arg5)));
                0x1::vector::push_back<address>(&mut v1, *0x1::option::borrow<address>(0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::order::progress<T1>(arg5)));
            } else if (*v2 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_ARB_SERVICE()) {
                0x1::vector::push_back<address>(&mut v1, *0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::order::service<T1>(arg5));
            } else {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::WITNESS_TYPE_INVALID();
            };
            v0 = v0 + 1;
        };
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::witness_add(arg0, arg1, &arg2, &arg3, &v1);
    }

    // decompiled from Move bytecode v6
}

