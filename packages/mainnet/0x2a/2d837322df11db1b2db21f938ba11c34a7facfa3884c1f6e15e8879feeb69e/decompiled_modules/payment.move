module 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment {
    struct Record has copy, drop, store {
        recipient: address,
        amount: u64,
    }

    struct Payment<phantom T0> has key {
        id: 0x2::object::UID,
        record: vector<Record>,
        for_guard: 0x1::option::Option<address>,
        for_object: 0x1::option::Option<address>,
        index: u64,
        amount: u128,
        signer: address,
        remark: 0x1::string::String,
        time: u64,
        from: 0x1::option::Option<address>,
    }

    struct CoinWrapper<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<T0>,
        payment: address,
    }

    public fun amount<T0>(arg0: &Payment<T0>, arg1: &address) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<Record>(&arg0.record)) {
            let v2 = 0x1::vector::borrow<Record>(&arg0.record, v0);
            if (v2.recipient == *arg1) {
                v1 = v1 + (v2.amount as u128);
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun create<T0>(arg0: vector<address>, arg1: vector<0x2::coin::Coin<T0>>, arg2: 0x1::option::Option<address>, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : address {
        let v0 = &mut arg1;
        let v1 = 0x1::option::none<address>();
        let v2 = 0x1::option::none<address>();
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
        create_imp<T0>(&arg0, v0, &arg2, &v1, arg3, &arg4, &v2, arg5, arg6)
    }

    public(friend) fun create2<T0>(arg0: &address, arg1: 0x2::coin::Coin<T0>, arg2: &0x1::option::Option<address>, arg3: &0x1::option::Option<address>, arg4: u64, arg5: &0x1::string::String, arg6: &0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : address {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(arg5);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = Record{
            recipient : *arg0,
            amount    : v0,
        };
        let v2 = 0x2::object::new(arg8);
        let v3 = 0x2::object::uid_to_address(&v2);
        let v4 = CoinWrapper<T0>{
            id      : 0x2::object::new(arg8),
            coin    : arg1,
            payment : v3,
        };
        0x2::transfer::public_transfer<CoinWrapper<T0>>(v4, *arg0);
        let v5 = Payment<T0>{
            id         : v2,
            record     : 0x1::vector::singleton<Record>(v1),
            for_guard  : *arg3,
            for_object : *arg2,
            index      : arg4,
            amount     : (v0 as u128),
            signer     : 0x2::tx_context::sender(arg8),
            remark     : *arg5,
            time       : 0x2::clock::timestamp_ms(arg7),
            from       : *arg6,
        };
        0x2::transfer::freeze_object<Payment<T0>>(v5);
        v3
    }

    public(friend) fun create_fromObject<T0>(arg0: &vector<address>, arg1: &mut vector<0x2::coin::Coin<T0>>, arg2: &0x1::option::Option<address>, arg3: &0x1::option::Option<address>, arg4: u64, arg5: &0x1::string::String, arg6: &0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : address {
        create_imp<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun create_fromObject2<T0>(arg0: &address, arg1: u64, arg2: &0x1::option::Option<address>, arg3: &0x1::option::Option<address>, arg4: u64, arg5: &0x1::string::String, arg6: &0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : address {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(arg5);
        let v0 = 0x2::object::new(arg8);
        let v1 = Record{
            recipient : *arg0,
            amount    : arg1,
        };
        let v2 = Payment<T0>{
            id         : v0,
            record     : 0x1::vector::singleton<Record>(v1),
            for_guard  : *arg3,
            for_object : *arg2,
            index      : arg4,
            amount     : (arg1 as u128),
            signer     : 0x2::tx_context::sender(arg8),
            remark     : *arg5,
            time       : 0x2::clock::timestamp_ms(arg7),
            from       : *arg6,
        };
        0x2::transfer::freeze_object<Payment<T0>>(v2);
        0x2::object::uid_to_address(&v0)
    }

    fun create_imp<T0>(arg0: &vector<address>, arg1: &mut vector<0x2::coin::Coin<T0>>, arg2: &0x1::option::Option<address>, arg3: &0x1::option::Option<address>, arg4: u64, arg5: &0x1::string::String, arg6: &0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : address {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DESCRIPTIONLEN(arg5);
        let v0 = 0x1::vector::length<address>(arg0);
        let v1 = 0x1::vector::length<address>(arg0);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::payment::REC_COUNT(v0);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::payment::COUNTS_NOT_MATCH(v0 == 0x1::vector::length<0x2::coin::Coin<T0>>(arg1));
        let v2 = 0;
        let v3 = 0x1::vector::empty<Record>();
        let v4 = 0x2::object::new(arg8);
        let v5 = 0x2::object::uid_to_address(&v4);
        while (v1 > 0) {
            let v6 = 0x1::vector::borrow<address>(arg0, v1 - 1);
            let v7 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(arg1);
            v2 = v2 + (0x2::coin::value<T0>(&v7) as u128);
            let v8 = Record{
                recipient : *v6,
                amount    : 0x2::coin::value<T0>(&v7),
            };
            0x1::vector::push_back<Record>(&mut v3, v8);
            let v9 = CoinWrapper<T0>{
                id      : 0x2::object::new(arg8),
                coin    : v7,
                payment : v5,
            };
            0x2::transfer::public_transfer<CoinWrapper<T0>>(v9, *v6);
            v1 = v1 - 1;
        };
        let v10 = Payment<T0>{
            id         : v4,
            record     : v3,
            for_guard  : *arg3,
            for_object : *arg2,
            index      : arg4,
            amount     : v2,
            signer     : 0x2::tx_context::sender(arg8),
            remark     : *arg5,
            time       : 0x2::clock::timestamp_ms(arg7),
            from       : *arg6,
        };
        0x2::transfer::freeze_object<Payment<T0>>(v10);
        v5
    }

    public fun create_withGuard<T0>(arg0: vector<address>, arg1: vector<0x2::coin::Coin<T0>>, arg2: 0x1::option::Option<address>, arg3: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : address {
        let v0 = &mut arg1;
        let v1 = 0x1::option::some<address>(0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg3));
        let v2 = 0x1::option::none<address>();
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
        create_imp<T0>(&arg0, v0, &arg2, &v1, arg4, &arg5, &v2, arg6, arg7)
    }

    public fun guard_query<T0>(arg0: &Payment<T0>, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport) {
        let v0 = 0x2::object::id_address<Payment<T0>>(arg0);
        let (v1, v2, _) = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 1200) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &arg0.signer);
        } else if (v2 == 1201) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u128>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U128(), &arg0.amount);
        } else if (v2 == 1202) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), &arg0.remark);
        } else if (v2 == 1203) {
            let v4 = 0x1::option::is_some<address>(&arg0.for_guard);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v4);
        } else if (v2 == 1204) {
            let v5 = 0x1::option::is_some<address>(&arg0.for_object);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v5);
        } else if (v2 == 1205) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&arg0.for_guard));
        } else if (v2 == 1206) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&arg0.for_object));
        } else if (v2 == 1207) {
            let v6 = 0x1::vector::length<Record>(&arg0.record);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v6);
        } else if (v2 == 1208) {
            let v7 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1);
            let v8 = recipient<T0>(arg0, &v7);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v8);
        } else if (v2 == 1209) {
            let v9 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1);
            let v10 = amount<T0>(arg0, &v9);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u128>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U128(), &v10);
        } else if (v2 == 1210) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &arg0.time);
        } else if (v2 == 1211) {
            let v11 = 0x1::option::is_some<address>(&arg0.from);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v11);
        } else if (v2 == 1212) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&arg0.from));
        } else if (v2 == 1213) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &arg0.index);
        } else if (v2 == 1214) {
            let v12 = false;
            if (0x1::option::is_some<address>(&arg0.for_object) && 0x1::option::is_some<address>(&arg0.for_guard)) {
                let v13 = if (*0x1::option::borrow<address>(&arg0.for_object) == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1)) {
                    if (*0x1::option::borrow<address>(&arg0.for_guard) == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1)) {
                        arg0.index == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U64(v1)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v13) {
                    v12 = true;
                };
            };
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v12);
        } else if (v2 == 1215) {
            let v14 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1);
            let v15 = 0;
            if (0x1::option::is_some<address>(&arg0.for_object) && 0x1::option::is_some<address>(&arg0.for_guard)) {
                let v16 = if (*0x1::option::borrow<address>(&arg0.for_object) == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1)) {
                    if (*0x1::option::borrow<address>(&arg0.for_guard) == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1)) {
                        arg0.index == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_U64(v1)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v16) {
                    v15 = amount<T0>(arg0, &v14);
                };
            };
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u128>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U128(), &v15);
        } else if (v2 == 1216) {
            let v17 = 0x1::type_name::get<T0>();
            let v18 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v17));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), &v18);
        } else if (v2 == 1217) {
            let v19 = 0x1::type_name::get_with_original_ids<T0>();
            let v20 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v19));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), &v20);
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::Q_CMD_NOT_MATCH();
        };
    }

    public fun payment_signer<T0>(arg0: &Payment<T0>) : &address {
        &arg0.signer
    }

    public fun recipient<T0>(arg0: &Payment<T0>, arg1: &address) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Record>(&arg0.record)) {
            if (0x1::vector::borrow<Record>(&arg0.record, v1).recipient == *arg1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun unwrap<T0>(arg0: CoinWrapper<T0>) : (0x2::coin::Coin<T0>, address) {
        let CoinWrapper {
            id      : v0,
            coin    : v1,
            payment : v2,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2)
    }

    public fun unwrap_assert<T0>(arg0: CoinWrapper<T0>, arg1: &Payment<T0>) : 0x2::coin::Coin<T0> {
        let CoinWrapper {
            id      : v0,
            coin    : v1,
            payment : v2,
        } = arg0;
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::payment::NOT_MATCH(v2 == 0x2::object::id_address<Payment<T0>>(arg1));
        0x2::object::delete(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

