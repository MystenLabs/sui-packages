module 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator {
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
        pending_obligations_for_refresh: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<0x2::object::ID>>,
    }

    struct VaultUnwindAccumulator<phantom T0> {
        shares: 0x2::balance::Balance<T0>,
        base_token_value_of_shares: u64,
        pending_unwinds: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<0x2::object::ID>>,
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

    fun assert_no_claimable_rewards<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: 0x2::object::ID) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, arg2);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v2)) {
            let v4 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v2, v3);
            let v5 = get_unclaimed_reward_indexes(arg1, 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::user_reward_managers<T0>(v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_user_reward_manager_index(v4)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::deposits_pool_reward_manager<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(v4))));
            assert!(0x1::vector::is_empty<u64>(&v5), 13906835913805463558);
            v3 = v3 + 1;
        };
        let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<T0>(v1);
        let v7 = 0;
        while (v7 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v6)) {
            let v8 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v6, v7);
            let v9 = get_unclaimed_reward_indexes(arg1, 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::user_reward_managers<T0>(v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_user_reward_manager_index(v8)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::borrows_pool_reward_manager<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_reserve_array_index(v8))));
            assert!(0x1::vector::is_empty<u64>(&v9), 13906835995409842182);
            v7 = v7 + 1;
        };
    }

    public fun base_token_value_of_shares<T0>(arg0: &VaultUnwindAccumulator<T0>) : u64 {
        arg0.base_token_value_of_shares
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
            assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::eq(v5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0)), 13906836403431997450);
            let v6 = ObligationAllocation{
                obligation_id       : v2,
                deposited_value_usd : v4,
                borrowed_value_usd  : v5,
                net_value_usd       : v4,
            };
            0x1::vector::push_back<ObligationAllocation>(&mut v0, v6);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg0);
        v0
    }

    public(friend) fun create_accumulator_cap<T0>() : AccumulatorCap<T0> {
        AccumulatorCap<T0>{dummy_field: false}
    }

    public(friend) fun create_unwind_accumulator<T0>(arg0: VaultValueAggregate<T0>, arg1: u64, arg2: 0x2::balance::Balance<T0>) : VaultUnwindAccumulator<T0> {
        let (v0, v1) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, LendingMarketAllocation>(arg0.lending_market_allocations);
        let v2 = 0x1::vector::empty<vector<0x2::object::ID>>();
        let v3 = v1;
        0x1::vector::reverse<LendingMarketAllocation>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<LendingMarketAllocation>(&v3)) {
            let v5 = 0x1::vector::pop_back<LendingMarketAllocation>(&mut v3);
            let v6 = &v5.obligations;
            let v7 = 0x1::vector::empty<0x2::object::ID>();
            let v8 = 0;
            while (v8 < 0x1::vector::length<ObligationAllocation>(v6)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v7, 0x1::vector::borrow<ObligationAllocation>(v6, v8).obligation_id);
                v8 = v8 + 1;
            };
            0x1::vector::push_back<vector<0x2::object::ID>>(&mut v2, v7);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<LendingMarketAllocation>(v3);
        VaultUnwindAccumulator<T0>{
            shares                     : arg2,
            base_token_value_of_shares : arg1,
            pending_unwinds            : 0x2::vec_map::from_keys_values<0x1::type_name::TypeName, vector<0x2::object::ID>>(v0, v2),
            agg                        : arg0,
        }
    }

    public(friend) fun create_vault_crank_accumulator<T0>(arg0: AccumulatorCap<T0>, arg1: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<0x2::object::ID>>) : VaultCrankAccumulator<T0> {
        VaultCrankAccumulator<T0>{
            acc                             : create_vault_value_accumulator<T0>(arg0, arg1),
            pending_obligations_for_refresh : arg1,
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
            acc                             : v0,
            pending_obligations_for_refresh : _,
        } = arg0;
        finalize_vault_value_accumulator<T0, T1, T2>(v0, arg1, arg2, arg3)
    }

    public(friend) fun finalize_unwind_accumulator<T0, T1, T2>(arg0: VaultUnwindAccumulator<T0>, arg1: &0x2::balance::Balance<T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, u64, VaultValueAggregate<T0>) {
        let VaultUnwindAccumulator {
            shares                     : v0,
            base_token_value_of_shares : v1,
            pending_unwinds            : _,
            agg                        : v3,
        } = arg0;
        let v4 = v3;
        let v5 = &mut v4;
        refresh_liquid_asset_value<T0, T1, T2>(v5, arg1, arg2, arg3);
        (v0, v1, v4)
    }

    public(friend) fun finalize_vault_value_accumulator<T0, T1, T2>(arg0: VaultValueAccumulator<T0>, arg1: &0x2::balance::Balance<T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock) : VaultValueAggregate<T0> {
        assert!(0x2::vec_map::is_empty<0x1::type_name::TypeName, vector<0x2::object::ID>>(&arg0.pending_lending_markets), 13906834878718214148);
        let VaultValueAccumulator {
            ticket                     : v0,
            pending_lending_markets    : _,
            lending_market_allocations : v2,
        } = arg0;
        VaultValueAggregate<T0>{
            ticket                     : v0,
            liquid_asset_value_usd     : 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::utils::token_amount_to_usd<T2, T1>(0x2::balance::value<T1>(arg1), arg2, arg3),
            total_obligation_value_usd : aggregate_lending_market_obligations(v2),
            lending_market_allocations : v2,
        }
    }

    public(friend) fun get_next_unwind_targets<T0, T1>(arg0: &mut VaultUnwindAccumulator<T0>) : vector<0x2::object::ID> {
        let (v0, v1) = 0x2::vec_map::remove_entry_by_idx<0x1::type_name::TypeName, vector<0x2::object::ID>>(&mut arg0.pending_unwinds, 0);
        assert!(v0 == 0x1::type_name::with_defining_ids<T1>(), 13906835780661215234);
        v1
    }

    fun get_unclaimed_reward_indexes(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolRewardManager) : vector<u64> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::rewards(arg1);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::pool_rewards(arg2);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v0)) {
            let v5 = 0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v0, v4);
            let v6;
            let v7;
            if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>(v5)) {
                let v8 = 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>(v5);
                if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::earned_rewards(v8), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
                    let v9 = 0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v1, v4);
                    if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>(v9)) {
                        let v10 = 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>(v9);
                        v7 = 0;
                        while (v7 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(v2)) {
                            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::coin_type<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(v2, v7)) == 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::coin_type(v10)) {
                                v6 = 0x1::option::some<u64>(v7);
                                /* label 15 */
                                if (0x1::option::is_some<u64>(&v6)) {
                                    if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ge(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::market_value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(v2, *0x1::option::borrow<u64>(&v6)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::earned_rewards(v8)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_scaled_val(1000000000000000000))) {
                                        0x1::vector::push_back<u64>(&mut v3, v4);
                                        /* goto 19 */
                                    } else {
                                        /* goto 19 */
                                    };
                                } else {
                                    /* goto 19 */
                                };
                            } else {
                                /* goto 20 */
                            };
                        };
                    };
                };
            };
            /* label 19 */
            v4 = v4 + 1;
            continue;
            /* label 20 */
            v7 = v7 + 1;
            /* goto 10 */
            continue;
            v6 = 0x1::option::none<u64>();
            /* goto 15 */
        };
        v3
    }

    public fun lending_market_allocations<T0>(arg0: &VaultValueAggregate<T0>) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, LendingMarketAllocation> {
        arg0.lending_market_allocations
    }

    public fun liquid_asset_value_usd<T0>(arg0: &VaultValueAggregate<T0>) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        arg0.liquid_asset_value_usd
    }

    public(friend) fun process_lending_market_for_crank<T0, T1>(arg0: &mut VaultCrankAccumulator<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_map::is_empty<0x1::type_name::TypeName, vector<0x2::object::ID>>(&arg0.pending_obligations_for_refresh), 13906835218020892680);
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<0x2::object::ID>>(&mut arg0.acc.pending_lending_markets, &v0);
        let v3 = v2;
        0x1::vector::reverse<0x2::object::ID>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&v3)) {
            assert_no_claimable_rewards<T1>(arg1, arg2, 0x1::vector::pop_back<0x2::object::ID>(&mut v3));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v3);
        0x2::vec_map::insert<0x1::type_name::TypeName, LendingMarketAllocation>(&mut arg0.acc.lending_market_allocations, v0, aggregate_allocation_data(calculate_obligation_values<T1>(v2, arg1)));
    }

    public(friend) fun process_lending_market_for_value_accumulator<T0, T1>(arg0: &mut VaultValueAccumulator<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let (v1, v2) = 0x2::vec_map::remove_entry_by_idx<0x1::type_name::TypeName, vector<0x2::object::ID>>(&mut arg0.pending_lending_markets, 0);
        assert!(v1 == v0, 13906834792818737154);
        0x2::vec_map::insert<0x1::type_name::TypeName, LendingMarketAllocation>(&mut arg0.lending_market_allocations, v0, aggregate_allocation_data(calculate_obligation_values<T1>(v2, arg1)));
    }

    public(friend) fun refresh_aggregate_for_lending_market<T0, T1>(arg0: &mut VaultValueAggregate<T0>, arg1: vector<0x2::object::ID>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, LendingMarketAllocation>(&mut arg0.lending_market_allocations, &v0) = aggregate_allocation_data(calculate_obligation_values<T1>(arg1, arg2));
        arg0.total_obligation_value_usd = aggregate_lending_market_obligations(arg0.lending_market_allocations);
    }

    public(friend) fun refresh_liquid_asset_value<T0, T1, T2>(arg0: &mut VaultValueAggregate<T0>, arg1: &0x2::balance::Balance<T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock) {
        arg0.liquid_asset_value_usd = 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::utils::token_amount_to_usd<T2, T1>(0x2::balance::value<T1>(arg1), arg2, arg3);
    }

    public(friend) fun refresh_obligations_for_crank<T0, T1>(arg0: &mut VaultCrankAccumulator<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<0x2::object::ID>>(&mut arg0.pending_obligations_for_refresh, &v0);
        let v3 = v2;
        let v4 = &v3;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(v4)) {
            let v6 = 0x1::vector::borrow<0x2::object::ID>(v4, v5);
            if (!0x1::vector::is_empty<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T1>(arg1, *v6)))) {
                0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T1>(arg1, *v6, arg2);
            };
            v5 = v5 + 1;
        };
    }

    public(friend) fun refresh_unwind_aggregate_for_lending_market<T0, T1>(arg0: &mut VaultUnwindAccumulator<T0>, arg1: vector<0x2::object::ID>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) {
        let v0 = &mut arg0.agg;
        refresh_aggregate_for_lending_market<T0, T1>(v0, arg1, arg2);
    }

    public fun total_obligation_value_usd<T0>(arg0: &VaultValueAggregate<T0>) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        arg0.total_obligation_value_usd
    }

    // decompiled from Move bytecode v6
}

