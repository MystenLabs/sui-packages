module 0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::single_chain_dca_orders {
    struct DcaOrder<phantom T0> has key {
        id: 0x2::object::UID,
        user: address,
        locked_coins_in: 0x2::balance::Balance<T0>,
        amount_in_per_interval: u64,
        amount_out_min: u64,
        extra_transfer_amount_out_min: u64,
        start_time: u64,
        deadline: u64,
        total_intervals: u32,
        interval_duration: u64,
        secret_hash: vector<u8>,
        total_executed_intervals: u32,
        last_executed_interval_index: u32,
    }

    struct FulfillmentReceipt<phantom T0, phantom T1> {
        order_id: 0x2::object::ID,
        interval_number_to_execute: u32,
        min_amount_out: u64,
        protocol_fee_amount: u64,
        coin_out_receiver: address,
        extra_transfer_receiver: 0x1::option::Option<address>,
    }

    struct SignedPermissionData has drop {
        solver_address: address,
        order_id: 0x2::object::ID,
        interval_number_to_execute: u32,
        protocol_fee_amount: u64,
        min_amount_out: u64,
        solver_deadline: u64,
        secret_number: u64,
        coin_out_receiver: address,
        extra_transfer_receiver: 0x1::option::Option<address>,
    }

    struct DcaOrderCreated<phantom T0> has copy, drop {
        order_id: 0x2::object::ID,
        guard_id: 0x2::object::ID,
        user: address,
        locked_coins_in: u64,
        amount_in_per_interval: u64,
        amount_out_min: u64,
        extra_transfer_amount_out_min: u64,
        start_time: u64,
        deadline: u64,
        total_intervals: u32,
        interval_duration: u64,
        secret_hash: vector<u8>,
    }

    struct DcaOrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
    }

    struct DcaOrderIntervalFulfilled has copy, drop {
        order_id: 0x2::object::ID,
        solver: address,
        interval_number: u32,
        amount_out: u64,
    }

    struct DcaOrderFulfilled has copy, drop {
        order_id: 0x2::object::ID,
    }

    public fun cancel_dca_order<T0>(arg0: DcaOrder<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let DcaOrder {
            id                            : v0,
            user                          : v1,
            locked_coins_in               : v2,
            amount_in_per_interval        : _,
            amount_out_min                : _,
            extra_transfer_amount_out_min : _,
            start_time                    : _,
            deadline                      : _,
            total_intervals               : _,
            interval_duration             : _,
            secret_hash                   : _,
            total_executed_intervals      : _,
            last_executed_interval_index  : _,
        } = arg0;
        let v13 = v0;
        if (0x2::tx_context::sender(arg1) != v1) {
            abort 0
        };
        let v14 = DcaOrderCancelled{order_id: 0x2::object::uid_to_inner(&v13)};
        0x2::event::emit<DcaOrderCancelled>(v14);
        0x2::object::delete(v13);
        0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::send_coins_and_destroy_balance<T0>(v2, v1, arg1);
    }

    fun check_signed_permission_data<T0, T1, T2>(arg0: &DcaOrder<T0>, arg1: &SignedPermissionData, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        if (arg1.solver_address != 0x2::tx_context::sender(arg3)) {
            abort 1
        };
        if (arg1.order_id != 0x2::object::id<DcaOrder<T0>>(arg0)) {
            abort 102
        };
        if (arg1.solver_deadline > arg0.deadline || arg1.solver_deadline <= 0x2::clock::timestamp_ms(arg2)) {
            abort 105
        };
        if (arg0.last_executed_interval_index >= get_current_interval_index<T0>(arg0, arg2)) {
            abort 116
        };
        let v0 = 0x1::type_name::get<T2>();
        if (!0x1::type_name::is_primitive(&v0) && 0x1::option::is_none<address>(&arg1.extra_transfer_receiver)) {
            abort 110
        };
        if (arg1.interval_number_to_execute != arg0.total_executed_intervals + 1) {
            abort 115
        };
        if (0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::single_chain_helpers::get_secret_hash<T1, T2>(arg1.coin_out_receiver, arg1.extra_transfer_receiver, arg1.secret_number) != arg0.secret_hash) {
            abort 109
        };
    }

    public fun create_dca_order<T0, T1, T2>(arg0: &0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::Guard<T0, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u32, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T1>(&arg1) == 0 || arg3 == 0) {
            abort 2
        };
        if (arg6 < 2) {
            abort 112
        };
        let v0 = 0x2::clock::timestamp_ms(arg9);
        if (v0 >= arg5) {
            abort 107
        };
        if (v0 + (arg6 as u64) * arg7 > arg5 || arg7 < 1000) {
            abort 114
        };
        let v1 = DcaOrder<T1>{
            id                            : 0x2::object::new(arg10),
            user                          : 0x2::tx_context::sender(arg10),
            locked_coins_in               : 0x2::coin::into_balance<T1>(arg1),
            amount_in_per_interval        : arg2,
            amount_out_min                : arg3,
            extra_transfer_amount_out_min : arg4,
            start_time                    : v0,
            deadline                      : arg5,
            total_intervals               : arg6,
            interval_duration             : arg7,
            secret_hash                   : arg8,
            total_executed_intervals      : 0,
            last_executed_interval_index  : 0,
        };
        if (arg2 * (arg6 as u64) != 0x2::balance::value<T1>(&v1.locked_coins_in)) {
            abort 113
        };
        let v2 = DcaOrderCreated<T1>{
            order_id                      : 0x2::object::id<DcaOrder<T1>>(&v1),
            guard_id                      : 0x2::object::id<0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::Guard<T0, T2>>(arg0),
            user                          : v1.user,
            locked_coins_in               : 0x2::balance::value<T1>(&v1.locked_coins_in),
            amount_in_per_interval        : arg2,
            amount_out_min                : arg3,
            extra_transfer_amount_out_min : arg4,
            start_time                    : v1.start_time,
            deadline                      : v1.deadline,
            total_intervals               : v1.total_intervals,
            interval_duration             : v1.interval_duration,
            secret_hash                   : arg8,
        };
        0x2::event::emit<DcaOrderCreated<T1>>(v2);
        0x2::transfer::share_object<DcaOrder<T1>>(v1);
    }

    fun decode_signed_permission_data(arg0: vector<u8>) : SignedPermissionData {
        if (0x1::vector::length<u8>(&arg0) != 133 && 0x1::vector::length<u8>(&arg0) != 165) {
            abort 108
        };
        let v0 = 0x2::bcs::new(arg0);
        SignedPermissionData{
            solver_address             : 0x2::bcs::peel_address(&mut v0),
            order_id                   : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            interval_number_to_execute : 0x2::bcs::peel_u32(&mut v0),
            protocol_fee_amount        : 0x2::bcs::peel_u64(&mut v0),
            min_amount_out             : 0x2::bcs::peel_u64(&mut v0),
            solver_deadline            : 0x2::bcs::peel_u64(&mut v0),
            secret_number              : 0x2::bcs::peel_u64(&mut v0),
            coin_out_receiver          : 0x2::bcs::peel_address(&mut v0),
            extra_transfer_receiver    : 0x2::bcs::peel_option_address(&mut v0),
        }
    }

    fun decode_start_permission_and_check_signature<T0, T1>(arg0: &0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::Guard<T0, T1>, arg1: vector<u8>, arg2: vector<u8>) : SignedPermissionData {
        let v0 = 0x2::address::to_bytes(0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::get_actioneer<T0, T1>(arg0));
        if (!0x2::ed25519::ed25519_verify(&arg2, &v0, &arg1)) {
            abort 101
        };
        decode_signed_permission_data(arg1)
    }

    public fun fulfill_dca_order_interval<T0, T1, T2, T3, T4>(arg0: &mut 0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::Guard<T0, T1>, arg1: DcaOrder<T2>, arg2: FulfillmentReceipt<T3, T4>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T3>, arg5: 0x1::option::Option<0x2::coin::Coin<T4>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let FulfillmentReceipt {
            order_id                   : v0,
            interval_number_to_execute : v1,
            min_amount_out             : v2,
            protocol_fee_amount        : v3,
            coin_out_receiver          : v4,
            extra_transfer_receiver    : v5,
        } = arg2;
        let v6 = v5;
        if (0x2::object::uid_to_inner(&arg1.id) != v0) {
            abort 106
        };
        if (arg1.total_executed_intervals + 1 != v1) {
            abort 115
        };
        let v7 = 0x2::coin::value<T3>(&arg4);
        if (v7 < v2) {
            abort 3
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(arg4, v4);
        if (0x1::option::is_some<address>(&v6)) {
            if (0x1::option::is_none<0x2::coin::Coin<T4>>(&arg5)) {
                abort 111
            };
            let v8 = 0x1::option::extract<0x2::coin::Coin<T4>>(&mut arg5);
            if (0x2::coin::value<T4>(&v8) < arg1.extra_transfer_amount_out_min) {
                abort 3
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v8, 0x1::option::extract<address>(&mut v6));
        };
        if (v3 != 0x2::coin::value<T0>(&arg3)) {
            abort 103
        };
        0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::increase_collected_fees<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg3));
        0x1::option::destroy_none<0x2::coin::Coin<T4>>(arg5);
        let v9 = DcaOrderIntervalFulfilled{
            order_id        : 0x2::object::uid_to_inner(&arg1.id),
            solver          : 0x2::tx_context::sender(arg7),
            interval_number : v1,
            amount_out      : v7,
        };
        0x2::event::emit<DcaOrderIntervalFulfilled>(v9);
        arg1.total_executed_intervals = arg1.total_executed_intervals + 1;
        arg1.last_executed_interval_index = get_current_interval_index<T2>(&arg1, arg6);
        if (arg1.total_intervals == arg1.total_executed_intervals) {
            let DcaOrder {
                id                            : v10,
                user                          : _,
                locked_coins_in               : v12,
                amount_in_per_interval        : _,
                amount_out_min                : _,
                extra_transfer_amount_out_min : _,
                start_time                    : _,
                deadline                      : _,
                total_intervals               : _,
                interval_duration             : _,
                secret_hash                   : _,
                total_executed_intervals      : _,
                last_executed_interval_index  : _,
            } = arg1;
            let v23 = v10;
            0x2::balance::destroy_zero<T2>(v12);
            let v24 = DcaOrderFulfilled{order_id: 0x2::object::uid_to_inner(&v23)};
            0x2::event::emit<DcaOrderFulfilled>(v24);
            0x2::object::delete(v23);
        } else {
            0x2::transfer::share_object<DcaOrder<T2>>(arg1);
        };
    }

    fun get_current_interval_index<T0>(arg0: &DcaOrder<T0>, arg1: &0x2::clock::Clock) : u32 {
        get_interval_index<T0>(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    fun get_interval_index<T0>(arg0: &DcaOrder<T0>, arg1: u64) : u32 {
        safe_u64_to_u32((arg1 - arg0.start_time) / arg0.interval_duration + 1)
    }

    fun safe_u64_to_u32(arg0: u64) : u32 {
        if (arg0 > 4294967295) {
            abort 4
        };
        (arg0 as u32)
    }

    public fun start_dca_order_execution<T0, T1, T2, T3, T4>(arg0: &mut 0x7116eb34e1dbc4c1b10a1b79df22698ba91e1cfe221ef0551a70b38fb929eab8::guard::Guard<T0, T1>, arg1: &mut DcaOrder<T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, FulfillmentReceipt<T3, T4>) {
        let v0 = decode_start_permission_and_check_signature<T0, T1>(arg0, arg2, arg3);
        check_signed_permission_data<T2, T3, T4>(arg1, &v0, arg4, arg5);
        if (v0.min_amount_out < arg1.amount_out_min) {
            abort 104
        };
        let v1 = FulfillmentReceipt<T3, T4>{
            order_id                   : 0x2::object::id<DcaOrder<T2>>(arg1),
            interval_number_to_execute : v0.interval_number_to_execute,
            min_amount_out             : v0.min_amount_out,
            protocol_fee_amount        : v0.protocol_fee_amount,
            coin_out_receiver          : v0.coin_out_receiver,
            extra_transfer_receiver    : v0.extra_transfer_receiver,
        };
        (0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg1.locked_coins_in, arg1.amount_in_per_interval), arg5), v1)
    }

    // decompiled from Move bytecode v6
}

