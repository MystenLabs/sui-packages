module 0xfbef5b406bf93c5497efb1c6883704a8fa3cb7969964255636fb81d69df06c76::source_chain_guard {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Guard<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        collected_fees: 0x2::balance::Balance<T0>,
        auctioneer_pub_key: address,
    }

    struct Order<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        locked_collateral: 0x2::balance::Balance<T0>,
        locked_coins_in: 0x2::balance::Balance<T1>,
        locked_stablecoins: 0x2::balance::Balance<T2>,
        user: address,
        min_stablecoins_amount: u64,
        active_solver: 0x1::option::Option<address>,
        execution_deadline: u64,
        deadline: u64,
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

    struct GuardCreated<phantom T0, phantom T1> has copy, drop {
        guard_id: 0x2::object::ID,
        auctioneer_pub_key: address,
    }

    struct OrderCreated<phantom T0, phantom T1, phantom T2> has copy, drop {
        order_id: 0x2::object::ID,
        guard_id: 0x2::object::ID,
        user: address,
        locked_coins_in: u64,
        deadline: u64,
        dest_chain_id: u32,
        destination_address: 0x1::string::String,
        token_out: 0x1::string::String,
        amount_out_min: u128,
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

    struct AuctioneerUpdated has copy, drop {
        guard_id: 0x2::object::ID,
        auctioneer_pub_key: address,
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
        } = arg0;
        let v9 = v1;
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
        send_coins_and_destroy_balance<T1>(v2, v4, arg2);
        send_coins_and_destroy_balance<T2>(v3, v4, arg2);
        if (0x2::balance::value<T0>(&v9) == 0) {
            0x2::balance::destroy_zero<T0>(v9);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg2), v4);
        };
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

    public fun claim_tokens<T0, T1, T2>(arg0: &Guard<T0, T2>, arg1: Order<T0, T1, T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::address::to_bytes(arg0.auctioneer_pub_key);
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
        } = arg1;
        let v11 = v8;
        let v12 = v2;
        let v13 = decode_signed_success_confirmation_data(arg2);
        if (&v13.order_id != 0x2::object::uid_as_inner(&v12)) {
            abort 108
        };
        let v14 = if (0x1::option::is_none<address>(&v11)) {
            true
        } else if (0x1::option::borrow<address>(&v11) != &v1) {
            true
        } else {
            v1 != v13.solver_address
        };
        if (v14) {
            abort 2
        };
        let v15 = OrderFulfilled{order_id: 0x2::object::uid_to_inner(&v12)};
        0x2::event::emit<OrderFulfilled>(v15);
        0x2::object::delete(v12);
        send_coins_and_destroy_balance<T1>(v4, v1, arg4);
        send_coins_and_destroy_balance<T2>(v5, v1, arg4);
        0x2::coin::from_balance<T0>(v3, arg4)
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &AdminCap, arg1: &mut Guard<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg1.collected_fees);
        if (v0 == 0) {
            abort 3
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collected_fees, v0), arg2)
    }

    public fun create_guard<T0, T1>(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Guard<T0, T1>{
            id                 : 0x2::object::new(arg2),
            collected_fees     : 0x2::balance::zero<T0>(),
            auctioneer_pub_key : arg1,
        };
        let v1 = GuardCreated<T0, T1>{
            guard_id           : 0x2::object::id<Guard<T0, T1>>(&v0),
            auctioneer_pub_key : arg1,
        };
        0x2::event::emit<GuardCreated<T0, T1>>(v1);
        0x2::transfer::share_object<Guard<T0, T1>>(v0);
    }

    public fun create_order<T0, T1, T2>(arg0: &Guard<T0, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u32, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T1>(&arg1) == 0) {
            abort 3
        };
        let v0 = Order<T0, T1, T2>{
            id                     : 0x2::object::new(arg8),
            locked_collateral      : 0x2::balance::zero<T0>(),
            locked_coins_in        : 0x2::coin::into_balance<T1>(arg1),
            locked_stablecoins     : 0x2::balance::zero<T2>(),
            user                   : 0x2::tx_context::sender(arg8),
            min_stablecoins_amount : arg2,
            active_solver          : 0x1::option::none<address>(),
            execution_deadline     : 0,
            deadline               : arg3,
        };
        let v1 = OrderCreated<T0, T1, T2>{
            order_id            : 0x2::object::id<Order<T0, T1, T2>>(&v0),
            guard_id            : 0x2::object::id<Guard<T0, T2>>(arg0),
            user                : v0.user,
            locked_coins_in     : 0x2::balance::value<T1>(&v0.locked_coins_in),
            deadline            : v0.deadline,
            dest_chain_id       : arg4,
            destination_address : arg5,
            token_out           : arg6,
            amount_out_min      : arg7,
        };
        0x2::event::emit<OrderCreated<T0, T1, T2>>(v1);
        0x2::transfer::share_object<Order<T0, T1, T2>>(v0);
    }

    fun decode_signed_permission_data(arg0: vector<u8>) : SignedPermissionData {
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
        let v0 = 0x2::bcs::new(arg0);
        SignedSuccessConfirmationData{
            solver_address : 0x2::bcs::peel_address(&mut v0),
            order_id       : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
        }
    }

    fun decode_start_permission_and_check_signature<T0, T1>(arg0: &Guard<T0, T1>, arg1: vector<u8>, arg2: vector<u8>) : SignedPermissionData {
        let v0 = 0x2::address::to_bytes(arg0.auctioneer_pub_key);
        if (!0x2::ed25519::ed25519_verify(&arg2, &v0, &arg1)) {
            abort 101
        };
        decode_signed_permission_data(arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun pre_start_order_execution<T0, T1, T2>(arg0: &Guard<T0, T2>, arg1: &mut Order<T0, T1, T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SwapReceipt) {
        let v0 = decode_start_permission_and_check_signature<T0, T2>(arg0, arg2, arg3);
        check_signed_permission_data<T0, T1, T2>(arg1, &v0, arg4, arg5);
        if (!v0.allow_swap) {
            abort 4
        };
        if (v0.min_stablecoins_amount < arg1.min_stablecoins_amount) {
            abort 106
        };
        let v1 = 0x2::balance::value<T1>(&arg1.locked_coins_in);
        if (v1 == 0) {
            abort 7
        };
        let v2 = SwapReceipt{
            order_id               : 0x2::object::id<Order<T0, T1, T2>>(arg1),
            min_stablecoins_amount : v0.min_stablecoins_amount,
        };
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.locked_coins_in, v1), arg5), v2)
    }

    fun send_coins_and_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun set_auctioneer_pub_key<T0, T1>(arg0: &AdminCap, arg1: &mut Guard<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.auctioneer_pub_key = arg2;
        let v0 = AuctioneerUpdated{
            guard_id           : 0x2::object::id<Guard<T0, T1>>(arg1),
            auctioneer_pub_key : arg2,
        };
        0x2::event::emit<AuctioneerUpdated>(v0);
    }

    public fun start_order_execution<T0, T1, T2>(arg0: &mut Guard<T0, T2>, arg1: &mut Order<T0, T1, T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = decode_start_permission_and_check_signature<T0, T2>(arg0, arg2, arg3);
        start_order_execution_internal<T0, T1, T2>(arg0, arg1, v0, arg4, arg5, arg6, arg7);
    }

    public fun start_order_execution_after_swap<T0, T1, T2>(arg0: &mut Guard<T0, T2>, arg1: &mut Order<T0, T1, T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T2>, arg8: SwapReceipt, arg9: &mut 0x2::tx_context::TxContext) {
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

    fun start_order_execution_internal<T0, T1, T2>(arg0: &mut Guard<T0, T2>, arg1: &mut Order<T0, T1, T2>, arg2: SignedPermissionData, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg2.collateral_amount != 0x2::coin::value<T0>(&arg3)) {
            abort 103
        };
        if (arg2.protocol_fee_amount != 0x2::coin::value<T0>(&arg4)) {
            abort 104
        };
        check_signed_permission_data<T0, T1, T2>(arg1, &arg2, arg5, arg6);
        let v0 = 0x2::balance::value<T0>(&arg1.locked_collateral);
        if (v0 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.locked_collateral, v0), arg6), arg1.user);
        };
        0x2::balance::join<T0>(&mut arg1.locked_collateral, 0x2::coin::into_balance<T0>(arg3));
        0x2::balance::join<T0>(&mut arg0.collected_fees, 0x2::coin::into_balance<T0>(arg4));
        arg1.execution_deadline = arg2.solver_deadline;
        arg1.active_solver = 0x1::option::some<address>(0x2::tx_context::sender(arg6));
        let v1 = ExecutionStarted{
            order_id            : 0x2::object::id<Order<T0, T1, T2>>(arg1),
            solver              : 0x2::tx_context::sender(arg6),
            collateral_amount   : arg2.collateral_amount,
            protocol_fee_amount : arg2.protocol_fee_amount,
            solver_deadline     : arg2.solver_deadline,
        };
        0x2::event::emit<ExecutionStarted>(v1);
    }

    // decompiled from Move bytecode v6
}

