module 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::liquidity_mining_admin {
    struct LiquidityMiningRewardAddedEvent has copy, drop {
        market: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        reward_coin_type: 0x1::type_name::TypeName,
        reward_type: u8,
        amount: u64,
        start_time_ms: u64,
        end_time_ms: u64,
    }

    struct LiquidityMiningRewardCancelledEvent has copy, drop {
        market: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        reward_coin_type: 0x1::type_name::TypeName,
        reward_type: u8,
        reward_index: u64,
        refunded_amount: u64,
    }

    struct LiquidityMiningRewardClosedEvent has copy, drop {
        market: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        reward_coin_type: 0x1::type_name::TypeName,
        reward_type: u8,
        reward_index: u64,
        refunded_amount: u64,
    }

    public fun add_liquidity_mining_rewards<T0, T1, T2>(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::AdminCap, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg3: u8, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T2>(&arg4) != 0, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::invalid_params_error());
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::validate_market<T0>(arg1, arg2);
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::liquidity_miner::add_reward<T0, T1, T2>(0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::borrow_liquidity_mining_mut<T0>(arg2), arg3, arg4, arg5, arg6, arg7, arg8);
        let v0 = LiquidityMiningRewardAddedEvent{
            market           : 0x2::object::id<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>>(arg2),
            coin_type        : 0x1::type_name::with_defining_ids<T1>(),
            reward_coin_type : 0x1::type_name::with_defining_ids<T2>(),
            reward_type      : arg3,
            amount           : 0x2::coin::value<T2>(&arg4),
            start_time_ms    : arg5,
            end_time_ms      : arg6,
        };
        0x2::event::emit<LiquidityMiningRewardAddedEvent>(v0);
    }

    public fun cancel_liquidity_mining_rewards<T0, T1, T2>(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::AdminCap, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::validate_market<T0>(arg1, arg2);
        let v0 = 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::liquidity_miner::cancel_reward<T0, T1, T2>(0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::borrow_liquidity_mining_mut<T0>(arg2), arg3, arg4, arg5);
        let v1 = LiquidityMiningRewardCancelledEvent{
            market           : 0x2::object::id<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>>(arg2),
            coin_type        : 0x1::type_name::with_defining_ids<T1>(),
            reward_coin_type : 0x1::type_name::with_defining_ids<T2>(),
            reward_type      : arg3,
            reward_index     : arg4,
            refunded_amount  : 0x2::balance::value<T2>(&v0),
        };
        0x2::event::emit<LiquidityMiningRewardCancelledEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg6), 0x2::tx_context::sender(arg6));
    }

    public fun close_liquidity_mining_rewards<T0, T1, T2>(arg0: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::AdminCap, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::validate_market<T0>(arg1, arg2);
        let v0 = 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::liquidity_miner::close_reward<T0, T1, T2>(0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::borrow_liquidity_mining_mut<T0>(arg2), arg3, arg4, arg5);
        let v1 = LiquidityMiningRewardClosedEvent{
            market           : 0x2::object::id<0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>>(arg2),
            coin_type        : 0x1::type_name::with_defining_ids<T1>(),
            reward_coin_type : 0x1::type_name::with_defining_ids<T2>(),
            reward_type      : arg3,
            reward_index     : arg4,
            refunded_amount  : 0x2::balance::value<T2>(&v0),
        };
        0x2::event::emit<LiquidityMiningRewardClosedEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg6), 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

