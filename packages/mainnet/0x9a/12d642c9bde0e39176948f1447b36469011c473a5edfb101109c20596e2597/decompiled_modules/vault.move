module 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::vault {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        version: 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::Version,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        obligations: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<ObligationData>>,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        deposit_asset: 0x2::balance::Balance<T1>,
        manager_fees: 0x2::balance::Balance<T0>,
        management_fee_bps: u64,
        performance_fee_bps: u64,
        deposit_fee_bps: u64,
        withdrawal_fee_bps: u64,
        accumulator_cap: 0x1::option::Option<0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::AccumulatorCap<T0>>,
        redemption_ratio_high_water_mark: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        last_cranked_ms: u64,
        trusted_market: 0x1::type_name::TypeName,
    }

    struct VaultManagerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct ObligationCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SwapTicket<phantom T0, phantom T1> {
        min_amount_out: 0x1::option::Option<u64>,
    }

    struct RewardWithdrawTicket<phantom T0, phantom T1, phantom T2> {
        reward: 0x2::balance::Balance<T2>,
    }

    struct ObligationData has store {
        obligation_cap: 0x2::bag::Bag,
        obligation_id: 0x2::object::ID,
    }

    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        management_fee_bps: u64,
        performance_fee_bps: u64,
        deposit_fee_bps: u64,
        withdrawal_fee_bps: u64,
    }

    struct VaultDepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        deposit_amount: u64,
        shares_minted: u64,
        timestamp_ms: u64,
    }

    struct VaultWithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        amount: u64,
        shares_burned: u64,
        timestamp_ms: u64,
    }

    struct ManagerAllocateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        lending_market_id: 0x2::object::ID,
        reserve_index: u64,
        obligation_index: u64,
        user: address,
        deposit_amount: u64,
        timestamp_ms: u64,
    }

    struct ManagerDivestEvent has copy, drop {
        vault_id: 0x2::object::ID,
        lending_market_id: 0x2::object::ID,
        reserve_index: u64,
        obligation_index: u64,
        user: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct FeesAccruedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        fee_type: 0x1::string::String,
        fee_shares: u64,
        timestamp_ms: u64,
    }

    struct VaultStatsEvent has copy, drop {
        vault_id: 0x2::object::ID,
        base_token_type: 0x1::type_name::TypeName,
        nav_per_share_usd: u64,
        utilization_rate_bps: u64,
        aum_usd: u64,
        total_shares: u64,
        lending_market_allocations: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::LendingMarketAllocation>,
    }

    struct ObligationUnwindEvent has copy, drop {
        vault_id: 0x2::object::ID,
        lending_market_id: 0x2::object::ID,
        obligation_index: u64,
        reserve_index: u64,
        ctoken_amount: u64,
        token_amount: u64,
        timestamp_ms: u64,
    }

    public fun create_unwind_accumulator<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>, arg4: &0x2::clock::Clock) : 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultUnwindAccumulator<T0> {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version(&arg0.version, 1);
        assert_trusted_lending_market<T0, T1, T2>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13906838215907868677);
        let (v1, _) = split_amount(v0, arg0.withdrawal_fee_bps);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::utils::usd_to_token_amount<T2, T1>(shares_to_usd(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v1), calculate_nav_per_share<T0, T1>(arg0, &arg3)), arg2, arg4));
        assert!(v3 > 0, 13906838293217280005);
        assert!(0x2::balance::value<T1>(&arg0.deposit_asset) < v3, 13906838310397804559);
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::create_unwind_accumulator<T0>(arg3, v3, 0x2::coin::into_balance<T0>(arg1))
    }

    public fun create_vault_crank_accumulator<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) : 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultCrankAccumulator<T0> {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version_and_upgrade(&mut arg0.version, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.last_cranked_ms + 60000, 13906837936736043029);
        assert!(0x1::option::is_some<0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::AccumulatorCap<T0>>(&arg0.accumulator_cap), 13906837958210748435);
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::create_vault_crank_accumulator<T0>(0x1::option::extract<0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::AccumulatorCap<T0>>(&mut arg0.accumulator_cap), extract_obligation_ids<T0, T1>(arg0))
    }

    public fun create_vault_value_accumulator<T0, T1>(arg0: &mut Vault<T0, T1>) : 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAccumulator<T0> {
        assert!(0x1::option::is_some<0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::AccumulatorCap<T0>>(&arg0.accumulator_cap), 13906837790707023891);
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::create_vault_value_accumulator<T0>(0x1::option::extract<0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::AccumulatorCap<T0>>(&mut arg0.accumulator_cap), extract_obligation_ids<T0, T1>(arg0))
    }

    public fun finalize_vault_value_accumulator<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAccumulator<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock) : 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0> {
        assert_trusted_lending_market<T0, T1, T2>(arg0);
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::finalize_vault_value_accumulator<T0, T1, T2>(arg1, &arg0.deposit_asset, arg2, arg3)
    }

    public fun process_lending_market_for_crank<T0, T1>(arg0: &mut 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultCrankAccumulator<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::process_lending_market_for_crank<T0, T1>(arg0, arg1, arg2);
    }

    public fun process_lending_market_for_value_accumulator<T0, T1>(arg0: &mut 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAccumulator<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::process_lending_market_for_value_accumulator<T0, T1>(arg0, arg1);
    }

    fun refresh_aggregate_for_lending_market<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: &mut 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::refresh_aggregate_for_lending_market<T0, T2>(arg1, get_obligation_ids<T0, T1, T2>(arg0), arg2);
    }

    public fun refresh_obligations_for_crank<T0, T1>(arg0: &mut 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultCrankAccumulator<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg2: &0x2::clock::Clock) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::refresh_obligations_for_crank<T0, T1>(arg0, arg1, arg2);
    }

    fun absorb_vault_value_aggregate<T0, T1>(arg0: 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>, arg1: &mut Vault<T0, T1>) {
        0x1::option::fill<0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::AccumulatorCap<T0>>(&mut arg1.accumulator_cap, 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::destroy_vault_value_aggregate<T0>(arg0));
    }

    fun accrue_all_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::coin::total_supply<T0>(&arg0.treasury_cap);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::total_obligation_value_usd<T0>(arg1), 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::liquid_asset_value_usd<T0>(arg1));
        let v2 = calculate_management_fee_shares<T0, T1>(arg0, arg3);
        let v3 = calculate_performance_fee_shares<T0, T1, T2>(arg0, v1, v0, arg2, arg3);
        let v4 = calculate_redemption_ratio<T2, T1>(v1, v0 + v2 + v3, arg2, arg3);
        let v5 = 0x2::clock::timestamp_ms(arg3);
        if (v2 > 0) {
            0x2::balance::join<T0>(&mut arg0.manager_fees, 0x2::coin::mint_balance<T0>(&mut arg0.treasury_cap, v2));
            let v6 = FeesAccruedEvent{
                vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
                fee_type     : 0x1::string::utf8(b"management"),
                fee_shares   : v2,
                timestamp_ms : v5,
            };
            0x2::event::emit<FeesAccruedEvent>(v6);
        };
        if (v3 > 0) {
            0x2::balance::join<T0>(&mut arg0.manager_fees, 0x2::coin::mint_balance<T0>(&mut arg0.treasury_cap, v3));
            let v7 = FeesAccruedEvent{
                vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
                fee_type     : 0x1::string::utf8(b"performance"),
                fee_shares   : v3,
                timestamp_ms : v5,
            };
            0x2::event::emit<FeesAccruedEvent>(v7);
        };
        if (v0 > 0 && 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(v4, arg0.redemption_ratio_high_water_mark)) {
            arg0.redemption_ratio_high_water_mark = v4;
        };
    }

    fun assert_reserve_exists<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) {
        let v0 = get_reserve_array_index<T0, T1>(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 13906841316875436055);
    }

    fun assert_trusted_lending_market<T0, T1, T2>(arg0: &Vault<T0, T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = arg0.trusted_market;
        assert!(&v1 == &v0, 13906840548076683293);
    }

    fun assert_vault_state_fresh<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.last_cranked_ms <= 3600000, 13906840522305699851);
    }

    public fun calculate_deposit_amount<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: u64, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>, arg4: &0x2::clock::Clock) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::utils::usd_to_token_amount<T2, T1>(shares_to_usd(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg1), calculate_nav_per_share<T0, T1>(arg0, arg3)), arg2, arg4))
    }

    fun calculate_management_fee_shares<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::coin::total_supply<T0>(&arg0.treasury_cap);
        if (arg0.management_fee_bps == 0 || v0 == 0) {
            return 0
        };
        let v1 = 0x2::clock::timestamp_ms(arg1) - arg0.last_cranked_ms;
        if (v1 == 0) {
            return 0
        };
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v1 / 1000), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_bps(arg0.management_fee_bps), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(31536000)));
        let v3 = v2;
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_bps(500);
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(v2, v4)) {
            v3 = v4;
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0), v3), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::sub(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1), v3)))
    }

    fun calculate_nav_from_shares_and_value(arg0: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::eq(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_u128(1000000000)
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_u128(1000000000)), share_decimals_factor_decimal()), arg0)
        }
    }

    public fun calculate_nav_per_share<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        let v0 = 0x2::coin::total_supply<T0>(&arg0.treasury_cap);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::total_obligation_value_usd<T0>(arg1), 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::liquid_asset_value_usd<T0>(arg1));
        if (v0 == 0 || 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::eq(v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_u128(1000000000)
        } else {
            calculate_nav_from_shares_and_value(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0), v1)
        }
    }

    fun calculate_performance_fee_shares<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg2: u64, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg4: &0x2::clock::Clock) : u64 {
        if (arg0.performance_fee_bps == 0 || arg2 == 0) {
            return 0
        };
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::eq(arg0.redemption_ratio_high_water_mark, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            return 0
        };
        let v0 = calculate_redemption_ratio<T2, T1>(arg1, arg2, arg3, arg4);
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(v0, arg0.redemption_ratio_high_water_mark)) {
            return 0
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(calculate_shares_from_usd_and_nav(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::utils::token_amount_to_usd<T2, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::sub(v0, arg0.redemption_ratio_high_water_mark), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2)), share_decimals_factor_decimal())), arg3, arg4), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_bps(arg0.performance_fee_bps)), calculate_nav_from_shares_and_value(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2), arg1)))
    }

    fun calculate_redemption_ratio<T0, T1>(arg0: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg1: u64, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        if (arg1 == 0 || 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::eq(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0)
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::utils::usd_to_token_amount<T0, T1>(arg0, arg2, arg3), share_decimals_factor_decimal()), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg1))
        }
    }

    fun calculate_shares_from_usd_and_nav(arg0: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_u128(1000000000)), share_decimals_factor_decimal()), arg1)
    }

    public fun calculate_shares_to_burn<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: u64, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>, arg4: &0x2::clock::Clock) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(calculate_shares_from_usd_and_nav(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::utils::token_amount_to_usd<T2, T1>(arg1, arg2, arg4), calculate_nav_per_share<T0, T1>(arg0, arg3)))
    }

    public fun calculate_shares_to_mint<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: u64, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>, arg4: &0x2::clock::Clock) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(calculate_shares_from_usd_and_nav(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::utils::token_amount_to_usd<T2, T1>(arg1, arg2, arg4), calculate_nav_per_share<T0, T1>(arg0, arg3)))
    }

    public fun calculate_utilization_rate<T0>(arg0: &0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::liquid_asset_value_usd<T0>(arg0), 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::total_obligation_value_usd<T0>(arg0));
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::eq(v0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            return 0
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::total_obligation_value_usd<T0>(arg0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(10000)), v0))
    }

    public fun calculate_withdraw_amount<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: u64, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>, arg4: &0x2::clock::Clock) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::utils::usd_to_token_amount<T2, T1>(shares_to_usd(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg1), calculate_nav_per_share<T0, T1>(arg0, arg3)), arg2, arg4))
    }

    fun cast_as_type<T0: store, T1: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : T1 {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, T1>(&mut v0, true)
    }

    public fun claim_manager_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultManagerCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let v0 = if (arg2 == 18446744073709551615) {
            0x2::balance::withdraw_all<T0>(&mut arg0.manager_fees)
        } else {
            0x2::balance::split<T0>(&mut arg0.manager_fees, arg2)
        };
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    public fun compound_rewards<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version(&arg0.version, 1);
        assert!(0x1::option::is_some<0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::AccumulatorCap<T0>>(&arg0.accumulator_cap), 13906837193706569747);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        0x2::balance::join<T1>(&mut arg0.deposit_asset, 0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T2, T1>(arg1, get_obligation_cap<T0, T1, T2>(arg0, &v0, arg2), arg6, arg3, arg4, arg5, arg7)));
    }

    fun convert_token_amount_to_ctoken<T0, T1>(arg0: u64, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::assert_price_is_fresh<T0>(v0, arg2);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(v0))
    }

    public fun create_obligation<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &VaultManagerCap<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T2>(arg2, arg3);
        let v1 = 0x2::bag::new(arg3);
        let v2 = ObligationCapKey{dummy_field: false};
        0x2::bag::add<ObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(&mut v1, v2, v0);
        let v3 = 0x1::type_name::with_defining_ids<T2>();
        let v4 = ObligationData{
            obligation_cap : v1,
            obligation_id  : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T2>(&v0),
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<ObligationData>>(&arg0.obligations, &v3)) {
            0x1::vector::push_back<ObligationData>(0x2::vec_map::get_mut<0x1::type_name::TypeName, vector<ObligationData>>(&mut arg0.obligations, &v3), v4);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, vector<ObligationData>>(&mut arg0.obligations, v3, 0x1::vector::singleton<ObligationData>(v4));
        };
    }

    public fun create_vault<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &0x2::coin_registry::Currency<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : VaultManagerCap<T0> {
        assert_reserve_exists<T1, T2>(arg2);
        assert!(0x2::coin_registry::is_metadata_cap_deleted<T0>(arg1), 13906835132122136593);
        assert!(0x2::coin_registry::decimals<T0>(arg1) == 6, 13906835136416579593);
        assert!(0x2::coin_registry::name<T0>(arg1) == 0x1::string::utf8(b"Suilend Vault Shares"), 13906835140711546889);
        assert!(0x2::coin_registry::description<T0>(arg1) == 0x1::string::utf8(b"Suilend Vault Shares"), 13906835153596448777);
        assert!(0x2::coin_registry::symbol<T0>(arg1) == 0x1::string::utf8(b"vSHARES"), 13906835162186383369);
        let v0 = 0x2::coin_registry::icon_url<T0>(arg1);
        assert!(0x1::string::is_empty(&v0), 13906835166481350665);
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 13906835170776317961);
        assert!(arg3 <= 500, 13906835179365728257);
        assert!(arg4 <= 5000, 13906835183660695553);
        assert!(arg5 <= 500, 13906835187955662849);
        assert!(arg6 <= 500, 13906835192250630145);
        let v1 = Vault<T0, T1>{
            id                               : 0x2::object::new(arg8),
            version                          : 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::new(1),
            metadata                         : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            obligations                      : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<ObligationData>>(),
            treasury_cap                     : arg0,
            deposit_asset                    : 0x2::balance::zero<T1>(),
            manager_fees                     : 0x2::balance::zero<T0>(),
            management_fee_bps               : arg3,
            performance_fee_bps              : arg4,
            deposit_fee_bps                  : arg5,
            withdrawal_fee_bps               : arg6,
            accumulator_cap                  : 0x1::option::some<0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::AccumulatorCap<T0>>(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::create_accumulator_cap<T0>()),
            redemption_ratio_high_water_mark : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0),
            last_cranked_ms                  : 0x2::clock::timestamp_ms(arg7),
            trusted_market                   : 0x1::type_name::with_defining_ids<T2>(),
        };
        let v2 = VaultManagerCap<T0>{
            id       : 0x2::object::new(arg8),
            vault_id : 0x2::object::id<Vault<T0, T1>>(&v1),
        };
        let v3 = VaultCreatedEvent{
            vault_id            : 0x2::object::id<Vault<T0, T1>>(&v1),
            management_fee_bps  : arg3,
            performance_fee_bps : arg4,
            deposit_fee_bps     : arg5,
            withdrawal_fee_bps  : arg6,
        };
        0x2::event::emit<VaultCreatedEvent>(v3);
        0x2::transfer::public_share_object<Vault<T0, T1>>(v1);
        v2
    }

    public fun deploy_funds<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &VaultManagerCap<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version_and_upgrade(&mut arg0.version, 1);
        assert_vault_state_fresh<T0, T1>(arg0, arg5);
        assert!(arg4 > 0, 13906835441358864387);
        assert!(0x2::balance::value<T1>(&arg0.deposit_asset) >= arg4, 13906835458538995719);
        let v0 = extract_reserve_array_index<T1, T2>(arg2);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T2, T1>(arg2, v0, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.deposit_asset, arg4), arg7), arg7);
        let v2 = 0x1::type_name::with_defining_ids<T2>();
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T2, T1>(arg2, v0, get_obligation_cap<T0, T1, T2>(arg0, &v2, arg3), arg5, v1, arg7);
        let v3 = ManagerAllocateEvent{
            vault_id          : 0x2::object::id<Vault<T0, T1>>(arg0),
            lending_market_id : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>>(arg2),
            reserve_index     : v0,
            obligation_index  : arg3,
            user              : 0x2::tx_context::sender(arg7),
            deposit_amount    : arg4,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ManagerAllocateEvent>(v3);
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::refresh_liquid_asset_value<T0, T1, T2>(&mut arg6, &arg0.deposit_asset, arg2, arg5);
        let v4 = &mut arg6;
        refresh_aggregate_for_lending_market<T0, T1, T2>(arg0, v4, arg2);
        emit_stats_event<T0, T1>(arg0, &arg6);
        absorb_vault_value_aggregate<T0, T1>(arg6, arg0);
        0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T2, T1>>(&v1)
    }

    public fun deposit<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock, arg4: 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version_and_upgrade(&mut arg0.version, 1);
        assert_trusted_lending_market<T0, T1, T2>(arg0);
        assert_vault_state_fresh<T0, T1>(arg0, arg3);
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_scaled_val(100000000000000000), 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::utils::token_amount_to_usd<T2, T1>(v0, arg2, arg3)), 13906836558050361347);
        0x2::balance::join<T1>(&mut arg0.deposit_asset, 0x2::coin::into_balance<T1>(arg1));
        let v2 = 0x2::coin::mint<T0>(&mut arg0.treasury_cap, calculate_shares_to_mint<T0, T1, T2>(arg0, v0, arg2, &arg4, arg3), arg5);
        let v3 = 0x2::coin::value<T0>(&v2);
        let (v4, v5) = split_amount(v3, arg0.deposit_fee_bps);
        assert!(v4 > 0, 13906836648244674563);
        if (v5 > 0) {
            0x2::balance::join<T0>(&mut arg0.manager_fees, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v2, v5, arg5)));
            let v6 = FeesAccruedEvent{
                vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
                fee_type     : 0x1::string::utf8(b"deposit"),
                fee_shares   : v5,
                timestamp_ms : v1,
            };
            0x2::event::emit<FeesAccruedEvent>(v6);
        };
        let v7 = VaultDepositEvent{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
            user           : 0x2::tx_context::sender(arg5),
            deposit_amount : v0,
            shares_minted  : v3,
            timestamp_ms   : v1,
        };
        0x2::event::emit<VaultDepositEvent>(v7);
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::refresh_liquid_asset_value<T0, T1, T2>(&mut arg4, &arg0.deposit_asset, arg2, arg3);
        emit_stats_event<T0, T1>(arg0, &arg4);
        absorb_vault_value_aggregate<T0, T1>(arg4, arg0);
        v2
    }

    public fun deposit_swapped_rewards<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: SwapTicket<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version(&arg0.version, 1);
        assert!(0x1::option::is_some<0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::AccumulatorCap<T0>>(&arg0.accumulator_cap), 13906837717692579859);
        let SwapTicket { min_amount_out: v0 } = arg1;
        if (0x1::option::is_some<u64>(&v0)) {
            assert!(0x2::coin::value<T1>(&arg2) >= 0x1::option::extract<u64>(&mut v0), 13906837739167809561);
        };
        0x2::balance::join<T1>(&mut arg0.deposit_asset, 0x2::coin::into_balance<T1>(arg2));
    }

    public fun divest_funds<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &VaultManagerCap<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version_and_upgrade(&mut arg0.version, 1);
        assert_vault_state_fresh<T0, T1>(arg0, arg5);
        assert!(arg4 > 0, 13906835763481542661);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = extract_reserve_array_index<T1, T2>(arg2);
        let v2 = redeem_ctokens<T1, T2>(arg2, get_obligation_cap<T0, T1, T2>(arg0, &v0, arg3), arg4, arg5, arg7, arg8);
        0x2::balance::join<T1>(&mut arg0.deposit_asset, 0x2::coin::into_balance<T1>(v2));
        let v3 = ManagerDivestEvent{
            vault_id          : 0x2::object::id<Vault<T0, T1>>(arg0),
            lending_market_id : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>>(arg2),
            reserve_index     : v1,
            obligation_index  : arg3,
            user              : 0x2::tx_context::sender(arg8),
            amount            : 0x2::coin::value<T1>(&v2),
            timestamp_ms      : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ManagerDivestEvent>(v3);
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::refresh_liquid_asset_value<T0, T1, T2>(&mut arg6, &arg0.deposit_asset, arg2, arg5);
        let v4 = &mut arg6;
        refresh_aggregate_for_lending_market<T0, T1, T2>(arg0, v4, arg2);
        emit_stats_event<T0, T1>(arg0, &arg6);
        absorb_vault_value_aggregate<T0, T1>(arg6, arg0);
    }

    fun emit_stats_event<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>) {
        let v0 = VaultStatsEvent{
            vault_id                   : 0x2::object::id<Vault<T0, T1>>(arg0),
            base_token_type            : 0x1::type_name::with_defining_ids<T1>(),
            nav_per_share_usd          : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(calculate_nav_per_share<T0, T1>(arg0, arg1)),
            utilization_rate_bps       : calculate_utilization_rate<T0>(arg1),
            aum_usd                    : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::total_obligation_value_usd<T0>(arg1), 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::liquid_asset_value_usd<T0>(arg1))),
            total_shares               : 0x2::coin::total_supply<T0>(&arg0.treasury_cap),
            lending_market_allocations : 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::lending_market_allocations<T0>(arg1),
        };
        0x2::event::emit<VaultStatsEvent>(v0);
    }

    fun extract_obligation_ids<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<0x2::object::ID>> {
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, vector<ObligationData>>(&arg0.obligations);
        let v1 = &v0;
        let v2 = 0x1::vector::empty<vector<0x2::object::ID>>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            let v4 = 0x2::vec_map::get<0x1::type_name::TypeName, vector<ObligationData>>(&arg0.obligations, 0x1::vector::borrow<0x1::type_name::TypeName>(v1, v3));
            let v5 = 0x1::vector::empty<0x2::object::ID>();
            let v6 = 0;
            while (v6 < 0x1::vector::length<ObligationData>(v4)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v5, 0x1::vector::borrow<ObligationData>(v4, v6).obligation_id);
                v6 = v6 + 1;
            };
            0x1::vector::push_back<vector<0x2::object::ID>>(&mut v2, v5);
            v3 = v3 + 1;
        };
        0x2::vec_map::from_keys_values<0x1::type_name::TypeName, vector<0x2::object::ID>>(v0, v2)
    }

    fun extract_reserve_array_index<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) : u64 {
        let v0 = get_reserve_array_index<T0, T1>(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 13906840621090734103);
        0x1::option::extract<u64>(&mut v0)
    }

    public fun finalize_vault_crank<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultCrankAccumulator<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version(&arg0.version, 1);
        assert_trusted_lending_market<T0, T1, T2>(arg0);
        let v0 = 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::finalize_crank_accumulator<T0, T1, T2>(arg1, &arg0.deposit_asset, arg2, arg3);
        accrue_all_fees<T0, T1, T2>(arg0, &v0, arg2, arg3);
        emit_stats_event<T0, T1>(arg0, &v0);
        absorb_vault_value_aggregate<T0, T1>(v0, arg0);
        arg0.last_cranked_ms = 0x2::clock::timestamp_ms(arg3);
    }

    fun get_obligation_cap<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: &0x1::type_name::TypeName, arg2: u64) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2> {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert!(&v0 == arg1, 13906840483650338815);
        let v1 = ObligationCapKey{dummy_field: false};
        0x2::bag::borrow<ObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T2>>(&0x1::vector::borrow<ObligationData>(0x2::vec_map::get<0x1::type_name::TypeName, vector<ObligationData>>(&arg0.obligations, arg1), arg2).obligation_cap, v1)
    }

    fun get_obligation_ids<T0, T1, T2>(arg0: &Vault<T0, T1>) : vector<0x2::object::ID> {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, vector<ObligationData>>(&arg0.obligations, &v0);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<ObligationData>(v1)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x1::vector::borrow<ObligationData>(v1, v3).obligation_id);
            v3 = v3 + 1;
        };
        v2
    }

    fun get_reserve_array_index<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>) : 0x1::option::Option<u64> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T1, T0>(arg0);
        if (v0 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T1>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T1>(arg0))) {
            0x1::option::some<u64>(v0)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun move_lending_market_to_front<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultManagerCap<T0>, arg2: 0x1::type_name::TypeName) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let v0 = &mut arg0.obligations;
        move_pair_to_start<0x1::type_name::TypeName, vector<ObligationData>>(v0, arg2);
    }

    public fun move_obligation_to_front<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultManagerCap<T0>, arg2: 0x1::type_name::TypeName, arg3: 0x2::object::ID) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, vector<ObligationData>>(&mut arg0.obligations, &arg2);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<ObligationData>(v0)) {
            if (0x1::vector::borrow<ObligationData>(v0, v1).obligation_id == arg3) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 4 */
                let v3 = 0x1::option::extract<u64>(&mut v2);
                if (v3 == 0) {
                    return
                };
                0x1::vector::insert<ObligationData>(v0, 0x1::vector::remove<ObligationData>(v0, v3), 0);
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 4 */
    }

    fun move_pair_to_start<T0: copy + drop, T1>(arg0: &mut 0x2::vec_map::VecMap<T0, T1>, arg1: T0) {
        let (_, v1) = 0x2::vec_map::remove<T0, T1>(arg0, &arg1);
        let v2 = 0x1::vector::empty<T0>();
        let v3 = 0x1::vector::empty<T1>();
        while (!0x2::vec_map::is_empty<T0, T1>(arg0)) {
            let (v4, v5) = 0x2::vec_map::remove_entry_by_idx<T0, T1>(arg0, 0);
            0x1::vector::push_back<T0>(&mut v2, v4);
            0x1::vector::push_back<T1>(&mut v3, v5);
        };
        0x2::vec_map::insert<T0, T1>(arg0, arg1, v1);
        while (!0x1::vector::is_empty<T0>(&v2)) {
            0x2::vec_map::insert<T0, T1>(arg0, 0x1::vector::remove<T0>(&mut v2, 0), 0x1::vector::remove<T1>(&mut v3, 0));
        };
        0x1::vector::destroy_empty<T0>(v2);
        0x1::vector::destroy_empty<T1>(v3);
    }

    public fun process_unwinds_for_lending_market<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultUnwindAccumulator<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version(&arg0.version, 1);
        if (0x2::balance::value<T1>(&arg0.deposit_asset) >= 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::base_token_value_of_shares<T0>(arg1)) {
            return
        };
        let v0 = 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::get_next_unwind_targets<T0, T2>(arg1);
        let v1 = extract_reserve_array_index<T1, T2>(arg2);
        let v2 = 0x1::type_name::with_defining_ids<T2>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v4 = 0x2::balance::value<T1>(&arg0.deposit_asset);
            let v5 = 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::base_token_value_of_shares<T0>(arg1);
            if (v4 >= v5) {
            } else {
                let v6 = get_obligation_cap<T0, T1, T2>(arg0, &v2, v3);
                let v7 = 0x1::u64::min(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(convert_token_amount_to_ctoken<T2, T1>(v5 - v4, arg2, arg3)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T2, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T2>(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T2>(v6))));
                if (v7 == 0) {
                } else {
                    let v8 = redeem_ctokens<T1, T2>(arg2, v6, v7, arg3, arg4, arg5);
                    0x2::balance::join<T1>(&mut arg0.deposit_asset, 0x2::coin::into_balance<T1>(v8));
                    let v9 = ObligationUnwindEvent{
                        vault_id          : 0x2::object::id<Vault<T0, T1>>(arg0),
                        lending_market_id : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>>(arg2),
                        obligation_index  : v3,
                        reserve_index     : v1,
                        ctoken_amount     : v7,
                        token_amount      : 0x2::coin::value<T1>(&v8),
                        timestamp_ms      : 0x2::clock::timestamp_ms(arg3),
                    };
                    0x2::event::emit<ObligationUnwindEvent>(v9);
                };
            };
            v3 = v3 + 1;
        };
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::refresh_unwind_aggregate_for_lending_market<T0, T2>(arg1, v0, arg2);
    }

    fun process_withdrawal<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_vault_state_fresh<T0, T1>(arg0, arg5);
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let (v2, v3) = split_amount(v0, arg0.withdrawal_fee_bps);
        assert!(v2 > 0, 13906841149370531845);
        if (v3 > 0) {
            0x2::balance::join<T0>(&mut arg0.manager_fees, 0x2::balance::split<T0>(&mut arg1, v3));
            let v4 = FeesAccruedEvent{
                vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
                fee_type     : 0x1::string::utf8(b"withdraw"),
                fee_shares   : v3,
                timestamp_ms : v1,
            };
            0x2::event::emit<FeesAccruedEvent>(v4);
        };
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, 0x2::coin::from_balance<T0>(arg1, arg6));
        let v5 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.deposit_asset, arg2), arg6);
        let v6 = VaultWithdrawEvent{
            vault_id      : 0x2::object::id<Vault<T0, T1>>(arg0),
            user          : 0x2::tx_context::sender(arg6),
            amount        : arg2,
            shares_burned : v0,
            timestamp_ms  : v1,
        };
        0x2::event::emit<VaultWithdrawEvent>(v6);
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::refresh_liquid_asset_value<T0, T1, T2>(&mut arg3, &arg0.deposit_asset, arg4, arg5);
        emit_stats_event<T0, T1>(arg0, &arg3);
        absorb_vault_value_aggregate<T0, T1>(arg3, arg0);
        v5
    }

    fun redeem_ctokens<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = extract_reserve_array_index<T0, T1>(arg0);
        if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T1, 0x2::sui::SUI>(arg0, v0, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T1, 0x2::sui::SUI>(arg0, v0, arg1, arg3, arg2, arg5), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, 0x2::sui::SUI>>(), arg5);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T1>(arg0, v0, &v2, arg4, arg5);
            let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T1, 0x2::sui::SUI>(arg0, v0, v2, arg5);
            cast_as_type<0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>>(v3, arg5)
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T1, T0>(arg0, v0, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T1, T0>(arg0, v0, arg1, arg3, arg2, arg5), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T1, T0>>(), arg5)
        }
    }

    public fun set_metadata<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultManagerCap<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version_and_upgrade(&mut arg0.version, 1);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.metadata, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, &arg2);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, arg2, arg3);
    }

    fun share_decimals_factor_decimal() : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, 6))
    }

    fun shares_to_usd(arg0: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(arg0, arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_u128(1000000000), share_decimals_factor_decimal()))
    }

    fun split_amount(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = arg0 * arg1 / 10000;
        (arg0 - v0, v0)
    }

    public fun swap_reward_for_base_token_unchecked<T0, T1, T2>(arg0: &VaultManagerCap<T0>, arg1: RewardWithdrawTicket<T0, T1, T2>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x2::tx_context::TxContext) : (SwapTicket<T0, T1>, 0x2::coin::Coin<T2>) {
        let RewardWithdrawTicket { reward: v0 } = arg1;
        let v1 = get_reserve_array_index<T2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2);
        assert!(0x1::option::is_none<u64>(&v1), 13906837657563562011);
        let v2 = SwapTicket<T0, T1>{min_amount_out: 0x1::option::none<u64>()};
        (v2, 0x2::coin::from_balance<T2>(v0, arg3))
    }

    public fun swap_reward_for_base_token_w_oracle<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: RewardWithdrawTicket<T0, T1, T2>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (SwapTicket<T0, T1>, 0x2::coin::Coin<T2>) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version(&arg0.version, 1);
        let RewardWithdrawTicket { reward: v0 } = arg1;
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2>(arg2);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg2);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::assert_price_is_fresh<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v2, arg3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::assert_price_is_fresh<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1, arg3);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::usd_to_token_amount<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::market_value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x2::balance::value<T2>(&v0)))), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::sub(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(10000), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(10)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(10000))));
        assert!(v3 > 0, 13906837571664085017);
        let v4 = SwapTicket<T0, T1>{min_amount_out: 0x1::option::some<u64>(v3)};
        (v4, 0x2::coin::from_balance<T2>(v0, arg4))
    }

    public fun unset_metadata<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultManagerCap<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version_and_upgrade(&mut arg0.version, 1);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.metadata, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, &arg2);
        };
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock, arg4: 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultValueAggregate<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version_and_upgrade(&mut arg0.version, 1);
        assert_trusted_lending_market<T0, T1, T2>(arg0);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 13906836841518333957);
        let (v0, _) = split_amount(0x2::coin::value<T0>(&arg1), arg0.withdrawal_fee_bps);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::utils::usd_to_token_amount<T2, T1>(shares_to_usd(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0), calculate_nav_per_share<T0, T1>(arg0, &arg4)), arg2, arg3));
        assert!(v2 <= 0x2::balance::value<T1>(&arg0.deposit_asset), 13906836918827876359);
        assert!(v2 > 0, 13906836923122712581);
        process_withdrawal<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(arg1), v2, arg4, arg2, arg3, arg5)
    }

    public fun withdraw_reward<T0, T1, T2, T3>(arg0: &Vault<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : RewardWithdrawTicket<T0, T1, T3> {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version(&arg0.version, 1);
        assert!(0x1::type_name::with_defining_ids<T1>() != 0x1::type_name::with_defining_ids<T3>(), 13906837352619966477);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        RewardWithdrawTicket<T0, T1, T3>{reward: 0x2::coin::into_balance<T3>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T2, T3>(arg1, get_obligation_cap<T0, T1, T2>(arg0, &v0, arg2), arg6, arg3, arg4, arg5, arg7))}
    }

    public fun withdraw_with_unwind<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::VaultUnwindAccumulator<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version::assert_version(&arg0.version, 1);
        assert_trusted_lending_market<T0, T1, T2>(arg0);
        let (v0, v1, v2) = 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::accumulator::finalize_unwind_accumulator<T0, T1, T2>(arg1, &arg0.deposit_asset, arg2, arg3);
        let v3 = 0x1::u64::min(v1, 0x2::balance::value<T1>(&arg0.deposit_asset));
        process_withdrawal<T0, T1, T2>(arg0, v0, v3, v2, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

