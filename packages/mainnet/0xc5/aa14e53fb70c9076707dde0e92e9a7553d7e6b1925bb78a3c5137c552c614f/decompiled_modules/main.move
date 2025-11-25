module 0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::main {
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
        fulfilled_time_ms: vector<u64>,
        next_execution_time_ms: u64,
        current_cycle: u64,
        created_at_ms: u64,
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

    struct OrderCreated has copy, drop {
        recipe_id: address,
        batch_id: 0x1::option::Option<u64>,
        gap_duration_ms: u64,
        gap_frequency: u64,
        gap_unit: u8,
        order_num: u64,
        cliff_duration_ms: u64,
        cliff_frequency: u64,
        cliff_unit: u8,
        min_amount_out: u64,
        max_amount_out: u64,
        from_coin_type: 0x1::type_name::TypeName,
        to_coin_type: 0x1::type_name::TypeName,
        deposited_amount: u64,
        created_time_ms: u64,
    }

    struct OrderFilled has copy, drop {
        recipe_id: address,
        cycle_number: u64,
        fulfilled_time_ms: u64,
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
        withdrawn_at_ms: u64,
    }

    struct OrderFinished has copy, drop {
        recipe_id: address,
        amount_in_returned: u64,
        amount_out_returned: u64,
        from_coin_type: 0x1::type_name::TypeName,
        to_coin_type: 0x1::type_name::TypeName,
        is_early_terminated: bool,
    }

    struct PayoutSent has copy, drop {
        recipe_id: address,
        user: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        cycle_number: u64,
        sent_at_ms: u64,
    }

    struct CycleRefunded has copy, drop {
        recipe_id: address,
        user: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        cycle_number: u64,
        refunded_at_ms: u64,
    }

    fun calculate_first_exec_time(arg0: &Order) : u64 {
        arg0.created_at_ms + arg0.cliff_duration_ms
    }

    fun calculate_next_exec_time_after(arg0: &Order, arg1: u64) : u64 {
        let (v0, _) = calculate_window_for_cycle(arg0, arg1 + 1);
        v0
    }

    fun calculate_window_for_cycle(arg0: &Order, arg1: u64) : (u64, u64) {
        let v0 = calculate_first_exec_time(arg0) + (arg1 - 1) * arg0.gap_duration_ms;
        (v0, v0 + arg0.gap_duration_ms)
    }

    public fun cancel_order<T0, T1>(arg0: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::GlobalConfig, arg1: &mut OrderRegistry, arg2: Receipt, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
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
        v3.next_execution_time_ms = 0;
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

    public fun claim_completed_order<T0, T1>(arg0: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::GlobalConfig, arg1: &mut OrderRegistry, arg2: Receipt, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
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

    public fun create_order<T0, T1>(arg0: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::GlobalConfig, arg1: &mut OrderRegistry, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : Receipt {
        validate_global_config(arg0);
        assert!(arg5 > 0, 10);
        assert!(arg3 > 0, 11);
        assert!(0x2::balance::value<T0>(&arg2) > 0, 12);
        assert!(arg8 <= arg9, 13);
        let v0 = time_to_ms(arg3, arg4);
        let v1 = time_to_ms(arg6, arg7);
        let v2 = 0x2::balance::value<T0>(&arg2);
        let v3 = 0x2::clock::timestamp_ms(arg10);
        let v4 = 0x2::tx_context::sender(arg11);
        let v5 = v2 / arg5;
        assert!(v5 > 0, 12);
        let v6 = Order{
            id                        : 0x2::object::new(arg11),
            user                      : v4,
            batch_id                  : 0x1::option::none<u64>(),
            gap_duration_ms           : v0,
            order_num                 : arg5,
            cliff_duration_ms         : v1,
            min_amount_out            : arg8,
            max_amount_out            : arg9,
            from_coin_type            : 0x1::type_name::with_defining_ids<T0>(),
            to_coin_type              : 0x1::type_name::with_defining_ids<T1>(),
            deposited_amount          : v2,
            original_amount_per_cycle : v5,
            fulfilled_time_ms         : vector[],
            next_execution_time_ms    : v3 + v1,
            current_cycle             : 0,
            created_at_ms             : v3,
            in_balance                : 0x2::bag::new(arg11),
            out_balance               : 0x2::bag::new(arg11),
            out_withdrawn             : 0,
            status                    : 0,
            executing_flag            : false,
        };
        let v7 = 0x2::object::uid_to_address(&v6.id);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v6.in_balance, 0x1::type_name::with_defining_ids<T0>(), arg2);
        update_user_orders_index(arg1, v4, v7);
        0x2::table::add<address, Order>(&mut arg1.orders, v7, v6);
        let v8 = OrderCreated{
            recipe_id         : v7,
            batch_id          : 0x1::option::none<u64>(),
            gap_duration_ms   : v0,
            gap_frequency     : arg3,
            gap_unit          : arg4,
            order_num         : arg5,
            cliff_duration_ms : v1,
            cliff_frequency   : arg6,
            cliff_unit        : arg7,
            min_amount_out    : arg8,
            max_amount_out    : arg9,
            from_coin_type    : 0x1::type_name::with_defining_ids<T0>(),
            to_coin_type      : 0x1::type_name::with_defining_ids<T1>(),
            deposited_amount  : v2,
            created_time_ms   : v3,
        };
        0x2::event::emit<OrderCreated>(v8);
        Receipt{
            id       : 0x2::object::new(arg11),
            order_id : v7,
            batch_id : 0x1::option::none<u64>(),
        }
    }

    public fun get_current_cycle(arg0: &Order) : u64 {
        arg0.current_cycle
    }

    public fun get_deposited_amount(arg0: &Order) : u64 {
        arg0.deposited_amount
    }

    public fun get_fulfilled_time_ms(arg0: &Order) : &vector<u64> {
        &arg0.fulfilled_time_ms
    }

    public fun get_next_execution_time_ms(arg0: &Order) : u64 {
        arg0.next_execution_time_ms
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

    public fun get_order_user(arg0: &Order) : address {
        arg0.user
    }

    public fun get_receipt_batch_id(arg0: &Receipt) : 0x1::option::Option<u64> {
        arg0.batch_id
    }

    public fun get_receipt_order_id(arg0: &Receipt) : address {
        arg0.order_id
    }

    public fun get_status_active() : u64 {
        0
    }

    public fun get_status_canceled() : u64 {
        2
    }

    public fun get_status_completed() : u64 {
        1
    }

    public fun get_user_orders(arg0: &OrderRegistry, arg1: address) : vector<address> {
        if (!0x2::table::contains<address, vector<address>>(&arg0.user_orders, arg1)) {
            return vector[]
        };
        let v0 = 0x2::table::borrow<address, vector<address>>(&arg0.user_orders, arg1);
        let v1 = vector[];
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

    fun internal_complete_execution<T0, T1>(arg0: &mut Order, arg1: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::types::ExecTicket, arg2: u64) : (u64, u64, u64, u64) {
        validate_order_types<T0, T1>(arg0);
        assert!(arg0.executing_flag, 27);
        let v0 = 0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::types::get_cycle_number(arg1);
        assert!(v0 == arg0.current_cycle + 1, 26);
        assert!(v0 <= arg0.order_num, 27);
        assert!(arg2 >= arg0.min_amount_out, 25);
        assert!(arg2 <= arg0.max_amount_out, 25);
        let v1 = 0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::types::get_execution_time(arg1);
        0x1::vector::push_back<u64>(&mut arg0.fulfilled_time_ms, v1);
        arg0.current_cycle = v0;
        if (arg0.current_cycle >= arg0.order_num) {
            arg0.status = 1;
            arg0.next_execution_time_ms = 0;
        } else {
            arg0.next_execution_time_ms = calculate_next_exec_time_after(arg0, arg0.current_cycle);
        };
        arg0.executing_flag = false;
        (v0, 0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::types::get_amount_borrowed(arg1), 0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::types::get_amount_in_max(arg1), v1)
    }

    public fun is_order_executable(arg0: &OrderRegistry, arg1: address, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<address, Order>(&arg0.orders, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, Order>(&arg0.orders, arg1);
        if (v0.status != 0) {
            return false
        };
        if (v0.current_cycle >= v0.order_num) {
            return false
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let (v2, v3) = calculate_window_for_cycle(v0, v0.current_cycle + 1);
        v1 >= v2 && v1 <= v3
    }

    public fun operator_execute_and_payout<T0, T1>(arg0: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::OperatorCap, arg1: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::GlobalConfig, arg2: &mut OrderRegistry, arg3: 0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::types::ExecTicket, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock) {
        validate_global_config(arg1);
        let v0 = 0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::types::get_order_id(&arg3);
        assert!(0x2::table::contains<address, Order>(&arg2.orders, v0), 37);
        let v1 = 0x2::table::borrow_mut<address, Order>(&mut arg2.orders, v0);
        let v2 = 0x2::coin::value<T1>(&arg4);
        let (v3, v4, v5, v6) = internal_complete_execution<T0, T1>(v1, &arg3, v2);
        v1.out_withdrawn = v1.out_withdrawn + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, v1.user);
        let v7 = OrderFilled{
            recipe_id            : v0,
            cycle_number         : v3,
            fulfilled_time_ms    : v6,
            from_coin_type       : 0x1::type_name::with_defining_ids<T0>(),
            to_coin_type         : 0x1::type_name::with_defining_ids<T1>(),
            amount_in_borrowed   : v4,
            amount_in_spent      : v5,
            amount_out           : v2,
            protocol_fee_charged : 0,
        };
        0x2::event::emit<OrderFilled>(v7);
        let v8 = PayoutSent{
            recipe_id    : v0,
            user         : v1.user,
            token_type   : 0x1::type_name::with_defining_ids<T1>(),
            amount       : v2,
            cycle_number : v3,
            sent_at_ms   : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<PayoutSent>(v8);
        let (_, _, _, _, _, _, _, _) = 0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::types::destroy_exec_ticket(arg3);
    }

    public fun operator_finalize<T0, T1>(arg0: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::OperatorCap, arg1: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::GlobalConfig, arg2: &mut OrderRegistry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        validate_global_config(arg1);
        assert!(0x2::table::contains<address, Order>(&arg2.orders, arg3), 37);
        let v0 = 0x2::table::borrow_mut<address, Order>(&mut arg2.orders, arg3);
        assert!(v0.status == 1, 33);
        validate_order_types<T0, T1>(v0);
        let v1 = &mut v0.in_balance;
        let v2 = get_or_create_balance<T0>(v1, 0x1::type_name::with_defining_ids<T0>());
        let v3 = &mut v0.out_balance;
        let v4 = get_or_create_balance<T1>(v3, 0x1::type_name::with_defining_ids<T1>());
        let v5 = 0x2::balance::value<T0>(&v2);
        let v6 = 0x2::balance::value<T1>(&v4);
        assert!(v5 > 0 || v6 > 0, 29);
        v0.out_withdrawn = v0.out_withdrawn + v6;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg4), v0.user);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg4), v0.user);
        let v7 = OrderFinished{
            recipe_id           : arg3,
            amount_in_returned  : v5,
            amount_out_returned : v6,
            from_coin_type      : 0x1::type_name::with_defining_ids<T0>(),
            to_coin_type        : 0x1::type_name::with_defining_ids<T1>(),
            is_early_terminated : false,
        };
        0x2::event::emit<OrderFinished>(v7);
    }

    public fun operator_refund_cycle<T0>(arg0: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::OperatorCap, arg1: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::GlobalConfig, arg2: &mut OrderRegistry, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validate_global_config(arg1);
        assert!(0x2::table::contains<address, Order>(&arg2.orders, arg3), 37);
        let v0 = 0x2::table::borrow_mut<address, Order>(&mut arg2.orders, arg3);
        assert!(v0.status == 0, 33);
        assert!(v0.current_cycle < v0.order_num, 23);
        assert!(!v0.executing_flag, 28);
        assert!(0x1::type_name::with_defining_ids<T0>() == v0.from_coin_type, 24);
        let v1 = v0.current_cycle + 1;
        let (_, v3) = calculate_window_for_cycle(v0, v1);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        assert!(v4 > v3 + 0, 21);
        let v5 = v0.original_amount_per_cycle;
        let v6 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.in_balance, 0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::balance::value<T0>(v6) >= v5, 35);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, v5), arg5), v0.user);
        v0.current_cycle = v1;
        if (v0.current_cycle >= v0.order_num) {
            v0.status = 1;
            v0.next_execution_time_ms = 0;
        } else {
            v0.next_execution_time_ms = calculate_next_exec_time_after(v0, v0.current_cycle);
        };
        let v7 = CycleRefunded{
            recipe_id      : arg3,
            user           : v0.user,
            token_type     : 0x1::type_name::with_defining_ids<T0>(),
            amount         : v5,
            cycle_number   : v1,
            refunded_at_ms : v4,
        };
        0x2::event::emit<CycleRefunded>(v7);
    }

    public fun operator_start_execute<T0>(arg0: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::OperatorCap, arg1: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::GlobalConfig, arg2: &mut OrderRegistry, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::types::ExecTicket, 0x2::coin::Coin<T0>) {
        validate_global_config(arg1);
        assert!(0x2::table::contains<address, Order>(&arg2.orders, arg3), 37);
        let v0 = 0x2::table::borrow_mut<address, Order>(&mut arg2.orders, arg3);
        assert!(v0.status == 0, 36);
        assert!(v0.current_cycle < v0.order_num, 23);
        assert!(0x1::type_name::with_defining_ids<T0>() == v0.from_coin_type, 24);
        assert!(!v0.executing_flag, 28);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = v0.current_cycle + 1;
        let (v3, v4) = calculate_window_for_cycle(v0, v2);
        assert!(v1 >= v3, 20);
        assert!(v1 <= v4, 21);
        let v5 = v0.original_amount_per_cycle;
        let v6 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.in_balance, 0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::balance::value<T0>(v6) >= v5, 35);
        v0.executing_flag = true;
        (0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::types::new_exec_ticket(arg3, v5, v5, v1, v2, v3, v4, v1), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, v5), arg5))
    }

    public fun time_to_ms(arg0: u64, arg1: u8) : u64 {
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 2) {
            true
        } else if (arg1 == 3) {
            true
        } else if (arg1 == 4) {
            true
        } else {
            arg1 == 5
        };
        assert!(v0, 15);
        if (arg1 == 1) {
            arg0 * 60 * 1000
        } else if (arg1 == 2) {
            arg0 * 60 * 60 * 1000
        } else if (arg1 == 3) {
            arg0 * 24 * 60 * 60 * 1000
        } else if (arg1 == 4) {
            arg0 * 7 * 24 * 60 * 60 * 1000
        } else {
            arg0 * 30 * 24 * 60 * 60 * 1000
        }
    }

    fun update_user_orders_index(arg0: &mut OrderRegistry, arg1: address, arg2: address) {
        if (!0x2::table::contains<address, vector<address>>(&arg0.user_orders, arg1)) {
            0x2::table::add<address, vector<address>>(&mut arg0.user_orders, arg1, vector[]);
        };
        0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_orders, arg1), arg2);
    }

    fun validate_global_config(arg0: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::GlobalConfig) {
        assert!(!0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::is_paused(arg0), 1);
        assert!(0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::get_version(arg0) == 2, 2);
    }

    fun validate_order_ownership(arg0: &Order, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg1), 32);
    }

    fun validate_order_types<T0, T1>(arg0: &Order) {
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.from_coin_type, 24);
        assert!(0x1::type_name::with_defining_ids<T1>() == arg0.to_coin_type, 24);
    }

    public fun withdraw_output<T0>(arg0: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::GlobalConfig, arg1: &mut OrderRegistry, arg2: &Receipt, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
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
            recipe_id       : arg2.order_id,
            user            : v0.user,
            token_type      : 0x1::type_name::with_defining_ids<T0>(),
            amount          : v2,
            withdrawn_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<WithdrawEvent>(v3);
        v1
    }

    public fun withdraw_output_amount<T0>(arg0: &0xc5aa14e53fb70c9076707dde0e92e9a7553d7e6b1925bb78a3c5137c552c614f::config::GlobalConfig, arg1: &mut OrderRegistry, arg2: &Receipt, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        validate_global_config(arg0);
        assert!(0x2::table::contains<address, Order>(&arg1.orders, arg2.order_id), 37);
        let v0 = 0x2::table::borrow_mut<address, Order>(&mut arg1.orders, arg2.order_id);
        validate_order_ownership(v0, arg5);
        assert!(v0.status == 0, 33);
        assert!(0x1::type_name::with_defining_ids<T0>() == v0.to_coin_type, 24);
        let v1 = withdraw_output_balance<T0>(v0, 0x1::option::some<u64>(arg3));
        v0.out_withdrawn = v0.out_withdrawn + arg3;
        let v2 = WithdrawEvent{
            recipe_id       : arg2.order_id,
            user            : v0.user,
            token_type      : 0x1::type_name::with_defining_ids<T0>(),
            amount          : arg3,
            withdrawn_at_ms : 0x2::clock::timestamp_ms(arg4),
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

