module 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::main {
    struct Order has store, key {
        id: 0x2::object::UID,
        user: address,
        batch_id: 0x1::option::Option<u64>,
        gap_duration_ms: u64,
        order_num: u64,
        cliff_duration_ms: u64,
        min_amount_out: u64,
        max_amount_out: u64,
        from_coin_type: 0x1::type_name::TypeName,
        to_coin_type: 0x1::type_name::TypeName,
        deposited_amount: u64,
        original_amount_per_cycle: u64,
        paid_fee: u64,
        fee_rate: u64,
        fulfilled_time: vector<u64>,
        next_execution_time: u64,
        current_cycle: u64,
        created_at: u64,
        in_balance: 0x2::bag::Bag,
        out_balance: 0x2::bag::Bag,
        out_withdrawn: u64,
        status: u64,
        executing_flag: bool,
    }

    struct OrderRegistry has store, key {
        id: 0x2::object::UID,
        user_orders: 0x2::table::Table<address, vector<address>>,
        orders: 0x2::table::Table<address, Order>,
        batch_orders: 0x2::table::Table<u64, vector<address>>,
        next_batch_id: u64,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        order_id: address,
        batch_id: 0x1::option::Option<u64>,
    }

    struct BatchOrderParams<phantom T0> {
        balance: 0x2::balance::Balance<T0>,
        gap_duration_ms: u64,
        order_num: u64,
        cliff_duration_ms: u64,
        min_amount_out: u64,
        max_amount_out: u64,
        fee_rate: u64,
        to_coin_type: 0x1::type_name::TypeName,
    }

    struct OrderCreated has copy, drop {
        recipe_id: address,
        batch_id: 0x1::option::Option<u64>,
        gap_duration_ms: u64,
        order_num: u64,
        cliff_duration_ms: u64,
        min_amount_out: u64,
        max_amount_out: u64,
        fee_rate: u64,
        from_coin_type: 0x1::type_name::TypeName,
        to_coin_type: 0x1::type_name::TypeName,
        deposited_amount: u64,
        created_time: u64,
    }

    struct BatchCreated has copy, drop {
        batch_id: u64,
        user: address,
        order_count: u64,
        total_deposited: u64,
        created_time: u64,
    }

    struct OrderFilled has copy, drop {
        recipe_id: address,
        cycle_number: u64,
        fulfilled_time: u64,
        from_coin_type: 0x1::type_name::TypeName,
        to_coin_type: 0x1::type_name::TypeName,
        amount_in_borrowed: u64,
        amount_in_spent: u64,
        amount_out: u64,
        protocol_fee_charged: u64,
    }

    struct WithdrawEvent has copy, drop {
        recipe_id: address,
        user: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        withdrawn_at: u64,
    }

    struct OrderFinished has copy, drop {
        recipe_id: address,
        amount_in_returned: u64,
        amount_out_returned: u64,
        from_coin_type: 0x1::type_name::TypeName,
        to_coin_type: 0x1::type_name::TypeName,
        is_early_terminated: bool,
    }

    public fun balance_to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    fun calc_first_exec_time(arg0: &Order) : u64 {
        arg0.created_at + arg0.cliff_duration_ms
    }

    fun calc_next_exec_time_after(arg0: &Order, arg1: u64) : u64 {
        let (v0, _) = calc_window_for_cycle(arg0, arg1 + 1);
        v0
    }

    fun calc_window_for_cycle(arg0: &Order, arg1: u64) : (u64, u64) {
        let v0 = calc_first_exec_time(arg0) + (arg1 - 1) * arg0.gap_duration_ms;
        let v1 = if (arg1 < arg0.order_num) {
            v0 + arg0.gap_duration_ms
        } else {
            v0 + arg0.gap_duration_ms
        };
        (v0, v1)
    }

    public fun cancel_order<T0, T1>(arg0: &0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::GlobalConfig, arg1: &mut OrderRegistry, arg2: Receipt, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        validate_global_config(arg0);
        let Receipt {
            id       : v0,
            order_id : v1,
            batch_id : _,
        } = arg2;
        0x2::object::delete(v0);
        assert!(0x2::table::contains<address, Order>(&arg1.orders, v1), 37);
        let v3 = 0x2::table::borrow_mut<address, Order>(&mut arg1.orders, v1);
        validate_order_ownership(v3, arg4);
        assert!(v3.status == 0, 33);
        validate_order_types<T0, T1>(v3);
        assert!(!v3.executing_flag, 28);
        let v4 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v3.in_balance, 0x1::type_name::with_defining_ids<T0>());
        let v5 = &mut v3.out_balance;
        let v6 = get_or_create_balance<T1>(v5, 0x1::type_name::with_defining_ids<T1>());
        v3.status = 2;
        v3.next_execution_time = 0;
        v3.executing_flag = false;
        let v7 = OrderFinished{
            recipe_id           : v1,
            amount_in_returned  : 0x2::balance::value<T0>(&v4),
            amount_out_returned : 0x2::balance::value<T1>(&v6),
            from_coin_type      : 0x1::type_name::with_defining_ids<T0>(),
            to_coin_type        : 0x1::type_name::with_defining_ids<T1>(),
            is_early_terminated : true,
        };
        0x2::event::emit<OrderFinished>(v7);
        (v4, v6)
    }

    public fun claim_order<T0, T1>(arg0: &0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::GlobalConfig, arg1: &mut OrderRegistry, arg2: Receipt, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        validate_global_config(arg0);
        let Receipt {
            id       : v0,
            order_id : v1,
            batch_id : _,
        } = arg2;
        0x2::object::delete(v0);
        assert!(0x2::table::contains<address, Order>(&arg1.orders, v1), 37);
        let v3 = 0x2::table::borrow_mut<address, Order>(&mut arg1.orders, v1);
        validate_order_ownership(v3, arg4);
        assert!(v3.status == 1, 33);
        validate_order_types<T0, T1>(v3);
        let v4 = &mut v3.in_balance;
        let v5 = get_or_create_balance<T0>(v4, 0x1::type_name::with_defining_ids<T0>());
        let v6 = &mut v3.out_balance;
        let v7 = get_or_create_balance<T1>(v6, 0x1::type_name::with_defining_ids<T1>());
        let v8 = 0x2::balance::value<T1>(&v7);
        v3.out_withdrawn = v3.out_withdrawn + v8;
        v3.executing_flag = false;
        let v9 = OrderFinished{
            recipe_id           : v1,
            amount_in_returned  : 0x2::balance::value<T0>(&v5),
            amount_out_returned : v8,
            from_coin_type      : 0x1::type_name::with_defining_ids<T0>(),
            to_coin_type        : 0x1::type_name::with_defining_ids<T1>(),
            is_early_terminated : false,
        };
        0x2::event::emit<OrderFinished>(v9);
        (v5, v7)
    }

    public fun coin_to_balance<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun create_batch_orders<T0>(arg0: &0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::GlobalConfig, arg1: &mut OrderRegistry, arg2: vector<BatchOrderParams<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, vector<Receipt>) {
        validate_global_config(arg0);
        let v0 = arg1.next_batch_id;
        arg1.next_batch_id = v0 + 1;
        let v1 = 0x1::vector::empty<Receipt>();
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0;
        let v4 = 0x2::clock::timestamp_ms(arg3);
        let v5 = 0x2::tx_context::sender(arg4);
        let v6 = 0;
        let v7 = 0x1::vector::length<BatchOrderParams<T0>>(&arg2);
        while (v6 < v7) {
            let (v8, v9, v10, v11, v12, v13, v14, v15) = destroy_batch_order_params<T0>(0x1::vector::pop_back<BatchOrderParams<T0>>(&mut arg2));
            let v16 = v8;
            assert!(v10 > 0, 10);
            assert!(v9 > 0, 11);
            assert!(0x2::balance::value<T0>(&v16) > 0, 12);
            assert!(v12 <= v13, 13);
            let v17 = 0x2::balance::value<T0>(&v16);
            let v18 = v17 / v10;
            assert!(v18 > 0, 12);
            let v19 = Order{
                id                        : 0x2::object::new(arg4),
                user                      : v5,
                batch_id                  : 0x1::option::some<u64>(v0),
                gap_duration_ms           : v9,
                order_num                 : v10,
                cliff_duration_ms         : v11,
                min_amount_out            : v12,
                max_amount_out            : v13,
                from_coin_type            : 0x1::type_name::with_defining_ids<T0>(),
                to_coin_type              : v15,
                deposited_amount          : v17,
                original_amount_per_cycle : v18,
                paid_fee                  : 0,
                fee_rate                  : v14,
                fulfilled_time            : 0x1::vector::empty<u64>(),
                next_execution_time       : v4 + v11,
                current_cycle             : 0,
                created_at                : v4,
                in_balance                : 0x2::bag::new(arg4),
                out_balance               : 0x2::bag::new(arg4),
                out_withdrawn             : 0,
                status                    : 0,
                executing_flag            : false,
            };
            let v20 = 0x2::object::uid_to_address(&v19.id);
            v3 = v3 + v17;
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v19.in_balance, 0x1::type_name::with_defining_ids<T0>(), v16);
            0x2::table::add<address, Order>(&mut arg1.orders, v20, v19);
            0x1::vector::push_back<address>(&mut v2, v20);
            let v21 = Receipt{
                id       : 0x2::object::new(arg4),
                order_id : v20,
                batch_id : 0x1::option::some<u64>(v0),
            };
            0x1::vector::push_back<Receipt>(&mut v1, v21);
            let v22 = OrderCreated{
                recipe_id         : v20,
                batch_id          : 0x1::option::some<u64>(v0),
                gap_duration_ms   : v9,
                order_num         : v10,
                cliff_duration_ms : v11,
                min_amount_out    : v12,
                max_amount_out    : v13,
                fee_rate          : v14,
                from_coin_type    : 0x1::type_name::with_defining_ids<T0>(),
                to_coin_type      : v15,
                deposited_amount  : v17,
                created_time      : v4,
            };
            0x2::event::emit<OrderCreated>(v22);
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<BatchOrderParams<T0>>(arg2);
        let v23 = 0;
        while (v23 < 0x1::vector::length<address>(&v2)) {
            update_user_orders_index(arg1, v5, *0x1::vector::borrow<address>(&v2, v23));
            v23 = v23 + 1;
        };
        0x2::table::add<u64, vector<address>>(&mut arg1.batch_orders, v0, v2);
        let v24 = BatchCreated{
            batch_id        : v0,
            user            : v5,
            order_count     : v7,
            total_deposited : v3,
            created_time    : v4,
        };
        0x2::event::emit<BatchCreated>(v24);
        (v0, v1)
    }

    public fun create_order<T0, T1>(arg0: &0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::GlobalConfig, arg1: &mut OrderRegistry, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : Receipt {
        validate_global_config(arg0);
        assert!(arg4 > 0, 10);
        assert!(arg3 > 0, 11);
        assert!(0x2::balance::value<T0>(&arg2) > 0, 12);
        assert!(arg6 <= arg7, 13);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = 0x2::tx_context::sender(arg10);
        let v3 = v0 / arg4;
        assert!(v3 > 0, 12);
        let v4 = Order{
            id                        : 0x2::object::new(arg10),
            user                      : v2,
            batch_id                  : 0x1::option::none<u64>(),
            gap_duration_ms           : arg3,
            order_num                 : arg4,
            cliff_duration_ms         : arg5,
            min_amount_out            : arg6,
            max_amount_out            : arg7,
            from_coin_type            : 0x1::type_name::with_defining_ids<T0>(),
            to_coin_type              : 0x1::type_name::with_defining_ids<T1>(),
            deposited_amount          : v0,
            original_amount_per_cycle : v3,
            paid_fee                  : 0,
            fee_rate                  : arg8,
            fulfilled_time            : 0x1::vector::empty<u64>(),
            next_execution_time       : v1 + arg5,
            current_cycle             : 0,
            created_at                : v1,
            in_balance                : 0x2::bag::new(arg10),
            out_balance               : 0x2::bag::new(arg10),
            out_withdrawn             : 0,
            status                    : 0,
            executing_flag            : false,
        };
        let v5 = 0x2::object::uid_to_address(&v4.id);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v4.in_balance, 0x1::type_name::with_defining_ids<T0>(), arg2);
        update_user_orders_index(arg1, v2, v5);
        0x2::table::add<address, Order>(&mut arg1.orders, v5, v4);
        let v6 = OrderCreated{
            recipe_id         : v5,
            batch_id          : 0x1::option::none<u64>(),
            gap_duration_ms   : arg3,
            order_num         : arg4,
            cliff_duration_ms : arg5,
            min_amount_out    : arg6,
            max_amount_out    : arg7,
            fee_rate          : arg8,
            from_coin_type    : 0x1::type_name::with_defining_ids<T0>(),
            to_coin_type      : 0x1::type_name::with_defining_ids<T1>(),
            deposited_amount  : v0,
            created_time      : v1,
        };
        0x2::event::emit<OrderCreated>(v6);
        Receipt{
            id       : 0x2::object::new(arg10),
            order_id : v5,
            batch_id : 0x1::option::none<u64>(),
        }
    }

    public fun destroy_batch_order_params<T0>(arg0: BatchOrderParams<T0>) : (0x2::balance::Balance<T0>, u64, u64, u64, u64, u64, u64, 0x1::type_name::TypeName) {
        let BatchOrderParams {
            balance           : v0,
            gap_duration_ms   : v1,
            order_num         : v2,
            cliff_duration_ms : v3,
            min_amount_out    : v4,
            max_amount_out    : v5,
            fee_rate          : v6,
            to_coin_type      : v7,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun end_execute_order<T0, T1>(arg0: &0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::GlobalConfig, arg1: &mut 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::ProtocolFeeVault, arg2: &mut OrderRegistry, arg3: 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::LoanTicket<T0>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        validate_global_config(arg0);
        let (v0, v1) = 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::destroy_loan_ticket<T0>(arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::get_order_id(&v3);
        assert!(0x2::table::contains<address, Order>(&arg2.orders, v4), 37);
        let v5 = 0x2::table::borrow_mut<address, Order>(&mut arg2.orders, v4);
        validate_order_types<T0, T1>(v5);
        assert!(v5.executing_flag, 27);
        let v6 = 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::get_cycle_number(&v3);
        assert!(v6 > v5.current_cycle, 27);
        let v7 = 0x2::balance::value<T1>(&arg5);
        assert!(v7 >= v5.min_amount_out, 25);
        assert!(v7 <= v5.max_amount_out, 25);
        let v8 = 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::get_amount_in_max(&v3);
        let v9 = 0x2::balance::value<T0>(&arg4) + 0x2::balance::value<T0>(&v2);
        assert!(v9 <= v8, 26);
        let v10 = &mut v5.in_balance;
        store_or_join_balance<T0>(v10, 0x1::type_name::with_defining_ids<T0>(), arg4);
        let v11 = &mut v5.in_balance;
        store_or_join_balance<T0>(v11, 0x1::type_name::with_defining_ids<T0>(), v2);
        let v12 = &mut v5.out_balance;
        store_or_join_balance<T1>(v12, 0x1::type_name::with_defining_ids<T1>(), arg5);
        let v13 = 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::get_execution_time(&v3);
        0x1::vector::push_back<u64>(&mut v5.fulfilled_time, v13);
        v5.current_cycle = v6;
        if (v5.current_cycle >= v5.order_num) {
            v5.status = 1;
            v5.next_execution_time = 0;
        } else {
            v5.next_execution_time = calc_next_exec_time_after(v5, v5.current_cycle);
        };
        v5.executing_flag = false;
        let v14 = OrderFilled{
            recipe_id            : v4,
            cycle_number         : 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::get_cycle_number(&v3),
            fulfilled_time       : v13,
            from_coin_type       : 0x1::type_name::with_defining_ids<T0>(),
            to_coin_type         : 0x1::type_name::with_defining_ids<T1>(),
            amount_in_borrowed   : 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::get_amount_borrowed(&v3),
            amount_in_spent      : v8 - v9,
            amount_out           : v7,
            protocol_fee_charged : 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::get_fee_collected(&v3),
        };
        0x2::event::emit<OrderFilled>(v14);
        let (_, _, _, _, _, _, _, _, _) = 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::destroy_exec_ticket(v3);
    }

    public fun get_batch_info(arg0: &OrderRegistry, arg1: u64) : (u64, u64) {
        if (!0x2::table::contains<u64, vector<address>>(&arg0.batch_orders, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<u64, vector<address>>(&arg0.batch_orders, arg1);
        let v1 = 0x1::vector::length<address>(v0);
        let v2 = 0;
        let v3 = 0;
        while (v2 < v1) {
            v3 = v3 + 0x2::table::borrow<address, Order>(&arg0.orders, *0x1::vector::borrow<address>(v0, v2)).deposited_amount;
            v2 = v2 + 1;
        };
        (v1, v3)
    }

    public fun get_batch_orders(arg0: &OrderRegistry, arg1: u64) : vector<address> {
        if (!0x2::table::contains<u64, vector<address>>(&arg0.batch_orders, arg1)) {
            return 0x1::vector::empty<address>()
        };
        let v0 = 0x2::table::borrow<u64, vector<address>>(&arg0.batch_orders, arg1);
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v0)) {
            0x1::vector::push_back<address>(&mut v1, *0x1::vector::borrow<address>(v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_current_cycle(arg0: &Order) : u64 {
        arg0.current_cycle
    }

    public fun get_deposited_amount(arg0: &Order) : u64 {
        arg0.deposited_amount
    }

    public fun get_fulfilled_time(arg0: &Order) : &vector<u64> {
        &arg0.fulfilled_time
    }

    public fun get_next_execution_time(arg0: &Order) : u64 {
        arg0.next_execution_time
    }

    fun get_or_create_balance<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x1::type_name::TypeName) : 0x2::balance::Balance<T0> {
        if (0x2::bag::contains<0x1::type_name::TypeName>(arg0, arg1)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, arg1)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public fun get_order_details(arg0: &OrderRegistry, arg1: address) : &Order {
        0x2::table::borrow<address, Order>(&arg0.orders, arg1)
    }

    public fun get_order_num(arg0: &Order) : u64 {
        arg0.order_num
    }

    public fun get_order_status(arg0: &Order) : u64 {
        arg0.status
    }

    public fun get_order_timing_plus(arg0: &OrderRegistry, arg1: address, arg2: &0x2::clock::Clock) : (bool, u64, u64, u64, u64) {
        if (!0x2::table::contains<address, Order>(&arg0.orders, arg1)) {
            return (false, 0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, Order>(&arg0.orders, arg1);
        if (v0.status != 0) {
            return (false, 0, 0, 0, 0)
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = calc_first_exec_time(v0);
        if (v1 < v2) {
            let (v3, v4) = calc_window_for_cycle(v0, 1);
            return (false, 1, v3, v4, v3)
        };
        let v5 = (v1 - v2) / v0.gap_duration_ms + 1;
        if (v5 > v0.order_num) {
            return (false, 0, 0, 0, 0)
        };
        let (v6, v7) = calc_window_for_cycle(v0, v5);
        let v8 = v1 >= v6 && v1 < v7;
        let v9 = if (v5 < v0.order_num) {
            let (v10, _) = calc_window_for_cycle(v0, v5 + 1);
            v10
        } else {
            0
        };
        (v8, v5, v6, v7, v9)
    }

    public fun get_order_user(arg0: &Order) : address {
        arg0.user
    }

    public fun get_paid_fee(arg0: &Order) : u64 {
        arg0.paid_fee
    }

    public fun get_receipt_batch_id(arg0: &Receipt) : 0x1::option::Option<u64> {
        arg0.batch_id
    }

    public fun get_receipt_order_id(arg0: &Receipt) : address {
        arg0.order_id
    }

    public fun get_user_orders(arg0: &OrderRegistry, arg1: address) : vector<address> {
        if (!0x2::table::contains<address, vector<address>>(&arg0.user_orders, arg1)) {
            return 0x1::vector::empty<address>()
        };
        let v0 = 0x2::table::borrow<address, vector<address>>(&arg0.user_orders, arg1);
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v0)) {
            0x1::vector::push_back<address>(&mut v1, *0x1::vector::borrow<address>(v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_withdrawable_output<T0>(arg0: &OrderRegistry, arg1: address) : u64 {
        let v0 = 0x2::table::borrow<address, Order>(&arg0.orders, arg1);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&v0.out_balance, 0x1::type_name::with_defining_ids<T0>())) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&v0.out_balance, 0x1::type_name::with_defining_ids<T0>()))
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OrderRegistry{
            id            : 0x2::object::new(arg0),
            user_orders   : 0x2::table::new<address, vector<address>>(arg0),
            orders        : 0x2::table::new<address, Order>(arg0),
            batch_orders  : 0x2::table::new<u64, vector<address>>(arg0),
            next_batch_id : 1,
        };
        0x2::transfer::share_object<OrderRegistry>(v0);
    }

    public fun is_order_executable(arg0: &OrderRegistry, arg1: address, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<address, Order>(&arg0.orders, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, Order>(&arg0.orders, arg1);
        if (v0.status != 0) {
            return false
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = calc_first_exec_time(v0);
        if (v1 < v2) {
            return false
        };
        let v3 = (v1 - v2) / v0.gap_duration_ms + 1;
        if (v3 == 0 || v3 > v0.order_num) {
            return false
        };
        let (v4, v5) = calc_window_for_cycle(v0, v3);
        v1 >= v4 && v1 < v5
    }

    public fun new_batch_order_params<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::type_name::TypeName) : BatchOrderParams<T0> {
        BatchOrderParams<T0>{
            balance           : arg0,
            gap_duration_ms   : arg1,
            order_num         : arg2,
            cliff_duration_ms : arg3,
            min_amount_out    : arg4,
            max_amount_out    : arg5,
            fee_rate          : arg6,
            to_coin_type      : arg7,
        }
    }

    public fun preview_next_execution<T0>(arg0: &OrderRegistry, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64, u64, bool, u64, u64, u64, u64, u64) {
        if (!0x2::table::contains<address, Order>(&arg0.orders, arg1)) {
            return (0, 0, 0, false, 0, 0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, Order>(&arg0.orders, arg1);
        if (v0.status != 0) {
            return (0, 0, 0, false, 0, 0, 0, 0, 0)
        };
        assert!(0x1::type_name::with_defining_ids<T0>() == v0.from_coin_type, 24);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = calc_first_exec_time(v0);
        if (v1 < v2) {
            let (v3, v4) = calc_window_for_cycle(v0, 1);
            let v5 = v0.original_amount_per_cycle;
            let v6 = v5 * v0.fee_rate / 1000000;
            return (1, v3, v4, false, v5, v6, v5 - v6, v0.min_amount_out, v0.max_amount_out)
        };
        let v7 = (v1 - v2) / v0.gap_duration_ms + 1;
        if (v7 > v0.order_num) {
            return (0, 0, 0, false, 0, 0, 0, 0, 0)
        };
        let (v8, v9) = calc_window_for_cycle(v0, v7);
        let v10 = v1 >= v8 && v1 < v9;
        let v11 = v0.original_amount_per_cycle;
        let v12 = v11 * v0.fee_rate / 1000000;
        (v7, v8, v9, v10, v11, v12, v11 - v12, v0.min_amount_out, v0.max_amount_out)
    }

    public fun put_back_input<T0>(arg0: &mut 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::LoanTicket<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::get_in_balance_mut<T0>(arg0), arg1);
    }

    public fun put_back_input_entry<T0>(arg0: &mut 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::LoanTicket<T0>, arg1: 0x2::balance::Balance<T0>) {
        put_back_input<T0>(arg0, arg1);
    }

    public fun start_execute_order<T0>(arg0: &0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::OperatorCap, arg1: &0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::GlobalConfig, arg2: &mut 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::ProtocolFeeVault, arg3: &mut OrderRegistry, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::LoanTicket<T0> {
        validate_global_config(arg1);
        assert!(0x2::table::contains<address, Order>(&arg3.orders, arg4), 37);
        let v0 = 0x2::table::borrow_mut<address, Order>(&mut arg3.orders, arg4);
        assert!(v0.status == 0, 36);
        assert!(0x1::type_name::with_defining_ids<T0>() == v0.from_coin_type, 24);
        assert!(!v0.executing_flag, 28);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let (v2, v3, v4) = validate_and_calculate_execution_timing(v0, v1);
        assert!(v2 > v0.current_cycle, 27);
        let v5 = v0.original_amount_per_cycle;
        let v6 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.in_balance, 0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::balance::value<T0>(v6) >= v5, 35);
        let v7 = v5 * v0.fee_rate / 1000000;
        let v8 = 0x2::balance::split<T0>(v6, v5);
        0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::collect_protocol_fee<T0>(arg2, 0x2::balance::split<T0>(&mut v8, v7), arg5);
        v0.paid_fee = v0.paid_fee + v7;
        v0.executing_flag = true;
        0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::new_loan_ticket<T0>(0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::new_exec_ticket(arg4, v5, 0x2::balance::value<T0>(&v8), v1, v2, v7, v3, v4, v1), v8)
    }

    fun store_or_join_balance<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x1::type_name::TypeName, arg2: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(arg0, arg1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, arg1), arg2);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, arg1, arg2);
        };
    }

    public fun take_input<T0>(arg0: &mut 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::LoanTicket<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::get_in_balance_mut<T0>(arg0);
        0x2::balance::split<T0>(v0, 0x2::balance::value<T0>(v0))
    }

    public fun take_input_entry<T0>(arg0: &mut 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::types::LoanTicket<T0>) : 0x2::balance::Balance<T0> {
        take_input<T0>(arg0)
    }

    fun update_user_orders_index(arg0: &mut OrderRegistry, arg1: address, arg2: address) {
        if (!0x2::table::contains<address, vector<address>>(&arg0.user_orders, arg1)) {
            0x2::table::add<address, vector<address>>(&mut arg0.user_orders, arg1, 0x1::vector::empty<address>());
        };
        0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_orders, arg1), arg2);
    }

    fun validate_and_calculate_execution_timing(arg0: &Order, arg1: u64) : (u64, u64, u64) {
        let v0 = calc_first_exec_time(arg0);
        assert!(arg1 >= v0, 22);
        let v1 = (arg1 - v0) / arg0.gap_duration_ms + 1;
        assert!(v1 >= 1 && v1 <= arg0.order_num, 23);
        let (v2, v3) = calc_window_for_cycle(arg0, v1);
        assert!(arg1 >= v2, 20);
        assert!(arg1 < v3, 21);
        (v1, v2, v3)
    }

    fun validate_global_config(arg0: &0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::GlobalConfig) {
        assert!(!0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::is_paused(arg0), 1);
        assert!(0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::get_version(arg0) == 1, 2);
    }

    fun validate_order_ownership(arg0: &Order, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg1), 32);
    }

    fun validate_order_types<T0, T1>(arg0: &Order) {
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.from_coin_type, 24);
        assert!(0x1::type_name::with_defining_ids<T1>() == arg0.to_coin_type, 24);
    }

    public fun withdraw_output<T0>(arg0: &0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::GlobalConfig, arg1: &mut OrderRegistry, arg2: &Receipt, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        validate_global_config(arg0);
        assert!(0x2::table::contains<address, Order>(&arg1.orders, arg2.order_id), 37);
        let v0 = 0x2::table::borrow_mut<address, Order>(&mut arg1.orders, arg2.order_id);
        validate_order_ownership(v0, arg4);
        assert!(v0.status == 0, 33);
        assert!(0x1::type_name::with_defining_ids<T0>() == v0.to_coin_type, 24);
        let v1 = withdraw_output_balance<T0>(v0, 0x1::option::none<u64>());
        let v2 = 0x2::balance::value<T0>(&v1);
        v0.out_withdrawn = v0.out_withdrawn + v2;
        let v3 = WithdrawEvent{
            recipe_id    : arg2.order_id,
            user         : v0.user,
            token_type   : 0x1::type_name::with_defining_ids<T0>(),
            amount       : v2,
            withdrawn_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<WithdrawEvent>(v3);
        v1
    }

    public fun withdraw_output_amount<T0>(arg0: &0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config::GlobalConfig, arg1: &mut OrderRegistry, arg2: &Receipt, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        validate_global_config(arg0);
        assert!(0x2::table::contains<address, Order>(&arg1.orders, arg2.order_id), 37);
        let v0 = 0x2::table::borrow_mut<address, Order>(&mut arg1.orders, arg2.order_id);
        validate_order_ownership(v0, arg5);
        assert!(v0.status == 0, 33);
        assert!(0x1::type_name::with_defining_ids<T0>() == v0.to_coin_type, 24);
        let v1 = withdraw_output_balance<T0>(v0, 0x1::option::some<u64>(arg3));
        v0.out_withdrawn = v0.out_withdrawn + arg3;
        let v2 = WithdrawEvent{
            recipe_id    : arg2.order_id,
            user         : v0.user,
            token_type   : 0x1::type_name::with_defining_ids<T0>(),
            amount       : arg3,
            withdrawn_at : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<WithdrawEvent>(v2);
        v1
    }

    fun withdraw_output_balance<T0>(arg0: &mut Order, arg1: 0x1::option::Option<u64>) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.out_balance, v0), 34);
        if (0x1::option::is_some<u64>(&arg1)) {
            let v2 = 0x1::option::extract<u64>(&mut arg1);
            assert!(v2 > 0, 12);
            let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.out_balance, v0);
            assert!(0x2::balance::value<T0>(v3) >= v2, 35);
            0x2::balance::split<T0>(v3, v2)
        } else {
            let v4 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.out_balance, v0);
            assert!(0x2::balance::value<T0>(&v4) > 0, 34);
            v4
        }
    }

    // decompiled from Move bytecode v6
}

