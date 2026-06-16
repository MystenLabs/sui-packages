module 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::router {
    public fun add_role(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::AdminCap, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg2: address, arg3: u8) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::add_role(arg0, arg1, arg2, arg3);
    }

    public fun remove_role(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::AdminCap, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg2: address, arg3: u8) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::remove_role(arg0, arg1, arg2, arg3);
    }

    public fun set_roles(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::AdminCap, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg2: address, arg3: u128) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::set_roles(arg0, arg1, arg2, arg3);
    }

    public fun accumulated_position_rewards(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::Pool, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::accumulated_position_rewards(arg0, arg1, arg2, arg3, arg4);
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::Pool, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::WrappedPositionNFT, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: u128, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::add_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        send_coin<T0>(0x2::coin::from_balance<T0>(v0, arg14), 0x2::tx_context::sender(arg14));
        send_coin<T1>(0x2::coin::from_balance<T1>(v1, arg14), 0x2::tx_context::sender(arg14));
    }

    public fun add_liquidity_fix_coin<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::Pool, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::WrappedPositionNFT, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::add_liquidity_fix_coin<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        send_coin<T0>(0x2::coin::from_balance<T0>(v0, arg14), 0x2::tx_context::sender(arg14));
        send_coin<T1>(0x2::coin::from_balance<T1>(v1, arg14), 0x2::tx_context::sender(arg14));
    }

    public fun add_rewarder<T0>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::Pool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::add_rewarder<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun close_position<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::Pool, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::WrappedPositionNFT, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::close_position<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        send_coin<T0>(0x2::coin::from_balance<T0>(v0, arg10), 0x2::tx_context::sender(arg10));
        send_coin<T1>(0x2::coin::from_balance<T1>(v1, arg10), 0x2::tx_context::sender(arg10));
    }

    public fun collect_clmm_reward<T0, T1, T2, T3>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::WrappedPositionNFT, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T0>, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        send_coin<T0>(0x2::coin::from_balance<T0>(0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::collect_clmm_reward<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), arg9), 0x2::tx_context::sender(arg9));
    }

    public fun collect_fee<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::WrappedPositionNFT, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::collect_fee<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        send_coin<T0>(0x2::coin::from_balance<T0>(v0, arg6), 0x2::tx_context::sender(arg6));
        send_coin<T1>(0x2::coin::from_balance<T1>(v1, arg6), 0x2::tx_context::sender(arg6));
    }

    public fun create_pool<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: u32, arg4: u32, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::create_pool<T0, T1, T2>(arg0, arg1, arg2, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg4), arg5, arg6);
    }

    public fun deposit<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::Pool, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::WrappedPositionNFT {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun harvest<T0>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::Pool, arg3: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::WrappedPositionNFT, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::harvest<T0>(arg0, arg1, arg2, arg3, arg4), arg5)
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::Pool, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::WrappedPositionNFT, arg7: u128, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::remove_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        send_coin<T0>(0x2::coin::from_balance<T0>(v0, arg11), 0x2::tx_context::sender(arg11));
        send_coin<T1>(0x2::coin::from_balance<T1>(v1, arg11), 0x2::tx_context::sender(arg11));
    }

    public fun update_effective_tick_range<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::Pool, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: u32, arg6: u32, arg7: u128, arg8: vector<0x2::object::ID>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::update_effective_tick_range<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg5), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg6), arg7, arg8, arg9, arg10, arg11);
    }

    public fun update_pool_allocate_point<T0>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::Pool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::update_pool_allocate_point<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun withdraw(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::Pool, arg3: 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::WrappedPositionNFT, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool::withdraw(arg0, arg1, arg2, arg3, arg4)
    }

    public fun create_rewarder<T0>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::create_rewarder<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun deposit_rewarder<T0>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = merge_coins<T0>(arg2, arg4);
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::deposit_rewarder<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        v0
    }

    public fun emergent_withdraw<T0>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::AdminCap, arg1: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg2: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg4)
    }

    public fun update_rewarder<T0>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::update_rewarder<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    public fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

