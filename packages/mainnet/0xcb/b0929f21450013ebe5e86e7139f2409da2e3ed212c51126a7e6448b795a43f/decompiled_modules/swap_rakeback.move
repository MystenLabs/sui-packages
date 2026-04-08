module 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::swap_rakeback {
    struct SwapRakebackReceipt<phantom T0, phantom T1, phantom T2: drop> {
        swap_id: 0x2::object::ID,
        actor: address,
        operator_type: 0x1::type_name::TypeName,
        source_coin_type: 0x1::type_name::TypeName,
        target_coin_type: 0x1::type_name::TypeName,
        source_amount: u64,
        source_rakeback_total_after_take: u64,
    }

    struct SwapRakebackStartedEvent<phantom T0, phantom T1, phantom T2: drop> has copy, drop {
        swap_id: 0x2::object::ID,
        actor: address,
        operator_type: 0x1::type_name::TypeName,
        source_coin_type: 0x1::type_name::TypeName,
        target_coin_type: 0x1::type_name::TypeName,
        source_amount: u64,
        source_rakeback_total_before_take: u64,
        source_rakeback_total_after_take: u64,
    }

    struct SwapRakebackSettledEvent<phantom T0, phantom T1, phantom T2: drop> has copy, drop {
        swap_id: 0x2::object::ID,
        actor: address,
        operator_type: 0x1::type_name::TypeName,
        source_coin_type: 0x1::type_name::TypeName,
        target_coin_type: 0x1::type_name::TypeName,
        source_amount: u64,
        target_amount: u64,
        refunded_source_amount: u64,
        source_rakeback_total_after_take: u64,
        source_rakeback_total_after_refund: u64,
        target_rakeback_total_before_put: u64,
        target_rakeback_total_after_put: u64,
    }

    struct SwapRakebackCancelledEvent<phantom T0, phantom T1, phantom T2: drop> has copy, drop {
        swap_id: 0x2::object::ID,
        actor: address,
        operator_type: 0x1::type_name::TypeName,
        source_coin_type: 0x1::type_name::TypeName,
        target_coin_type: 0x1::type_name::TypeName,
        source_amount: u64,
        refunded_source_amount: u64,
        source_rakeback_total_after_take: u64,
        source_rakeback_total_after_refund: u64,
    }

    public fun actor<T0, T1, T2: drop>(arg0: &SwapRakebackReceipt<T0, T1, T2>) : address {
        arg0.actor
    }

    fun assert_distinct_coin_types<T0, T1>() {
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<T1>(), 13835340007000244225);
    }

    fun deposit_target_balance<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: T1, arg2: 0x2::balance::Balance<T0>) : (u64, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0, 13835903102982815749);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_put_rakeback_pool<T0, T1>(arg0, arg1, arg2);
        (v0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::total_rakeback_pool_balance<T0>(arg0), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::total_rakeback_pool_balance<T0>(arg0))
    }

    fun new_receipt<T0, T1, T2: drop>(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SwapRakebackReceipt<T0, T1, T2> {
        SwapRakebackReceipt<T0, T1, T2>{
            swap_id                          : new_swap_id(arg3),
            actor                            : arg0,
            operator_type                    : 0x1::type_name::with_defining_ids<T2>(),
            source_coin_type                 : 0x1::type_name::with_defining_ids<T0>(),
            target_coin_type                 : 0x1::type_name::with_defining_ids<T1>(),
            source_amount                    : arg1,
            source_rakeback_total_after_take : arg2,
        }
    }

    fun new_swap_id(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        0x2::object::uid_to_inner(&v0)
    }

    public fun operator_refund_swap_balance<T0, T1, T2: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: T2, arg2: SwapRakebackReceipt<T0, T1, T2>, arg3: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        assert!(v0 > 0, 13836185866449846279);
        assert!(v0 == source_amount<T0, T1, T2>(&arg2), 13836467362901524489);
        let (_, v2) = refund_source_balance<T0, T2>(arg0, arg1, arg3);
        let SwapRakebackReceipt {
            swap_id                          : v3,
            actor                            : v4,
            operator_type                    : v5,
            source_coin_type                 : v6,
            target_coin_type                 : v7,
            source_amount                    : v8,
            source_rakeback_total_after_take : v9,
        } = arg2;
        let v10 = SwapRakebackCancelledEvent<T0, T1, T2>{
            swap_id                            : v3,
            actor                              : v4,
            operator_type                      : v5,
            source_coin_type                   : v6,
            target_coin_type                   : v7,
            source_amount                      : v8,
            refunded_source_amount             : v0,
            source_rakeback_total_after_take   : v9,
            source_rakeback_total_after_refund : v2,
        };
        0x2::event::emit<SwapRakebackCancelledEvent<T0, T1, T2>>(v10);
    }

    public fun operator_refund_swap_coin<T0, T1, T2: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: T2, arg2: SwapRakebackReceipt<T0, T1, T2>, arg3: 0x2::coin::Coin<T0>) {
        operator_refund_swap_balance<T0, T1, T2>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3));
    }

    public fun operator_settle_swap_balance<T0, T1, T2: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: T2, arg2: SwapRakebackReceipt<T0, T1, T2>, arg3: 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = deposit_target_balance<T1, T2>(arg0, arg1, arg3);
        let SwapRakebackReceipt {
            swap_id                          : v3,
            actor                            : v4,
            operator_type                    : v5,
            source_coin_type                 : v6,
            target_coin_type                 : v7,
            source_amount                    : v8,
            source_rakeback_total_after_take : v9,
        } = arg2;
        let v10 = SwapRakebackSettledEvent<T0, T1, T2>{
            swap_id                            : v3,
            actor                              : v4,
            operator_type                      : v5,
            source_coin_type                   : v6,
            target_coin_type                   : v7,
            source_amount                      : v8,
            target_amount                      : v0,
            refunded_source_amount             : 0,
            source_rakeback_total_after_take   : v9,
            source_rakeback_total_after_refund : v9,
            target_rakeback_total_before_put   : v1,
            target_rakeback_total_after_put    : v2,
        };
        0x2::event::emit<SwapRakebackSettledEvent<T0, T1, T2>>(v10);
    }

    public fun operator_settle_swap_coin<T0, T1, T2: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: T2, arg2: SwapRakebackReceipt<T0, T1, T2>, arg3: 0x2::coin::Coin<T1>) {
        operator_settle_swap_balance<T0, T1, T2>(arg0, arg1, arg2, 0x2::coin::into_balance<T1>(arg3));
    }

    public fun operator_settle_swap_with_refund_balance<T0, T1, T2: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: T2, arg2: T2, arg3: SwapRakebackReceipt<T0, T1, T2>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = deposit_target_balance<T1, T2>(arg0, arg2, arg5);
        let (v3, v4) = refund_source_balance<T0, T2>(arg0, arg1, arg4);
        let SwapRakebackReceipt {
            swap_id                          : v5,
            actor                            : v6,
            operator_type                    : v7,
            source_coin_type                 : v8,
            target_coin_type                 : v9,
            source_amount                    : v10,
            source_rakeback_total_after_take : v11,
        } = arg3;
        let v12 = SwapRakebackSettledEvent<T0, T1, T2>{
            swap_id                            : v5,
            actor                              : v6,
            operator_type                      : v7,
            source_coin_type                   : v8,
            target_coin_type                   : v9,
            source_amount                      : v10,
            target_amount                      : v0,
            refunded_source_amount             : v4 - v3,
            source_rakeback_total_after_take   : v11,
            source_rakeback_total_after_refund : v4,
            target_rakeback_total_before_put   : v1,
            target_rakeback_total_after_put    : v2,
        };
        0x2::event::emit<SwapRakebackSettledEvent<T0, T1, T2>>(v12);
    }

    public fun operator_settle_swap_with_refund_coin<T0, T1, T2: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: T2, arg2: T2, arg3: SwapRakebackReceipt<T0, T1, T2>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>) {
        operator_settle_swap_with_refund_balance<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5));
    }

    public fun operator_start_swap_balance<T0, T1, T2: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: T2, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, SwapRakebackReceipt<T0, T1, T2>) {
        assert_distinct_coin_types<T0, T1>();
        assert!(arg2 > 0, 13835622014553030659);
        let v0 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::total_rakeback_pool_balance<T0>(arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = new_receipt<T0, T1, T2>(v1, arg2, v0, arg3);
        let v3 = SwapRakebackStartedEvent<T0, T1, T2>{
            swap_id                           : v2.swap_id,
            actor                             : v2.actor,
            operator_type                     : v2.operator_type,
            source_coin_type                  : v2.source_coin_type,
            target_coin_type                  : v2.target_coin_type,
            source_amount                     : v2.source_amount,
            source_rakeback_total_before_take : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::total_rakeback_pool_balance<T0>(arg0),
            source_rakeback_total_after_take  : v0,
        };
        0x2::event::emit<SwapRakebackStartedEvent<T0, T1, T2>>(v3);
        (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_from_rakeback_pool<T0, T2>(arg0, arg1, arg2), v2)
    }

    public fun operator_start_swap_coin<T0, T1, T2: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: T2, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapRakebackReceipt<T0, T1, T2>) {
        let (v0, v1) = operator_start_swap_balance<T0, T1, T2>(arg0, arg1, arg2, arg3);
        (0x2::coin::from_balance<T0>(v0, arg3), v1)
    }

    fun refund_source_balance<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: T1, arg2: 0x2::balance::Balance<T0>) : (u64, u64) {
        assert!(0x2::balance::value<T0>(&arg2) > 0, 13836184685333839879);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_put_rakeback_pool<T0, T1>(arg0, arg1, arg2);
        (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::total_rakeback_pool_balance<T0>(arg0), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::total_rakeback_pool_balance<T0>(arg0))
    }

    public fun source_amount<T0, T1, T2: drop>(arg0: &SwapRakebackReceipt<T0, T1, T2>) : u64 {
        arg0.source_amount
    }

    public fun source_rakeback_total_after_take<T0, T1, T2: drop>(arg0: &SwapRakebackReceipt<T0, T1, T2>) : u64 {
        arg0.source_rakeback_total_after_take
    }

    public fun swap_id<T0, T1, T2: drop>(arg0: &SwapRakebackReceipt<T0, T1, T2>) : 0x2::object::ID {
        arg0.swap_id
    }

    // decompiled from Move bytecode v6
}

