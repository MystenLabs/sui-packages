module 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct WrappedPositionNFT has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        clmm_postion: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
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
        clmm_position_id: 0x2::object::ID,
        tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity: u128,
        effective_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        effective_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sqrt_price: u128,
        share: u128,
        rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionRewardInfo>,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        clmm_pool_id: 0x2::object::ID,
        effective_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        effective_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sqrt_price: u128,
        total_share: u128,
        rewarders: vector<0x1::type_name::TypeName>,
        positions: 0x2::linked_table::LinkedTable<0x2::object::ID, WrappedPositionInfo>,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        sqrt_price: u128,
        effective_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        effective_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct UpdateEffectiveTickRangeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        effective_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        effective_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
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
        clmm_position_id: 0x2::object::ID,
        effective_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        effective_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sqrt_price: u128,
        liquidity: u128,
        share: u128,
        pool_total_share: u128,
    }

    struct WithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        clmm_position_id: 0x2::object::ID,
        share: u128,
    }

    struct HarvestEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        clmm_position_id: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct AccumulatedPositionRewardsEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        clmm_position_id: 0x2::object::ID,
        rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct AddLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        clmm_poo_id: 0x2::object::ID,
        clmm_position_id: 0x2::object::ID,
        effective_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        effective_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sqrt_price: u128,
        old_liquidity: u128,
        new_liquidity: u128,
        old_share: u128,
        new_share: u128,
    }

    struct AddLiquidityFixCoinEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        clmm_poo_id: 0x2::object::ID,
        clmm_position_id: 0x2::object::ID,
        effective_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        effective_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sqrt_price: u128,
        old_liquidity: u128,
        new_liquidity: u128,
        old_share: u128,
        new_share: u128,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        wrapped_position_id: 0x2::object::ID,
        clmm_poo_id: 0x2::object::ID,
        clmm_position_id: 0x2::object::ID,
        effective_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        effective_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sqrt_price: u128,
        old_liquidity: u128,
        new_liquidity: u128,
        old_share: u128,
        new_share: u128,
    }

    public fun accumulated_position_rewards(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg1: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg2: &mut Pool, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg0);
        let v0 = 0x2::linked_table::borrow_mut<0x2::object::ID, WrappedPositionInfo>(&mut arg2.positions, arg3);
        let v1 = v0.share;
        update_position_share(v0, 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::pool_rewards_settle(arg1, arg2.rewarders, arg2.clmm_pool_id, arg4), v1);
        let v2 = 0;
        let v3 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        while (v2 < 0x2::vec_map::size<0x1::type_name::TypeName, PositionRewardInfo>(&v0.rewards)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, PositionRewardInfo>(&v0.rewards, v2);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v3, *v4, ((v5.reward / 1000000000000) as u64));
            v2 = v2 + 1;
        };
        let v6 = AccumulatedPositionRewardsEvent{
            pool_id             : 0x2::object::id<Pool>(arg2),
            wrapped_position_id : arg3,
            clmm_position_id    : v0.clmm_position_id,
            rewards             : v3,
        };
        0x2::event::emit<AccumulatedPositionRewardsEvent>(v6);
    }

    public fun add_liquidity<T0, T1>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &mut Pool, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut WrappedPositionNFT, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg0);
        assert!(0x2::object::id<Pool>(arg3) == arg5.pool_id, 2);
        assert!(arg3.clmm_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4), 3);
        let v0 = &mut arg5.clmm_postion;
        let (v1, v2) = add_liquidity_to_clmm<T0, T1>(arg1, arg4, v0, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v3 = 0x2::object::id<WrappedPositionNFT>(arg5);
        let v4 = 0x2::linked_table::borrow<0x2::object::ID, WrappedPositionInfo>(&arg3.positions, v3);
        let v5 = v4.clmm_position_id;
        let v6 = update_position_liquidity(arg2, arg3, arg5, arg11);
        let v7 = AddLiquidityEvent{
            pool_id              : 0x2::object::id<Pool>(arg3),
            wrapped_position_id  : v3,
            clmm_poo_id          : arg3.clmm_pool_id,
            clmm_position_id     : v5,
            effective_tick_lower : arg3.effective_tick_lower,
            effective_tick_upper : arg3.effective_tick_upper,
            sqrt_price           : arg3.sqrt_price,
            old_liquidity        : v4.liquidity,
            new_liquidity        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg5.clmm_postion),
            old_share            : v4.share,
            new_share            : v6,
        };
        0x2::event::emit<AddLiquidityEvent>(v7);
        (v1, v2)
    }

    public fun add_liquidity_fix_coin<T0, T1>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &mut Pool, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut WrappedPositionNFT, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg0);
        assert!(0x2::object::id<Pool>(arg3) == arg5.pool_id, 2);
        assert!(arg3.clmm_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4), 3);
        let v0 = &mut arg5.clmm_postion;
        let (v1, v2) = add_liquidity_fix_coin_to_clmm<T0, T1>(arg1, arg4, v0, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v3 = 0x2::object::id<WrappedPositionNFT>(arg5);
        let v4 = 0x2::linked_table::borrow<0x2::object::ID, WrappedPositionInfo>(&arg3.positions, v3);
        let v5 = v4.clmm_position_id;
        let v6 = update_position_liquidity(arg2, arg3, arg5, arg11);
        let v7 = AddLiquidityFixCoinEvent{
            pool_id              : 0x2::object::id<Pool>(arg3),
            wrapped_position_id  : v3,
            clmm_poo_id          : arg3.clmm_pool_id,
            clmm_position_id     : v5,
            effective_tick_lower : arg3.effective_tick_lower,
            effective_tick_upper : arg3.effective_tick_upper,
            sqrt_price           : arg3.sqrt_price,
            old_liquidity        : v4.liquidity,
            new_liquidity        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg5.clmm_postion),
            old_share            : v4.share,
            new_share            : v6,
        };
        0x2::event::emit<AddLiquidityFixCoinEvent>(v7);
        (v1, v2)
    }

    fun add_liquidity_fix_coin_to_clmm<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = if (arg7) {
            arg5
        } else {
            arg6
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, v0, arg7, arg8);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v1);
        assert!(v2 <= arg5, 12);
        assert!(v3 <= arg6, 12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v2, arg9)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v3, arg9)), v1);
        (0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4))
    }

    fun add_liquidity_to_clmm<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg7, arg8);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v0);
        assert!(v1 <= arg5, 12);
        assert!(v2 <= arg6, 12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v1, arg9)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v2, arg9)), v0);
        (0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4))
    }

    public fun add_rewarder<T0>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::OperatorCap, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &mut Pool, arg4: u64, arg5: &0x2::clock::Clock) {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg1);
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::check_pool_manager_role(arg1, 0x2::object::id_address<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::OperatorCap>(arg0));
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg3.rewarders, &v0), 7);
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::add_pool<T0>(arg2, arg3.clmm_pool_id, arg4, arg5);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg3.rewarders, 0x1::type_name::get<T0>());
        let v1 = AddRewardEvent{
            pool_id        : 0x2::object::id<Pool>(arg3),
            clmm_pool_id   : arg3.clmm_pool_id,
            rewarder       : 0x1::type_name::get<T0>(),
            allocate_point : arg4,
        };
        0x2::event::emit<AddRewardEvent>(v1);
    }

    public fun borrow_clmm_position(arg0: &WrappedPositionNFT) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        &arg0.clmm_postion
    }

    public fun borrow_pool_rewarders(arg0: &Pool) : &vector<0x1::type_name::TypeName> {
        &arg0.rewarders
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

    public fun calculate_position_share(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u128, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, arg1), 10);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg4, arg5), 10);
        assert!(arg3 <= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), 11);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg1, arg4) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0, arg5)) {
            return 0
        };
        let v0 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, arg4)) {
            arg4
        } else {
            arg0
        };
        let v1 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg1, arg5)) {
            arg1
        } else {
            arg5
        };
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(arg3), arg3, arg2, true);
        (((v2 as u256) * 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(arg3, arg3) >> 128) as u128) + (v3 as u128)
    }

    public fun check_effective_range(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, arg1), 5);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick()) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_tick()), 5);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(arg2);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, v0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(arg1, v0), 5);
    }

    public fun close_position<T0, T1>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg1: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg2: &mut Pool, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: WrappedPositionNFT, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg0);
        let v0 = withdraw(arg0, arg1, arg2, arg5, arg8);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let (v2, v3) = if (v1 > 0) {
            let v4 = &mut v0;
            remove_liquidity_from_clmm<T0, T1>(arg3, arg4, v4, v1, arg6, arg7, arg8)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg3, arg4, v0);
        (v2, v3)
    }

    public fun collect_clmm_reward<T0, T1, T2>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &WrappedPositionNFT, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg0);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg3.clmm_postion), 1);
        0x2::coin::join<T0>(&mut arg5, 0x2::coin::from_balance<T0>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T1, T2, T0>(arg1, arg2, &arg3.clmm_postion, arg4, arg6, arg7), arg8));
        0x2::coin::into_balance<T0>(arg5)
    }

    public fun collect_fee<T0, T1>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &WrappedPositionNFT, arg4: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg0);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg3.clmm_postion), 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &arg3.clmm_postion, arg4)
    }

    public fun create_pool<T0, T1>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::OperatorCap, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg1);
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::check_pool_manager_role(arg1, 0x2::object::id_address<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::OperatorCap>(arg0));
        check_effective_range(arg4, arg5, arg6);
        let v0 = Pool{
            id                   : 0x2::object::new(arg7),
            clmm_pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            effective_tick_lower : arg4,
            effective_tick_upper : arg5,
            sqrt_price           : arg6,
            total_share          : 0,
            rewarders            : 0x1::vector::empty<0x1::type_name::TypeName>(),
            positions            : 0x2::linked_table::new<0x2::object::ID, WrappedPositionInfo>(arg7),
        };
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::register_pool(arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3));
        0x2::transfer::share_object<Pool>(v0);
        let v1 = CreatePoolEvent{
            pool_id              : 0x2::object::id<Pool>(&v0),
            clmm_pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            sqrt_price           : arg6,
            effective_tick_lower : arg4,
            effective_tick_upper : arg5,
        };
        0x2::event::emit<CreatePoolEvent>(v1);
    }

    public fun deposit(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg1: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg2: &mut Pool, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : WrappedPositionNFT {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg3) == arg2.clmm_pool_id, 2);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2.rewarders) > 0, 8);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&arg3);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg3);
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg3);
        let v4 = WrappedPositionNFT{
            id           : 0x2::object::new(arg5),
            pool_id      : 0x2::object::id<Pool>(arg2),
            clmm_postion : arg3,
            url          : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::url(&arg3),
        };
        let v5 = WrappedPositionInfo{
            id                   : 0x2::object::id<WrappedPositionNFT>(&v4),
            pool_id              : 0x2::object::id<Pool>(arg2),
            clmm_pool_id         : arg2.clmm_pool_id,
            clmm_position_id     : v3,
            tick_lower           : v0,
            tick_upper           : v1,
            liquidity            : v2,
            effective_tick_lower : arg2.effective_tick_lower,
            effective_tick_upper : arg2.effective_tick_upper,
            sqrt_price           : arg2.sqrt_price,
            share                : 0,
            rewards              : 0x2::vec_map::empty<0x1::type_name::TypeName, PositionRewardInfo>(),
        };
        0x2::linked_table::push_back<0x2::object::ID, WrappedPositionInfo>(&mut arg2.positions, 0x2::object::id<WrappedPositionNFT>(&v4), v5);
        let v6 = update_position_liquidity(arg1, arg2, &v4, arg4);
        let v7 = DepositEvent{
            pool_id              : 0x2::object::id<Pool>(arg2),
            wrapped_position_id  : 0x2::object::id<WrappedPositionNFT>(&v4),
            clmm_pool_id         : arg2.clmm_pool_id,
            clmm_position_id     : v3,
            effective_tick_lower : arg2.effective_tick_lower,
            effective_tick_upper : arg2.effective_tick_upper,
            sqrt_price           : arg2.sqrt_price,
            liquidity            : v2,
            share                : v6,
            pool_total_share     : arg2.total_share,
        };
        0x2::event::emit<DepositEvent>(v7);
        v4
    }

    fun destory_wrapping_position_info(arg0: WrappedPositionInfo) {
        let WrappedPositionInfo {
            id                   : _,
            pool_id              : _,
            clmm_pool_id         : _,
            clmm_position_id     : _,
            tick_lower           : _,
            tick_upper           : _,
            liquidity            : _,
            effective_tick_lower : _,
            effective_tick_upper : _,
            sqrt_price           : _,
            share                : _,
            rewards              : v11,
        } = arg0;
        let v12 = v11;
        while (!0x2::vec_map::is_empty<0x1::type_name::TypeName, PositionRewardInfo>(&v12)) {
            let (_, _) = 0x2::vec_map::pop<0x1::type_name::TypeName, PositionRewardInfo>(&mut v12);
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, PositionRewardInfo>(v12);
    }

    public fun harvest<T0>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg1: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg2: &mut Pool, arg3: &WrappedPositionNFT, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::object::id<Pool>(arg2) == arg3.pool_id, 2);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg2.rewarders, &v0), 6);
        let v1 = 0x2::object::id<WrappedPositionNFT>(arg3);
        let v2 = 0x2::linked_table::borrow_mut<0x2::object::ID, WrappedPositionInfo>(&mut arg2.positions, v1);
        let v3 = v2.share;
        update_position_share(v2, 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::pool_rewards_settle(arg1, arg2.rewarders, arg2.clmm_pool_id, arg4), v3);
        let v4 = 0x1::type_name::get<T0>();
        let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, PositionRewardInfo>(&mut v2.rewards, &v4);
        let v6 = ((v5.reward / 1000000000000) as u64);
        v5.reward = 0;
        v5.reward_harvested = v5.reward_harvested + v6;
        let v7 = HarvestEvent{
            pool_id             : 0x2::object::id<Pool>(arg2),
            wrapped_position_id : v1,
            clmm_pool_id        : v2.clmm_pool_id,
            clmm_position_id    : v2.clmm_position_id,
            rewarder_type       : v4,
            amount              : v6,
        };
        0x2::event::emit<HarvestEvent>(v7);
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::withdraw_reward<T0>(arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg3.clmm_postion), v6)
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cetus.zone"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cetus"));
        let v4 = 0x2::package::claim<POOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<WrappedPositionNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<WrappedPositionNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WrappedPositionNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun position_rewarder_info(arg0: &WrappedPositionInfo, arg1: &0x1::type_name::TypeName) : PositionRewardInfo {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, PositionRewardInfo>(&arg0.rewards, arg1)) {
            PositionRewardInfo{reward: 0, reward_debt: 0, reward_harvested: 0}
        } else {
            *0x2::vec_map::get<0x1::type_name::TypeName, PositionRewardInfo>(&arg0.rewards, arg1)
        }
    }

    public fun remove_liquidity<T0, T1>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &mut Pool, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut WrappedPositionNFT, arg6: u128, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg0);
        assert!(0x2::object::id<Pool>(arg3) == arg5.pool_id, 2);
        assert!(arg3.clmm_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4), 3);
        let v0 = &mut arg5.clmm_postion;
        let (v1, v2) = remove_liquidity_from_clmm<T0, T1>(arg1, arg4, v0, arg6, arg7, arg8, arg9);
        let v3 = 0x2::object::id<WrappedPositionNFT>(arg5);
        let v4 = 0x2::linked_table::borrow<0x2::object::ID, WrappedPositionInfo>(&arg3.positions, v3);
        let v5 = v4.clmm_position_id;
        let v6 = update_position_liquidity(arg2, arg3, arg5, arg9);
        let v7 = RemoveLiquidityEvent{
            pool_id              : 0x2::object::id<Pool>(arg3),
            wrapped_position_id  : v3,
            clmm_poo_id          : arg3.clmm_pool_id,
            clmm_position_id     : v5,
            effective_tick_lower : arg3.effective_tick_lower,
            effective_tick_upper : arg3.effective_tick_upper,
            sqrt_price           : arg3.sqrt_price,
            old_liquidity        : v4.liquidity,
            new_liquidity        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg5.clmm_postion),
            old_share            : v4.share,
            new_share            : v6,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v7);
        (v1, v2)
    }

    fun remove_liquidity_from_clmm<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: u128, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::balance::value<T0>(&v3) >= arg4, 15);
        assert!(0x2::balance::value<T1>(&v2) >= arg5, 15);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg0, arg1, arg2, false);
        0x2::balance::join<T0>(&mut v3, v4);
        0x2::balance::join<T1>(&mut v2, v5);
        (v3, v2)
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

    public fun total_share(arg0: &Pool) : u128 {
        arg0.total_share
    }

    public fun update_effective_tick_range<T0, T1>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::OperatorCap, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &mut Pool, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg6: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg7: u128, arg8: vector<0x2::object::ID>, arg9: u64, arg10: &0x2::clock::Clock) : 0x1::option::Option<0x2::object::ID> {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg1);
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::check_pool_manager_role(arg1, 0x2::object::id_address<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::OperatorCap>(arg0));
        check_effective_range(arg5, arg6, arg7);
        assert!(arg3.clmm_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4), 3);
        arg3.effective_tick_lower = arg5;
        arg3.effective_tick_upper = arg6;
        arg3.sqrt_price = arg7;
        let v0 = if (0x1::vector::is_empty<0x2::object::ID>(&arg8)) {
            *0x2::linked_table::front<0x2::object::ID, WrappedPositionInfo>(&arg3.positions)
        } else {
            assert!(0x1::vector::length<0x2::object::ID>(&arg8) == 1, 9);
            0x1::option::some<0x2::object::ID>(0x1::vector::pop_back<0x2::object::ID>(&mut arg8))
        };
        let v1 = v0;
        if (0x1::option::is_none<0x2::object::ID>(&v1)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v2 = 0;
        let v3 = arg3.total_share;
        while (v2 < arg9 && 0x1::option::is_some<0x2::object::ID>(&v1)) {
            let v4 = *0x1::option::borrow<0x2::object::ID>(&v1);
            let v5 = 0x2::linked_table::borrow_mut<0x2::object::ID, WrappedPositionInfo>(&mut arg3.positions, v4);
            let v6 = calculate_position_share(v5.tick_lower, v5.tick_upper, v5.liquidity, arg3.sqrt_price, arg3.effective_tick_lower, arg3.effective_tick_upper);
            let v7 = v3 - v5.share;
            v3 = v7 + v6;
            update_position_share(v5, 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::pool_rewards_settle(arg2, arg3.rewarders, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4), arg10), v6);
            v5.effective_tick_lower = arg3.effective_tick_lower;
            v5.effective_tick_upper = arg3.effective_tick_upper;
            v5.sqrt_price = arg3.sqrt_price;
            v1 = *0x2::linked_table::next<0x2::object::ID, WrappedPositionInfo>(&arg3.positions, v4);
            v2 = v2 + 1;
        };
        arg3.total_share = v3;
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::set_pool_share(arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4), arg3.total_share);
        let v8 = UpdateEffectiveTickRangeEvent{
            pool_id              : 0x2::object::id<Pool>(arg3),
            clmm_pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4),
            effective_tick_lower : arg5,
            effective_tick_upper : arg6,
            sqrt_price           : arg7,
            start                : arg8,
            end                  : *0x2::linked_table::back<0x2::object::ID, WrappedPositionInfo>(&arg3.positions),
            limit                : arg9,
        };
        0x2::event::emit<UpdateEffectiveTickRangeEvent>(v8);
        v1
    }

    public fun update_pool_allocate_point<T0>(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::OperatorCap, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &Pool, arg4: u64, arg5: &0x2::clock::Clock) {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg1);
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::check_pool_manager_role(arg1, 0x2::object::id_address<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::OperatorCap>(arg0));
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::set_pool<T0>(arg2, arg3.clmm_pool_id, arg4, arg5);
        let v0 = UpdatePoolAllocatePointEvent{
            pool_id            : 0x2::object::id<Pool>(arg3),
            clmm_pool_id       : arg3.clmm_pool_id,
            old_allocate_point : 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::borrow_pool_allocate_point(arg2, 0x1::type_name::get<T0>(), arg3.clmm_pool_id),
            new_allocate_point : arg4,
        };
        0x2::event::emit<UpdatePoolAllocatePointEvent>(v0);
    }

    fun update_position_liquidity(arg0: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg1: &mut Pool, arg2: &WrappedPositionNFT, arg3: &0x2::clock::Clock) : u128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg2.clmm_postion);
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, WrappedPositionInfo>(&mut arg1.positions, 0x2::object::id<WrappedPositionNFT>(arg2));
        v1.liquidity = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg2.clmm_postion);
        let v2 = calculate_position_share(v1.tick_lower, v1.tick_upper, v1.liquidity, arg1.sqrt_price, arg1.effective_tick_lower, arg1.effective_tick_upper);
        let v3 = arg1.total_share - v1.share + v2;
        update_position_share(v1, 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::pool_rewards_settle(arg0, arg1.rewarders, v0, arg3), v2);
        arg1.total_share = v3;
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::set_pool_share(arg0, v0, arg1.total_share);
        v2
    }

    fun update_position_share(arg0: &mut WrappedPositionInfo, arg1: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>, arg2: u128) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<0x1::type_name::TypeName, u128>(&arg1)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u128>(&arg1, v0);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, PositionRewardInfo>(&arg0.rewards, v1)) {
                let v3 = PositionRewardInfo{
                    reward           : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(arg0.share, *v2) as u128),
                    reward_debt      : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(arg2, *v2) as u128),
                    reward_harvested : 0,
                };
                0x2::vec_map::insert<0x1::type_name::TypeName, PositionRewardInfo>(&mut arg0.rewards, *v1, v3);
            } else {
                let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, PositionRewardInfo>(&mut arg0.rewards, v1);
                v4.reward = v4.reward + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(arg0.share, *v2) as u128) - v4.reward_debt;
                v4.reward_debt = (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(arg2, *v2) as u128);
            };
            v0 = v0 + 1;
        };
        arg0.share = arg2;
    }

    public fun withdraw(arg0: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg1: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg2: &mut Pool, arg3: WrappedPositionNFT, arg4: &0x2::clock::Clock) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::checked_package_version(arg0);
        assert!(0x2::object::id<Pool>(arg2) == arg3.pool_id, 2);
        let WrappedPositionNFT {
            id           : v0,
            pool_id      : _,
            clmm_postion : v2,
            url          : _,
        } = arg3;
        let v4 = v2;
        let v5 = v0;
        let v6 = 0x2::object::uid_to_inner(&v5);
        0x2::object::delete(v5);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v4);
        let v8 = 0x2::linked_table::remove<0x2::object::ID, WrappedPositionInfo>(&mut arg2.positions, v6);
        let v9 = v8.share;
        let v10 = &mut v8;
        update_position_share(v10, 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::pool_rewards_settle(arg1, arg2.rewarders, v7, arg4), 0);
        arg2.total_share = arg2.total_share - v9;
        0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::set_pool_share(arg1, v7, arg2.total_share);
        let v11 = 0;
        while (v11 < 0x2::vec_map::size<0x1::type_name::TypeName, PositionRewardInfo>(&v8.rewards)) {
            let (_, v13) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, PositionRewardInfo>(&v8.rewards, v11);
            assert!(v13.reward == 0, 4);
            v11 = v11 + 1;
        };
        destory_wrapping_position_info(v8);
        let v14 = WithdrawEvent{
            pool_id             : 0x2::object::id<Pool>(arg2),
            wrapped_position_id : v6,
            clmm_pool_id        : v7,
            clmm_position_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v4),
            share               : v9,
        };
        0x2::event::emit<WithdrawEvent>(v14);
        v4
    }

    // decompiled from Move bytecode v6
}

