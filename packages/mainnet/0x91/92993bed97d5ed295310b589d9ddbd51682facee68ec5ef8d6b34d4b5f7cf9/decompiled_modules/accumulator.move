module 0x9192993bed97d5ed295310b589d9ddbd51682facee68ec5ef8d6b34d4b5f7cf9::accumulator {
    struct AccumulatorCap<phantom T0> has store {
        dummy_field: bool,
    }

    struct VaultValueAccumulator<phantom T0> {
        ticket: AccumulatorCap<T0>,
        pending_lending_markets: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<0x2::object::ID>>,
        lending_market_allocations: 0x2::vec_map::VecMap<0x1::type_name::TypeName, LendingMarketAllocation>,
    }

    struct VaultValueAggregate<phantom T0> {
        ticket: AccumulatorCap<T0>,
        liquid_asset_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        total_obligation_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        lending_market_allocations: 0x2::vec_map::VecMap<0x1::type_name::TypeName, LendingMarketAllocation>,
    }

    struct VaultCrankAccumulator<phantom T0> {
        acc: VaultValueAccumulator<T0>,
        main_pool_reserves: vector<0x1::type_name::TypeName>,
    }

    struct VaultUnwindAccumulator<phantom T0> {
        shares: 0x2::balance::Balance<T0>,
        pending_unwinds: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<UnwindTarget>>,
        agg: VaultValueAggregate<T0>,
    }

    struct LendingMarketAllocation has copy, drop {
        deposited_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        borrowed_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        net_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        obligations: vector<ObligationAllocation>,
    }

    struct ObligationAllocation has copy, drop, store {
        obligation_id: 0x2::object::ID,
        deposited_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        borrowed_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        net_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
    }

    struct UnwindTarget has drop {
        obligation_index: u64,
        usd_to_recover: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
    }

    fun aggregate_allocation_data(arg0: vector<ObligationAllocation>) : LendingMarketAllocation {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        let v3 = &arg0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<ObligationAllocation>(v3)) {
            let v5 = 0x1::vector::borrow<ObligationAllocation>(v3, v4);
            v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(v0, v5.deposited_value_usd);
            v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(v1, v5.borrowed_value_usd);
            v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(v2, v5.net_value_usd);
            v4 = v4 + 1;
        };
        LendingMarketAllocation{
            deposited_value_usd : v0,
            borrowed_value_usd  : v1,
            net_value_usd       : v2,
            obligations         : arg0,
        }
    }

    fun aggregate_lending_market_obligations(arg0: 0x2::vec_map::VecMap<0x1::type_name::TypeName, LendingMarketAllocation>) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        let v1 = 0x2::vec_map::keys<0x1::type_name::TypeName, LendingMarketAllocation>(&arg0);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
            v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(v0, 0x2::vec_map::get<0x1::type_name::TypeName, LendingMarketAllocation>(&arg0, &v3).net_value_usd);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v1);
        v0
    }

    fun assert_no_claimable_rewards<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &vector<0x1::type_name::TypeName>, arg2: 0x2::object::ID) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, arg2);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v2)) {
            let v4 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v2, v3);
            let v5 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(v4));
            let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::coin_type<T0>(v5);
            if (0x1::vector::contains<0x1::type_name::TypeName>(arg1, &v6)) {
                let v7 = get_claimable_reward_indexes(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::user_reward_managers<T0>(v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_user_reward_manager_index(v4)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::deposits_pool_reward_manager<T0>(v5));
                assert!(0x1::vector::is_empty<u64>(&v7), 13906835918100365317);
            };
            v3 = v3 + 1;
        };
        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<T0>(v1);
        let v9 = 0;
        while (v9 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v8)) {
            let v10 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v8, v9);
            let v11 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_reserve_array_index(v10));
            let v12 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::coin_type<T0>(v11);
            if (0x1::vector::contains<0x1::type_name::TypeName>(arg1, &v12)) {
                let v13 = get_claimable_reward_indexes(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::user_reward_managers<T0>(v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_user_reward_manager_index(v10)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::borrows_pool_reward_manager<T0>(v11));
                assert!(0x1::vector::is_empty<u64>(&v13), 13906836003999711237);
            };
            v9 = v9 + 1;
        };
    }

    fun calculate_obligation_values<T0>(arg0: vector<0x2::object::ID>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : vector<ObligationAllocation> {
        let v0 = 0x1::vector::empty<ObligationAllocation>();
        0x1::vector::reverse<0x2::object::ID>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0)) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg0);
            let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, v2);
            let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<T0>(v3);
            let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<T0>(v3);
            let v6 = ObligationAllocation{
                obligation_id       : v2,
                deposited_value_usd : v4,
                borrowed_value_usd  : v5,
                net_value_usd       : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_sub(v4, v5),
            };
            0x1::vector::push_back<ObligationAllocation>(&mut v0, v6);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg0);
        v0
    }

    fun calculate_unwind_plan<T0>(arg0: &VaultValueAggregate<T0>, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<UnwindTarget>> {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, vector<UnwindTarget>>();
        let v1 = arg1;
        let v2 = 0x2::vec_map::keys<0x1::type_name::TypeName, LendingMarketAllocation>(&arg0.lending_market_allocations);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2) && 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            let v4 = 0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
            let v5 = 0x1::vector::empty<UnwindTarget>();
            let v6 = &0x2::vec_map::get<0x1::type_name::TypeName, LendingMarketAllocation>(&arg0.lending_market_allocations, v4).obligations;
            let v7 = 0;
            while (v7 < 0x1::vector::length<ObligationAllocation>(v6) && 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
                let v8 = 0x1::vector::borrow<ObligationAllocation>(v6, v7).net_value_usd;
                if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(v8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
                    let v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::min(v1, v8);
                    let v10 = UnwindTarget{
                        obligation_index : v7,
                        usd_to_recover   : v9,
                    };
                    0x1::vector::push_back<UnwindTarget>(&mut v5, v10);
                    v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_sub(v1, v9);
                };
                v7 = v7 + 1;
            };
            if (!0x1::vector::is_empty<UnwindTarget>(&v5)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, vector<UnwindTarget>>(&mut v0, *v4, v5);
            };
            v3 = v3 + 1;
        };
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::eq(v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0)), 13906836377661997063);
        v0
    }

    public(friend) fun create_accumulator_cap<T0>() : AccumulatorCap<T0> {
        AccumulatorCap<T0>{dummy_field: false}
    }

    public(friend) fun create_unwind_accumulator<T0>(arg0: VaultValueAggregate<T0>, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg2: 0x2::balance::Balance<T0>) : VaultUnwindAccumulator<T0> {
        VaultUnwindAccumulator<T0>{
            shares          : arg2,
            pending_unwinds : calculate_unwind_plan<T0>(&arg0, arg1),
            agg             : arg0,
        }
    }

    public(friend) fun create_vault_crank_accumulator<T0>(arg0: AccumulatorCap<T0>, arg1: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<0x2::object::ID>>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) : VaultCrankAccumulator<T0> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::coin_type<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(v0, v2)));
            v2 = v2 + 1;
        };
        VaultCrankAccumulator<T0>{
            acc                : create_vault_value_accumulator<T0>(arg0, arg1),
            main_pool_reserves : v1,
        }
    }

    public(friend) fun create_vault_value_accumulator<T0>(arg0: AccumulatorCap<T0>, arg1: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<0x2::object::ID>>) : VaultValueAccumulator<T0> {
        VaultValueAccumulator<T0>{
            ticket                     : arg0,
            pending_lending_markets    : arg1,
            lending_market_allocations : 0x2::vec_map::empty<0x1::type_name::TypeName, LendingMarketAllocation>(),
        }
    }

    public(friend) fun destroy_vault_value_aggregate<T0>(arg0: VaultValueAggregate<T0>) : AccumulatorCap<T0> {
        let VaultValueAggregate {
            ticket                     : v0,
            liquid_asset_value_usd     : _,
            total_obligation_value_usd : _,
            lending_market_allocations : _,
        } = arg0;
        v0
    }

    public(friend) fun finalize_crank_accumulator<T0, T1, T2>(arg0: VaultCrankAccumulator<T0>, arg1: &0x2::balance::Balance<T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock) : VaultValueAggregate<T0> {
        let VaultCrankAccumulator {
            acc                : v0,
            main_pool_reserves : _,
        } = arg0;
        finalize_vault_value_accumulator<T0, T1, T2>(v0, arg1, arg2, arg3)
    }

    public(friend) fun finalize_unwind_accumulator<T0, T1, T2>(arg0: VaultUnwindAccumulator<T0>, arg1: &0x2::balance::Balance<T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, VaultValueAggregate<T0>) {
        assert!(0x2::vec_map::is_empty<0x1::type_name::TypeName, vector<UnwindTarget>>(&arg0.pending_unwinds), 13906835449948798979);
        let VaultUnwindAccumulator {
            shares          : v0,
            pending_unwinds : _,
            agg             : v2,
        } = arg0;
        let v3 = v2;
        let v4 = &mut v3;
        refresh_liquid_asset_value<T0, T1, T2>(v4, arg1, arg2, arg3);
        (v0, v3)
    }

    public(friend) fun finalize_vault_value_accumulator<T0, T1, T2>(arg0: VaultValueAccumulator<T0>, arg1: &0x2::balance::Balance<T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock) : VaultValueAggregate<T0> {
        assert!(0x2::vec_map::is_empty<0x1::type_name::TypeName, vector<0x2::object::ID>>(&arg0.pending_lending_markets), 13906834938847690755);
        let VaultValueAccumulator {
            ticket                     : v0,
            pending_lending_markets    : _,
            lending_market_allocations : v2,
        } = arg0;
        VaultValueAggregate<T0>{
            ticket                     : v0,
            liquid_asset_value_usd     : 0x9192993bed97d5ed295310b589d9ddbd51682facee68ec5ef8d6b34d4b5f7cf9::utils::token_amount_to_usd<T2, T1>(0x2::balance::value<T1>(arg1), arg2, arg3),
            total_obligation_value_usd : aggregate_lending_market_obligations(v2),
            lending_market_allocations : v2,
        }
    }

    fun get_claimable_reward_indexes(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolRewardManager) : vector<u64> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::rewards(arg0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::pool_rewards(arg1);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v0)) {
            let v4 = 0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v0, v3);
            if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>(v4)) {
                if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::earned_rewards(0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>(v4)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
                    if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v1, v3))) {
                        0x1::vector::push_back<u64>(&mut v2, v3);
                    };
                };
            };
            v3 = v3 + 1;
        };
        v2
    }

    public(friend) fun get_next_unwind_targets<T0, T1>(arg0: &mut VaultUnwindAccumulator<T0>) : 0x1::option::Option<vector<UnwindTarget>> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, vector<UnwindTarget>>(&arg0.pending_unwinds, &v0)) {
            return 0x1::option::none<vector<UnwindTarget>>()
        };
        let (v1, v2) = 0x2::vec_map::remove_entry_by_idx<0x1::type_name::TypeName, vector<UnwindTarget>>(&mut arg0.pending_unwinds, 0);
        assert!(v1 == v0, 13906835754891345921);
        let v3 = v2;
        if (0x1::vector::is_empty<UnwindTarget>(&v3)) {
            return 0x1::option::none<vector<UnwindTarget>>()
        };
        0x1::option::some<vector<UnwindTarget>>(v3)
    }

    public fun lending_market_allocations<T0>(arg0: &VaultValueAggregate<T0>) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, LendingMarketAllocation> {
        arg0.lending_market_allocations
    }

    public fun liquid_asset_value_usd<T0>(arg0: &VaultValueAggregate<T0>) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        arg0.liquid_asset_value_usd
    }

    public fun obligation_index(arg0: &UnwindTarget) : u64 {
        arg0.obligation_index
    }

    public(friend) fun process_lending_market_for_crank<T0, T1>(arg0: &mut VaultCrankAccumulator<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<0x2::object::ID>>(&mut arg0.acc.pending_lending_markets, &v0);
        let v3 = v2;
        0x1::vector::reverse<0x2::object::ID>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&v3)) {
            assert_no_claimable_rewards<T1>(arg1, &arg0.main_pool_reserves, 0x1::vector::pop_back<0x2::object::ID>(&mut v3));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v3);
        0x2::vec_map::insert<0x1::type_name::TypeName, LendingMarketAllocation>(&mut arg0.acc.lending_market_allocations, v0, aggregate_allocation_data(calculate_obligation_values<T1>(v2, arg1)));
    }

    public(friend) fun process_lending_market_for_value_accumulator<T0, T1>(arg0: &mut VaultValueAccumulator<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let (v1, v2) = 0x2::vec_map::remove_entry_by_idx<0x1::type_name::TypeName, vector<0x2::object::ID>>(&mut arg0.pending_lending_markets, 0);
        assert!(v1 == v0, 13906834852948213761);
        0x2::vec_map::insert<0x1::type_name::TypeName, LendingMarketAllocation>(&mut arg0.lending_market_allocations, v0, aggregate_allocation_data(calculate_obligation_values<T1>(v2, arg1)));
    }

    public(friend) fun refresh_aggregate_for_lending_market<T0, T1>(arg0: &mut VaultValueAggregate<T0>, arg1: vector<0x2::object::ID>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, LendingMarketAllocation>(&mut arg0.lending_market_allocations, &v0) = aggregate_allocation_data(calculate_obligation_values<T1>(arg1, arg2));
        arg0.total_obligation_value_usd = aggregate_lending_market_obligations(arg0.lending_market_allocations);
    }

    public(friend) fun refresh_liquid_asset_value<T0, T1, T2>(arg0: &mut VaultValueAggregate<T0>, arg1: &0x2::balance::Balance<T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock) {
        arg0.liquid_asset_value_usd = 0x9192993bed97d5ed295310b589d9ddbd51682facee68ec5ef8d6b34d4b5f7cf9::utils::token_amount_to_usd<T2, T1>(0x2::balance::value<T1>(arg1), arg2, arg3);
    }

    public(friend) fun refresh_unwind_aggregate_for_lending_market<T0, T1>(arg0: &mut VaultUnwindAccumulator<T0>, arg1: vector<0x2::object::ID>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) {
        let v0 = &mut arg0.agg;
        refresh_aggregate_for_lending_market<T0, T1>(v0, arg1, arg2);
    }

    public fun total_obligation_value_usd<T0>(arg0: &VaultValueAggregate<T0>) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        arg0.total_obligation_value_usd
    }

    public fun usd_to_recover(arg0: &UnwindTarget) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        arg0.usd_to_recover
    }

    // decompiled from Move bytecode v6
}

