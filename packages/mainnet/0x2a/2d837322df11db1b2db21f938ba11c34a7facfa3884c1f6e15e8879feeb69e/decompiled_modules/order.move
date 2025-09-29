module 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::order {
    struct Discount has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        type: u8,
        price_greater: 0x1::option::Option<u64>,
        off: u64,
        time_start: u64,
        time_end: u64,
        service: address,
    }

    struct Order<phantom T0> has key {
        id: 0x2::object::UID,
        items: vector<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::Item>,
        required_info: 0x1::option::Option<RequiredInfo>,
        discount: 0x1::option::Option<address>,
        progress: 0x1::option::Option<address>,
        machine: 0x1::option::Option<address>,
        amount: u64,
        payed: 0x2::balance::Balance<T0>,
        payer: address,
        service: address,
        dispute: vector<address>,
        agent: vector<address>,
        time: u64,
    }

    struct RequiredInfo has copy, drop, store {
        customer_pub: 0x1::string::String,
        info: 0x1::string::String,
    }

    public(friend) fun order<T0>(arg0: &address, arg1: 0x2::coin::Coin<T0>, arg2: &vector<0x1::string::String>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<0x1::option::Option<0x1::string::String>>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Order<T0> {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::ORD_COIN(0x2::coin::value<T0>(&arg1) >= arg6);
        let v0 = 0x2::tx_context::sender(arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v1 = Order<T0>{
            id            : 0x2::object::new(arg8),
            items         : 0x1::vector::empty<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::Item>(),
            required_info : 0x1::option::none<RequiredInfo>(),
            discount      : 0x1::option::none<address>(),
            progress      : 0x1::option::none<address>(),
            machine       : 0x1::option::none<address>(),
            amount        : arg6,
            payed         : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg6, arg8)),
            payer         : v0,
            service       : *arg0,
            dispute       : 0x1::vector::empty<address>(),
            agent         : 0x1::vector::empty<address>(),
            time          : 0x2::clock::timestamp_ms(arg7),
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(arg2)) {
            0x1::vector::push_back<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::Item>(&mut v1.items, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::Item_new(0x1::vector::borrow<0x1::string::String>(arg2, v2), 0x1::vector::borrow<0x1::option::Option<0x1::string::String>>(arg5, v2), *0x1::vector::borrow<u64>(arg3, v2), *0x1::vector::borrow<u64>(arg4, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun ASSERT_ORDER_PERMISSION<T0>(arg0: &Order<T0>, arg1: &address) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::ORD_PERM(hasOrderPermission<T0>(arg0, arg1));
    }

    public fun agent_set<T0>(arg0: &mut Order<T0>, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::AGENT_COUNT(0x1::vector::length<address>(&arg1));
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::ORD_PAYER(arg0.payer == 0x2::tx_context::sender(arg2));
        arg0.agent = arg1;
    }

    public(friend) fun create<T0>(arg0: Order<T0>) : address {
        let v0 = 0x2::object::id_address<Order<T0>>(&arg0);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::NewOrderEvent_emit(&v0, &arg0.service, &arg0.progress, arg0.amount);
        0x2::transfer::share_object<Order<T0>>(arg0);
        v0
    }

    public fun discount_destroy(arg0: Discount) {
        let Discount {
            id            : v0,
            name          : _,
            type          : _,
            price_greater : _,
            off           : _,
            time_start    : _,
            time_end      : _,
            service       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun discount_order<T0>(arg0: &address, arg1: 0x2::coin::Coin<T0>, arg2: &vector<0x1::string::String>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<0x1::option::Option<0x1::string::String>>, arg6: u64, arg7: Discount, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Order<T0> {
        let v0 = 0;
        if (0x1::option::is_some<u64>(&arg7.price_greater)) {
            v0 = *0x1::option::borrow<u64>(&arg7.price_greater);
        };
        let v1 = if (arg7.service != *arg0) {
            true
        } else if (arg6 < v0) {
            true
        } else {
            !0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::time_in_range2(arg7.time_start, arg7.time_end, arg8)
        };
        if (v1) {
            let v2 = 0x2::tx_context::sender(arg9);
            discount_send(arg7, &v2);
            return order<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9)
        };
        if (arg7.type == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::DISCOUNT_TYPE_MINUS()) {
            if (arg7.off >= arg6) {
                arg6 = 0;
            } else {
                arg6 = arg6 - arg7.off;
            };
        } else if (arg7.type == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::DISCOUNT_TYPE_OFF_RATIO()) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::DNT_OFF(arg7.off);
            let v3 = (arg6 as u128) * ((10000 - arg7.off) as u128) / 10000;
            arg6 = (v3 as u64);
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::DNT_TYPE2();
        };
        let v4 = order<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        v4.discount = 0x1::option::some<address>(0x2::object::id_address<Discount>(&arg7));
        0x2::transfer::freeze_object<Discount>(arg7);
        v4
    }

    public(friend) fun discount_send(arg0: Discount, arg1: &address) {
        0x2::transfer::public_transfer<Discount>(arg0, *arg1);
    }

    public(friend) fun discounts(arg0: &address, arg1: &0x1::string::String, arg2: u8, arg3: u64, arg4: &0x1::option::Option<u64>, arg5: &0x1::option::Option<u64>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : vector<Discount> {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::ASSERT_DISCOUNT_NEW(arg1, arg2, arg3);
        let v0 = 0;
        let v1 = 0x1::vector::empty<Discount>();
        let v2 = 0x2::clock::timestamp_ms(arg8);
        if (0x1::option::is_some<u64>(arg5)) {
            v2 = *0x1::option::borrow<u64>(arg5);
        };
        while (v0 < arg7) {
            let v3 = Discount{
                id            : 0x2::object::new(arg9),
                name          : *arg1,
                type          : arg2,
                price_greater : *arg4,
                off           : arg3,
                time_start    : v2,
                time_end      : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::time_expand(arg6, v2),
                service       : *arg0,
            };
            0x1::vector::push_back<Discount>(&mut v1, v3);
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun dispute<T0>(arg0: &mut Order<T0>, arg1: &address) {
        if (!0x1::vector::contains<address>(&arg0.dispute, arg1)) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::DNT_COUNT(0x1::vector::length<address>(&arg0.dispute));
            0x1::vector::push_back<address>(&mut arg0.dispute, *arg1);
        };
    }

    public fun guard_query<T0>(arg0: &Order<T0>, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport) {
        let v0 = 0x2::object::id_address<Order<T0>>(arg0);
        let (v1, v2, _) = 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 500) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &arg0.amount);
        } else if (v2 == 501) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &arg0.payer);
        } else if (v2 == 502) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &arg0.service);
        } else if (v2 == 503) {
            let v4 = 0x1::option::is_some<address>(&arg0.progress);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v4);
        } else if (v2 == 504) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&arg0.progress));
        } else if (v2 == 505) {
            let v5 = 0x1::option::is_some<RequiredInfo>(&arg0.required_info);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v5);
        } else if (v2 == 506) {
            let v6 = 0x1::option::is_some<address>(&arg0.discount);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v6);
        } else if (v2 == 507) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<address>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&arg0.discount));
        } else if (v2 == 508) {
            let v7 = 0x2::balance::value<T0>(&arg0.payed);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v7);
        } else if (v2 == 511) {
            let v8 = 0x1::vector::length<address>(&arg0.agent);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v8);
        } else if (v2 == 512) {
            let v9 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1);
            let v10 = 0x1::vector::contains<address>(&arg0.agent, &v9);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v10);
        } else if (v2 == 513) {
            let v11 = 0x1::vector::length<address>(&arg0.dispute);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v11);
        } else if (v2 == 514) {
            let v12 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_ADDRESS(v1);
            let v13 = 0x1::vector::contains<address>(&arg0.dispute, &v12);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v13);
        } else if (v2 == 515) {
            let v14 = 0x1::type_name::get<T0>();
            let v15 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v14));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), &v15);
        } else if (v2 == 516) {
            let v16 = 0x1::type_name::get_with_original_ids<T0>();
            let v17 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v16));
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), &v17);
        } else if (v2 == 517) {
            let v18 = 0x1::vector::length<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::Item>(&arg0.items);
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v18);
        } else if (v2 == 518) {
            let v19 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1));
            let (v20, _, _) = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::Item_find(&arg0.items, &v19);
            let v23 = v20;
            if (v23) {
                0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<bool>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v23);
            };
        } else if (v2 == 519) {
            let v24 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1));
            let (v25, v26, _) = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::Item_find(&arg0.items, &v24);
            let v28 = v26;
            if (v25) {
                0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v28);
            };
        } else if (v2 == 520) {
            let v29 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(v1));
            let (v30, _, v32) = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::Item_find(&arg0.items, &v29);
            let v33 = v32;
            if (v30) {
                0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v33);
            };
        } else if (v2 == 521) {
            0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::BUILD_RESULT_DATA<u64>(v1, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &arg0.time);
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::Q_CMD_NOT_MATCH();
        };
    }

    public fun hasOrderPermission<T0>(arg0: &Order<T0>, arg1: &address) : bool {
        arg0.payer == *arg1 || 0x1::vector::contains<address>(&arg0.agent, arg1)
    }

    public fun has_progress<T0>(arg0: &Order<T0>) : bool {
        0x1::option::is_some<address>(&arg0.progress)
    }

    public fun machine<T0>(arg0: &Order<T0>) : &0x1::option::Option<address> {
        &arg0.machine
    }

    fun ops_to_progress<T0>(arg0: &Order<T0>, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::progress::Progress) {
        let v0 = arg0.agent;
        0x1::vector::push_back<address>(&mut v0, arg0.payer);
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::progress::OrderPayer_set(arg1, &v0);
    }

    public fun progress<T0>(arg0: &Order<T0>) : &0x1::option::Option<address> {
        &arg0.progress
    }

    fun order_coin_calc<T0>(arg0: &Order<T0>, arg1: u16) : u64 {
        if (arg1 > 10000) {
            arg1 = 10000;
        };
        0x1::u64::min((((arg0.amount as u128) * (arg1 as u128) / 10000) as u64), 0x2::balance::value<T0>(&arg0.payed))
    }

    public fun order_ops_to_progress<T0>(arg0: &mut Order<T0>, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::progress::Progress) {
        if (0x1::option::is_some<address>(&arg0.progress)) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::PROGRESS(*0x1::option::borrow<address>(&arg0.progress) == 0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::progress::Progress>(arg1));
            ops_to_progress<T0>(arg0, arg1);
        };
    }

    public fun payer_change<T0>(arg0: &mut Order<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::order::ORD_PAYER(arg0.payer == 0x2::tx_context::sender(arg2));
        arg0.payer = arg1;
    }

    public fun receive<T0, T1>(arg0: &mut Order<T0>, arg1: 0x2::transfer::Receiving<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::CoinWrapper<T1>>, arg2: &0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::Payment<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        ASSERT_ORDER_PERMISSION<T0>(arg0, &v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::unwrap_assert<T1>(0x2::transfer::public_receive<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::payment::CoinWrapper<T1>>(&mut arg0.id, arg1), arg2), arg0.payer);
    }

    public(friend) fun refund<T0>(arg0: &mut Order<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        ASSERT_ORDER_PERMISSION<T0>(arg0, &v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payed, 0x2::balance::value<T0>(&arg0.payed)), arg1), arg0.payer);
    }

    public(friend) fun refund_by_service<T0>(arg0: &mut Order<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payed, 0x2::balance::value<T0>(&arg0.payed)), arg1), arg0.payer);
    }

    public(friend) fun refund_indemnity<T0>(arg0: &mut Order<T0>, arg1: &u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        ASSERT_ORDER_PERMISSION<T0>(arg0, &v0);
        let v1 = 0x2::balance::value<T0>(&arg0.payed);
        let v2 = v1;
        if (*arg1 < v1) {
            v2 = *arg1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payed, v2), arg2), arg0.payer);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payed, 0x2::balance::value<T0>(&arg0.payed)), arg2)
    }

    public(friend) fun refund_with_passport<T0>(arg0: &mut Order<T0>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        ASSERT_ORDER_PERMISSION<T0>(arg0, &v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payed, order_coin_calc<T0>(arg0, arg1)), arg2), arg0.payer);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payed, 0x2::balance::value<T0>(&arg0.payed)), arg2)
    }

    public(friend) fun required_info_answer<T0>(arg0: &mut Order<T0>, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        ASSERT_ORDER_PERMISSION<T0>(arg0, &v0);
        let v1 = RequiredInfo{
            customer_pub : *arg1,
            info         : *arg2,
        };
        arg0.required_info = 0x1::option::some<RequiredInfo>(v1);
    }

    public fun service<T0>(arg0: &Order<T0>) : &address {
        &arg0.service
    }

    public(friend) fun set_progress<T0>(arg0: &mut Order<T0>, arg1: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::progress::Progress, arg2: &address) {
        arg0.progress = 0x1::option::some<address>(0x2::object::id_address<0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::progress::Progress>(arg1));
        arg0.machine = 0x1::option::some<address>(*arg2);
        ops_to_progress<T0>(arg0, arg1);
    }

    public(friend) fun withdraw_with_passport<T0>(arg0: &mut Order<T0>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.payed);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payed, v0), arg2), arg0.payer);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payed, order_coin_calc<T0>(arg0, arg1)), arg2)
    }

    public fun witness<T0>(arg0: &mut 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::Passport, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: &Order<T0>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        while (v0 < 0x1::vector::length<u8>(&arg3)) {
            let v2 = 0x1::vector::borrow<u8>(&arg3, v0);
            if (*v2 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_ORDER_PROGRESS()) {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::OBJECT_INVALID_WITH_TYPE(0x1::option::is_some<address>(&arg4.progress));
                0x1::vector::push_back<address>(&mut v1, *0x1::option::borrow<address>(&arg4.progress));
            } else if (*v2 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_ORDER_MACHINE()) {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::OBJECT_INVALID_WITH_TYPE(0x1::option::is_some<address>(&arg4.machine));
                0x1::vector::push_back<address>(&mut v1, *0x1::option::borrow<address>(&arg4.machine));
            } else if (*v2 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_ORDER_SERVICE()) {
                0x1::vector::push_back<address>(&mut v1, arg4.service);
            } else {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::WITNESS_TYPE_INVALID();
            };
            v0 = v0 + 1;
        };
        0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport::witness_add(arg0, arg1, &arg2, &arg3, &v1);
    }

    // decompiled from Move bytecode v6
}

