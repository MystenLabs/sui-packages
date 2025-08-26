module 0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::single_chain_limit_orders {
    struct LimitOrder<phantom T0> has key {
        id: 0x2::object::UID,
        user: address,
        locked_coins_in: 0x2::balance::Balance<T0>,
        amount_out_min: u64,
        extra_transfer_amount_out_min: u64,
        deadline: u64,
        secret_hash: vector<u8>,
    }

    struct FulfillmentReceipt<phantom T0, phantom T1> {
        order_id: 0x2::object::ID,
        min_amount_out: u64,
        protocol_fee_amount: u64,
        coin_out_receiver: address,
        extra_transfer_receiver: 0x1::option::Option<address>,
    }

    struct SignedPermissionData has drop {
        solver_address: address,
        order_id: 0x2::object::ID,
        protocol_fee_amount: u64,
        min_amount_out: u64,
        solver_deadline: u64,
        secret_number: u64,
        coin_out_receiver: address,
        extra_transfer_receiver: 0x1::option::Option<address>,
    }

    struct LimitOrderCreated<phantom T0> has copy, drop {
        order_id: 0x2::object::ID,
        guard_id: 0x2::object::ID,
        user: address,
        locked_coins_in: u64,
        amount_out_min: u64,
        extra_transfer_amount_out_min: u64,
        deadline: u64,
        secret_hash: vector<u8>,
    }

    struct OrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
    }

    struct OrderFulfilled has copy, drop {
        order_id: 0x2::object::ID,
        amount_out: u64,
    }

    public fun cancel_order<T0>(arg0: LimitOrder<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let LimitOrder {
            id                            : v0,
            user                          : v1,
            locked_coins_in               : v2,
            amount_out_min                : _,
            extra_transfer_amount_out_min : _,
            deadline                      : _,
            secret_hash                   : _,
        } = arg0;
        let v7 = v0;
        if (0x2::tx_context::sender(arg1) != v1) {
            abort 0
        };
        let v8 = OrderCancelled{order_id: 0x2::object::uid_to_inner(&v7)};
        0x2::event::emit<OrderCancelled>(v8);
        0x2::object::delete(v7);
        0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::send_coins_and_destroy_balance<T0>(v2, v1, arg1);
    }

    fun check_signed_permission_data<T0, T1, T2>(arg0: &LimitOrder<T0>, arg1: &SignedPermissionData, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        if (arg1.solver_address != 0x2::tx_context::sender(arg3)) {
            abort 1
        };
        if (arg1.order_id != 0x2::object::id<LimitOrder<T0>>(arg0)) {
            abort 102
        };
        if (arg1.solver_deadline > arg0.deadline || arg1.solver_deadline <= 0x2::clock::timestamp_ms(arg2)) {
            abort 105
        };
        let v0 = 0x1::type_name::get<T2>();
        if (!0x1::type_name::is_primitive(&v0) && 0x1::option::is_none<address>(&arg1.extra_transfer_receiver)) {
            abort 110
        };
        if (0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::single_chain_helpers::get_secret_hash<T1, T2>(arg1.coin_out_receiver, arg1.extra_transfer_receiver, arg1.secret_number) != arg0.secret_hash) {
            abort 109
        };
    }

    public fun create_limit_order<T0, T1, T2>(arg0: &0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::Guard<T0, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T1>(&arg1) == 0 || arg2 == 0) {
            abort 2
        };
        if (0x2::clock::timestamp_ms(arg6) >= arg4) {
            abort 107
        };
        let v0 = LimitOrder<T1>{
            id                            : 0x2::object::new(arg7),
            user                          : 0x2::tx_context::sender(arg7),
            locked_coins_in               : 0x2::coin::into_balance<T1>(arg1),
            amount_out_min                : arg2,
            extra_transfer_amount_out_min : arg3,
            deadline                      : arg4,
            secret_hash                   : arg5,
        };
        let v1 = LimitOrderCreated<T1>{
            order_id                      : 0x2::object::id<LimitOrder<T1>>(&v0),
            guard_id                      : 0x2::object::id<0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::Guard<T0, T2>>(arg0),
            user                          : v0.user,
            locked_coins_in               : 0x2::balance::value<T1>(&v0.locked_coins_in),
            amount_out_min                : arg2,
            extra_transfer_amount_out_min : arg3,
            deadline                      : v0.deadline,
            secret_hash                   : arg5,
        };
        0x2::event::emit<LimitOrderCreated<T1>>(v1);
        0x2::transfer::share_object<LimitOrder<T1>>(v0);
    }

    fun decode_signed_permission_data(arg0: vector<u8>) : SignedPermissionData {
        if (0x1::vector::length<u8>(&arg0) != 129 && 0x1::vector::length<u8>(&arg0) != 161) {
            abort 108
        };
        let v0 = 0x2::bcs::new(arg0);
        SignedPermissionData{
            solver_address          : 0x2::bcs::peel_address(&mut v0),
            order_id                : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            protocol_fee_amount     : 0x2::bcs::peel_u64(&mut v0),
            min_amount_out          : 0x2::bcs::peel_u64(&mut v0),
            solver_deadline         : 0x2::bcs::peel_u64(&mut v0),
            secret_number           : 0x2::bcs::peel_u64(&mut v0),
            coin_out_receiver       : 0x2::bcs::peel_address(&mut v0),
            extra_transfer_receiver : 0x2::bcs::peel_option_address(&mut v0),
        }
    }

    fun decode_start_permission_and_check_signature<T0, T1>(arg0: &0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::Guard<T0, T1>, arg1: vector<u8>, arg2: vector<u8>) : SignedPermissionData {
        let v0 = 0x2::address::to_bytes(0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::get_actioneer<T0, T1>(arg0));
        if (!0x2::ed25519::ed25519_verify(&arg2, &v0, &arg1)) {
            abort 101
        };
        decode_signed_permission_data(arg1)
    }

    public fun fulfill_order<T0, T1, T2, T3, T4>(arg0: &mut 0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::Guard<T0, T1>, arg1: LimitOrder<T2>, arg2: FulfillmentReceipt<T3, T4>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T3>, arg5: 0x1::option::Option<0x2::coin::Coin<T4>>, arg6: &mut 0x2::tx_context::TxContext) {
        let LimitOrder {
            id                            : v0,
            user                          : _,
            locked_coins_in               : v2,
            amount_out_min                : _,
            extra_transfer_amount_out_min : v4,
            deadline                      : _,
            secret_hash                   : _,
        } = arg1;
        let v7 = v0;
        let FulfillmentReceipt {
            order_id                : v8,
            min_amount_out          : v9,
            protocol_fee_amount     : v10,
            coin_out_receiver       : v11,
            extra_transfer_receiver : v12,
        } = arg2;
        let v13 = v12;
        if (0x2::object::uid_to_inner(&v7) != v8) {
            abort 106
        };
        let v14 = 0x2::coin::value<T3>(&arg4);
        if (v14 < v9) {
            abort 3
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(arg4, v11);
        if (0x1::option::is_some<address>(&v13)) {
            if (0x1::option::is_none<0x2::coin::Coin<T4>>(&arg5)) {
                abort 111
            };
            let v15 = 0x1::option::extract<0x2::coin::Coin<T4>>(&mut arg5);
            if (0x2::coin::value<T4>(&v15) < v4) {
                abort 3
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v15, 0x1::option::extract<address>(&mut v13));
        };
        if (v10 != 0x2::coin::value<T0>(&arg3)) {
            abort 103
        };
        0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::increase_collected_fees<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg3));
        0x1::option::destroy_none<0x2::coin::Coin<T4>>(arg5);
        let v16 = OrderFulfilled{
            order_id   : 0x2::object::uid_to_inner(&v7),
            amount_out : v14,
        };
        0x2::event::emit<OrderFulfilled>(v16);
        0x2::balance::destroy_zero<T2>(v2);
        0x2::object::delete(v7);
    }

    public fun start_order_execution<T0, T1, T2, T3, T4>(arg0: &mut 0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::Guard<T0, T1>, arg1: &mut LimitOrder<T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, FulfillmentReceipt<T3, T4>) {
        let v0 = decode_start_permission_and_check_signature<T0, T1>(arg0, arg2, arg3);
        check_signed_permission_data<T2, T3, T4>(arg1, &v0, arg4, arg5);
        if (v0.min_amount_out < arg1.amount_out_min) {
            abort 104
        };
        let v1 = FulfillmentReceipt<T3, T4>{
            order_id                : 0x2::object::id<LimitOrder<T2>>(arg1),
            min_amount_out          : v0.min_amount_out,
            protocol_fee_amount     : v0.protocol_fee_amount,
            coin_out_receiver       : v0.coin_out_receiver,
            extra_transfer_receiver : v0.extra_transfer_receiver,
        };
        (0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(&mut arg1.locked_coins_in), arg5), v1)
    }

    // decompiled from Move bytecode v6
}

