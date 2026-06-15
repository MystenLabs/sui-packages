module 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor {
    struct AllowedPoolsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SwapInfoMapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MaxPriceAgeSecsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinSwapInfo has copy, drop, store {
        market_id: u64,
    }

    struct Investor<phantom T0> has store, key {
        id: 0x2::object::UID,
        alphalend_position_cap: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap,
        free_rewards: 0x2::bag::Bag,
        tokensDeposited: u64,
        allowed_coin_types_for_swap: 0x2::vec_map::VecMap<0x1::type_name::TypeName, bool>,
        minimum_swap_amount: u64,
        market_id: u64,
    }

    struct RewardEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        location: u64,
    }

    struct AutoCompoundingEvent has copy, drop {
        investor_id: 0x2::object::ID,
        compound_amount: u64,
        total_amount: u64,
        fee_collected: u64,
        location: u64,
    }

    struct LessExternalRewards has copy, drop {
        amount: u64,
        total_external_rewards: u64,
    }

    struct InterestAccrualEvent has copy, drop {
        pool_id: 0x2::object::ID,
        accrued_interest: u64,
        interest_based_reward: u64,
        interest_based_fees: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    public(friend) fun add_allowed_pool<T0>(arg0: &mut Investor<T0>, arg1: 0x2::object::ID, arg2: u64) {
        assert!(arg2 <= 500, 2008);
        let v0 = AllowedPoolsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<AllowedPoolsKey>(&arg0.id, v0)) {
            let v1 = AllowedPoolsKey{dummy_field: false};
            0x2::dynamic_field::add<AllowedPoolsKey, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut arg0.id, v1, 0x2::vec_map::empty<0x2::object::ID, u64>());
        };
        let v2 = AllowedPoolsKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<AllowedPoolsKey, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut arg0.id, v2);
        if (0x2::vec_map::contains<0x2::object::ID, u64>(v3, &arg1)) {
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(v3, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x2::object::ID, u64>(v3, arg1, arg2);
        };
    }

    public(friend) fun add_or_remove_coin_type_for_swap<T0>(arg0: &mut Investor<T0>, arg1: 0x1::type_name::TypeName, arg2: u8) {
        if (arg2 == 1 && !0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_coin_types_for_swap, &arg1)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, bool>(&mut arg0.allowed_coin_types_for_swap, arg1, true);
        } else if (arg2 == 0 && 0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_coin_types_for_swap, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, bool>(&mut arg0.allowed_coin_types_for_swap, &arg1);
        };
    }

    fun assert_price_slippage<T0, T1, T2>(arg0: &Investor<T0>, arg1: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = SwapInfoMapKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<SwapInfoMapKey>(&arg0.id, v0), 2005);
        let v1 = SwapInfoMapKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<SwapInfoMapKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, CoinSwapInfo>>(&arg0.id, v1);
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        let v4 = 0x1::type_name::with_defining_ids<T2>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, CoinSwapInfo>(v2, &v3), 2005);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, CoinSwapInfo>(v2, &v4), 2005);
        let v5 = *0x2::vec_map::get<0x1::type_name::TypeName, CoinSwapInfo>(v2, &v3);
        let v6 = *0x2::vec_map::get<0x1::type_name::TypeName, CoinSwapInfo>(v2, &v4);
        let v7 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v8 = get_max_price_age_secs<T0>(arg0);
        let v9 = 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_price_info(arg1, v3);
        let v10 = 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_updated_time(&v9);
        let v11 = 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_price_info(arg1, v4);
        let v12 = 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::get_updated_time(&v11);
        assert!(v7 >= v10 && v7 - v10 <= v8, 2007);
        assert!(v7 >= v12 && v7 - v12 <= v8, 2007);
        assert!(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::ge(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg4), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_asset_price(arg2, v6.market_id)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg3), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_asset_price(arg2, v5.market_id)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(10000 - arg5))), 2006);
    }

    public(friend) fun autocompound<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg1, arg3);
        if (v0 == 0) {
            return
        };
        let v1 = if (v0 > arg0.tokensDeposited) {
            v0 - arg0.tokensDeposited
        } else {
            0
        };
        let v2 = 0x2::balance::zero<T0>();
        if (v1 > 0) {
            let v3 = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
                let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<0x2::sui::SUI>(arg1, &arg0.alphalend_position_cap, arg0.market_id, v1, arg3), arg2, arg3, arg4));
                recast_balance_type<T0, 0x2::sui::SUI, T0>(arg0, v4)
            } else {
                0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, v1, arg3), arg3, arg4))
            };
            0x2::balance::join<T0>(&mut v2, v3);
        };
        let v5 = collect_reward<T0, T0>(arg0, arg1, arg3, arg4);
        0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(v5));
        let v6 = RewardEvent{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v1,
            location  : 30,
        };
        0x2::event::emit<RewardEvent>(v6);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T0>()) == true) {
            0x2::balance::join<T0>(&mut v2, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T0>())));
        };
        let v7 = get_total_invested<T0>(arg0, arg1, arg3);
        let v8 = AutoCompoundingEvent{
            investor_id     : 0x2::object::uid_to_inner(&arg0.id),
            compound_amount : 0x2::balance::value<T0>(&v2),
            total_amount    : v7,
            fee_collected   : 0,
            location        : 1,
        };
        0x2::event::emit<AutoCompoundingEvent>(v8);
        if (0x2::balance::value<T0>(&v2) > 0) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, 0x2::coin::from_balance<T0>(v2, arg4), arg3, arg4);
        } else {
            0x2::balance::destroy_zero<T0>(v2);
        };
        arg0.tokensDeposited = get_total_invested<T0>(arg0, arg1, arg3);
    }

    fun collect_reward<T0, T1>(arg0: &Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T1>(arg1, arg0.market_id, &arg0.alphalend_position_cap, arg2, arg3);
        let v2 = v0;
        0x2::coin::join<T1>(&mut v2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg1, v1, arg2, arg3));
        v2
    }

    public(friend) fun collect_reward_and_swap_bluefin<T0, T1, T2>(arg0: &mut Investor<T0>, arg1: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::Oracle, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: bool, arg6: bool, arg7: 0x1::option::Option<u64>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested<T0>(arg0, arg2, arg9);
        if (v0 == 0) {
            return
        };
        let v1 = if (0x1::option::is_some<u64>(&arg7)) {
            let v2 = *0x1::option::borrow<u64>(&arg7);
            assert!(v2 <= 10000, 2008);
            v2
        } else if (arg8) {
            10000
        } else {
            get_pool_slippage_bps<T0>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg3))
        };
        let v3 = 0x2::balance::zero<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>()) == true) {
            0x2::balance::join<T1>(&mut v3, 0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>())));
        };
        let v4 = 0x2::balance::zero<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>()) == true) {
            0x2::balance::join<T2>(&mut v4, 0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>())));
        };
        if (arg5) {
            let v5 = collect_reward<T0, T1>(arg0, arg2, arg9, arg10);
            0x2::balance::join<T1>(&mut v3, 0x2::coin::into_balance<T1>(v5));
            let v6 = 0x2::balance::value<T1>(&v3);
            if (v6 >= arg0.minimum_swap_amount && arg6) {
                let (v7, _) = get_bluefin_sqrt_price_limits<T1, T2>(arg3);
                let (v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T2>(arg9, arg4, arg3, v3, 0x2::balance::zero<T2>(), true, true, v6, 0, v7);
                let v11 = v10;
                let v12 = v9;
                assert!(0x2::balance::value<T1>(&v12) == 0, 2000);
                0x2::balance::destroy_zero<T1>(v12);
                if (!arg8) {
                    assert_price_slippage<T0, T1, T2>(arg0, arg1, arg2, v6, 0x2::balance::value<T2>(&v11), v1, arg9);
                };
                0x2::balance::join<T2>(&mut v4, v11);
                update_free_rewards<T0, T2>(arg0, v4);
            } else {
                update_free_rewards<T0, T1>(arg0, v3);
                update_free_rewards<T0, T2>(arg0, v4);
            };
        } else {
            let v13 = collect_reward<T0, T2>(arg0, arg2, arg9, arg10);
            0x2::balance::join<T2>(&mut v4, 0x2::coin::into_balance<T2>(v13));
            let v14 = 0x2::balance::value<T2>(&v4);
            if (v14 >= arg0.minimum_swap_amount && arg6) {
                let (_, v16) = get_bluefin_sqrt_price_limits<T1, T2>(arg3);
                let (v17, v18) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T2>(arg9, arg4, arg3, 0x2::balance::zero<T1>(), v4, false, true, v14, 0, v16);
                let v19 = v18;
                let v20 = v17;
                assert!(0x2::balance::value<T2>(&v19) == 0, 2001);
                0x2::balance::destroy_zero<T2>(v19);
                if (!arg8) {
                    assert_price_slippage<T0, T2, T1>(arg0, arg1, arg2, v14, 0x2::balance::value<T1>(&v20), v1, arg9);
                };
                0x2::balance::join<T1>(&mut v3, v20);
                update_free_rewards<T0, T1>(arg0, v3);
            } else {
                update_free_rewards<T0, T2>(arg0, v4);
                update_free_rewards<T0, T1>(arg0, v3);
            };
        };
    }

    public(friend) fun create_investor<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: u64, arg2: 0x2::vec_map::VecMap<0x1::type_name::TypeName, bool>, arg3: &mut 0x2::tx_context::TxContext) : Investor<T0> {
        Investor<T0>{
            id                          : 0x2::object::new(arg3),
            alphalend_position_cap      : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg0, arg3),
            free_rewards                : 0x2::bag::new(arg3),
            tokensDeposited             : 0,
            allowed_coin_types_for_swap : arg2,
            minimum_swap_amount         : 200000,
            market_id                   : arg1,
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, arg2, arg3, arg4);
        arg0.tokensDeposited = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg1, arg0.market_id, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.alphalend_position_cap), arg3) as u64);
    }

    public(friend) fun get_bluefin_sqrt_price_limits<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : (u128, u128) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v2 = if (v0 >= 100 && v0 <= 500) {
            v1 * 999499874 / 1000000000
        } else if (v0 > 500 && v0 <= 2500) {
            v1 * 997496867 / 1000000000
        } else if (v0 > 2500 && v0 <= 10000) {
            v1 * 992471662 / 1000000000
        } else {
            v1 * 987420882 / 1000000000
        };
        let v3 = if (v0 >= 100 && v0 <= 500) {
            v1 * 1000499875 / 1000000000
        } else if (v0 > 500 && v0 <= 2500) {
            v1 * 1002496882 / 1000000000
        } else if (v0 > 2500 && v0 <= 10000) {
            v1 * 1007472083 / 1000000000
        } else {
            v1 * 1012422836 / 1000000000
        };
        (v2, v3)
    }

    fun get_max_price_age_secs<T0>(arg0: &Investor<T0>) : u64 {
        let v0 = MaxPriceAgeSecsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MaxPriceAgeSecsKey>(&arg0.id, v0)) {
            let v2 = MaxPriceAgeSecsKey{dummy_field: false};
            *0x2::dynamic_field::borrow<MaxPriceAgeSecsKey, u64>(&arg0.id, v2)
        } else {
            63
        }
    }

    fun get_pool_slippage_bps<T0>(arg0: &Investor<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = AllowedPoolsKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<AllowedPoolsKey>(&arg0.id, v0), 2004);
        let v1 = AllowedPoolsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<AllowedPoolsKey, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&arg0.id, v1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(v2, &arg1), 2004);
        *0x2::vec_map::get<0x2::object::ID, u64>(v2, &arg1)
    }

    public(friend) fun get_total_invested<T0>(arg0: &Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : u64 {
        if (arg0.tokensDeposited == 0) {
            return 0
        };
        (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg1, arg0.market_id, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.alphalend_position_cap), arg2) as u64)
    }

    public(friend) fun has_unclaimed_rewards<T0>(arg0: &Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_claimable_rewards(arg1, &arg0.alphalend_position_cap, arg2);
        0x1::vector::length<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::ClaimableReward>(&v0) > 0
    }

    public(friend) fun recast_balance_type<T0, T1, T2>(arg0: &mut Investor<T0>, arg1: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T2> {
        assert!(0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<T2>(), 2003);
        update_free_rewards<T0, T1>(arg0, arg1);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>()) == true, 13906834805703573503);
        0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>()), 0x2::balance::value<T1>(&arg1))
    }

    public(friend) fun remove_allowed_pool<T0>(arg0: &mut Investor<T0>, arg1: 0x2::object::ID) {
        let v0 = AllowedPoolsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<AllowedPoolsKey>(&arg0.id, v0)) {
            return
        };
        let v1 = AllowedPoolsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<AllowedPoolsKey, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut arg0.id, v1);
        if (0x2::vec_map::contains<0x2::object::ID, u64>(v2, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(v2, &arg1);
        };
    }

    public(friend) fun remove_coin_swap_info<T0>(arg0: &mut Investor<T0>, arg1: 0x1::type_name::TypeName) {
        let v0 = SwapInfoMapKey{dummy_field: false};
        if (0x2::dynamic_field::exists<SwapInfoMapKey>(&arg0.id, v0)) {
            let v1 = SwapInfoMapKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<SwapInfoMapKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, CoinSwapInfo>>(&mut arg0.id, v1);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, CoinSwapInfo>(v2, &arg1)) {
                let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, CoinSwapInfo>(v2, &arg1);
            };
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_coin_types_for_swap, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, bool>(&mut arg0.allowed_coin_types_for_swap, &arg1);
        };
    }

    public(friend) fun set_coin_swap_info<T0>(arg0: &mut Investor<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = SwapInfoMapKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SwapInfoMapKey>(&arg0.id, v0)) {
            let v1 = SwapInfoMapKey{dummy_field: false};
            0x2::dynamic_field::add<SwapInfoMapKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, CoinSwapInfo>>(&mut arg0.id, v1, 0x2::vec_map::empty<0x1::type_name::TypeName, CoinSwapInfo>());
        };
        let v2 = SwapInfoMapKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<SwapInfoMapKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, CoinSwapInfo>>(&mut arg0.id, v2);
        let v4 = CoinSwapInfo{market_id: arg2};
        if (0x2::vec_map::contains<0x1::type_name::TypeName, CoinSwapInfo>(v3, &arg1)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, CoinSwapInfo>(v3, &arg1) = v4;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, CoinSwapInfo>(v3, arg1, v4);
        };
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_coin_types_for_swap, &arg1)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, bool>(&mut arg0.allowed_coin_types_for_swap, arg1, true);
        };
    }

    public(friend) fun set_max_price_age_secs<T0>(arg0: &mut Investor<T0>, arg1: u64) {
        let v0 = MaxPriceAgeSecsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MaxPriceAgeSecsKey>(&arg0.id, v0)) {
            let v1 = MaxPriceAgeSecsKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<MaxPriceAgeSecsKey, u64>(&mut arg0.id, v1) = arg1;
        } else {
            let v2 = MaxPriceAgeSecsKey{dummy_field: false};
            0x2::dynamic_field::add<MaxPriceAgeSecsKey, u64>(&mut arg0.id, v2, arg1);
        };
    }

    public(friend) fun set_minimum_swap_amount<T0>(arg0: &mut Investor<T0>, arg1: u64) {
        arg0.minimum_swap_amount = arg1;
    }

    public(friend) fun split_interest_based_reward<T0>(arg0: &mut Investor<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg3: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock) : u64 {
        let v0 = get_total_invested<T0>(arg0, arg4, arg6);
        if (v0 == 0) {
            return 0
        };
        let v1 = if (v0 > arg0.tokensDeposited) {
            v0 - arg0.tokensDeposited
        } else {
            0
        };
        let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v0), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1)), arg2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensDeposited)));
        let v3 = v2;
        if (v2 > 0x2::balance::value<T0>(arg1)) {
            let v4 = LessExternalRewards{
                amount                 : v2,
                total_external_rewards : 0x2::balance::value<T0>(arg1),
            };
            0x2::event::emit<LessExternalRewards>(v4);
            v3 = 0x2::balance::value<T0>(arg1);
        };
        let v5 = RewardEvent{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v3,
            location  : 1,
        };
        0x2::event::emit<RewardEvent>(v5);
        update_free_rewards<T0, T0>(arg0, 0x2::balance::split<T0>(arg1, v3));
        let v6 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1), arg3));
        let v7 = InterestAccrualEvent{
            pool_id               : arg5,
            accrued_interest      : v1,
            interest_based_reward : v3,
            interest_based_fees   : v6,
            coin_type             : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<InterestAccrualEvent>(v7);
        v6
    }

    public(friend) fun update_free_rewards<T0, T1>(arg0: &mut Investor<T0>, arg1: 0x2::balance::Balance<T1>) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>()) == true) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>()), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T1>(), arg1);
        };
    }

    public(friend) fun withdraw_from_alphalend<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: u64, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = get_total_invested<T0>(arg0, arg1, arg5);
        let v1 = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<0x2::sui::SUI>(arg1, &arg0.alphalend_position_cap, arg0.market_id, (((arg2 as u256) * (v0 as u256) / (arg3 as u256)) as u64), arg5), arg4, arg5, arg6));
            recast_balance_type<T0, 0x2::sui::SUI, T0>(arg0, v2)
        } else {
            0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg1, &arg0.alphalend_position_cap, arg0.market_id, (((arg2 as u256) * (v0 as u256) / (arg3 as u256)) as u64), arg5), arg5, arg6))
        };
        arg0.tokensDeposited = get_total_invested<T0>(arg0, arg1, arg5);
        v1
    }

    // decompiled from Move bytecode v7
}

