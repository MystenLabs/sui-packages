module 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::liquidity_mining_rewards {
    struct AddRewardWish<phantom T0, phantom T1, phantom T2> has copy, drop, store {
        market_id: 0x2::object::ID,
        protocol_app: 0x2::object::ID,
        reward_type: u8,
        amount: u64,
        start_time_ms: u64,
        end_time_ms: u64,
    }

    struct CancelRewardWish<phantom T0, phantom T1, phantom T2> has copy, drop, store {
        market_id: 0x2::object::ID,
        protocol_app: 0x2::object::ID,
        reward_type: u8,
        reward_index: u64,
    }

    struct CloseRewardWish<phantom T0, phantom T1, phantom T2> has copy, drop, store {
        market_id: 0x2::object::ID,
        protocol_app: 0x2::object::ID,
        reward_type: u8,
        reward_index: u64,
    }

    public fun fulfill_add_reward_wish<T0, T1, T2>(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg2: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_functional(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        let v0 = 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::take_locked_update<0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::TimeLock<AddRewardWish<T0, T1, T2>>>(arg0, 0x1::type_name::with_defining_ids<AddRewardWish<T0, T1, T2>>());
        assert!(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::is_active<AddRewardWish<T0, T1, T2>>(&v0, arg4), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::errors::time_locked_not_active());
        let v1 = 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::into_inner<AddRewardWish<T0, T1, T2>>(v0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::wish_event::emit_fulfill_wish_event<AddRewardWish<T0, T1, T2>>(v1);
        let AddRewardWish {
            market_id     : v2,
            protocol_app  : v3,
            reward_type   : v4,
            amount        : v5,
            start_time_ms : v6,
            end_time_ms   : v7,
        } = v1;
        assert!(v2 == 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>>(arg1), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::errors::invalid_market_id());
        assert!(v3 == 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp>(arg2), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::errors::invalid_protocol_app_id());
        assert!(0x2::coin::value<T2>(&arg3) == v5, 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::errors::invalid_coin_amount());
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::liquidity_mining_admin::add_liquidity_mining_rewards<T0, T1, T2>(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::lending_admin_cap(arg0), arg2, arg1, v4, arg3, v6, v7, arg4, arg5);
    }

    public fun fulfill_cancel_reward_wish<T0, T1, T2>(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg2: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_functional(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::take_locked_update<0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::TimeLock<CancelRewardWish<T0, T1, T2>>>(arg0, 0x1::type_name::with_defining_ids<CancelRewardWish<T0, T1, T2>>());
        assert!(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::is_active<CancelRewardWish<T0, T1, T2>>(&v0, arg3), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::errors::time_locked_not_active());
        let v1 = 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::into_inner<CancelRewardWish<T0, T1, T2>>(v0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::wish_event::emit_fulfill_wish_event<CancelRewardWish<T0, T1, T2>>(v1);
        let CancelRewardWish {
            market_id    : v2,
            protocol_app : v3,
            reward_type  : v4,
            reward_index : v5,
        } = v1;
        assert!(v2 == 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>>(arg1), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::errors::invalid_market_id());
        assert!(v3 == 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp>(arg2), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::errors::invalid_protocol_app_id());
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::liquidity_mining_admin::cancel_liquidity_mining_rewards<T0, T1, T2>(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::lending_admin_cap(arg0), arg2, arg1, v4, v5, arg3, arg4);
    }

    public fun fulfill_close_reward_wish<T0, T1, T2>(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg2: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_functional(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::take_locked_update<0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::TimeLock<CloseRewardWish<T0, T1, T2>>>(arg0, 0x1::type_name::with_defining_ids<CloseRewardWish<T0, T1, T2>>());
        assert!(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::is_active<CloseRewardWish<T0, T1, T2>>(&v0, arg3), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::errors::time_locked_not_active());
        let v1 = 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::into_inner<CloseRewardWish<T0, T1, T2>>(v0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::wish_event::emit_fulfill_wish_event<CloseRewardWish<T0, T1, T2>>(v1);
        let CloseRewardWish {
            market_id    : v2,
            protocol_app : v3,
            reward_type  : v4,
            reward_index : v5,
        } = v1;
        assert!(v2 == 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>>(arg1), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::errors::invalid_market_id());
        assert!(v3 == 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp>(arg2), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::errors::invalid_protocol_app_id());
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::liquidity_mining_admin::close_liquidity_mining_rewards<T0, T1, T2>(0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::lending_admin_cap(arg0), arg2, arg1, v4, v5, arg3, arg4);
    }

    public fun wish_add_reward<T0, T1, T2>(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg2: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_functional(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg8));
        let v0 = AddRewardWish<T0, T1, T2>{
            market_id     : 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>>(arg1),
            protocol_app  : 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp>(arg2),
            reward_type   : arg3,
            amount        : arg4,
            start_time_ms : arg5,
            end_time_ms   : arg6,
        };
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::wish_event::emit_new_wish_event<AddRewardWish<T0, T1, T2>>(v0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::store_locked_update<0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::TimeLock<AddRewardWish<T0, T1, T2>>>(arg0, 0x1::type_name::with_defining_ids<AddRewardWish<T0, T1, T2>>(), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::new_time_locked<AddRewardWish<T0, T1, T2>>(v0, arg7, 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::time_lock_duration_seconds(arg0), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_cancel_reward<T0, T1, T2>(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg2: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_functional(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        let v0 = CancelRewardWish<T0, T1, T2>{
            market_id    : 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>>(arg1),
            protocol_app : 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp>(arg2),
            reward_type  : arg3,
            reward_index : arg4,
        };
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::wish_event::emit_new_wish_event<CancelRewardWish<T0, T1, T2>>(v0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::store_locked_update<0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::TimeLock<CancelRewardWish<T0, T1, T2>>>(arg0, 0x1::type_name::with_defining_ids<CancelRewardWish<T0, T1, T2>>(), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::new_time_locked<CancelRewardWish<T0, T1, T2>>(v0, arg5, 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::time_lock_duration_seconds(arg0), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::time_lock_expriration_seconds(arg0)));
    }

    public fun wish_close_reward<T0, T1, T2>(arg0: &mut 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::DragonBallCollector, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg2: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_functional(arg0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        let v0 = CloseRewardWish<T0, T1, T2>{
            market_id    : 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>>(arg1),
            protocol_app : 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp>(arg2),
            reward_type  : arg3,
            reward_index : arg4,
        };
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::wish_event::emit_new_wish_event<CloseRewardWish<T0, T1, T2>>(v0);
        0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::store_locked_update<0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::TimeLock<CloseRewardWish<T0, T1, T2>>>(arg0, 0x1::type_name::with_defining_ids<CloseRewardWish<T0, T1, T2>>(), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::time_lock::new_time_locked<CloseRewardWish<T0, T1, T2>>(v0, arg5, 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::time_lock_duration_seconds(arg0), 0xbe5c9b1447e9b45ce67dbdc3450c2374606a0f01e410416f76c774f6aaf87016::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

