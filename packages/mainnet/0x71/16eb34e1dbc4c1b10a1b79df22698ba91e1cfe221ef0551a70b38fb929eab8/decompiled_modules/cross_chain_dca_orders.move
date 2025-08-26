module 0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::cross_chain_dca_orders {
    struct DcaOrder<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        cancelled: bool,
        coins_in_were_swapped_during_interval: bool,
        locked_collateral: 0x2::balance::Balance<T0>,
        locked_coins_in: 0x2::balance::Balance<T1>,
        locked_stablecoins: 0x2::balance::Balance<T2>,
        user: address,
        active_solver: 0x1::option::Option<address>,
        amount_in_per_interval: u64,
        min_stablecoins_amount: u64,
        total_intervals: u32,
        interval_duration: u64,
        interval_index_of_latest_execution_start: u32,
        total_executed_intervals: u32,
        last_executed_interval_index: u32,
        start_time: u64,
        execution_deadline: u64,
        deadline: u64,
        execution_details_hash: vector<u8>,
    }

    struct SwapReceipt {
        order_id: 0x2::object::ID,
        interval_number: u32,
        min_stablecoins_amount: u64,
    }

    struct SignedDcaPermissionData has drop {
        solver_address: address,
        order_id: 0x2::object::ID,
        interval_number_to_execute: u32,
        collateral_amount: u64,
        protocol_fee_amount: u64,
        allow_swap: bool,
        min_stablecoins_amount: u64,
        previous_executed_interval_index: u32,
        previous_executed_interval_solver: address,
        solver_deadline: u64,
    }

    struct SignedDcaSuccessConfirmationData has drop {
        solver_address: address,
        order_id: 0x2::object::ID,
        interval_number: u32,
        interval_index: u32,
    }

    struct DcaOrderCreated<phantom T0, phantom T1, phantom T2> has copy, drop {
        order_id: 0x2::object::ID,
        guard_id: 0x2::object::ID,
        user: address,
        locked_coins_in: u64,
        amount_in_per_interval: u64,
        min_stablecoins_amount_per_interval: u64,
        start_time: u64,
        deadline: u64,
        total_intervals: u32,
        interval_duration: u64,
        execution_details_hash: vector<u8>,
    }

    struct DcaOrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
    }

    struct DcaExecutionStarted has copy, drop {
        order_id: 0x2::object::ID,
        interval_number: u32,
        solver: address,
        collateral_amount: u64,
        protocol_fee_amount: u64,
        solver_deadline: u64,
    }

    struct DcaCoinInSwapped has copy, drop {
        order_id: 0x2::object::ID,
        interval_number: u32,
        solver: address,
        stablecoin_amount: u64,
    }

    struct DcaOrderIntervalFulfilled has copy, drop {
        order_id: 0x2::object::ID,
        solver: address,
        interval_number: u32,
    }

    struct FailedDcaIntervalExecution has copy, drop {
        order_id: 0x2::object::ID,
        interval_number: u32,
        interval_index: u32,
    }

    struct DcaOrderFulfilled has copy, drop {
        order_id: 0x2::object::ID,
    }

    public fun cancel_dca_order<T0, T1, T2>(arg0: DcaOrder<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != arg0.user) {
            abort 0
        };
        let v0 = DcaOrderCancelled{order_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<DcaOrderCancelled>(v0);
        let v1 = arg0.execution_deadline >= 0x2::clock::timestamp_ms(arg1);
        let v2 = arg0.cancelled && arg0.total_executed_intervals != arg0.total_intervals;
        if (v1 && v2) {
            abort 1
        };
        if (v1 && !v2) {
            let v3 = arg0.total_intervals - arg0.total_executed_intervals - 1;
            if (v3 != 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.locked_coins_in, (v3 as u64) * arg0.amount_in_per_interval), arg2), arg0.user);
            };
            arg0.cancelled = true;
            0x2::transfer::share_object<DcaOrder<T0, T1, T2>>(arg0);
        } else {
            let DcaOrder {
                id                                       : v4,
                cancelled                                : _,
                coins_in_were_swapped_during_interval    : _,
                locked_collateral                        : v7,
                locked_coins_in                          : v8,
                locked_stablecoins                       : v9,
                user                                     : v10,
                active_solver                            : _,
                amount_in_per_interval                   : _,
                min_stablecoins_amount                   : _,
                total_intervals                          : _,
                interval_duration                        : _,
                interval_index_of_latest_execution_start : _,
                total_executed_intervals                 : _,
                last_executed_interval_index             : _,
                start_time                               : _,
                execution_deadline                       : _,
                deadline                                 : _,
                execution_details_hash                   : _,
            } = arg0;
            0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::send_coins_and_destroy_balance<T1>(v8, v10, arg2);
            0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::send_coins_and_destroy_balance<T2>(v9, v10, arg2);
            0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::send_coins_and_destroy_balance<T0>(v7, v10, arg2);
            0x2::object::delete(v4);
        };
    }

    fun check_signed_permission_data<T0, T1, T2>(arg0: &DcaOrder<T0, T1, T2>, arg1: &SignedDcaPermissionData, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        if (arg1.solver_address != 0x2::tx_context::sender(arg3)) {
            abort 2
        };
        if (arg1.order_id != 0x2::object::id<DcaOrder<T0, T1, T2>>(arg0)) {
            abort 102
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg1.solver_deadline > arg0.deadline || arg1.solver_deadline <= v0) {
            abort 105
        };
        if (arg0.execution_deadline > v0) {
            abort 1
        };
        if (arg1.interval_number_to_execute != arg0.total_executed_intervals + 1) {
            abort 203
        };
        if (arg0.cancelled) {
            abort 205
        };
    }

    public fun claim_tokens_for_dca_interval<T0, T1, T2>(arg0: &0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::Guard<T0, T2>, arg1: DcaOrder<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::address::to_bytes(0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::get_actioneer<T0, T2>(arg0));
        if (!0x2::ed25519::ed25519_verify(&arg4, &v0, &arg3)) {
            abort 101
        };
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = decode_signed_success_confirmation_data(arg3);
        let v3 = if (&v2.order_id != 0x2::object::uid_as_inner(&arg1.id)) {
            true
        } else if (get_current_interval_index<T0, T1, T2>(&arg1, arg2) < v2.interval_index) {
            true
        } else {
            v2.interval_number != arg1.total_executed_intervals + 1
        };
        if (v3) {
            abort 108
        };
        let v4 = if (0x1::option::is_none<address>(&arg1.active_solver)) {
            true
        } else if (0x1::option::borrow<address>(&arg1.active_solver) != &v1) {
            true
        } else {
            v1 != v2.solver_address
        };
        if (v4) {
            abort 2
        };
        let v5 = &mut arg1;
        if (register_order_interval_fulfillment<T0, T1, T2>(v5, v2.interval_index, v2.solver_address, arg5)) {
            let DcaOrder {
                id                                       : v6,
                cancelled                                : _,
                coins_in_were_swapped_during_interval    : _,
                locked_collateral                        : v9,
                locked_coins_in                          : v10,
                locked_stablecoins                       : v11,
                user                                     : _,
                active_solver                            : _,
                amount_in_per_interval                   : _,
                min_stablecoins_amount                   : _,
                total_intervals                          : _,
                interval_duration                        : _,
                interval_index_of_latest_execution_start : _,
                total_executed_intervals                 : _,
                last_executed_interval_index             : _,
                start_time                               : _,
                execution_deadline                       : _,
                deadline                                 : _,
                execution_details_hash                   : _,
            } = arg1;
            0x2::balance::destroy_zero<T1>(v10);
            0x2::balance::destroy_zero<T2>(v11);
            0x2::balance::destroy_zero<T0>(v9);
            0x2::object::delete(v6);
        } else {
            0x2::transfer::share_object<DcaOrder<T0, T1, T2>>(arg1);
        };
    }

    public fun create_dca_order<T0, T1, T2>(arg0: &0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::Guard<T0, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u32, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T1>(&arg1) == 0 || arg3 == 0) {
            abort 3
        };
        if (arg5 < 1000) {
            abort 112
        };
        let v0 = 0x2::clock::timestamp_ms(arg8);
        if (v0 + (arg4 as u64) * arg5 > arg6) {
            abort 109
        };
        if (0x2::coin::value<T1>(&arg1) != (arg4 as u64) * arg2) {
            abort 201
        };
        if (arg4 < 2) {
            abort 202
        };
        let v1 = DcaOrder<T0, T1, T2>{
            id                                       : 0x2::object::new(arg9),
            cancelled                                : false,
            coins_in_were_swapped_during_interval    : false,
            locked_collateral                        : 0x2::balance::zero<T0>(),
            locked_coins_in                          : 0x2::coin::into_balance<T1>(arg1),
            locked_stablecoins                       : 0x2::balance::zero<T2>(),
            user                                     : 0x2::tx_context::sender(arg9),
            active_solver                            : 0x1::option::none<address>(),
            amount_in_per_interval                   : arg2,
            min_stablecoins_amount                   : arg3,
            total_intervals                          : arg4,
            interval_duration                        : arg5,
            interval_index_of_latest_execution_start : 0,
            total_executed_intervals                 : 0,
            last_executed_interval_index             : 0,
            start_time                               : v0,
            execution_deadline                       : 0,
            deadline                                 : arg6,
            execution_details_hash                   : arg7,
        };
        let v2 = DcaOrderCreated<T0, T1, T2>{
            order_id                            : 0x2::object::id<DcaOrder<T0, T1, T2>>(&v1),
            guard_id                            : 0x2::object::id<0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::Guard<T0, T2>>(arg0),
            user                                : v1.user,
            locked_coins_in                     : 0x2::balance::value<T1>(&v1.locked_coins_in),
            amount_in_per_interval              : arg2,
            min_stablecoins_amount_per_interval : arg3,
            start_time                          : v0,
            deadline                            : v1.deadline,
            total_intervals                     : arg4,
            interval_duration                   : arg5,
            execution_details_hash              : arg7,
        };
        0x2::event::emit<DcaOrderCreated<T0, T1, T2>>(v2);
        0x2::transfer::share_object<DcaOrder<T0, T1, T2>>(v1);
    }

    fun decode_signed_permission_data(arg0: vector<u8>) : SignedDcaPermissionData {
        if (0x1::vector::length<u8>(&arg0) != 137) {
            abort 110
        };
        let v0 = 0x2::bcs::new(arg0);
        SignedDcaPermissionData{
            solver_address                    : 0x2::bcs::peel_address(&mut v0),
            order_id                          : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            interval_number_to_execute        : 0x2::bcs::peel_u32(&mut v0),
            collateral_amount                 : 0x2::bcs::peel_u64(&mut v0),
            protocol_fee_amount               : 0x2::bcs::peel_u64(&mut v0),
            allow_swap                        : 0x2::bcs::peel_bool(&mut v0),
            min_stablecoins_amount            : 0x2::bcs::peel_u64(&mut v0),
            previous_executed_interval_index  : 0x2::bcs::peel_u32(&mut v0),
            previous_executed_interval_solver : 0x2::bcs::peel_address(&mut v0),
            solver_deadline                   : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    fun decode_signed_success_confirmation_data(arg0: vector<u8>) : SignedDcaSuccessConfirmationData {
        if (0x1::vector::length<u8>(&arg0) != 72) {
            abort 111
        };
        let v0 = 0x2::bcs::new(arg0);
        SignedDcaSuccessConfirmationData{
            solver_address  : 0x2::bcs::peel_address(&mut v0),
            order_id        : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            interval_number : 0x2::bcs::peel_u32(&mut v0),
            interval_index  : 0x2::bcs::peel_u32(&mut v0),
        }
    }

    fun decode_start_permission_and_check_signature<T0, T1>(arg0: &0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::Guard<T0, T1>, arg1: vector<u8>, arg2: vector<u8>) : SignedDcaPermissionData {
        let v0 = 0x2::address::to_bytes(0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::get_actioneer<T0, T1>(arg0));
        if (!0x2::ed25519::ed25519_verify(&arg2, &v0, &arg1)) {
            abort 101
        };
        decode_signed_permission_data(arg1)
    }

    fun get_current_interval_index<T0, T1, T2>(arg0: &DcaOrder<T0, T1, T2>, arg1: &0x2::clock::Clock) : u32 {
        get_interval_index<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    fun get_interval_index<T0, T1, T2>(arg0: &DcaOrder<T0, T1, T2>, arg1: u64) : u32 {
        safe_u64_to_u32((arg1 - arg0.start_time) / arg0.interval_duration + 1)
    }

    fun handle_previous_intervals<T0, T1, T2>(arg0: &mut DcaOrder<T0, T1, T2>, arg1: &SignedDcaPermissionData, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.cancelled) {
            abort 205
        };
        if (arg0.total_executed_intervals != 0 && arg1.previous_executed_interval_solver == @0x0 || arg1.previous_executed_interval_index < arg0.last_executed_interval_index) {
            abort 102
        };
        if (!(arg0.execution_deadline != 0) && arg1.previous_executed_interval_solver == @0x0) {
            return
        };
        if (arg1.previous_executed_interval_index > arg2 || arg0.last_executed_interval_index >= arg2) {
            abort 207
        };
        if (arg0.last_executed_interval_index == arg1.previous_executed_interval_index) {
            0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::send_coins_and_destroy_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.locked_collateral), arg0.user, arg3);
            if (arg0.coins_in_were_swapped_during_interval) {
                if (arg2 != arg0.interval_index_of_latest_execution_start) {
                    arg0.total_executed_intervals = arg0.total_executed_intervals + 1;
                    arg0.last_executed_interval_index = arg0.interval_index_of_latest_execution_start;
                    arg0.coins_in_were_swapped_during_interval = false;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(&mut arg0.locked_stablecoins), arg3), arg0.user);
                    let v0 = FailedDcaIntervalExecution{
                        order_id        : 0x2::object::id<DcaOrder<T0, T1, T2>>(arg0),
                        interval_number : arg0.total_executed_intervals,
                        interval_index  : arg0.interval_index_of_latest_execution_start,
                    };
                    0x2::event::emit<FailedDcaIntervalExecution>(v0);
                };
            };
        } else {
            let v1 = if (0x1::option::is_none<address>(&arg0.active_solver)) {
                true
            } else {
                let v2 = arg1.solver_address;
                0x1::option::borrow<address>(&arg0.active_solver) != &v2
            };
            if (v1) {
                abort 102
            };
            if (register_order_interval_fulfillment<T0, T1, T2>(arg0, arg1.previous_executed_interval_index, arg1.solver_address, arg3)) {
                abort 206
            };
        };
    }

    public fun pre_start_dca_order_execution<T0, T1, T2>(arg0: &0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::Guard<T0, T2>, arg1: &mut DcaOrder<T0, T1, T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SwapReceipt) {
        let v0 = decode_start_permission_and_check_signature<T0, T2>(arg0, arg2, arg3);
        let v1 = get_current_interval_index<T0, T1, T2>(arg1, arg4);
        handle_previous_intervals<T0, T1, T2>(arg1, &v0, v1, arg5);
        arg1.interval_index_of_latest_execution_start = v1;
        check_signed_permission_data<T0, T1, T2>(arg1, &v0, arg4, arg5);
        if (!v0.allow_swap) {
            abort 4
        };
        if (v0.min_stablecoins_amount < arg1.min_stablecoins_amount) {
            abort 106
        };
        if (arg1.coins_in_were_swapped_during_interval) {
            abort 7
        };
        arg1.coins_in_were_swapped_during_interval = true;
        let v2 = SwapReceipt{
            order_id               : 0x2::object::id<DcaOrder<T0, T1, T2>>(arg1),
            interval_number        : v0.interval_number_to_execute,
            min_stablecoins_amount : v0.min_stablecoins_amount,
        };
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.locked_coins_in, arg1.amount_in_per_interval), arg5), v2)
    }

    fun register_order_interval_fulfillment<T0, T1, T2>(arg0: &mut DcaOrder<T0, T1, T2>, arg1: u32, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : bool {
        if (arg0.last_executed_interval_index >= arg1) {
            abort 204
        };
        if (arg0.cancelled && arg0.total_executed_intervals == arg0.total_intervals) {
            abort 205
        };
        let v0 = DcaOrderIntervalFulfilled{
            order_id        : 0x2::object::uid_to_inner(&arg0.id),
            solver          : arg2,
            interval_number : arg0.total_executed_intervals + 1,
        };
        0x2::event::emit<DcaOrderIntervalFulfilled>(v0);
        if (arg0.cancelled) {
            arg0.total_executed_intervals = arg0.total_intervals;
        } else {
            arg0.total_executed_intervals = arg0.total_executed_intervals + 1;
        };
        arg0.last_executed_interval_index = arg1;
        0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::send_coins_and_destroy_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.locked_collateral), arg2, arg3);
        if (arg0.coins_in_were_swapped_during_interval) {
            arg0.coins_in_were_swapped_during_interval = false;
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(&mut arg0.locked_stablecoins), arg3), arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.locked_coins_in, arg0.amount_in_per_interval), arg3), arg2);
        };
        arg0.active_solver = 0x1::option::none<address>();
        if (get_interval_index<T0, T1, T2>(arg0, arg0.execution_deadline) > arg1) {
            arg0.execution_deadline = arg0.start_time + arg0.interval_duration * (arg1 as u64) - 1;
        };
        if (arg0.total_executed_intervals == arg0.total_intervals) {
            let v1 = DcaOrderFulfilled{order_id: 0x2::object::uid_to_inner(&arg0.id)};
            0x2::event::emit<DcaOrderFulfilled>(v1);
        };
        arg0.total_executed_intervals == arg0.total_intervals
    }

    fun safe_u64_to_u32(arg0: u64) : u32 {
        if (arg0 > 4294967295) {
            abort 8
        };
        (arg0 as u32)
    }

    public fun start_dca_order_execution<T0, T1, T2>(arg0: &mut 0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::Guard<T0, T2>, arg1: &mut DcaOrder<T0, T1, T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = decode_start_permission_and_check_signature<T0, T2>(arg0, arg2, arg3);
        let v1 = get_current_interval_index<T0, T1, T2>(arg1, arg6);
        handle_previous_intervals<T0, T1, T2>(arg1, &v0, v1, arg7);
        arg1.interval_index_of_latest_execution_start = v1;
        start_dca_order_execution_internal<T0, T1, T2>(arg0, arg1, v0, arg4, arg5, arg6, arg7);
    }

    public fun start_dca_order_execution_after_swap<T0, T1, T2>(arg0: &mut 0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::Guard<T0, T2>, arg1: &mut DcaOrder<T0, T1, T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T2>, arg8: SwapReceipt, arg9: &mut 0x2::tx_context::TxContext) {
        if (!arg1.coins_in_were_swapped_during_interval) {
            abort 5
        };
        let SwapReceipt {
            order_id               : v0,
            interval_number        : v1,
            min_stablecoins_amount : v2,
        } = arg8;
        let v3 = decode_start_permission_and_check_signature<T0, T2>(arg0, arg2, arg3);
        if (0x2::coin::value<T2>(&arg7) < v2) {
            abort 6
        };
        if (0x2::object::id<DcaOrder<T0, T1, T2>>(arg1) != v0) {
            abort 107
        };
        if (arg1.total_executed_intervals + 1 != v1) {
            abort 203
        };
        if (!v3.allow_swap) {
            abort 4
        };
        let v4 = DcaCoinInSwapped{
            order_id          : 0x2::object::id<DcaOrder<T0, T1, T2>>(arg1),
            interval_number   : v3.interval_number_to_execute,
            solver            : 0x2::tx_context::sender(arg9),
            stablecoin_amount : 0x2::coin::value<T2>(&arg7),
        };
        0x2::event::emit<DcaCoinInSwapped>(v4);
        0x2::balance::join<T2>(&mut arg1.locked_stablecoins, 0x2::coin::into_balance<T2>(arg7));
        start_dca_order_execution_internal<T0, T1, T2>(arg0, arg1, v3, arg4, arg5, arg6, arg9);
    }

    fun start_dca_order_execution_internal<T0, T1, T2>(arg0: &mut 0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::Guard<T0, T2>, arg1: &mut DcaOrder<T0, T1, T2>, arg2: SignedDcaPermissionData, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg2.collateral_amount != 0x2::coin::value<T0>(&arg3)) {
            abort 103
        };
        if (arg2.protocol_fee_amount != 0x2::coin::value<T0>(&arg4)) {
            abort 104
        };
        check_signed_permission_data<T0, T1, T2>(arg1, &arg2, arg5, arg6);
        if (0x2::balance::value<T0>(&arg1.locked_collateral) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.locked_collateral), arg6), arg1.user);
        };
        0x2::balance::join<T0>(&mut arg1.locked_collateral, 0x2::coin::into_balance<T0>(arg3));
        0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::increase_collected_fees<T0, T2>(arg0, 0x2::coin::into_balance<T0>(arg4));
        arg1.execution_deadline = arg2.solver_deadline;
        arg1.active_solver = 0x1::option::some<address>(0x2::tx_context::sender(arg6));
        let v0 = DcaExecutionStarted{
            order_id            : 0x2::object::id<DcaOrder<T0, T1, T2>>(arg1),
            interval_number     : arg2.interval_number_to_execute,
            solver              : 0x2::tx_context::sender(arg6),
            collateral_amount   : arg2.collateral_amount,
            protocol_fee_amount : arg2.protocol_fee_amount,
            solver_deadline     : arg2.solver_deadline,
        };
        0x2::event::emit<DcaExecutionStarted>(v0);
    }

    // decompiled from Move bytecode v6
}

