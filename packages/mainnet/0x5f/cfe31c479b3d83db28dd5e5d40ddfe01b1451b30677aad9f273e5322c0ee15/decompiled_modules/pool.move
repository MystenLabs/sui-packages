module 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct WrappedPositionNFT has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        nft: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT,
        url: 0x1::string::String,
    }

    struct PositionRewardInfo has copy, drop, store {
        reward: u128,
        reward_debt: u128,
        reward_harvested: u64,
    }

    struct WrappedPositionInfo has store {
        id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nft_address: address,
        tick_lower: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_upper: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        liquidity: u128,
        effective_tick_lower: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        effective_tick_upper: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        sqrt_price: u128,
        share: u128,
        rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionRewardInfo>,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        clmm_pool_id: 0x2::object::ID,
        effective_tick_lower: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        effective_tick_upper: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        sqrt_price: u128,
        total_share: u128,
        rewarders: vector<0x1::type_name::TypeName>,
        positions: 0x2::linked_table::LinkedTable<0x2::object::ID, WrappedPositionInfo>,
        is_effective_range_migrating: bool,
    }

    struct PoolInvalidPositions has store, key {
        id: 0x2::object::UID,
        positions: 0x2::linked_table::LinkedTable<0x2::object::ID, WrappedPositionInfo>,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        sqrt_price: u128,
        effective_tick_lower: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        effective_tick_upper: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
    }

    struct UpdateEffectiveTickRangeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        effective_tick_lower: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        effective_tick_upper: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        sqrt_price: u128,
        start: vector<0x2::object::ID>,
        end: 0x1::option::Option<0x2::object::ID>,
        limit: u64,
    }

    struct AddRewardEvent has copy, drop {
        pool_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        rewarder: 0x1::type_name::TypeName,
        allocate_point: u64,
    }

    struct UpdatePoolAllocatePointEvent has copy, drop {
        pool_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        old_allocate_point: u64,
        new_allocate_point: u64,
    }

    struct DepositEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        effective_tick_lower: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        effective_tick_upper: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        sqrt_price: u128,
        liquidity: u128,
        share: u128,
        pool_total_share: u128,
    }

    struct WithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        share: u128,
    }

    struct HarvestEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct AccumulatedPositionRewardsEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct AddLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        effective_tick_lower: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        effective_tick_upper: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        sqrt_price: u128,
        old_liquidity: u128,
        new_liquidity: u128,
        old_share: u128,
        new_share: u128,
    }

    struct AddLiquidityFixCoinEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        effective_tick_lower: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        effective_tick_upper: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        sqrt_price: u128,
        old_liquidity: u128,
        new_liquidity: u128,
        old_share: u128,
        new_share: u128,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        effective_tick_lower: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        effective_tick_upper: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        sqrt_price: u128,
        old_liquidity: u128,
        new_liquidity: u128,
        old_share: u128,
        new_share: u128,
    }

    struct CollectFeeEvent has copy, drop {
        wrapped_position_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct ClosePositionEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct MigrateInvalidPoolPositionsEvent has copy, drop {
        pool_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        start_idx: 0x1::option::Option<0x2::object::ID>,
        end: 0x1::option::Option<0x2::object::ID>,
    }

    public fun accumulated_position_rewards(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut Pool, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        assert_not_effective_range_migrating(arg2);
        assert!(0x2::linked_table::contains<0x2::object::ID, WrappedPositionInfo>(&arg2.positions, arg3), 14);
        let v0 = 0x2::linked_table::borrow_mut<0x2::object::ID, WrappedPositionInfo>(&mut arg2.positions, arg3);
        let v1 = v0.share;
        update_position_share(v0, 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::pool_rewards_settle(arg1, arg2.rewarders, arg2.clmm_pool_id, arg4), v1);
        let v2 = 0;
        let v3 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        while (v2 < 0x2::vec_map::length<0x1::type_name::TypeName, PositionRewardInfo>(&v0.rewards)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, PositionRewardInfo>(&v0.rewards, v2);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v3, *v4, (v5.reward as u64));
            v2 = v2 + 1;
        };
        let v6 = AccumulatedPositionRewardsEvent{
            pool_id             : 0x2::object::id<Pool>(arg2),
            wrapped_position_id : arg3,
            nft_id              : v0.nft_id,
            rewards             : v3,
        };
        0x2::event::emit<AccumulatedPositionRewardsEvent>(v6);
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut Pool, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut WrappedPositionNFT, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: u128, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        assert_not_effective_range_migrating(arg2);
        assert!(0x2::object::id<Pool>(arg2) == arg6.pool_id, 2);
        assert!(arg2.clmm_pool_id == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 3);
        let v0 = 0x2::object::id<WrappedPositionNFT>(arg6);
        assert!(0x2::linked_table::contains<0x2::object::ID, WrappedPositionInfo>(&arg2.positions, v0), 14);
        let v1 = 0x2::linked_table::borrow<0x2::object::ID, WrappedPositionInfo>(&arg2.positions, v0);
        let v2 = v1.liquidity;
        let v3 = v1.share;
        assert!(arg11 > 0, 13);
        let (v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_amount_for_liquidity(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v1.tick_lower), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v1.tick_upper), arg11);
        let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity_with_return_<T0, T1, T2>(arg3, arg4, 0x1::vector::singleton<0x2::coin::Coin<T0>>(arg7), 0x1::vector::singleton<0x2::coin::Coin<T1>>(arg8), &mut arg6.nft, (amount_desired_for_requested_liquidity(v4) as u64), (amount_desired_for_requested_liquidity(v5) as u64), arg9, arg10, arg13, arg12, arg5, arg14);
        let (_, _, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg4, v1.nft_address);
        assert!(v10 > v2, 13);
        let v11 = update_position_liquidity(arg1, arg2, arg6, v10, arg12);
        let v12 = AddLiquidityEvent{
            pool_id              : 0x2::object::id<Pool>(arg2),
            wrapped_position_id  : v0,
            clmm_pool_id         : arg2.clmm_pool_id,
            nft_id               : v1.nft_id,
            effective_tick_lower : arg2.effective_tick_lower,
            effective_tick_upper : arg2.effective_tick_upper,
            sqrt_price           : arg2.sqrt_price,
            old_liquidity        : v2,
            new_liquidity        : v10,
            old_share            : v3,
            new_share            : v11,
        };
        0x2::event::emit<AddLiquidityEvent>(v12);
        (0x2::coin::into_balance<T0>(v6), 0x2::coin::into_balance<T1>(v7))
    }

    public fun add_liquidity_fix_coin<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut Pool, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut WrappedPositionNFT, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        assert_not_effective_range_migrating(arg2);
        assert!(0x2::object::id<Pool>(arg2) == arg6.pool_id, 2);
        assert!(arg2.clmm_pool_id == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 3);
        let v0 = 0x2::object::id<WrappedPositionNFT>(arg6);
        assert!(0x2::linked_table::contains<0x2::object::ID, WrappedPositionInfo>(&arg2.positions, v0), 14);
        let v1 = 0x2::linked_table::borrow<0x2::object::ID, WrappedPositionInfo>(&arg2.positions, v0);
        let v2 = v1.liquidity;
        let v3 = v1.share;
        assert!(arg9 > 0 || arg10 > 0, 13);
        let (v4, v5) = if (arg11) {
            (arg9, 0)
        } else {
            (0, arg10)
        };
        let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity_with_return_<T0, T1, T2>(arg3, arg4, 0x1::vector::singleton<0x2::coin::Coin<T0>>(arg7), 0x1::vector::singleton<0x2::coin::Coin<T1>>(arg8), &mut arg6.nft, arg9, arg10, v4, v5, arg13, arg12, arg5, arg14);
        let (_, _, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg4, v1.nft_address);
        assert!(v10 > v2, 13);
        let v11 = update_position_liquidity(arg1, arg2, arg6, v10, arg12);
        let v12 = AddLiquidityFixCoinEvent{
            pool_id              : 0x2::object::id<Pool>(arg2),
            wrapped_position_id  : v0,
            clmm_pool_id         : arg2.clmm_pool_id,
            nft_id               : v1.nft_id,
            effective_tick_lower : arg2.effective_tick_lower,
            effective_tick_upper : arg2.effective_tick_upper,
            sqrt_price           : arg2.sqrt_price,
            old_liquidity        : v2,
            new_liquidity        : v10,
            old_share            : v3,
            new_share            : v11,
        };
        0x2::event::emit<AddLiquidityFixCoinEvent>(v12);
        (0x2::coin::into_balance<T0>(v6), 0x2::coin::into_balance<T1>(v7))
    }

    public fun add_rewarder<T0>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut Pool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg5));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg2.rewarders, &v0), 7);
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::add_pool<T0>(arg1, arg2.clmm_pool_id, arg3, arg4);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg2.rewarders, v0);
        let v1 = AddRewardEvent{
            pool_id        : 0x2::object::id<Pool>(arg2),
            clmm_pool_id   : arg2.clmm_pool_id,
            rewarder       : v0,
            allocate_point : arg3,
        };
        0x2::event::emit<AddRewardEvent>(v1);
    }

    fun amount_desired_for_requested_liquidity(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        arg0 + 1
    }

    fun assert_not_effective_range_migrating(arg0: &Pool) {
        assert!(!arg0.is_effective_range_migrating, 16);
    }

    fun assert_position_liquidity_valid(arg0: u128, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: u128) {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_amount_for_liquidity(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg2), arg3);
        assert!(v0 > 0 || v1 > 0, 13);
    }

    public fun borrow_pool_rewarders(arg0: &Pool) : &vector<0x1::type_name::TypeName> {
        &arg0.rewarders
    }

    public fun borrow_position_nft(arg0: &WrappedPositionNFT) : &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        &arg0.nft
    }

    public fun borrow_position_rewarder_info(arg0: &WrappedPositionInfo, arg1: &0x1::type_name::TypeName) : &PositionRewardInfo {
        0x2::vec_map::get<0x1::type_name::TypeName, PositionRewardInfo>(&arg0.rewards, arg1)
    }

    public fun borrow_rewarders(arg0: &WrappedPositionInfo) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionRewardInfo> {
        &arg0.rewards
    }

    public fun borrow_wrapped_position_info(arg0: &Pool, arg1: 0x2::object::ID) : &WrappedPositionInfo {
        0x2::linked_table::borrow<0x2::object::ID, WrappedPositionInfo>(&arg0.positions, arg1)
    }

    public fun calculate_position_share(arg0: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: u128, arg3: u128, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) : u128 {
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg0, arg1), 10);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg4, arg5), 10);
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(arg1, arg4) || 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(arg0, arg5)) {
            return 0
        };
        let v0 = if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg0, arg4)) {
            arg4
        } else {
            arg0
        };
        let v1 = if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg1, arg5)) {
            arg1
        } else {
            arg5
        };
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_amount_for_liquidity(arg3, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v1), arg2);
        (((v2 as u256) * 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::full_mul(arg3, arg3) >> 128) as u128) + (v3 as u128)
    }

    public fun check_effective_range(arg0: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: u128, arg3: u32) {
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg0, arg1), 5);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_min_tick(arg3)) && 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_max_tick(arg3)), 5);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::tick_index_from_sqrt_price(arg2);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg0, v0) && 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gt(arg1, v0), 5);
    }

    public fun clmm_pool_id(arg0: &Pool) : 0x2::object::ID {
        arg0.clmm_pool_id
    }

    public fun close_position<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut Pool, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: WrappedPositionNFT, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        assert_not_effective_range_migrating(arg2);
        assert!(arg2.clmm_pool_id == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 3);
        let v0 = 0x2::object::id<Pool>(arg2);
        let v1 = withdraw(arg0, arg1, arg2, arg6, arg9);
        let v2 = 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v1);
        let (_, _, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg4, v2);
        let (v6, v7) = if (v5 > 0) {
            let (v8, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg3, arg4, &mut v1, v5, arg7, arg8, 0x2::clock::timestamp_ms(arg9) + 60000, arg9, arg5, arg10);
            (0x2::coin::into_balance<T0>(v8), 0x2::coin::into_balance<T1>(v9))
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v10 = v7;
        let v11 = v6;
        let (v12, v13) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg3, arg4, &mut v1, 18446744073709551615, 18446744073709551615, v2, 0x2::clock::timestamp_ms(arg9) + 60000, arg9, arg5, arg10);
        0x2::balance::join<T0>(&mut v11, 0x2::coin::into_balance<T0>(v12));
        0x2::balance::join<T1>(&mut v10, 0x2::coin::into_balance<T1>(v13));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::burn<T0, T1, T2>(arg4, v1, arg5, arg10);
        let v14 = ClosePositionEvent{
            pool_id             : v0,
            wrapped_position_id : 0x2::object::id<WrappedPositionNFT>(&arg6),
            clmm_pool_id        : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3),
            nft_id              : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&v1),
            liquidity           : v5,
            amount_a            : 0x2::balance::value<T0>(&v11),
            amount_b            : 0x2::balance::value<T1>(&v10),
        };
        0x2::event::emit<ClosePositionEvent>(v14);
        (v11, v10)
    }

    public fun collect_clmm_reward<T0, T1, T2, T3>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut WrappedPositionNFT, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T0>, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>>(arg1) == 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(&arg4.nft), 1);
        0x2::coin::join<T0>(&mut arg7, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_reward_with_return_<T1, T2, T3, T0>(arg1, arg2, &mut arg4.nft, arg5, arg6, 18446744073709551615, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg4.nft), 0x2::clock::timestamp_ms(arg8) + 60000, arg8, arg3, arg9));
        0x2::coin::into_balance<T0>(arg7)
    }

    public fun collect_fee<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut WrappedPositionNFT, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1) == 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(&arg4.nft), 1);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg1, arg2, &mut arg4.nft, 18446744073709551615, 18446744073709551615, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg4.nft), 0x2::clock::timestamp_ms(arg5) + 60000, arg5, arg3, arg6);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = CollectFeeEvent{
            wrapped_position_id : 0x2::object::id<WrappedPositionNFT>(arg4),
            clmm_pool_id        : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1),
            nft_id              : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&arg4.nft),
            amount_a            : 0x2::balance::value<T0>(&v2),
            amount_b            : 0x2::balance::value<T1>(&v3),
        };
        0x2::event::emit<CollectFeeEvent>(v4);
        (v2, v3)
    }

    public fun create_pool<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg6));
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg2);
        check_effective_range(arg3, arg4, v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg2));
        let v1 = Pool{
            id                           : 0x2::object::new(arg6),
            clmm_pool_id                 : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2),
            effective_tick_lower         : arg3,
            effective_tick_upper         : arg4,
            sqrt_price                   : v0,
            total_share                  : 0,
            rewarders                    : 0x1::vector::empty<0x1::type_name::TypeName>(),
            positions                    : 0x2::linked_table::new<0x2::object::ID, WrappedPositionInfo>(arg6),
            is_effective_range_migrating : false,
        };
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::register_pool(arg1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2));
        0x2::transfer::share_object<Pool>(v1);
        let v2 = CreatePoolEvent{
            pool_id              : 0x2::object::id<Pool>(&v1),
            clmm_pool_id         : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2),
            sqrt_price           : v0,
            effective_tick_lower : arg3,
            effective_tick_upper : arg4,
        };
        0x2::event::emit<CreatePoolEvent>(v2);
    }

    public fun deposit<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut Pool, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : WrappedPositionNFT {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        assert_not_effective_range_migrating(arg2);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(&arg5) == arg2.clmm_pool_id, 2);
        assert!(arg2.clmm_pool_id == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 3);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2.rewarders) > 0, 8);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&arg5);
        let v1 = 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg5);
        let (v2, v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg4, v1);
        assert_position_liquidity_valid(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3), v2, v3, v4);
        let v5 = WrappedPositionNFT{
            id      : 0x2::object::new(arg7),
            pool_id : 0x2::object::id<Pool>(arg2),
            nft     : arg5,
            url     : 0x1::string::utf8(b""),
        };
        let v6 = WrappedPositionInfo{
            id                   : 0x2::object::id<WrappedPositionNFT>(&v5),
            pool_id              : 0x2::object::id<Pool>(arg2),
            clmm_pool_id         : arg2.clmm_pool_id,
            nft_id               : v0,
            nft_address          : v1,
            tick_lower           : v2,
            tick_upper           : v3,
            liquidity            : v4,
            effective_tick_lower : arg2.effective_tick_lower,
            effective_tick_upper : arg2.effective_tick_upper,
            sqrt_price           : arg2.sqrt_price,
            share                : 0,
            rewards              : 0x2::vec_map::empty<0x1::type_name::TypeName, PositionRewardInfo>(),
        };
        0x2::linked_table::push_back<0x2::object::ID, WrappedPositionInfo>(&mut arg2.positions, 0x2::object::id<WrappedPositionNFT>(&v5), v6);
        let v7 = update_position_liquidity(arg1, arg2, &v5, v4, arg6);
        let v8 = DepositEvent{
            pool_id              : 0x2::object::id<Pool>(arg2),
            wrapped_position_id  : 0x2::object::id<WrappedPositionNFT>(&v5),
            clmm_pool_id         : arg2.clmm_pool_id,
            nft_id               : v0,
            effective_tick_lower : arg2.effective_tick_lower,
            effective_tick_upper : arg2.effective_tick_upper,
            sqrt_price           : arg2.sqrt_price,
            liquidity            : v4,
            share                : v7,
            pool_total_share     : arg2.total_share,
        };
        0x2::event::emit<DepositEvent>(v8);
        v5
    }

    fun destroy_wrapping_position_info(arg0: WrappedPositionInfo) {
        let WrappedPositionInfo {
            id                   : _,
            pool_id              : _,
            clmm_pool_id         : _,
            nft_id               : _,
            nft_address          : _,
            tick_lower           : _,
            tick_upper           : _,
            liquidity            : _,
            effective_tick_lower : _,
            effective_tick_upper : _,
            sqrt_price           : _,
            share                : _,
            rewards              : v12,
        } = arg0;
        let v13 = v12;
        while (!0x2::vec_map::is_empty<0x1::type_name::TypeName, PositionRewardInfo>(&v13)) {
            let (_, _) = 0x2::vec_map::pop<0x1::type_name::TypeName, PositionRewardInfo>(&mut v13);
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, PositionRewardInfo>(v13);
    }

    public fun effective_tick_lower(arg0: &Pool) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32 {
        arg0.effective_tick_lower
    }

    public fun effective_tick_upper(arg0: &Pool) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32 {
        arg0.effective_tick_upper
    }

    public fun harvest<T0>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut Pool, arg3: &mut WrappedPositionNFT, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        assert_not_effective_range_migrating(arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::object::id<Pool>(arg2);
        assert!(v1 == arg3.pool_id, 2);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg2.rewarders, &v0), 6);
        let v2 = 0x2::object::id<WrappedPositionNFT>(arg3);
        if (!0x2::linked_table::contains<0x2::object::ID, WrappedPositionInfo>(&arg2.positions, v2)) {
            let v3 = 0x2::linked_table::borrow_mut<0x2::object::ID, WrappedPositionInfo>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInvalidPositions>(&mut arg2.id, 0x1::string::utf8(b"invalid_pool_positions")).positions, v2);
            let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, PositionRewardInfo>(&mut v3.rewards, &v0);
            let v5 = (v4.reward as u64);
            v4.reward = 0;
            v4.reward_harvested = v4.reward_harvested + v5;
            let v6 = HarvestEvent{
                pool_id             : v1,
                wrapped_position_id : v2,
                clmm_pool_id        : v3.clmm_pool_id,
                nft_id              : v3.nft_id,
                rewarder_type       : v0,
                amount              : v5,
            };
            0x2::event::emit<HarvestEvent>(v6);
            return 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::withdraw_reward<T0>(arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(&arg3.nft), v5)
        };
        assert!(0x2::linked_table::contains<0x2::object::ID, WrappedPositionInfo>(&arg2.positions, v2), 14);
        let v7 = 0x2::linked_table::borrow_mut<0x2::object::ID, WrappedPositionInfo>(&mut arg2.positions, v2);
        let v8 = v7.share;
        update_position_share(v7, 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::pool_rewards_settle(arg1, arg2.rewarders, arg2.clmm_pool_id, arg4), v8);
        let v9 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, PositionRewardInfo>(&mut v7.rewards, &v0);
        let v10 = (v9.reward as u64);
        v9.reward = 0;
        v9.reward_harvested = v9.reward_harvested + v10;
        let v11 = HarvestEvent{
            pool_id             : v1,
            wrapped_position_id : v2,
            clmm_pool_id        : v7.clmm_pool_id,
            nft_id              : v7.nft_id,
            rewarder_type       : v0,
            amount              : v10,
        };
        0x2::event::emit<HarvestEvent>(v11);
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::withdraw_reward<T0>(arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(&arg3.nft), v10)
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_invalid_pool_positions(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut Pool, arg2: &mut 0x2::tx_context::TxContext) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = PoolInvalidPositions{
            id        : 0x2::object::new(arg2),
            positions : 0x2::linked_table::new<0x2::object::ID, WrappedPositionInfo>(arg2),
        };
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, 0x1::string::utf8(b"invalid_pool_positions")), 12);
        0x2::dynamic_object_field::add<0x1::string::String, PoolInvalidPositions>(&mut arg1.id, 0x1::string::utf8(b"invalid_pool_positions"), v0);
    }

    public fun is_effective_range_migrating(arg0: &Pool) : bool {
        arg0.is_effective_range_migrating
    }

    public fun migrate_invalid_pool_positions<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut Pool, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg7));
        assert!(arg2.clmm_pool_id == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 3);
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg2.id, 0x1::string::utf8(b"invalid_pool_positions")), 11);
        let v0 = if (0x1::option::is_none<0x2::object::ID>(&arg4)) {
            *0x2::linked_table::front<0x2::object::ID, WrappedPositionInfo>(&arg2.positions)
        } else {
            arg4
        };
        let v1 = v0;
        if (0x1::option::is_none<0x2::object::ID>(&v1)) {
            return
        };
        assert!(arg5 > 0, 15);
        let v2 = v1;
        let v3 = arg2.total_share;
        let v4 = 0;
        while (v4 < arg5 && 0x1::option::is_some<0x2::object::ID>(&v1)) {
            let v5 = *0x1::option::borrow<0x2::object::ID>(&v1);
            let v6 = 0x2::linked_table::borrow<0x2::object::ID, WrappedPositionInfo>(&arg2.positions, v5);
            let (v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_amount_for_liquidity(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v6.tick_lower), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v6.tick_upper), v6.liquidity);
            v1 = *0x2::linked_table::next<0x2::object::ID, WrappedPositionInfo>(&arg2.positions, v5);
            v2 = v1;
            if (v7 > 0 || v8 > 0) {
                v4 = v4 + 1;
                continue
            };
            let v9 = 0x2::linked_table::remove<0x2::object::ID, WrappedPositionInfo>(&mut arg2.positions, v5);
            v3 = v3 - v9.share;
            let v10 = &mut v9;
            update_position_share(v10, 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::pool_rewards_settle(arg1, arg2.rewarders, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), arg6), 0);
            0x2::linked_table::push_back<0x2::object::ID, WrappedPositionInfo>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInvalidPositions>(&mut arg2.id, 0x1::string::utf8(b"invalid_pool_positions")).positions, v5, v9);
            v4 = v4 + 1;
        };
        arg2.total_share = v3;
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::set_pool_share(arg1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), arg2.total_share);
        let v11 = MigrateInvalidPoolPositionsEvent{
            pool_id      : 0x2::object::id<Pool>(arg2),
            clmm_pool_id : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3),
            start_idx    : arg4,
            end          : v2,
        };
        0x2::event::emit<MigrateInvalidPoolPositionsEvent>(v11);
    }

    fun position_reward_amount(arg0: u128, arg1: u256) : u128 {
        (((arg0 as u256) * arg1 / 1000000000000000000000000000000000000) as u128)
    }

    public fun position_rewarder_info(arg0: &WrappedPositionInfo, arg1: &0x1::type_name::TypeName) : PositionRewardInfo {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, PositionRewardInfo>(&arg0.rewards, arg1)) {
            PositionRewardInfo{reward: 0, reward_debt: 0, reward_harvested: 0}
        } else {
            *0x2::vec_map::get<0x1::type_name::TypeName, PositionRewardInfo>(&arg0.rewards, arg1)
        }
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut Pool, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut WrappedPositionNFT, arg7: u128, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        assert_not_effective_range_migrating(arg2);
        assert!(0x2::object::id<Pool>(arg2) == arg6.pool_id, 2);
        assert!(arg2.clmm_pool_id == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 3);
        let v0 = 0x2::object::id<WrappedPositionNFT>(arg6);
        assert!(0x2::linked_table::contains<0x2::object::ID, WrappedPositionInfo>(&arg2.positions, v0), 14);
        let v1 = 0x2::linked_table::borrow<0x2::object::ID, WrappedPositionInfo>(&arg2.positions, v0);
        let v2 = v1.share;
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg3, arg4, &mut arg6.nft, arg7, arg8, arg9, 0x2::clock::timestamp_ms(arg10) + 60000, arg10, arg5, arg11);
        let (_, _, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg4, v1.nft_address);
        assert_position_liquidity_valid(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3), v1.tick_lower, v1.tick_upper, v7);
        let v8 = update_position_liquidity(arg1, arg2, arg6, v7, arg10);
        let v9 = RemoveLiquidityEvent{
            pool_id              : 0x2::object::id<Pool>(arg2),
            wrapped_position_id  : v0,
            clmm_pool_id         : arg2.clmm_pool_id,
            nft_id               : v1.nft_id,
            effective_tick_lower : arg2.effective_tick_lower,
            effective_tick_upper : arg2.effective_tick_upper,
            sqrt_price           : arg2.sqrt_price,
            old_liquidity        : v1.liquidity,
            new_liquidity        : v7,
            old_share            : v2,
            new_share            : v8,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v9);
        (0x2::coin::into_balance<T0>(v3), 0x2::coin::into_balance<T1>(v4))
    }

    public fun reward(arg0: &PositionRewardInfo) : u128 {
        arg0.reward
    }

    public fun reward_debt(arg0: &PositionRewardInfo) : u128 {
        arg0.reward_debt
    }

    public fun reward_harvested(arg0: &PositionRewardInfo) : u64 {
        arg0.reward_harvested
    }

    public fun share(arg0: &WrappedPositionInfo) : u128 {
        arg0.share
    }

    public fun sqrt_price(arg0: &Pool) : u128 {
        arg0.sqrt_price
    }

    public fun total_share(arg0: &Pool) : u128 {
        arg0.total_share
    }

    public fun update_effective_tick_range<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut Pool, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg6: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg7: u128, arg8: vector<0x2::object::ID>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : 0x1::option::Option<0x2::object::ID> {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        update_effective_tick_range_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    fun update_effective_tick_range_internal<T0, T1, T2>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut Pool, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg6: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg7: u128, arg8: vector<0x2::object::ID>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : 0x1::option::Option<0x2::object::ID> {
        assert!(arg9 > 0, 15);
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg11));
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3);
        check_effective_range(arg5, arg6, v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg3));
        assert!(arg2.clmm_pool_id == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 3);
        arg2.effective_tick_lower = arg5;
        arg2.effective_tick_upper = arg6;
        arg2.sqrt_price = v0;
        let v1 = if (0x1::vector::is_empty<0x2::object::ID>(&arg8)) {
            *0x2::linked_table::front<0x2::object::ID, WrappedPositionInfo>(&arg2.positions)
        } else {
            assert!(0x1::vector::length<0x2::object::ID>(&arg8) == 1, 9);
            0x1::option::some<0x2::object::ID>(0x1::vector::pop_back<0x2::object::ID>(&mut arg8))
        };
        let v2 = v1;
        if (0x1::option::is_none<0x2::object::ID>(&v2)) {
            arg2.is_effective_range_migrating = false;
            return 0x1::option::none<0x2::object::ID>()
        };
        arg2.is_effective_range_migrating = true;
        let v3 = v2;
        let v4 = 0;
        let v5 = arg2.total_share;
        while (v4 < arg9 && 0x1::option::is_some<0x2::object::ID>(&v2)) {
            let v6 = *0x1::option::borrow<0x2::object::ID>(&v2);
            let v7 = 0x2::linked_table::borrow_mut<0x2::object::ID, WrappedPositionInfo>(&mut arg2.positions, v6);
            let (_, _, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg4, v7.nft_address);
            let v11 = calculate_position_share(v7.tick_lower, v7.tick_upper, v10, arg2.sqrt_price, arg2.effective_tick_lower, arg2.effective_tick_upper);
            let v12 = v5 - v7.share;
            v5 = v12 + v11;
            update_position_share(v7, 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::pool_rewards_settle(arg1, arg2.rewarders, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), arg10), v11);
            v7.effective_tick_lower = arg2.effective_tick_lower;
            v7.effective_tick_upper = arg2.effective_tick_upper;
            v7.sqrt_price = arg2.sqrt_price;
            v7.liquidity = v10;
            v2 = *0x2::linked_table::next<0x2::object::ID, WrappedPositionInfo>(&arg2.positions, v6);
            v3 = v2;
            v4 = v4 + 1;
        };
        arg2.total_share = v5;
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::set_pool_share(arg1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), arg2.total_share);
        arg2.is_effective_range_migrating = 0x1::option::is_some<0x2::object::ID>(&v2);
        let v13 = UpdateEffectiveTickRangeEvent{
            pool_id              : 0x2::object::id<Pool>(arg2),
            clmm_pool_id         : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3),
            effective_tick_lower : arg5,
            effective_tick_upper : arg6,
            sqrt_price           : v0,
            start                : arg8,
            end                  : v3,
            limit                : arg9,
        };
        0x2::event::emit<UpdateEffectiveTickRangeEvent>(v13);
        v2
    }

    public fun update_pool_allocate_point<T0>(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &Pool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg5));
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::set_pool<T0>(arg1, arg2.clmm_pool_id, arg3, arg4);
        let v0 = UpdatePoolAllocatePointEvent{
            pool_id            : 0x2::object::id<Pool>(arg2),
            clmm_pool_id       : arg2.clmm_pool_id,
            old_allocate_point : 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::borrow_pool_allocate_point(arg1, 0x1::type_name::with_defining_ids<T0>(), arg2.clmm_pool_id),
            new_allocate_point : arg3,
        };
        0x2::event::emit<UpdatePoolAllocatePointEvent>(v0);
    }

    fun update_position_liquidity(arg0: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg1: &mut Pool, arg2: &WrappedPositionNFT, arg3: u128, arg4: &0x2::clock::Clock) : u128 {
        if (!0x2::linked_table::contains<0x2::object::ID, WrappedPositionInfo>(&arg1.positions, 0x2::object::id<WrappedPositionNFT>(arg2))) {
            return 0
        };
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(&arg2.nft);
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, WrappedPositionInfo>(&mut arg1.positions, 0x2::object::id<WrappedPositionNFT>(arg2));
        v1.liquidity = arg3;
        let v2 = calculate_position_share(v1.tick_lower, v1.tick_upper, v1.liquidity, arg1.sqrt_price, arg1.effective_tick_lower, arg1.effective_tick_upper);
        let v3 = arg1.total_share - v1.share + v2;
        update_position_share(v1, 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::pool_rewards_settle(arg0, arg1.rewarders, v0, arg4), v2);
        arg1.total_share = v3;
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::set_pool_share(arg0, v0, arg1.total_share);
        v2
    }

    fun update_position_share(arg0: &mut WrappedPositionInfo, arg1: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>, arg2: u128) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<0x1::type_name::TypeName, u256>(&arg1)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u256>(&arg1, v0);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, PositionRewardInfo>(&arg0.rewards, v1)) {
                let v3 = PositionRewardInfo{
                    reward           : position_reward_amount(arg0.share, *v2),
                    reward_debt      : position_reward_amount(arg2, *v2),
                    reward_harvested : 0,
                };
                0x2::vec_map::insert<0x1::type_name::TypeName, PositionRewardInfo>(&mut arg0.rewards, *v1, v3);
            } else {
                let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, PositionRewardInfo>(&mut arg0.rewards, v1);
                v4.reward = v4.reward + position_reward_amount(arg0.share, *v2) - v4.reward_debt;
                v4.reward_debt = position_reward_amount(arg2, *v2);
            };
            v0 = v0 + 1;
        };
        arg0.share = arg2;
    }

    public fun withdraw(arg0: &0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::GlobalConfig, arg1: &mut 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::RewarderManager, arg2: &mut Pool, arg3: WrappedPositionNFT, arg4: &0x2::clock::Clock) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config::checked_package_version(arg0);
        assert_not_effective_range_migrating(arg2);
        assert!(0x2::object::id<Pool>(arg2) == arg3.pool_id, 2);
        let WrappedPositionNFT {
            id      : v0,
            pool_id : _,
            nft     : v2,
            url     : _,
        } = arg3;
        let v4 = v2;
        let v5 = v0;
        let v6 = 0x2::object::uid_to_inner(&v5);
        0x2::object::delete(v5);
        let v7 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(&v4);
        let v8 = if (!0x2::linked_table::contains<0x2::object::ID, WrappedPositionInfo>(&arg2.positions, v6)) {
            0x2::linked_table::remove<0x2::object::ID, WrappedPositionInfo>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PoolInvalidPositions>(&mut arg2.id, 0x1::string::utf8(b"invalid_pool_positions")).positions, v6)
        } else {
            0x2::linked_table::remove<0x2::object::ID, WrappedPositionInfo>(&mut arg2.positions, v6)
        };
        let v9 = v8;
        let v10 = v9.share;
        let v11 = &mut v9;
        update_position_share(v11, 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::pool_rewards_settle(arg1, arg2.rewarders, v7, arg4), 0);
        arg2.total_share = arg2.total_share - v10;
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::rewarder::set_pool_share(arg1, v7, arg2.total_share);
        let v12 = 0;
        while (v12 < 0x2::vec_map::length<0x1::type_name::TypeName, PositionRewardInfo>(&v9.rewards)) {
            let (_, v14) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, PositionRewardInfo>(&v9.rewards, v12);
            assert!(v14.reward == 0, 4);
            v12 = v12 + 1;
        };
        destroy_wrapping_position_info(v9);
        let v15 = WithdrawEvent{
            pool_id             : 0x2::object::id<Pool>(arg2),
            wrapped_position_id : v6,
            clmm_pool_id        : v7,
            nft_id              : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&v4),
            share               : v10,
        };
        0x2::event::emit<WithdrawEvent>(v15);
        v4
    }

    // decompiled from Move bytecode v6
}

