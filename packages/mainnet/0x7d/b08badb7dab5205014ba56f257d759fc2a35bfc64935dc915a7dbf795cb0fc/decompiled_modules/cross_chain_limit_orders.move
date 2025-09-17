module 0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::cross_chain_limit_orders {
    struct Order<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        locked_collateral: 0x2::balance::Balance<T0>,
        locked_coins_in: 0x2::balance::Balance<T1>,
        locked_stablecoins: 0x2::balance::Balance<T2>,
        user: address,
        min_stablecoins_amount: u64,
        active_solver: 0x1::option::Option<address>,
        execution_deadline: u64,
        deadline: u64,
        execution_details_hash: vector<u8>,
    }

    struct SwapReceipt {
        order_id: 0x2::object::ID,
        min_stablecoins_amount: u64,
    }

    struct SignedPermissionData has drop {
        solver_address: address,
        order_id: 0x2::object::ID,
        collateral_amount: u64,
        protocol_fee_amount: u64,
        allow_swap: bool,
        min_stablecoins_amount: u64,
        solver_deadline: u64,
    }

    struct SignedSuccessConfirmationData has drop {
        solver_address: address,
        order_id: 0x2::object::ID,
    }

    struct OrderCreated<phantom T0, phantom T1, phantom T2> has copy, drop {
        order_id: 0x2::object::ID,
        guard_id: 0x2::object::ID,
        user: address,
        locked_coins_in: u64,
        deadline: u64,
        execution_details_hash: vector<u8>,
    }

    struct OrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
    }

    struct ExecutionStarted has copy, drop {
        order_id: 0x2::object::ID,
        solver: address,
        collateral_amount: u64,
        protocol_fee_amount: u64,
        solver_deadline: u64,
    }

    struct CoinInSwapped has copy, drop {
        order_id: 0x2::object::ID,
        solver: address,
        stablecoin_amount: u64,
    }

    struct OrderFulfilled has copy, drop {
        order_id: 0x2::object::ID,
    }

    public fun cancel_order<T0, T1, T2>(arg0: Order<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let Order {
            id                     : v0,
            locked_collateral      : v1,
            locked_coins_in        : v2,
            locked_stablecoins     : v3,
            user                   : v4,
            min_stablecoins_amount : _,
            active_solver          : _,
            execution_deadline     : v7,
            deadline               : v8,
            execution_details_hash : _,
        } = arg0;
        let v10 = v0;
        if (0x2::tx_context::sender(arg2) != v4) {
            abort 0
        };
        let v11 = 0x2::clock::timestamp_ms(arg1);
        if (v11 <= v7 && v11 <= v8) {
            abort 1
        };
        let v12 = OrderCancelled{order_id: 0x2::object::uid_to_inner(&v10)};
        0x2::event::emit<OrderCancelled>(v12);
        0x2::object::delete(v10);
        0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::send_coins_and_destroy_balance<T1>(v2, v4, arg2);
        0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::send_coins_and_destroy_balance<T2>(v3, v4, arg2);
        0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::send_coins_and_destroy_balance<T0>(v1, v4, arg2);
    }

    fun check_signed_permission_data<T0, T1, T2>(arg0: &Order<T0, T1, T2>, arg1: &SignedPermissionData, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        if (arg1.solver_address != 0x2::tx_context::sender(arg3)) {
            abort 2
        };
        if (arg1.order_id != 0x2::object::id<Order<T0, T1, T2>>(arg0)) {
            abort 102
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg1.solver_deadline > arg0.deadline || arg1.solver_deadline <= v0) {
            abort 105
        };
        if (arg0.execution_deadline > v0) {
            abort 1
        };
    }

    public fun claim_tokens<T0, T1, T2>(arg0: &0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::Guard<T0, T2>, arg1: Order<T0, T1, T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::address::to_bytes(0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::get_actioneer<T0, T2>(arg0));
        if (!0x2::ed25519::ed25519_verify(&arg3, &v0, &arg2)) {
            abort 101
        };
        let v1 = 0x2::tx_context::sender(arg4);
        let Order {
            id                     : v2,
            locked_collateral      : v3,
            locked_coins_in        : v4,
            locked_stablecoins     : v5,
            user                   : _,
            min_stablecoins_amount : _,
            active_solver          : v8,
            execution_deadline     : _,
            deadline               : _,
            execution_details_hash : _,
        } = arg1;
        let v12 = v8;
        let v13 = v2;
        let v14 = decode_signed_success_confirmation_data(arg2);
        if (&v14.order_id != 0x2::object::uid_as_inner(&v13)) {
            abort 108
        };
        let v15 = if (0x1::option::is_none<address>(&v12)) {
            true
        } else if (0x1::option::borrow<address>(&v12) != &v1) {
            true
        } else {
            v1 != v14.solver_address
        };
        if (v15) {
            abort 2
        };
        let v16 = OrderFulfilled{order_id: 0x2::object::uid_to_inner(&v13)};
        0x2::event::emit<OrderFulfilled>(v16);
        0x2::object::delete(v13);
        0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::send_coins_and_destroy_balance<T1>(v4, v1, arg4);
        0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::send_coins_and_destroy_balance<T2>(v5, v1, arg4);
        0x2::coin::from_balance<T0>(v3, arg4)
    }

    public fun create_order<T0, T1, T2>(arg0: &0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::Guard<T0, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T1>(&arg1) == 0 || arg2 == 0) {
            abort 3
        };
        if (0x2::clock::timestamp_ms(arg5) >= arg3) {
            abort 109
        };
        let v0 = Order<T0, T1, T2>{
            id                     : 0x2::object::new(arg6),
            locked_collateral      : 0x2::balance::zero<T0>(),
            locked_coins_in        : 0x2::coin::into_balance<T1>(arg1),
            locked_stablecoins     : 0x2::balance::zero<T2>(),
            user                   : 0x2::tx_context::sender(arg6),
            min_stablecoins_amount : arg2,
            active_solver          : 0x1::option::none<address>(),
            execution_deadline     : 0,
            deadline               : arg3,
            execution_details_hash : arg4,
        };
        let v1 = OrderCreated<T0, T1, T2>{
            order_id               : 0x2::object::id<Order<T0, T1, T2>>(&v0),
            guard_id               : 0x2::object::id<0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::Guard<T0, T2>>(arg0),
            user                   : v0.user,
            locked_coins_in        : 0x2::balance::value<T1>(&v0.locked_coins_in),
            deadline               : v0.deadline,
            execution_details_hash : arg4,
        };
        0x2::event::emit<OrderCreated<T0, T1, T2>>(v1);
        0x2::transfer::share_object<Order<T0, T1, T2>>(v0);
    }

    fun decode_signed_permission_data(arg0: vector<u8>) : SignedPermissionData {
        if (0x1::vector::length<u8>(&arg0) != 97) {
            abort 110
        };
        let v0 = 0x2::bcs::new(arg0);
        SignedPermissionData{
            solver_address         : 0x2::bcs::peel_address(&mut v0),
            order_id               : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            collateral_amount      : 0x2::bcs::peel_u64(&mut v0),
            protocol_fee_amount    : 0x2::bcs::peel_u64(&mut v0),
            allow_swap             : 0x2::bcs::peel_bool(&mut v0),
            min_stablecoins_amount : 0x2::bcs::peel_u64(&mut v0),
            solver_deadline        : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    fun decode_signed_success_confirmation_data(arg0: vector<u8>) : SignedSuccessConfirmationData {
        if (0x1::vector::length<u8>(&arg0) != 64) {
            abort 111
        };
        let v0 = 0x2::bcs::new(arg0);
        SignedSuccessConfirmationData{
            solver_address : 0x2::bcs::peel_address(&mut v0),
            order_id       : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
        }
    }

    fun decode_start_permission_and_check_signature<T0, T1>(arg0: &0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::Guard<T0, T1>, arg1: vector<u8>, arg2: vector<u8>) : SignedPermissionData {
        let v0 = 0x2::address::to_bytes(0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::get_actioneer<T0, T1>(arg0));
        if (!0x2::ed25519::ed25519_verify(&arg2, &v0, &arg1)) {
            abort 101
        };
        decode_signed_permission_data(arg1)
    }

    public fun pre_start_order_execution<T0, T1, T2>(arg0: &0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::Guard<T0, T2>, arg1: &mut Order<T0, T1, T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SwapReceipt) {
        let v0 = decode_start_permission_and_check_signature<T0, T2>(arg0, arg2, arg3);
        check_signed_permission_data<T0, T1, T2>(arg1, &v0, arg4, arg5);
        if (!v0.allow_swap) {
            abort 4
        };
        if (v0.min_stablecoins_amount < arg1.min_stablecoins_amount) {
            abort 106
        };
        if (0x2::balance::value<T1>(&arg1.locked_coins_in) == 0) {
            abort 7
        };
        let v1 = SwapReceipt{
            order_id               : 0x2::object::id<Order<T0, T1, T2>>(arg1),
            min_stablecoins_amount : v0.min_stablecoins_amount,
        };
        (0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.locked_coins_in), arg5), v1)
    }

    public fun start_order_execution<T0, T1, T2>(arg0: &mut 0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::Guard<T0, T2>, arg1: &mut Order<T0, T1, T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = decode_start_permission_and_check_signature<T0, T2>(arg0, arg2, arg3);
        start_order_execution_internal<T0, T1, T2>(arg0, arg1, v0, arg4, arg5, arg6, arg7);
    }

    public fun start_order_execution_after_swap<T0, T1, T2>(arg0: &mut 0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::Guard<T0, T2>, arg1: &mut Order<T0, T1, T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T2>, arg8: SwapReceipt, arg9: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T1>(&arg1.locked_coins_in) != 0) {
            abort 5
        };
        let SwapReceipt {
            order_id               : v0,
            min_stablecoins_amount : v1,
        } = arg8;
        let v2 = decode_start_permission_and_check_signature<T0, T2>(arg0, arg2, arg3);
        if (0x2::coin::value<T2>(&arg7) < v1) {
            abort 6
        };
        if (0x2::object::id<Order<T0, T1, T2>>(arg1) != v0) {
            abort 107
        };
        if (!v2.allow_swap) {
            abort 4
        };
        let v3 = CoinInSwapped{
            order_id          : 0x2::object::id<Order<T0, T1, T2>>(arg1),
            solver            : 0x2::tx_context::sender(arg9),
            stablecoin_amount : 0x2::coin::value<T2>(&arg7),
        };
        0x2::event::emit<CoinInSwapped>(v3);
        0x2::balance::join<T2>(&mut arg1.locked_stablecoins, 0x2::coin::into_balance<T2>(arg7));
        start_order_execution_internal<T0, T1, T2>(arg0, arg1, v2, arg4, arg5, arg6, arg9);
    }

    fun start_order_execution_internal<T0, T1, T2>(arg0: &mut 0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::Guard<T0, T2>, arg1: &mut Order<T0, T1, T2>, arg2: SignedPermissionData, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
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
        0x14bd4a581cbaf2239a9c1472ca2f751a1d262c4872476eab700bfba7eab0ccc5::guard::increase_collected_fees<T0, T2>(arg0, 0x2::coin::into_balance<T0>(arg4));
        arg1.execution_deadline = arg2.solver_deadline;
        arg1.active_solver = 0x1::option::some<address>(0x2::tx_context::sender(arg6));
        let v0 = ExecutionStarted{
            order_id            : 0x2::object::id<Order<T0, T1, T2>>(arg1),
            solver              : 0x2::tx_context::sender(arg6),
            collateral_amount   : arg2.collateral_amount,
            protocol_fee_amount : arg2.protocol_fee_amount,
            solver_deadline     : arg2.solver_deadline,
        };
        0x2::event::emit<ExecutionStarted>(v0);
    }

    // decompiled from Move bytecode v6
}

