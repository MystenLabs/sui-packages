module 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single {
    struct ManagerCap has key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        num_of_vault: u64,
        authority: 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::Authority<ManagerCap>,
        restrict_activation_time_period: RestrictActivationTimePeriod,
        deposit_vault_registry: DepositVaultRegistry,
        bid_vault_registry: BidVaultRegistry,
        version: u64,
    }

    struct DepositVaultRegistry has store, key {
        id: 0x2::object::UID,
        user_share_registry: 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareRegistry,
    }

    struct BidVaultRegistry has store, key {
        id: 0x2::object::UID,
        user_share_registry: 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareRegistry,
    }

    struct RestrictActivationTimePeriod has drop, store {
        from_ts_ms: u64,
        to_ts_ms: u64,
    }

    struct PortfolioVault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        info: Info,
        config: Config,
        auction: 0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>,
        authority: 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::Authority<ManagerCap>,
    }

    struct Info has copy, drop, store {
        index: u64,
        creator: address,
        create_ts_ms: u64,
        round: u64,
        delivery_info: 0x1::option::Option<DeliveryInfo>,
    }

    struct Config has copy, drop, store {
        option_type: u64,
        period: u8,
        activation_ts_ms: u64,
        expiration_ts_ms: u64,
        d_token_decimal: u64,
        b_token_decimal: u64,
        o_token_decimal: u64,
        lot_size: u64,
        capacity: u64,
        leverage: u64,
        has_next: bool,
        active_vault_config: VaultConfig,
        warmup_vault_config: VaultConfig,
        upcoming_vault_config: VaultConfig,
    }

    struct AdditionalConfigRegistry has key {
        id: 0x2::object::UID,
    }

    struct AdditionalConfigKey has copy, drop, store {
        index: u64,
        tag: vector<u8>,
    }

    struct PayoffConfig has copy, drop, store {
        strike_pct: u64,
        weight: u64,
        is_buyer: bool,
        strike: 0x1::option::Option<u64>,
    }

    struct VaultConfig has copy, drop, store {
        payoff_configs: vector<PayoffConfig>,
        strike_increment: u64,
        decay_speed: u64,
        initial_price: u64,
        final_price: u64,
        auction_duration_in_ms: u64,
    }

    struct DeliveryInfo has copy, drop, store {
        round: u64,
        price: u64,
        size: u64,
        premium: u64,
        ts_ms: u64,
    }

    struct VaultTsMs has copy, drop, store {
        activation_ts_ms: u64,
        expiration_ts_ms: u64,
    }

    struct NewAuction has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        vault_config: VaultConfig,
        able_to_remove_bid: bool,
    }

    struct Delivery<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        max_size: u64,
        delivery_price: u64,
        delivery_size: u64,
        premium_value: u64,
        refund_shares: u64,
        fee_per_unit: u64,
        accumulated_fee: u64,
    }

    struct IncentiveDelivery<phantom T0> has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        refunded_incentive_fund: u64,
        depositor_incentive_amount: u64,
    }

    struct Settle<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        oracle_price: u64,
        delivery_size: u64,
        portfolio_payoff: u64,
        portfolio_payoff_is_neg: bool,
        original_premium: u64,
        portfolio_final_payoff: u64,
        portfolio_final_payoff_is_neg: bool,
        total_balance: u64,
        share_price: u64,
        performance_fee: u64,
        activation_ts_ms: u64,
        expiration_ts_ms: u64,
    }

    struct AddPortfolioVaultAuthorizedUser<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
        users: vector<address>,
        is_manager: bool,
    }

    struct RemovePortfolioVaultAuthorizedUser<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
        users: vector<address>,
        is_manager: bool,
    }

    struct NewPortfolioVault<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
        info: Info,
        config: Config,
        is_manager: bool,
    }

    struct UpdateCapacity<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
        previous: u64,
        current: u64,
        is_manager: bool,
    }

    struct UpdateLotSize<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
        previous: u64,
        current: u64,
        is_manager: bool,
    }

    struct UpdateWarmupVaultConfig<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
        previous: VaultConfig,
        current: VaultConfig,
        is_manager: bool,
    }

    struct UpdateUpcomingVaultConfig<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
        previous: VaultConfig,
        current: VaultConfig,
        is_manager: bool,
    }

    struct NewManager has copy, drop {
        signer: address,
        users: vector<address>,
    }

    struct RemoveManager has copy, drop {
        signer: address,
    }

    struct AddAuthorizedUser has copy, drop {
        signer: address,
        users: vector<address>,
    }

    struct RemoveAuthorizedUser has copy, drop {
        signer: address,
        users: vector<address>,
    }

    struct Evolution<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
    }

    struct UpdateRestrictActivationTimePeriod has copy, drop {
        signer: address,
        previous_from_ts_ms: u64,
        previous_to_ts_ms: u64,
        current_from_ts_ms: u64,
        current_to_ts_ms: u64,
    }

    struct Close<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
    }

    struct UpdateActiveVaultConfig<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
        previous: VaultConfig,
        current: VaultConfig,
    }

    struct TerminateVault<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
    }

    struct TerminateAuction<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
    }

    struct Deposit<phantom T0> has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
    }

    struct Withdraw<phantom T0> has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
    }

    struct Claim<phantom T0> has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
        fee: u64,
    }

    struct Harvest<phantom T0> has copy, drop {
        signer: address,
        index: u64,
        share: u64,
        amount: u64,
    }

    struct ClaimAndHarvest<phantom T0, phantom T1> has copy, drop {
        signer: address,
        index: u64,
    }

    struct Compound<phantom T0> has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
    }

    struct Unsubscribe<phantom T0> has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
    }

    struct NewBid<phantom T0, phantom T1, phantom T2> has copy, drop {
        signer: address,
        index: u64,
        bid_index: u64,
        price: u64,
        size: u64,
        coin_value: u64,
        ts_ms: u64,
    }

    struct IncentiveNewBid<phantom T0> has copy, drop {
        signer: address,
        index: u64,
        bid_index: u64,
        incentive_value: u64,
    }

    struct BenchmarkPrice has copy, drop {
        signer: address,
        index: u64,
        benchmark_price: u64,
    }

    struct UserShare {
        index: u64,
        tag: u8,
        user: address,
        share: u64,
    }

    struct VaultUserShare {
        user: address,
        share: u64,
    }

    struct UserBid {
        index: u64,
        price: u64,
        size: u64,
        ts_ms: u64,
        balance: u64,
        bidder: address,
    }

    fun activate_<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut AdditionalConfigRegistry, arg2: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareRegistry, arg3: &mut PortfolioVault<T0, T1, T2>, arg4: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0>, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg6) >= arg3.config.activation_ts_ms, 0);
        let (v0, v1) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg5, arg6);
        let v2 = arg3.config.warmup_vault_config.payoff_configs;
        let v3 = arg3.config.warmup_vault_config.strike_increment;
        let v4 = &mut v2;
        set_strike(v4, v0, v3);
        if (arg3.config.option_type == 1) {
            let v5 = &mut v2;
            adjust_put_strike(v5, v0, v3);
        };
        calculate_max_loss_per_unit(arg3.config.option_type, v0, v1, arg3.config.d_token_decimal, arg3.config.o_token_decimal, v2, arg3.config.leverage);
        arg3.info.round = arg3.info.round + 1;
        arg3.config.active_vault_config = arg3.config.warmup_vault_config;
        arg3.config.warmup_vault_config = arg3.config.upcoming_vault_config;
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::activate<ManagerCap, T0>(arg0, arg2, arg4, arg3.config.has_next, arg7);
        let v6 = arg3.config.activation_ts_ms;
        new_auction_<T0, T1, T2>(arg1, arg3, v6, arg5, arg6, arg7);
    }

    public(friend) entry fun activate_share<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 8);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg3);
        let v2 = &mut arg1.deposit_vault_registry.id;
        let v3 = get_mut_deposit_vault<T0>(v2, arg3);
        assert!(0x2::clock::timestamp_ms(arg4) >= v1.config.activation_ts_ms, 0);
        let v4 = AdditionalConfigKey{
            index : arg3,
            tag   : b"activate_amount",
        };
        let v5 = get_additional_config<u64>(arg2, v4);
        let (v6, v7) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::activate_share<ManagerCap, T0>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, v3, arg5);
        if (v7) {
            update_portfolio_step(arg2, arg3, 9);
        };
        let v8 = AdditionalConfigKey{
            index : arg3,
            tag   : b"activate_amount",
        };
        update_additional_config<u64>(arg2, v8, v6 + 0x1::option::get_with_default<u64>(&v5, 0));
    }

    public(friend) entry fun activate_vault<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 9);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg3);
        let v2 = &mut arg1.deposit_vault_registry.id;
        let (v3, v4) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg4, arg5);
        let v5 = v1.config.warmup_vault_config.payoff_configs;
        let v6 = v1.config.warmup_vault_config.strike_increment;
        let v7 = &mut v5;
        set_strike(v7, v3, v6);
        if (v1.config.option_type == 1) {
            let v8 = &mut v5;
            adjust_put_strike(v8, v3, v6);
        };
        calculate_max_loss_per_unit(v1.config.option_type, v3, v4, v1.config.d_token_decimal, v1.config.o_token_decimal, v5, v1.config.leverage);
        let v9 = AdditionalConfigKey{
            index : arg3,
            tag   : b"activate_amount",
        };
        let v10 = get_additional_config<u64>(arg2, v9);
        v1.info.round = v1.info.round + 1;
        v1.config.active_vault_config = v1.config.warmup_vault_config;
        v1.config.warmup_vault_config = v1.config.upcoming_vault_config;
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::activate_vault<ManagerCap, T0>(arg0, get_mut_deposit_vault<T0>(v2, arg3), *0x1::option::borrow<u64>(&v10), v1.config.has_next, arg6);
        update_portfolio_step(arg2, arg3, 10);
    }

    fun adjust_put_strike(arg0: &mut vector<PayoffConfig>, arg1: u64, arg2: u64) {
        let v0 = 0x1::vector::length<PayoffConfig>(arg0);
        while (v0 > 0) {
            let v1 = 0x1::vector::borrow_mut<PayoffConfig>(arg0, v0 - 1);
            if (arg1 * v1.strike_pct / 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4) % arg2 != 0) {
                *0x1::option::borrow_mut<u64>(&mut v1.strike) = *0x1::option::borrow<u64>(&v1.strike) - arg2;
            };
            v0 = v0 - 1;
        };
    }

    fun calculate_max_auction_size(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        ((((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg0) * arg1) as u128) * (arg2 as u128) / (arg3 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(2) as u128)) as u64) / arg4 * arg4
    }

    fun calculate_max_loss_per_unit(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: vector<PayoffConfig>, arg6: u64) : u64 {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = if (arg1 / 100000 > 0) {
            arg1 / 100000
        } else {
            1
        };
        let v2 = if (arg1 < 18446744073709551615 / 100) {
            arg1 * 100
        } else {
            18446744073709551615
        };
        0x1::vector::push_back<u64>(&mut v0, v1);
        0x1::vector::push_back<u64>(&mut v0, v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<PayoffConfig>(&arg5)) {
            let v4 = 0x1::vector::borrow<PayoffConfig>(&arg5, v3);
            assert!(0x1::option::is_some<u64>(&v4.strike), 16);
            let v5 = 0x1::option::borrow<u64>(&v4.strike);
            if (!0x1::vector::contains<u64>(&v0, v5)) {
                0x1::vector::push_back<u64>(&mut v0, *v5);
            };
            v3 = v3 + 1;
        };
        let v6 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::zero();
        while (!0x1::vector::is_empty<u64>(&v0)) {
            let v7 = calculate_portfolio_payoff_by_price(arg0, 0x1::vector::pop_back<u64>(&mut v0), arg2, arg3, arg5, arg6, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg4), arg4);
            if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::compare(&v6, &v7) == 2) {
                v6 = v7;
            };
        };
        assert!(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::is_neg(&v6), 18);
        let v8 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::neg(&v6);
        let v9 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v8);
        assert!(v9 > 0, 18);
        v9
    }

    fun calculate_option_payoff(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 % 2 == 0) {
            if (arg1 >= arg3) {
                (((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg2) as u128) * ((arg1 - arg3) as u128) / (arg1 as u128)) as u64)
            } else {
                0
            }
        } else {
            assert!(arg0 % 2 == 1, 20);
            if (arg1 <= arg3) {
                arg3 - arg1
            } else {
                0
            }
        }
    }

    fun calculate_portfolio_payoff_by_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: vector<PayoffConfig>, arg5: u64, arg6: u64, arg7: u64) : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::I64 {
        let v0 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::zero();
        while (!0x1::vector::is_empty<PayoffConfig>(&arg4)) {
            let v1 = 0x1::vector::pop_back<PayoffConfig>(&mut arg4);
            assert!(0x1::option::is_some<u64>(&v1.strike), 16);
            let v2 = if (v1.is_buyer) {
                0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from(1)
            } else {
                0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::neg_from(1)
            };
            let v3 = v2;
            let v4 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from((((calculate_option_payoff(arg0, arg1, arg2, *0x1::option::borrow<u64>(&v1.strike)) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg3) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg2) as u128)) as u64));
            let v5 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::mul(&v4, &v3);
            let v6 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from(v1.weight);
            let v7 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::mul(&v5, &v6);
            let v8 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from(arg5);
            let v9 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::mul(&v7, &v8);
            let v10 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(2));
            let v11 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::div(&v9, &v10);
            let v12 = &v0;
            v0 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::add(v12, &v11);
        };
        let v13 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::abs(&v0);
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::is_neg(&v0)) {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::neg_from((((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v13) as u128) * (arg6 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg7) as u128)) as u64))
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from((((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v13) as u128) * (arg6 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg7) as u128)) as u64))
        }
    }

    fun calculate_spot(arg0: u64, arg1: u64) : u64 {
        arg0 * 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4) / arg1
    }

    fun calculate_strike(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 * arg1 / 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4);
        if (v0 % arg2 == 0) {
            return v0
        };
        v0 / arg2 * arg2 + arg2
    }

    fun check_auction_settings(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= arg1 && arg1 > 0, 6);
        assert!(arg2 >= 300000, 8);
    }

    fun check_capacity<T0, T1, T2>(arg0: &Registry, arg1: u64) {
        let v0 = get_deposit_vault<T0>(&arg0.deposit_vault_registry.id, arg1);
        assert!(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v0) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::warmup_balance<ManagerCap, T0>(v0) <= get_portfolio_vault<T0, T1, T2>(&arg0.id, arg1).config.capacity, 10);
    }

    public(friend) entry fun claim<T0>(arg0: &mut Registry, arg1: &AdditionalConfigRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = get_portfolio_step(arg1, arg2);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = *0x1::option::borrow<u64>(&v0) == 0 || *0x1::option::borrow<u64>(&v0) == 11;
            if (!v1) {
                abort 23
            };
        };
        let v2 = &mut arg0.deposit_vault_registry.id;
        let (v3, v4) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::claim<ManagerCap, T0>(&mut arg0.deposit_vault_registry.user_share_registry, get_mut_deposit_vault<T0>(v2, arg2), arg3);
        if (v3 == 0) {
            abort 22
        };
        let v5 = Claim<T0>{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg2,
            amount : v3,
            fee    : v4,
        };
        0x2::event::emit<Claim<T0>>(v5);
    }

    public(friend) entry fun claim_and_harvest<T0, T1>(arg0: &mut Registry, arg1: &AdditionalConfigRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = get_portfolio_step(arg1, arg2);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = *0x1::option::borrow<u64>(&v0) == 0 || *0x1::option::borrow<u64>(&v0) == 11;
            if (!v1) {
                abort 23
            };
        };
        let v2 = &mut arg0.deposit_vault_registry.id;
        let (v3, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::claim<ManagerCap, T0>(&mut arg0.deposit_vault_registry.user_share_registry, get_mut_deposit_vault<T0>(v2, arg2), arg3);
        let v5 = &mut arg0.bid_vault_registry.id;
        let (v6, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::harvest<ManagerCap, T1>(&mut arg0.bid_vault_registry.user_share_registry, get_mut_bid_vault<T1>(v5, arg2), arg3);
        if (v3 == 0 && v6 == 0) {
            abort 22
        };
        let v8 = ClaimAndHarvest<T0, T1>{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg2,
        };
        0x2::event::emit<ClaimAndHarvest<T0, T1>>(v8);
    }

    public(friend) entry fun close<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        version_check(arg1);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg2);
        assert!(v1.config.has_next, 999);
        v1.config.has_next = false;
        let v2 = Close<T0, T1, T2>{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg2,
        };
        0x2::event::emit<Close<T0, T1, T2>>(v2);
    }

    public(friend) entry fun compound<T0, T1>(arg0: &mut Registry, arg1: &AdditionalConfigRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = get_portfolio_step(arg1, arg2);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = *0x1::option::borrow<u64>(&v0) == 0 || *0x1::option::borrow<u64>(&v0) == 11;
            if (!v1) {
                abort 23
            };
        };
        let v2 = &mut arg0.deposit_vault_registry.id;
        let v3 = get_mut_deposit_vault<T0>(v2, arg2);
        let v4 = &mut arg0.bid_vault_registry.id;
        let v5 = get_mut_bid_vault<T0>(v4, arg2);
        let v6 = &mut arg0.id;
        let v7 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::compound<ManagerCap, T0>(&mut arg0.deposit_vault_registry.user_share_registry, &mut arg0.bid_vault_registry.user_share_registry, v3, v5, get_mut_portfolio_vault<T0, T0, T1>(v6, arg2).config.lot_size, arg3);
        if (v7 == 0) {
            abort 22
        };
        check_capacity<T0, T0, T1>(arg0, arg2);
        let v8 = Compound<T0>{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg2,
            amount : v7,
        };
        0x2::event::emit<Compound<T0>>(v8);
    }

    fun copy_user_share(arg0: &mut vector<UserShare>, arg1: &0x2::object::UID, arg2: u64, arg3: u8, arg4: address) {
        let v0 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::new_user_share_key(arg2, arg3, arg4);
        if (0x2::dynamic_field::exists_with_type<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::Node<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, u64>>(arg1, v0)) {
            let v1 = 0x2::dynamic_field::borrow<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::Node<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, u64>>(arg1, v0);
            if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::node_exists<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, u64>(v1)) {
                let v2 = UserShare{
                    index : arg2,
                    tag   : arg3,
                    user  : arg4,
                    share : *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::node_value<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, u64>(v1),
                };
                0x1::vector::push_back<UserShare>(arg0, v2);
            };
        };
    }

    fun copy_vault_user_share(arg0: &0x2::object::UID, arg1: &0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::LinkedList<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, u64>, arg2: 0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>, arg3: u64) : vector<VaultUserShare> {
        let v0 = 0x1::vector::empty<VaultUserShare>();
        let v1 = if (0x1::option::is_some<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>(&arg2)) {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, u64>(arg0, arg1, *0x1::option::borrow<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>(&arg2))
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, u64>(arg1)
        };
        let v2 = v1;
        while (0x1::option::is_some<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>(&v2) && arg3 > 0) {
            let v3 = 0x1::option::borrow<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>(&v2);
            let (_, _, v6) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_key_info(v3);
            let v7 = VaultUserShare{
                user  : v6,
                share : *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, u64>(arg0, arg1, *v3),
            };
            0x1::vector::push_back<VaultUserShare>(&mut v0, v7);
            v2 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, u64>(arg0, arg1, *v3);
            arg3 = arg3 - 1;
        };
        v0
    }

    fun create_additional_configs_for_delivery_premium_loop(arg0: &mut AdditionalConfigRegistry, arg1: u64) {
        let v0 = AdditionalConfigKey{
            index : arg1,
            tag   : b"premium_balance_value",
        };
        update_additional_config<u64>(arg0, v0, 0);
        let v1 = AdditionalConfigKey{
            index : arg1,
            tag   : b"performance_fee_value",
        };
        update_additional_config<u64>(arg0, v1, 0);
        let v2 = AdditionalConfigKey{
            index : arg1,
            tag   : b"accumulated_fee",
        };
        update_additional_config<u64>(arg0, v2, 0);
        let v3 = AdditionalConfigKey{
            index : arg1,
            tag   : b"bidder_shares",
        };
        update_additional_config<0x2::vec_map::VecMap<address, u64>>(arg0, v3, 0x2::vec_map::empty<address, u64>());
        let v4 = AdditionalConfigKey{
            index : arg1,
            tag   : b"refunded_incentive_fund_record",
        };
        update_additional_config<u64>(arg0, v4, 0);
    }

    fun create_payoff_configs(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<bool>) : vector<PayoffConfig> {
        assert!(0x1::vector::length<u64>(&arg0) > 0, 17);
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 17);
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<bool>(&arg2), 17);
        let v0 = 0x1::vector::empty<PayoffConfig>();
        while (!0x1::vector::is_empty<u64>(&arg0)) {
            let v1 = PayoffConfig{
                strike_pct : 0x1::vector::pop_back<u64>(&mut arg0),
                weight     : 0x1::vector::pop_back<u64>(&mut arg1),
                is_buyer   : 0x1::vector::pop_back<bool>(&mut arg2),
                strike     : 0x1::option::none<u64>(),
            };
            0x1::vector::push_back<PayoffConfig>(&mut v0, v1);
        };
        v0
    }

    public(friend) entry fun delivery<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        oracle_check(arg2, arg3, arg4);
        ensure_portfolio_step(arg2, arg3, 11);
        delivery_<T0, T1, T2>(arg0, arg1, arg3, arg2, arg4, arg5, arg6);
        update_portfolio_step(arg2, arg3, 0);
    }

    fun delivery_<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: &mut AdditionalConfigRegistry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg4, arg5);
        let v2 = get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2);
        let v3 = get_deposit_vault<T0>(&arg1.deposit_vault_registry.id, arg2);
        let v4 = 0x1::vector::borrow<PayoffConfig>(&v2.config.active_vault_config.payoff_configs, 0);
        let v5 = calculate_spot(*0x1::option::borrow<u64>(&v4.strike), v4.strike_pct);
        let v6 = AdditionalConfigKey{
            index : v2.info.index,
            tag   : b"auction_benchmark_price",
        };
        let v7 = get_additional_config<u64>(arg3, v6);
        let v8 = AdditionalConfigKey{
            index : v2.info.index,
            tag   : b"auction_lot_size",
        };
        let v9 = get_additional_config<u64>(arg3, v8);
        let v10 = calculate_max_auction_size(v2.config.o_token_decimal, v2.config.leverage, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v3) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v3), calculate_max_loss_per_unit(v2.config.option_type, *0x1::option::borrow_with_default<u64>(&v7, &v5), v1, v2.config.d_token_decimal, v2.config.o_token_decimal, v2.config.active_vault_config.payoff_configs, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(2)), *0x1::option::borrow_with_default<u64>(&v9, &v2.config.lot_size));
        let v11 = AdditionalConfigKey{
            index : get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2).info.index,
            tag   : b"incentive_flag",
        };
        let v12 = get_additional_config<bool>(arg3, v11);
        let (v13, v14, v15, v16, v17, v18, v19, v20) = if (0x1::option::is_some<bool>(&v12) && *0x1::option::borrow<bool>(&v12)) {
            let v21 = AdditionalConfigKey{
                index : arg2,
                tag   : b"remaining_incentive_sui",
            };
            let v22 = get_additional_config<u64>(arg3, v21);
            let v23 = 0;
            let v24 = AdditionalConfigKey{
                index : get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2).info.index,
                tag   : b"incentive_rate_bp",
            };
            let v25 = get_additional_config<u64>(arg3, v24);
            let v26 = 0;
            let v27 = AdditionalConfigKey{
                index : get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2).info.index,
                tag   : b"bidder_incentive_record",
            };
            let v28 = get_additional_config<0x2::vec_map::VecMap<u64, u64>>(arg3, v27);
            let v29 = 0x2::vec_map::empty<u64, u64>();
            let v30 = &mut arg1.id;
            let v31 = get_mut_portfolio_vault<T0, T1, T2>(v30, arg2);
            let v32 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                v0
            } else {
                1
            };
            let v33 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                0x1::option::some<u64>(v1)
            } else {
                0x1::option::none<u64>()
            };
            let (v34, v35, v36, v37, v38, v39, v40, v41, v42) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::delivery_with_rewards_v2<ManagerCap, T1>(arg0, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v31.auction), v10, v31.config.b_token_decimal, v31.config.o_token_decimal, v32, v33, *0x1::option::borrow_with_default<u64>(&v25, &v26), *0x1::option::borrow_with_default<0x2::vec_map::VecMap<u64, u64>>(&v28, &v29), arg5, arg6);
            let v43 = v41;
            let v44 = b"incentivise_sui";
            if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v44)) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v44, 0x2::balance::zero<T0>());
            };
            if (0x2::balance::value<T1>(&v43) > 0) {
                let v45 = AdditionalConfigKey{
                    index : arg2,
                    tag   : b"remaining_incentive_sui",
                };
                update_additional_config<u64>(arg3, v45, *0x1::option::borrow_with_default<u64>(&v22, &v23) + 0x2::balance::value<T1>(&v43));
            };
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"incentivise_sui"), v43);
            let v46 = AdditionalConfigKey{
                index : arg2,
                tag   : b"bidder_incentive_record",
            };
            update_additional_config<0x2::vec_map::VecMap<u64, u64>>(arg3, v46, v42);
            (v34, v35, v36, v37, v38, v39, v40, 0x2::balance::value<T1>(&v43))
        } else {
            let v47 = AdditionalConfigKey{
                index : arg2,
                tag   : b"bidder_incentive_record",
            };
            let v48 = get_additional_config<0x2::vec_map::VecMap<u64, u64>>(arg3, v47);
            if (0x1::option::is_some<0x2::vec_map::VecMap<u64, u64>>(&v48)) {
                if (0x2::vec_map::size<u64, u64>(0x1::option::borrow<0x2::vec_map::VecMap<u64, u64>>(&v48)) > 0) {
                    let v49 = AdditionalConfigKey{
                        index : arg2,
                        tag   : b"bidder_incentive_record",
                    };
                    update_additional_config<0x2::vec_map::VecMap<u64, u64>>(arg3, v49, 0x2::vec_map::empty<u64, u64>());
                };
            };
            let v50 = &mut arg1.id;
            let v51 = get_mut_portfolio_vault<T0, T1, T2>(v50, arg2);
            let v52 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                v0
            } else {
                1
            };
            let v53 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                0x1::option::some<u64>(v1)
            } else {
                0x1::option::none<u64>()
            };
            let (v54, v55, v56, v57, v58, v59, v60) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::delivery<ManagerCap, T1>(arg0, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v51.auction), v10, v51.config.b_token_decimal, v51.config.o_token_decimal, v52, v53, arg5, arg6);
            (v54, v55, v56, v57, v58, v59, v60, 0)
        };
        let v61 = &mut arg1.id;
        let v62 = get_mut_portfolio_vault<T0, T1, T2>(v61, arg2);
        let v63 = DeliveryInfo{
            round   : v62.info.round,
            price   : v16,
            size    : v17,
            premium : v15,
            ts_ms   : 0x2::clock::timestamp_ms(arg5),
        };
        v62.info.delivery_info = 0x1::option::some<DeliveryInfo>(v63);
        let v64 = &mut arg1.deposit_vault_registry.id;
        let v65 = get_mut_deposit_vault<T0>(v64, arg2);
        let v66 = &mut arg1.bid_vault_registry.id;
        let v67 = get_mut_bid_vault<T1>(v66, arg2);
        let v68 = if (v10 > 0) {
            ((((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, T0>(v65) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_share_supply<ManagerCap, T0>(v65)) as u128) * ((v10 - v17) as u128) / (v10 as u128)) as u64)
        } else {
            0
        };
        if (0x1::option::is_some<bool>(&v12) && *0x1::option::borrow<bool>(&v12)) {
            let v69 = AdditionalConfigKey{
                index : arg2,
                tag   : b"remaining_incentive_sui",
            };
            let v70 = get_additional_config<u64>(arg3, v69);
            let v71 = 0;
            let v72 = *0x1::option::borrow_with_default<u64>(&v70, &v71);
            let v73 = get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2);
            let v74 = AdditionalConfigKey{
                index : arg2,
                tag   : b"depositor_incentive_rate_bp",
            };
            let v75 = get_additional_config<u64>(arg3, v74);
            let v76 = 0;
            let v77 = 0x1::vector::borrow<PayoffConfig>(&v73.config.active_vault_config.payoff_configs, 0);
            let v78 = calculate_spot(*0x1::option::borrow<u64>(&v77.strike), v77.strike_pct);
            let v79 = AdditionalConfigKey{
                index : v73.info.index,
                tag   : b"auction_benchmark_price",
            };
            let v80 = get_additional_config<u64>(arg3, v79);
            let v81 = if (v10 > 0) {
                ((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v65) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v65)) as u128) * (v17 as u128) / (v10 as u128)
            } else {
                0
            };
            let v82 = if (v73.config.option_type == 1) {
                v81 * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v1) as u128) / (*0x1::option::borrow_with_default<u64>(&v80, &v78) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v73.config.b_token_decimal) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v73.config.d_token_decimal) as u128)
            } else {
                v81
            };
            let v83 = ((v82 * (*0x1::option::borrow_with_default<u64>(&v75, &v76) as u128) / 10000) as u64);
            let v84 = b"incentivise_sui";
            if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v84)) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v84, 0x2::balance::zero<T0>());
            };
            let v85 = if (v83 > 0) {
                if (v72 > v83) {
                    v83
                } else {
                    v72
                }
            } else {
                0
            };
            let v86 = AdditionalConfigKey{
                index : arg2,
                tag   : b"remaining_incentive_sui",
            };
            update_additional_config<u64>(arg3, v86, v72 - v85);
            let v87 = 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"incentivise_sui"), v85);
            let v88 = &mut arg1.id;
            let v89 = get_mut_portfolio_vault<T0, T1, T2>(v88, arg2);
            let v90 = IncentiveDelivery<T1>{
                signer                     : 0x2::tx_context::sender(arg6),
                index                      : v89.info.index,
                round                      : v89.info.round,
                refunded_incentive_fund    : v20,
                depositor_incentive_amount : 0x2::balance::value<T1>(&v87),
            };
            0x2::event::emit<IncentiveDelivery<T1>>(v90);
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery_with_rewards<ManagerCap, T0, T1>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, &mut arg1.bid_vault_registry.user_share_registry, v65, v67, v68, v13, v14, v87, arg6);
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery<ManagerCap, T0, T1>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, &mut arg1.bid_vault_registry.user_share_registry, v65, v67, v68, v13, v14, arg6);
        };
        let v91 = &mut arg1.id;
        let v92 = get_mut_portfolio_vault<T0, T1, T2>(v91, arg2);
        update_portfolio_step(arg3, v92.info.index, 0);
        let v93 = Delivery<T0, T1, T2>{
            signer          : 0x2::tx_context::sender(arg6),
            index           : v92.info.index,
            round           : v92.info.round,
            max_size        : v10,
            delivery_price  : v16,
            delivery_size   : v17,
            premium_value   : v15,
            refund_shares   : v68,
            fee_per_unit    : v18,
            accumulated_fee : v19,
        };
        0x2::event::emit<Delivery<T0, T1, T2>>(v93);
    }

    public(friend) entry fun delivery_active<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 15);
        let v0 = &mut arg1.deposit_vault_registry.id;
        let v1 = get_mut_deposit_vault<T0>(v0, arg3);
        let v2 = &mut arg1.bid_vault_registry.id;
        let v3 = AdditionalConfigKey{
            index : arg3,
            tag   : b"total_share_supply",
        };
        let v4 = get_additional_config<u64>(arg2, v3);
        let v5 = AdditionalConfigKey{
            index : arg3,
            tag   : b"premium_balance_value",
        };
        let v6 = get_additional_config<u64>(arg2, v5);
        let v7 = AdditionalConfigKey{
            index : arg3,
            tag   : b"performance_fee_value",
        };
        let v8 = get_additional_config<u64>(arg2, v7);
        let v9 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        let v10 = get_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v9);
        let (v11, v12, v13, v14) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery_active<ManagerCap, T0, T1>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, &mut arg1.bid_vault_registry.user_share_registry, v1, get_mut_bid_vault<T1>(v2, arg3), *0x1::option::borrow<u64>(&v4), *0x1::option::borrow<u64>(&v6), *0x1::option::borrow<u64>(&v8), 0x1::option::get_with_default<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v10, 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>()), arg4);
        let v15 = v14;
        if (0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>(&v15)) {
            update_portfolio_step(arg2, arg3, 16);
        };
        let v16 = AdditionalConfigKey{
            index : arg3,
            tag   : b"total_share_supply",
        };
        update_additional_config<u64>(arg2, v16, v11);
        let v17 = AdditionalConfigKey{
            index : arg3,
            tag   : b"premium_balance_value",
        };
        update_additional_config<u64>(arg2, v17, v12);
        let v18 = AdditionalConfigKey{
            index : arg3,
            tag   : b"performance_fee_value",
        };
        update_additional_config<u64>(arg2, v18, v13);
        let v19 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        update_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v19, v15);
    }

    public(friend) entry fun delivery_bidder<T0>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 17);
        let v0 = &mut arg1.bid_vault_registry.id;
        let v1 = AdditionalConfigKey{
            index : arg3,
            tag   : b"bidder_shares",
        };
        let v2 = get_additional_config<0x2::vec_map::VecMap<address, u64>>(arg2, v1);
        let v3 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery_bidder<ManagerCap, T0>(arg0, &mut arg1.bid_vault_registry.user_share_registry, get_mut_bid_vault<T0>(v0, arg3), *0x1::option::borrow<0x2::vec_map::VecMap<address, u64>>(&v2), arg4);
        if (0x2::vec_map::is_empty<address, u64>(&v3)) {
            update_portfolio_step(arg2, arg3, 0);
        };
        let v4 = AdditionalConfigKey{
            index : arg3,
            tag   : b"bidder_shares",
        };
        update_additional_config<0x2::vec_map::VecMap<address, u64>>(arg2, v4, v3);
    }

    public(friend) entry fun delivery_calculation<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        oracle_check(arg2, arg3, arg4);
        ensure_portfolio_step(arg2, arg3, 11);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg3);
        let v2 = &mut arg1.deposit_vault_registry.id;
        let v3 = get_mut_deposit_vault<T0>(v2, arg3);
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg4, arg5);
        let v6 = 0x1::vector::borrow<PayoffConfig>(&v1.config.active_vault_config.payoff_configs, 0);
        let v7 = calculate_spot(*0x1::option::borrow<u64>(&v6.strike), v6.strike_pct);
        let v8 = AdditionalConfigKey{
            index : v1.info.index,
            tag   : b"auction_benchmark_price",
        };
        let v9 = get_additional_config<u64>(arg2, v8);
        let v10 = AdditionalConfigKey{
            index : v1.info.index,
            tag   : b"auction_lot_size",
        };
        let v11 = get_additional_config<u64>(arg2, v10);
        let v12 = calculate_max_auction_size(v1.config.o_token_decimal, v1.config.leverage, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v3) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v3), calculate_max_loss_per_unit(v1.config.option_type, *0x1::option::borrow_with_default<u64>(&v9, &v7), v5, v1.config.d_token_decimal, v1.config.o_token_decimal, v1.config.active_vault_config.payoff_configs, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(2)), *0x1::option::borrow_with_default<u64>(&v11, &v1.config.lot_size));
        let v13 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
            v4
        } else {
            1
        };
        let v14 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
            0x1::option::some<u64>(v5)
        } else {
            0x1::option::none<u64>()
        };
        let (v15, v16, v17) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::delivery_calculation<ManagerCap, T1>(arg0, 0x1::option::borrow<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v1.auction), v12, v1.config.b_token_decimal, v1.config.o_token_decimal, v13, v14, arg5, arg6);
        let v18 = AdditionalConfigKey{
            index : arg3,
            tag   : b"max_delivery_size",
        };
        update_additional_config<u64>(arg2, v18, v12);
        let v19 = AdditionalConfigKey{
            index : arg3,
            tag   : b"delivery_price",
        };
        update_additional_config<u64>(arg2, v19, v15);
        let v20 = AdditionalConfigKey{
            index : arg3,
            tag   : b"delivery_size",
        };
        update_additional_config<u64>(arg2, v20, v16);
        let v21 = AdditionalConfigKey{
            index : arg3,
            tag   : b"remaining_delivery_size",
        };
        update_additional_config<u64>(arg2, v21, v16);
        let v22 = AdditionalConfigKey{
            index : arg3,
            tag   : b"fee_per_unit",
        };
        update_additional_config<u64>(arg2, v22, v17);
        let v23 = AdditionalConfigKey{
            index : arg3,
            tag   : b"total_share_supply",
        };
        update_additional_config<u64>(arg2, v23, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, T0>(v3) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_share_supply<ManagerCap, T0>(v3));
        update_portfolio_step(arg2, arg3, 12);
        create_additional_configs_for_delivery_premium_loop(arg2, arg3);
    }

    public(friend) entry fun delivery_deactivating<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 16);
        let v0 = &mut arg1.deposit_vault_registry.id;
        let v1 = get_mut_deposit_vault<T0>(v0, arg3);
        let v2 = &mut arg1.bid_vault_registry.id;
        let v3 = AdditionalConfigKey{
            index : arg3,
            tag   : b"total_share_supply",
        };
        let v4 = get_additional_config<u64>(arg2, v3);
        let v5 = AdditionalConfigKey{
            index : arg3,
            tag   : b"premium_balance_value",
        };
        let v6 = get_additional_config<u64>(arg2, v5);
        let v7 = AdditionalConfigKey{
            index : arg3,
            tag   : b"performance_fee_value",
        };
        let v8 = get_additional_config<u64>(arg2, v7);
        let v9 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        let v10 = get_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v9);
        let (v11, v12, v13, v14) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery_deactivating<ManagerCap, T0, T1>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, &mut arg1.bid_vault_registry.user_share_registry, v1, get_mut_bid_vault<T1>(v2, arg3), *0x1::option::borrow<u64>(&v4), *0x1::option::borrow<u64>(&v6), *0x1::option::borrow<u64>(&v8), 0x1::option::get_with_default<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v10, 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>()), arg4);
        let v15 = v14;
        if (0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>(&v15)) {
            update_portfolio_step(arg2, arg3, 17);
        };
        let v16 = AdditionalConfigKey{
            index : arg3,
            tag   : b"total_share_supply",
        };
        update_additional_config<u64>(arg2, v16, v11);
        let v17 = AdditionalConfigKey{
            index : arg3,
            tag   : b"premium_balance_value",
        };
        update_additional_config<u64>(arg2, v17, v12);
        let v18 = AdditionalConfigKey{
            index : arg3,
            tag   : b"performance_fee_value",
        };
        update_additional_config<u64>(arg2, v18, v13);
        let v19 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        update_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v19, v15);
    }

    public(friend) entry fun delivery_premium<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        oracle_check(arg2, arg3, arg4);
        ensure_portfolio_step(arg2, arg3, 11);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg3);
        let v2 = &mut arg1.deposit_vault_registry.id;
        let v3 = get_mut_deposit_vault<T0>(v2, arg3);
        let (_, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg4, arg5);
        let v6 = 0x1::vector::borrow<PayoffConfig>(&v1.config.active_vault_config.payoff_configs, 0);
        let v7 = calculate_spot(*0x1::option::borrow<u64>(&v6.strike), v6.strike_pct);
        let v8 = AdditionalConfigKey{
            index : v1.info.index,
            tag   : b"auction_benchmark_price",
        };
        let v9 = get_additional_config<u64>(arg2, v8);
        let v10 = AdditionalConfigKey{
            index : v1.info.index,
            tag   : b"auction_lot_size",
        };
        let v11 = get_additional_config<u64>(arg2, v10);
        let v12 = calculate_max_auction_size(v1.config.o_token_decimal, v1.config.leverage, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v3) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v3), calculate_max_loss_per_unit(v1.config.option_type, *0x1::option::borrow_with_default<u64>(&v9, &v7), v5, v1.config.d_token_decimal, v1.config.o_token_decimal, v1.config.active_vault_config.payoff_configs, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(2)), *0x1::option::borrow_with_default<u64>(&v11, &v1.config.lot_size));
        let (v13, v14) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg4, arg5);
        let v15 = AdditionalConfigKey{
            index : get_portfolio_vault<T0, T1, T2>(&arg1.id, arg3).info.index,
            tag   : b"incentive_flag",
        };
        let v16 = get_additional_config<bool>(arg2, v15);
        let (v17, v18, v19, v20, v21, v22, v23, v24) = if (0x1::option::is_some<bool>(&v16) && *0x1::option::borrow<bool>(&v16)) {
            let v25 = AdditionalConfigKey{
                index : arg3,
                tag   : b"remaining_incentive_sui",
            };
            let v26 = get_additional_config<u64>(arg2, v25);
            let v27 = 0;
            let v28 = AdditionalConfigKey{
                index : get_portfolio_vault<T0, T1, T2>(&arg1.id, arg3).info.index,
                tag   : b"incentive_rate_bp",
            };
            let v29 = get_additional_config<u64>(arg2, v28);
            let v30 = 0;
            let v31 = AdditionalConfigKey{
                index : get_portfolio_vault<T0, T1, T2>(&arg1.id, arg3).info.index,
                tag   : b"bidder_incentive_record",
            };
            let v32 = get_additional_config<0x2::vec_map::VecMap<u64, u64>>(arg2, v31);
            let v33 = 0x2::vec_map::empty<u64, u64>();
            let v34 = &mut arg1.id;
            let v35 = get_mut_portfolio_vault<T0, T1, T2>(v34, arg3);
            let v36 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                v13
            } else {
                1
            };
            let v37 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                0x1::option::some<u64>(v14)
            } else {
                0x1::option::none<u64>()
            };
            let (v38, v39, v40, v41, v42, v43, v44, v45, v46) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::delivery_with_rewards_v2<ManagerCap, T1>(arg0, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v35.auction), v12, v35.config.b_token_decimal, v35.config.o_token_decimal, v36, v37, *0x1::option::borrow_with_default<u64>(&v29, &v30), *0x1::option::borrow_with_default<0x2::vec_map::VecMap<u64, u64>>(&v32, &v33), arg5, arg6);
            let v47 = v45;
            let v48 = b"incentivise_sui";
            if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v48)) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, v48, 0x2::balance::zero<T1>());
            };
            if (0x2::balance::value<T1>(&v47) > 0) {
                let v49 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"remaining_incentive_sui",
                };
                update_additional_config<u64>(arg2, v49, *0x1::option::borrow_with_default<u64>(&v26, &v27) + 0x2::balance::value<T1>(&v47));
            };
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"incentivise_sui"), v47);
            let v50 = AdditionalConfigKey{
                index : arg3,
                tag   : b"bidder_incentive_record",
            };
            update_additional_config<0x2::vec_map::VecMap<u64, u64>>(arg2, v50, v46);
            (v38, v39, v40, v41, v42, v43, v44, 0x2::balance::value<T1>(&v47))
        } else {
            let v51 = &mut arg1.id;
            let v52 = get_mut_portfolio_vault<T0, T1, T2>(v51, arg3);
            let v53 = AdditionalConfigKey{
                index : arg3,
                tag   : b"bidder_incentive_record",
            };
            let v54 = get_additional_config<0x2::vec_map::VecMap<u64, u64>>(arg2, v53);
            if (0x1::option::is_some<0x2::vec_map::VecMap<u64, u64>>(&v54)) {
                if (0x2::vec_map::size<u64, u64>(0x1::option::borrow<0x2::vec_map::VecMap<u64, u64>>(&v54)) > 0) {
                    let v55 = AdditionalConfigKey{
                        index : arg3,
                        tag   : b"bidder_incentive_record",
                    };
                    update_additional_config<0x2::vec_map::VecMap<u64, u64>>(arg2, v55, 0x2::vec_map::empty<u64, u64>());
                };
            };
            let v56 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                v13
            } else {
                1
            };
            let v57 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                0x1::option::some<u64>(v14)
            } else {
                0x1::option::none<u64>()
            };
            let (v58, v59, v60, v61, v62, v63, v64) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::delivery<ManagerCap, T1>(arg0, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v52.auction), v12, v52.config.b_token_decimal, v52.config.o_token_decimal, v56, v57, arg5, arg6);
            (v58, v59, v60, v61, v62, v63, v64, 0)
        };
        let v65 = &mut arg1.deposit_vault_registry.id;
        let v66 = get_mut_deposit_vault<T0>(v65, arg3);
        let v67 = &mut arg1.bid_vault_registry.id;
        let v68 = get_mut_bid_vault<T1>(v67, arg3);
        let v69 = &mut arg1.id;
        let v70 = get_mut_portfolio_vault<T0, T1, T2>(v69, arg3);
        let v71 = DeliveryInfo{
            round   : v70.info.round,
            price   : v20,
            size    : v21,
            premium : v19,
            ts_ms   : 0x2::clock::timestamp_ms(arg5),
        };
        v70.info.delivery_info = 0x1::option::some<DeliveryInfo>(v71);
        let (v72, v73) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery_premium<ManagerCap, T1>(arg0, v68, v17);
        let v74 = if (v12 > 0) {
            ((((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, T0>(v66) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_share_supply<ManagerCap, T0>(v66)) as u128) * ((v12 - v21) as u128) / (v12 as u128)) as u64)
        } else {
            0
        };
        let v75 = AdditionalConfigKey{
            index : arg3,
            tag   : b"total_share_supply",
        };
        update_additional_config<u64>(arg2, v75, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, T0>(v66) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_share_supply<ManagerCap, T0>(v66));
        let v76 = AdditionalConfigKey{
            index : arg3,
            tag   : b"refund_shares",
        };
        update_additional_config<u64>(arg2, v76, v74);
        let v77 = AdditionalConfigKey{
            index : arg3,
            tag   : b"bidder_shares",
        };
        update_additional_config<0x2::vec_map::VecMap<address, u64>>(arg2, v77, v18);
        let v78 = AdditionalConfigKey{
            index : arg3,
            tag   : b"premium_balance_value",
        };
        update_additional_config<u64>(arg2, v78, v72);
        let v79 = AdditionalConfigKey{
            index : arg3,
            tag   : b"performance_fee_value",
        };
        update_additional_config<u64>(arg2, v79, v73);
        let v80 = if (0x1::option::is_some<bool>(&v16) && *0x1::option::borrow<bool>(&v16)) {
            let v81 = AdditionalConfigKey{
                index : arg3,
                tag   : b"remaining_incentive_sui",
            };
            let v82 = get_additional_config<u64>(arg2, v81);
            let v83 = 0;
            let v84 = *0x1::option::borrow_with_default<u64>(&v82, &v83);
            let v85 = get_portfolio_vault<T0, T1, T2>(&arg1.id, arg3);
            let v86 = &mut arg1.deposit_vault_registry.id;
            let v87 = get_mut_deposit_vault<T0>(v86, arg3);
            let v88 = AdditionalConfigKey{
                index : arg3,
                tag   : b"depositor_incentive_rate_bp",
            };
            let v89 = get_additional_config<u64>(arg2, v88);
            let v90 = 0;
            let v91 = 0x1::vector::borrow<PayoffConfig>(&v85.config.active_vault_config.payoff_configs, 0);
            let v92 = calculate_spot(*0x1::option::borrow<u64>(&v91.strike), v91.strike_pct);
            let v93 = AdditionalConfigKey{
                index : v85.info.index,
                tag   : b"auction_benchmark_price",
            };
            let v94 = get_additional_config<u64>(arg2, v93);
            let v95 = if (v12 > 0) {
                ((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v87) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v87)) as u128) * (v21 as u128) / (v12 as u128)
            } else {
                0
            };
            let v96 = if (v85.config.option_type == 1) {
                v95 * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v14) as u128) / (*0x1::option::borrow_with_default<u64>(&v94, &v92) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v85.config.b_token_decimal) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v85.config.d_token_decimal) as u128)
            } else {
                v95
            };
            let v97 = ((v96 * (*0x1::option::borrow_with_default<u64>(&v89, &v90) as u128) / 10000) as u64);
            let v98 = b"incentivise_sui";
            if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v98)) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v98, 0x2::balance::zero<T0>());
            };
            let v99 = if (v97 > 0) {
                if (v84 > v97) {
                    v97
                } else {
                    v84
                }
            } else {
                0
            };
            let v100 = AdditionalConfigKey{
                index : arg3,
                tag   : b"remaining_incentive_sui",
            };
            update_additional_config<u64>(arg2, v100, v84 - v99);
            let v101 = 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"incentivise_sui"), v99);
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery_reward<ManagerCap, T1>(arg0, v68, v101);
            0x2::balance::value<T1>(&v101)
        } else {
            0
        };
        if (0x1::option::is_some<bool>(&v16) && *0x1::option::borrow<bool>(&v16)) {
            let v102 = &mut arg1.id;
            let v103 = get_mut_portfolio_vault<T0, T1, T2>(v102, arg3);
            let v104 = AdditionalConfigKey{
                index : v103.info.index,
                tag   : b"premium_balance_value",
            };
            let v105 = get_additional_config<u64>(arg2, v104);
            let v106 = AdditionalConfigKey{
                index : arg3,
                tag   : b"premium_balance_value",
            };
            update_additional_config<u64>(arg2, v106, *0x1::option::borrow<u64>(&v105) + v80);
            let v107 = IncentiveDelivery<T1>{
                signer                     : 0x2::tx_context::sender(arg6),
                index                      : v103.info.index,
                round                      : v103.info.round,
                refunded_incentive_fund    : v24,
                depositor_incentive_amount : v80,
            };
            0x2::event::emit<IncentiveDelivery<T1>>(v107);
        };
        update_portfolio_step(arg2, arg3, 13);
        let v108 = &mut arg1.id;
        let v109 = get_mut_portfolio_vault<T0, T1, T2>(v108, arg3);
        let v110 = Delivery<T0, T1, T2>{
            signer          : 0x2::tx_context::sender(arg6),
            index           : v109.info.index,
            round           : v109.info.round,
            max_size        : v12,
            delivery_price  : v20,
            delivery_size   : v21,
            premium_value   : v19,
            refund_shares   : v74,
            fee_per_unit    : v22,
            accumulated_fee : v23,
        };
        0x2::event::emit<Delivery<T0, T1, T2>>(v110);
    }

    public(friend) entry fun delivery_premium_loop<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.bid_vault_registry.id;
        let v1 = get_mut_bid_vault<T1>(v0, arg3);
        ensure_portfolio_step(arg2, arg3, 12);
        let v2 = AdditionalConfigKey{
            index : arg3,
            tag   : b"delivery_price",
        };
        let v3 = AdditionalConfigKey{
            index : arg3,
            tag   : b"remaining_delivery_size",
        };
        let v4 = AdditionalConfigKey{
            index : arg3,
            tag   : b"fee_per_unit",
        };
        let v5 = AdditionalConfigKey{
            index : arg3,
            tag   : b"incentive_flag",
        };
        let v6 = get_additional_config<bool>(arg2, v5);
        let v7 = get_additional_config<u64>(arg2, v4);
        let v8 = get_additional_config<u64>(arg2, v3);
        let v9 = get_additional_config<u64>(arg2, v2);
        let v10 = if (0x1::option::is_some<bool>(&v6) && *0x1::option::borrow<bool>(&v6)) {
            let v11 = AdditionalConfigKey{
                index : get_portfolio_vault<T0, T1, T2>(&arg1.id, arg3).info.index,
                tag   : b"incentive_rate_bp",
            };
            let v12 = get_additional_config<u64>(arg2, v11);
            let v13 = 0;
            *0x1::option::borrow_with_default<u64>(&v12, &v13)
        } else {
            0
        };
        let v14 = AdditionalConfigKey{
            index : get_portfolio_vault<T0, T1, T2>(&arg1.id, arg3).info.index,
            tag   : b"bidder_incentive_record",
        };
        let v15 = get_additional_config<0x2::vec_map::VecMap<u64, u64>>(arg2, v14);
        let v16 = 0x2::vec_map::empty<u64, u64>();
        let v17 = &mut arg1.id;
        let v18 = get_mut_portfolio_vault<T0, T1, T2>(v17, arg3);
        let (v19, v20, v21, _, v23, v24, v25, v26) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::delivery_premium_loop_v2<ManagerCap, T1>(arg0, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v18.auction), v18.config.o_token_decimal, *0x1::option::borrow<u64>(&v9), *0x1::option::borrow<u64>(&v8), *0x1::option::borrow<u64>(&v7), arg5, v10, *0x1::option::borrow_with_default<0x2::vec_map::VecMap<u64, u64>>(&v15, &v16), arg6, arg7);
        let v27 = v25;
        let v28 = v21;
        let v29 = v19;
        if (0x2::balance::value<T1>(&v27) > 0) {
            let v30 = AdditionalConfigKey{
                index : arg3,
                tag   : b"refunded_incentive_fund_record",
            };
            let v31 = get_additional_config<u64>(arg2, v30);
            let v32 = AdditionalConfigKey{
                index : arg3,
                tag   : b"refunded_incentive_fund_record",
            };
            update_additional_config<u64>(arg2, v32, *0x1::option::borrow<u64>(&v31) + 0x2::balance::value<T1>(&v27));
            let v33 = b"incentivise_sui";
            if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v33)) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, v33, 0x2::balance::zero<T1>());
            };
            let v34 = AdditionalConfigKey{
                index : arg3,
                tag   : b"remaining_incentive_sui",
            };
            let v35 = get_additional_config<u64>(arg2, v34);
            let v36 = 0;
            let v37 = AdditionalConfigKey{
                index : arg3,
                tag   : b"remaining_incentive_sui",
            };
            update_additional_config<u64>(arg2, v37, *0x1::option::borrow_with_default<u64>(&v35, &v36) + 0x2::balance::value<T1>(&v27));
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"incentivise_sui"), v27);
        } else {
            0x2::balance::destroy_zero<T1>(v27);
        };
        let v38 = AdditionalConfigKey{
            index : arg3,
            tag   : b"bidder_incentive_record",
        };
        update_additional_config<0x2::vec_map::VecMap<u64, u64>>(arg2, v38, v26);
        let (v39, v40) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery_premium<ManagerCap, T1>(arg0, v1, v20);
        let v41 = AdditionalConfigKey{
            index : arg3,
            tag   : b"remaining_delivery_size",
        };
        update_additional_config<u64>(arg2, v41, v23);
        let v42 = &mut arg1.id;
        let v43 = get_mut_portfolio_vault<T0, T1, T2>(v42, arg3);
        let v44 = AdditionalConfigKey{
            index : v43.info.index,
            tag   : b"premium_balance_value",
        };
        let v45 = get_additional_config<u64>(arg2, v44);
        let v46 = AdditionalConfigKey{
            index : v43.info.index,
            tag   : b"performance_fee_value",
        };
        let v47 = get_additional_config<u64>(arg2, v46);
        let v48 = AdditionalConfigKey{
            index : arg3,
            tag   : b"premium_balance_value",
        };
        update_additional_config<u64>(arg2, v48, *0x1::option::borrow<u64>(&v45) + v39);
        let v49 = AdditionalConfigKey{
            index : arg3,
            tag   : b"performance_fee_value",
        };
        update_additional_config<u64>(arg2, v49, *0x1::option::borrow<u64>(&v47) + v40);
        let v50 = AdditionalConfigKey{
            index : v43.info.index,
            tag   : b"accumulated_fee",
        };
        let v51 = get_additional_config<u64>(arg2, v50);
        let v52 = AdditionalConfigKey{
            index : arg3,
            tag   : b"accumulated_fee",
        };
        update_additional_config<u64>(arg2, v52, *0x1::option::borrow<u64>(&v51) + v24);
        let v53 = AdditionalConfigKey{
            index : v43.info.index,
            tag   : b"bidder_shares",
        };
        let v54 = get_additional_config<0x2::vec_map::VecMap<address, u64>>(arg2, v53);
        let v55 = 0x1::option::borrow_mut<0x2::vec_map::VecMap<address, u64>>(&mut v54);
        while (!0x2::vec_map::is_empty<address, u64>(&v28)) {
            let (v56, v57) = 0x2::vec_map::pop<address, u64>(&mut v28);
            let v58 = v56;
            if (0x2::vec_map::contains<address, u64>(v55, &v58)) {
                let v59 = 0x2::vec_map::get_mut<address, u64>(v55, &v58);
                *v59 = *v59 + v57;
                continue
            };
            0x2::vec_map::insert<address, u64>(v55, v58, v57);
        };
        let v60 = AdditionalConfigKey{
            index : arg3,
            tag   : b"bidder_shares",
        };
        update_additional_config<0x2::vec_map::VecMap<address, u64>>(arg2, v60, *v55);
        if (0x1::option::is_some<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v29)) {
            let v61 = &mut arg1.id;
            0x1::option::fill<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut get_mut_portfolio_vault<T0, T1, T2>(v61, arg3).auction, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v29));
        } else {
            let v62 = &mut arg1.id;
            let v63 = get_mut_portfolio_vault<T0, T1, T2>(v62, arg3);
            let v64 = AdditionalConfigKey{
                index : v63.info.index,
                tag   : b"delivery_size",
            };
            let v65 = get_additional_config<u64>(arg2, v64);
            let v66 = AdditionalConfigKey{
                index : v63.info.index,
                tag   : b"premium_balance_value",
            };
            let v67 = get_additional_config<u64>(arg2, v66);
            let v68 = AdditionalConfigKey{
                index : v63.info.index,
                tag   : b"performance_fee_value",
            };
            let v69 = get_additional_config<u64>(arg2, v68);
            let v70 = DeliveryInfo{
                round   : v63.info.round,
                price   : *0x1::option::borrow<u64>(&v9),
                size    : *0x1::option::borrow<u64>(&v65),
                premium : *0x1::option::borrow<u64>(&v67) + *0x1::option::borrow<u64>(&v69),
                ts_ms   : 0x2::clock::timestamp_ms(arg5),
            };
            v63.info.delivery_info = 0x1::option::some<DeliveryInfo>(v70);
            let v71 = if (0x1::option::is_some<bool>(&v6) && *0x1::option::borrow<bool>(&v6)) {
                let v72 = get_portfolio_vault<T0, T1, T2>(&arg1.id, arg3);
                let v73 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"remaining_incentive_sui",
                };
                let v74 = get_additional_config<u64>(arg2, v73);
                let v75 = 0;
                let v76 = *0x1::option::borrow_with_default<u64>(&v74, &v75);
                let v77 = &mut arg1.deposit_vault_registry.id;
                let v78 = get_mut_deposit_vault<T0>(v77, arg3);
                let v79 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"depositor_incentive_rate_bp",
                };
                let v80 = get_additional_config<u64>(arg2, v79);
                let v81 = 0;
                let v82 = 0x1::vector::borrow<PayoffConfig>(&v72.config.active_vault_config.payoff_configs, 0);
                let v83 = calculate_spot(*0x1::option::borrow<u64>(&v82.strike), v82.strike_pct);
                let v84 = AdditionalConfigKey{
                    index : v72.info.index,
                    tag   : b"auction_benchmark_price",
                };
                let v85 = get_additional_config<u64>(arg2, v84);
                let v86 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"delivery_size",
                };
                let v87 = get_additional_config<u64>(arg2, v86);
                let v88 = 0;
                let v89 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"max_delivery_size",
                };
                let v90 = get_additional_config<u64>(arg2, v89);
                let v91 = 0;
                let v92 = *0x1::option::borrow_with_default<u64>(&v90, &v91);
                let (_, v94) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg4, arg5);
                let v95 = if (v92 > 0) {
                    ((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v78) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v78)) as u128) * (*0x1::option::borrow_with_default<u64>(&v87, &v88) as u128) / (v92 as u128)
                } else {
                    0
                };
                let v96 = if (v72.config.option_type == 1) {
                    v95 * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v94) as u128) / (*0x1::option::borrow_with_default<u64>(&v85, &v83) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v72.config.b_token_decimal) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v72.config.d_token_decimal) as u128)
                } else {
                    v95
                };
                let v97 = ((v96 * (*0x1::option::borrow_with_default<u64>(&v80, &v81) as u128) / 10000) as u64);
                let v98 = b"incentivise_sui";
                if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v98)) {
                    0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v98, 0x2::balance::zero<T0>());
                };
                let v99 = if (v97 > 0) {
                    if (v76 > v97) {
                        v97
                    } else {
                        v76
                    }
                } else {
                    0
                };
                let v100 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"remaining_incentive_sui",
                };
                update_additional_config<u64>(arg2, v100, v76 - v99);
                let v101 = 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"incentivise_sui"), v99);
                0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery_reward<ManagerCap, T1>(arg0, v1, v101);
                0x2::balance::value<T1>(&v101)
            } else {
                0
            };
            let v102 = &mut arg1.id;
            let v103 = get_mut_portfolio_vault<T0, T1, T2>(v102, arg3);
            let v104 = AdditionalConfigKey{
                index : v103.info.index,
                tag   : b"total_share_supply",
            };
            let v105 = get_additional_config<u64>(arg2, v104);
            let v106 = AdditionalConfigKey{
                index : v103.info.index,
                tag   : b"max_delivery_size",
            };
            let v107 = get_additional_config<u64>(arg2, v106);
            let v108 = *0x1::option::borrow<u64>(&v107);
            let v109 = AdditionalConfigKey{
                index : v103.info.index,
                tag   : b"delivery_size",
            };
            let v110 = get_additional_config<u64>(arg2, v109);
            let v111 = *0x1::option::borrow<u64>(&v110);
            let v112 = if (v108 > 0) {
                (((*0x1::option::borrow<u64>(&v105) as u128) * ((v108 - v111) as u128) / (v108 as u128)) as u64)
            } else {
                0
            };
            let v113 = AdditionalConfigKey{
                index : arg3,
                tag   : b"refund_shares",
            };
            update_additional_config<u64>(arg2, v113, v112);
            update_portfolio_step(arg2, arg3, 13);
            let v114 = AdditionalConfigKey{
                index : v103.info.index,
                tag   : b"accumulated_fee",
            };
            let v115 = get_additional_config<u64>(arg2, v114);
            let v116 = AdditionalConfigKey{
                index : v103.info.index,
                tag   : b"premium_balance_value",
            };
            let v117 = get_additional_config<u64>(arg2, v116);
            let v118 = AdditionalConfigKey{
                index : v103.info.index,
                tag   : b"performance_fee_value",
            };
            let v119 = get_additional_config<u64>(arg2, v118);
            let v120 = Delivery<T0, T1, T2>{
                signer          : 0x2::tx_context::sender(arg7),
                index           : v103.info.index,
                round           : v103.info.round,
                max_size        : v108,
                delivery_price  : *0x1::option::borrow<u64>(&v9),
                delivery_size   : v111,
                premium_value   : *0x1::option::borrow<u64>(&v117) + *0x1::option::borrow<u64>(&v119),
                refund_shares   : v112,
                fee_per_unit    : *0x1::option::borrow<u64>(&v7),
                accumulated_fee : *0x1::option::borrow<u64>(&v115),
            };
            0x2::event::emit<Delivery<T0, T1, T2>>(v120);
            let v121 = AdditionalConfigKey{
                index : arg3,
                tag   : b"refunded_incentive_fund_record",
            };
            let v122 = get_additional_config<u64>(arg2, v121);
            let v123 = 0;
            let v124 = IncentiveDelivery<T1>{
                signer                     : 0x2::tx_context::sender(arg7),
                index                      : v103.info.index,
                round                      : v103.info.round,
                refunded_incentive_fund    : *0x1::option::borrow_with_default<u64>(&v122, &v123),
                depositor_incentive_amount : v71,
            };
            0x2::event::emit<IncentiveDelivery<T1>>(v124);
            if (0x1::option::is_some<bool>(&v6) && *0x1::option::borrow<bool>(&v6)) {
                let v125 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"premium_balance_value",
                };
                update_additional_config<u64>(arg2, v125, *0x1::option::borrow<u64>(&v117) + v71);
            };
        };
        0x1::option::destroy_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(v29);
    }

    public(friend) entry fun deposit<T0, T1, T2>(arg0: &mut Registry, arg1: &AdditionalConfigRegistry, arg2: u64, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = AdditionalConfigKey{
            index : get_portfolio_vault<T0, T1, T2>(&arg0.id, arg2).info.index,
            tag   : b"min_deposit",
        };
        let v1 = get_additional_config<u64>(arg1, v0);
        let v2 = 0;
        assert!(arg4 >= *0x1::option::borrow_with_default<u64>(&v1, &v2), 25);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::prepare_deposit_vault_user_share_node(&mut arg0.deposit_vault_registry.user_share_registry, arg2, arg5);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::prepare_bid_vault_user_share_node(&mut arg0.bid_vault_registry.user_share_registry, arg2, arg5);
        let v3 = &mut arg0.id;
        let v4 = get_mut_portfolio_vault<T0, T1, T2>(v3, arg2);
        let v5 = &mut arg0.deposit_vault_registry.id;
        check_capacity<T0, T1, T2>(arg0, arg2);
        let v6 = Deposit<T0>{
            signer : 0x2::tx_context::sender(arg5),
            index  : arg2,
            amount : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deposit<ManagerCap, T0>(&mut arg0.deposit_vault_registry.user_share_registry, get_mut_deposit_vault<T0>(v5, arg2), arg3, arg4, v4.config.lot_size, arg5),
        };
        0x2::event::emit<Deposit<T0>>(v6);
    }

    public(friend) entry fun deposit_incentive_fund<T0>(arg0: &ManagerCap, arg1: &mut Registry, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        let v0 = b"incentivise_sui";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0), 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::extract_balance<T0>(arg2, arg3, arg4));
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::extract_balance<T0>(arg2, arg3, arg4));
        };
    }

    fun ensure_portfolio_step(arg0: &AdditionalConfigRegistry, arg1: u64, arg2: u64) {
        let v0 = get_portfolio_step(arg0, arg1);
        if (0x1::option::is_none<u64>(&v0) && arg2 != 0) {
            abort 1001
        };
        if (0x1::option::is_some<u64>(&v0)) {
            if (*0x1::option::borrow<u64>(&v0) != arg2) {
                abort 1001
            };
        };
    }

    public(friend) entry fun evolution<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        oracle_check(arg2, arg3, arg4);
        evolution_<T0, T1, T2>(arg0, arg1, arg3, arg2, arg4, arg5, arg6);
        let v0 = Evolution<T0, T1, T2>{
            signer : 0x2::tx_context::sender(arg6),
            index  : arg3,
        };
        0x2::event::emit<Evolution<T0, T1, T2>>(v0);
    }

    fun evolution_<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: &mut AdditionalConfigRegistry, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2).auction), 14);
        ensure_portfolio_step(arg3, arg2, 0);
        if (0x1::option::is_some<DeliveryInfo>(&get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2).info.delivery_info) && 0x1::option::borrow<DeliveryInfo>(&get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2).info.delivery_info).round == get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2).info.round) {
            settle_<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg2);
        let v2 = &mut arg1.deposit_vault_registry.id;
        let v3 = get_mut_deposit_vault<T0>(v2, arg2);
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::has_next<ManagerCap, T0>(v3)) {
            let v4 = &mut arg1.deposit_vault_registry.user_share_registry;
            activate_<T0, T1, T2>(arg0, arg3, v4, v1, v3, arg4, arg5, arg6);
            update_portfolio_step(arg3, v1.info.index, 11);
        } else {
            update_portfolio_step(arg3, v1.info.index, 0);
        };
    }

    public(friend) fun f_new_bid<T0, T1, T2>(arg0: &mut Registry, arg1: &mut AdditionalConfigRegistry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock, arg5: vector<0x2::coin::Coin<T1>>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        version_check(arg0);
        oracle_check(arg1, arg2, arg3);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::prepare_bid_vault_bidder_share_node(&mut arg0.bid_vault_registry.user_share_registry, arg2, arg7);
        let v0 = &mut arg0.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg2);
        assert!(0x1::option::is_none<DeliveryInfo>(&v1.info.delivery_info) || 0x1::option::borrow<DeliveryInfo>(&v1.info.delivery_info).round != v1.info.round, 15);
        if (0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v1.auction)) {
            abort 12
        };
        let (v2, v3) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg3, arg4);
        let v4 = &mut arg0.id;
        let v5 = get_mut_portfolio_vault<T0, T1, T2>(v4, arg2);
        let v6 = &mut arg0.deposit_vault_registry.id;
        let v7 = get_mut_deposit_vault<T0>(v6, arg2);
        let v8 = AdditionalConfigKey{
            index : v5.info.index,
            tag   : b"min_bid_size",
        };
        let v9 = get_additional_config<u64>(arg1, v8);
        let v10 = 0;
        assert!(arg6 >= *0x1::option::borrow_with_default<u64>(&v9, &v10), 24);
        let v11 = 0x1::vector::borrow<PayoffConfig>(&v5.config.active_vault_config.payoff_configs, 0);
        let v12 = calculate_spot(*0x1::option::borrow<u64>(&v11.strike), v11.strike_pct);
        let v13 = AdditionalConfigKey{
            index : v5.info.index,
            tag   : b"auction_benchmark_price",
        };
        let v14 = get_additional_config<u64>(arg1, v13);
        let v15 = *0x1::option::borrow_with_default<u64>(&v14, &v12);
        let v16 = AdditionalConfigKey{
            index : v5.info.index,
            tag   : b"auction_lot_size",
        };
        let v17 = get_additional_config<u64>(arg1, v16);
        let v18 = calculate_max_auction_size(v5.config.o_token_decimal, v5.config.leverage, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v7) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v7), calculate_max_loss_per_unit(v5.config.option_type, v15, v3, v5.config.d_token_decimal, v5.config.o_token_decimal, v5.config.active_vault_config.payoff_configs, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(2)), *0x1::option::borrow_with_default<u64>(&v17, &v5.config.lot_size));
        let v19 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::total_bid_size<ManagerCap, T1>(0x1::option::borrow<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v5.auction));
        assert!(v19 < v18, 11);
        if (v19 + arg6 > v18) {
            arg6 = v18 - v19;
        };
        let v20 = &mut arg0.id;
        let v21 = get_mut_portfolio_vault<T0, T1, T2>(v20, arg2);
        let v22 = AdditionalConfigKey{
            index : v21.info.index,
            tag   : b"incentive_flag",
        };
        let v23 = get_additional_config<bool>(arg1, v22);
        let (v24, v25) = if (0x1::option::is_some<bool>(&v23) && *0x1::option::borrow<bool>(&v23)) {
            let v26 = AdditionalConfigKey{
                index : v21.info.index,
                tag   : b"incentive_rate_bp",
            };
            let v27 = get_additional_config<u64>(arg1, v26);
            let v28 = 0;
            let v29 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                v2
            } else {
                1
            };
            let v30 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                0x1::option::some<u64>(v3)
            } else {
                0x1::option::none<u64>()
            };
            let v31 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::get_dutch_total_bid_value<ManagerCap, T1>(0x1::option::borrow<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v21.auction), arg6, v21.config.b_token_decimal, v21.config.o_token_decimal, v29, v30, arg4);
            let v32 = (((v31 as u128) * (*0x1::option::borrow_with_default<u64>(&v27, &v28) as u128) / 10000) as u64);
            let v33 = AdditionalConfigKey{
                index : arg2,
                tag   : b"remaining_incentive_sui",
            };
            let v34 = get_additional_config<u64>(arg1, v33);
            let v35 = 0;
            let v36 = *0x1::option::borrow_with_default<u64>(&v34, &v35);
            let v37 = b"incentivise_sui";
            if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v37)) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg0.id, v37, 0x2::balance::zero<T1>());
            };
            let v38 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg0.id, b"incentivise_sui");
            let v39 = 0x2::balance::value<T1>(v38);
            let v40 = 0x2::balance::split<T1>(v38, v36);
            let (v41, v42) = if (0x2::balance::value<T1>(&v40) < v32) {
                let v43 = 0x2::balance::value<T1>(&v40);
                let v44 = 0x2::balance::split<T1>(&mut v40, v43);
                0x2::balance::join<T1>(&mut v44, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::extract_balance<T1>(arg5, v31 - v43, arg7));
                (v44, v43)
            } else {
                let v45 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::extract_balance<T1>(arg5, v31 - v32, arg7);
                0x2::balance::join<T1>(&mut v45, 0x2::balance::split<T1>(&mut v40, v32));
                (v45, v32)
            };
            0x2::balance::join<T1>(v38, v40);
            let v46 = 0x2::balance::value<T1>(v38);
            if (v39 > v46) {
                let v47 = AdditionalConfigKey{
                    index : arg2,
                    tag   : b"remaining_incentive_sui",
                };
                update_additional_config<u64>(arg1, v47, v36 - v39 - v46);
            };
            (0x1::vector::singleton<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v41, arg7)), v42)
        } else {
            (arg5, 0)
        };
        let v48 = &mut arg0.id;
        let v49 = get_mut_portfolio_vault<T0, T1, T2>(v48, arg2);
        let (v50, v51) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg3, arg4);
        let v52 = AdditionalConfigKey{
            index : v49.info.index,
            tag   : b"auction_lot_size",
        };
        let v53 = get_additional_config<u64>(arg1, v52);
        let v54 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
            v50
        } else {
            1
        };
        let v55 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
            0x1::option::some<u64>(v51)
        } else {
            0x1::option::none<u64>()
        };
        let (v56, v57, v58, v59, v60, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::new_bid<ManagerCap, T1>(0x1::option::borrow_mut<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v49.auction), arg6, v49.config.b_token_decimal, v49.config.o_token_decimal, *0x1::option::borrow_with_default<u64>(&v53, &v49.config.lot_size), v24, v54, v55, arg4, arg7);
        let v62 = AdditionalConfigKey{
            index : arg2,
            tag   : b"incentive_flag",
        };
        let v63 = get_additional_config<bool>(arg1, v62);
        if (0x1::option::is_some<bool>(&v63) && *0x1::option::borrow<bool>(&v63)) {
            if (v25 > 0) {
                let v64 = AdditionalConfigKey{
                    index : arg2,
                    tag   : b"bidder_incentive_record",
                };
                let v65 = get_additional_config<0x2::vec_map::VecMap<u64, u64>>(arg1, v64);
                let v66 = 0x2::vec_map::empty<u64, u64>();
                let v67 = *0x1::option::borrow_with_default<0x2::vec_map::VecMap<u64, u64>>(&v65, &v66);
                0x2::vec_map::insert<u64, u64>(&mut v67, v56, v25);
                let v68 = AdditionalConfigKey{
                    index : arg2,
                    tag   : b"bidder_incentive_record",
                };
                update_additional_config<0x2::vec_map::VecMap<u64, u64>>(arg1, v68, v67);
            };
            let v69 = IncentiveNewBid<T1>{
                signer          : 0x2::tx_context::sender(arg7),
                index           : arg2,
                bid_index       : v56,
                incentive_value : v25,
            };
            0x2::event::emit<IncentiveNewBid<T1>>(v69);
        };
        let v70 = NewBid<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg7),
            index      : arg2,
            bid_index  : v56,
            price      : v57,
            size       : v58,
            coin_value : v59,
            ts_ms      : v60,
        };
        0x2::event::emit<NewBid<T0, T1, T2>>(v70);
        let v71 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
            v59 / 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(get_portfolio_vault<T0, T1, T2>(&arg0.id, arg2).config.b_token_decimal)
        } else {
            (((v15 as u128) * (v59 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(get_portfolio_vault<T0, T1, T2>(&arg0.id, arg2).config.b_token_decimal) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v3) as u128)) as u64)
        };
        let v72 = BenchmarkPrice{
            signer          : 0x2::tx_context::sender(arg7),
            index           : arg2,
            benchmark_price : v15,
        };
        0x2::event::emit<BenchmarkPrice>(v72);
        v71
    }

    fun get_additional_config<T0: copy + drop + store>(arg0: &AdditionalConfigRegistry, arg1: AdditionalConfigKey) : 0x1::option::Option<T0> {
        if (0x2::dynamic_field::exists_with_type<AdditionalConfigKey, T0>(&arg0.id, arg1)) {
            0x1::option::some<T0>(*0x2::dynamic_field::borrow<AdditionalConfigKey, T0>(&arg0.id, arg1))
        } else {
            0x1::option::none<T0>()
        }
    }

    public(friend) fun get_additional_configs<T0>(arg0: &Registry, arg1: &AdditionalConfigRegistry, arg2: vector<u64>) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = get_incentive_fund_value<T0>(arg0);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x1::bcs::to_bytes<u64>(&v1));
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v2 = 0x1::vector::empty<u8>();
            let v3 = 0x1::vector::pop_back<u64>(&mut arg2);
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&v3));
            let v4 = AdditionalConfigKey{
                index : v3,
                tag   : b"auction_start_delay_ts_ms",
            };
            let v5 = get_additional_config<u64>(arg1, v4);
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x1::option::Option<u64>>(&v5));
            let v6 = AdditionalConfigKey{
                index : v3,
                tag   : b"auction_lot_size",
            };
            let v7 = get_additional_config<u64>(arg1, v6);
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x1::option::Option<u64>>(&v7));
            let v8 = AdditionalConfigKey{
                index : v3,
                tag   : b"auction_benchmark_price",
            };
            let v9 = get_additional_config<u64>(arg1, v8);
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x1::option::Option<u64>>(&v9));
            let v10 = AdditionalConfigKey{
                index : v3,
                tag   : b"oracle_id",
            };
            let v11 = get_additional_config<address>(arg1, v10);
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x1::option::Option<address>>(&v11));
            let v12 = AdditionalConfigKey{
                index : v3,
                tag   : b"risk_level",
            };
            let v13 = get_additional_config<u8>(arg1, v12);
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x1::option::Option<u8>>(&v13));
            let v14 = AdditionalConfigKey{
                index : v3,
                tag   : b"min_bid_size",
            };
            let v15 = get_additional_config<u64>(arg1, v14);
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x1::option::Option<u64>>(&v15));
            let v16 = AdditionalConfigKey{
                index : v3,
                tag   : b"min_deposit",
            };
            let v17 = get_additional_config<u64>(arg1, v16);
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x1::option::Option<u64>>(&v17));
            let v18 = AdditionalConfigKey{
                index : v3,
                tag   : b"incentive_flag",
            };
            let v19 = get_additional_config<bool>(arg1, v18);
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x1::option::Option<bool>>(&v19));
            let v20 = AdditionalConfigKey{
                index : v3,
                tag   : b"incentive_rate_bp",
            };
            let v21 = get_additional_config<u64>(arg1, v20);
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x1::option::Option<u64>>(&v21));
            let v22 = AdditionalConfigKey{
                index : v3,
                tag   : b"remaining_incentive_sui",
            };
            let v23 = get_additional_config<u64>(arg1, v22);
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x1::option::Option<u64>>(&v23));
            let v24 = AdditionalConfigKey{
                index : v3,
                tag   : b"depositor_incentive_rate_bp",
            };
            let v25 = get_additional_config<u64>(arg1, v24);
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x1::option::Option<u64>>(&v25));
            let v26 = AdditionalConfigKey{
                index : v3,
                tag   : b"portfolio_step",
            };
            let v27 = get_additional_config<u64>(arg1, v26);
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x1::option::Option<u64>>(&v27));
            0x1::vector::push_back<vector<u8>>(&mut v0, v2);
        };
        v0
    }

    public(friend) fun get_auction_bids<T0, T1, T2>(arg0: &Registry, arg1: u64) : vector<UserBid> {
        let v0 = 0x1::vector::empty<UserBid>();
        let v1 = 0x1::option::borrow<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&get_portfolio_vault<T0, T1, T2>(&arg0.id, arg1).auction);
        let v2 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::get_bid_index<ManagerCap, T1>(v1);
        while (v2 > 0) {
            let (v3, v4, v5, v6, v7) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::get_user_bid_info<ManagerCap, T1>(v1, v2 - 1);
            let v8 = UserBid{
                index   : v2 - 1,
                price   : v3,
                size    : v4,
                ts_ms   : v5,
                balance : v6,
                bidder  : v7,
            };
            0x1::vector::push_back<UserBid>(&mut v0, v8);
            v2 = v2 - 1;
        };
        v0
    }

    public(friend) fun get_auction_max_size<T0, T1, T2>(arg0: &Registry, arg1: &AdditionalConfigRegistry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock) : u64 {
        oracle_check(arg1, arg2, arg3);
        let v0 = get_portfolio_vault<T0, T1, T2>(&arg0.id, arg2);
        let v1 = get_deposit_vault<T0>(&arg0.deposit_vault_registry.id, arg2);
        let (_, v3) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg3, arg4);
        let v4 = 0x1::vector::borrow<PayoffConfig>(&v0.config.active_vault_config.payoff_configs, 0);
        let v5 = calculate_spot(*0x1::option::borrow<u64>(&v4.strike), v4.strike_pct);
        let v6 = AdditionalConfigKey{
            index : v0.info.index,
            tag   : b"auction_benchmark_price",
        };
        let v7 = get_additional_config<u64>(arg1, v6);
        calculate_max_auction_size(v0.config.o_token_decimal, v0.config.leverage, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v1) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v1), calculate_max_loss_per_unit(v0.config.option_type, *0x1::option::borrow_with_default<u64>(&v7, &v5), v3, v0.config.d_token_decimal, v0.config.o_token_decimal, v0.config.active_vault_config.payoff_configs, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(2)), v0.config.lot_size)
    }

    public(friend) fun get_auction_total_bid_size<T0, T1, T2>(arg0: &Registry, arg1: u64) : u64 {
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::total_bid_size<ManagerCap, T1>(0x1::option::borrow<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&get_portfolio_vault<T0, T1, T2>(&arg0.id, arg1).auction))
    }

    fun get_bid_vault<T0>(arg0: &0x2::object::UID, arg1: u64) : &0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T0> {
        0x2::dynamic_field::borrow<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T0>>(arg0, arg1)
    }

    fun get_deposit_vault<T0>(arg0: &0x2::object::UID, arg1: u64) : &0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0> {
        0x2::dynamic_field::borrow<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0>>(arg0, arg1)
    }

    public(friend) fun get_incentive_fund_value<T0>(arg0: &Registry) : u64 {
        let v0 = b"incentivise_sui";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public(friend) fun get_max_loss_per_unit<T0, T1, T2>(arg0: &Registry, arg1: &AdditionalConfigRegistry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock) : u64 {
        oracle_check(arg1, arg2, arg3);
        let v0 = get_portfolio_vault<T0, T1, T2>(&arg0.id, arg2);
        let (_, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg3, arg4);
        let v3 = 0x1::vector::borrow<PayoffConfig>(&v0.config.active_vault_config.payoff_configs, 0);
        let v4 = calculate_spot(*0x1::option::borrow<u64>(&v3.strike), v3.strike_pct);
        let v5 = AdditionalConfigKey{
            index : v0.info.index,
            tag   : b"auction_benchmark_price",
        };
        let v6 = get_additional_config<u64>(arg1, v5);
        calculate_max_loss_per_unit(v0.config.option_type, *0x1::option::borrow_with_default<u64>(&v6, &v4), v2, v0.config.d_token_decimal, v0.config.o_token_decimal, v0.config.active_vault_config.payoff_configs, v0.config.leverage)
    }

    fun get_mut_bid_vault<T0>(arg0: &mut 0x2::object::UID, arg1: u64) : &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T0> {
        0x2::dynamic_field::borrow_mut<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T0>>(arg0, arg1)
    }

    fun get_mut_deposit_vault<T0>(arg0: &mut 0x2::object::UID, arg1: u64) : &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0> {
        0x2::dynamic_field::borrow_mut<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0>>(arg0, arg1)
    }

    fun get_mut_portfolio_vault<T0, T1, T2>(arg0: &mut 0x2::object::UID, arg1: u64) : &mut PortfolioVault<T0, T1, T2> {
        0x2::dynamic_object_field::borrow_mut<u64, PortfolioVault<T0, T1, T2>>(arg0, arg1)
    }

    fun get_portfolio_step(arg0: &AdditionalConfigRegistry, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = AdditionalConfigKey{
            index : arg1,
            tag   : b"portfolio_step",
        };
        get_additional_config<u64>(arg0, v0)
    }

    fun get_portfolio_vault<T0, T1, T2>(arg0: &0x2::object::UID, arg1: u64) : &PortfolioVault<T0, T1, T2> {
        0x2::dynamic_object_field::borrow<u64, PortfolioVault<T0, T1, T2>>(arg0, arg1)
    }

    public(friend) fun get_user_shares(arg0: &Registry, arg1: vector<u64>, arg2: address) : vector<UserShare> {
        let v0 = 0x1::vector::empty<UserShare>();
        while (!0x1::vector::is_empty<u64>(&arg1)) {
            let v1 = 0x1::vector::pop_back<u64>(&mut arg1);
            let v2 = &mut v0;
            copy_user_share(v2, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.deposit_vault_registry.user_share_registry), v1, 0, arg2);
            let v3 = &mut v0;
            copy_user_share(v3, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.deposit_vault_registry.user_share_registry), v1, 1, arg2);
            let v4 = &mut v0;
            copy_user_share(v4, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.deposit_vault_registry.user_share_registry), v1, 2, arg2);
            let v5 = &mut v0;
            copy_user_share(v5, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.deposit_vault_registry.user_share_registry), v1, 3, arg2);
            let v6 = &mut v0;
            copy_user_share(v6, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.bid_vault_registry.user_share_registry), v1, 4, arg2);
            let v7 = &mut v0;
            copy_user_share(v7, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.bid_vault_registry.user_share_registry), v1, 5, arg2);
            let v8 = &mut v0;
            copy_user_share(v8, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.bid_vault_registry.user_share_registry), v1, 6, arg2);
        };
        v0
    }

    public(friend) fun get_vault_user_shares<T0, T1>(arg0: &Registry, arg1: u64, arg2: u8, arg3: 0x1::option::Option<address>, arg4: u64) : vector<VaultUserShare> {
        let v0 = if (0x1::option::is_some<address>(&arg3)) {
            0x1::option::some<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::new_user_share_key(arg1, arg2, 0x1::option::extract<address>(&mut arg3)))
        } else {
            0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>()
        };
        if (arg2 == 0) {
            copy_vault_user_share(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.deposit_vault_registry.user_share_registry), 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_user_shares<ManagerCap, T0>(get_deposit_vault<T0>(&arg0.deposit_vault_registry.id, arg1)), v0, arg4)
        } else if (arg2 == 1) {
            copy_vault_user_share(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.deposit_vault_registry.user_share_registry), 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_user_shares<ManagerCap, T0>(get_deposit_vault<T0>(&arg0.deposit_vault_registry.id, arg1)), v0, arg4)
        } else if (arg2 == 2) {
            copy_vault_user_share(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.deposit_vault_registry.user_share_registry), 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::inactive_user_shares<ManagerCap, T0>(get_deposit_vault<T0>(&arg0.deposit_vault_registry.id, arg1)), v0, arg4)
        } else if (arg2 == 3) {
            copy_vault_user_share(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.deposit_vault_registry.user_share_registry), 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::warmup_user_shares<ManagerCap, T0>(get_deposit_vault<T0>(&arg0.deposit_vault_registry.id, arg1)), v0, arg4)
        } else if (arg2 == 4) {
            copy_vault_user_share(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.bid_vault_registry.user_share_registry), 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::bidder_shares<ManagerCap, T1>(get_bid_vault<T1>(&arg0.bid_vault_registry.id, arg1)), v0, arg4)
        } else if (arg2 == 5) {
            copy_vault_user_share(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.bid_vault_registry.user_share_registry), 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::premium_shares<ManagerCap, T1>(get_bid_vault<T1>(&arg0.bid_vault_registry.id, arg1)), v0, arg4)
        } else if (arg2 == 6) {
            copy_vault_user_share(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::get_user_share_registry_uid(&arg0.bid_vault_registry.user_share_registry), 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::performance_fee_shares<ManagerCap, T1>(get_bid_vault<T1>(&arg0.bid_vault_registry.id, arg1)), v0, arg4)
        } else {
            0x1::vector::empty<VaultUserShare>()
        }
    }

    public(friend) entry fun harvest<T0>(arg0: &mut Registry, arg1: &AdditionalConfigRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = get_portfolio_step(arg1, arg2);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = *0x1::option::borrow<u64>(&v0) == 0 || *0x1::option::borrow<u64>(&v0) == 11;
            if (!v1) {
                abort 23
            };
        };
        let v2 = &mut arg0.bid_vault_registry.id;
        let (v3, v4) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::harvest<ManagerCap, T0>(&mut arg0.bid_vault_registry.user_share_registry, get_mut_bid_vault<T0>(v2, arg2), arg3);
        if (v3 == 0) {
            abort 22
        };
        let v5 = Harvest<T0>{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg2,
            share  : v3,
            amount : v4,
        };
        0x2::event::emit<Harvest<T0>>(v5);
    }

    public(friend) entry fun hotfix(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        let v0 = &mut arg1.deposit_vault_registry.id;
        let v1 = get_mut_deposit_vault<0x2::sui::SUI>(v0, arg3);
        let v2 = AdditionalConfigKey{
            index : arg3,
            tag   : b"hotfix_balance_value",
        };
        let v3 = get_additional_config<u64>(arg2, v2);
        let v4 = AdditionalConfigKey{
            index : arg3,
            tag   : b"hotfix_share_supply",
        };
        let v5 = get_additional_config<u64>(arg2, v4);
        let v6 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        let v7 = get_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v6);
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, 0x2::sui::SUI>(v1) == 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, 0x2::sui::SUI>(v1)) {
            abort 0
        };
        let (v8, v9, _, v11) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::hotfix_deposit_vault<ManagerCap, 0x2::sui::SUI>(&mut arg1.deposit_vault_registry.user_share_registry, v1, *0x1::option::borrow<u64>(&v3), 0, *0x1::option::borrow<u64>(&v5), 0x1::option::get_with_default<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v7, 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>()), arg4);
        let v12 = AdditionalConfigKey{
            index : arg3,
            tag   : b"hotfix_balance_value",
        };
        update_additional_config<u64>(arg2, v12, v9);
        let v13 = AdditionalConfigKey{
            index : arg3,
            tag   : b"hotfix_share_supply",
        };
        update_additional_config<u64>(arg2, v13, v11);
        let v14 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        update_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v14, v8);
    }

    public(friend) entry fun hotfix_set_additional_config(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry) {
        let v0 = 8;
        let v1 = &mut arg1.deposit_vault_registry.id;
        let v2 = get_mut_deposit_vault<0x2::sui::SUI>(v1, v0);
        let v3 = AdditionalConfigKey{
            index : v0,
            tag   : b"hotfix_balance_value",
        };
        update_additional_config<u64>(arg2, v3, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, 0x2::sui::SUI>(v2));
        let v4 = AdditionalConfigKey{
            index : v0,
            tag   : b"hotfix_share_supply",
        };
        update_additional_config<u64>(arg2, v4, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, 0x2::sui::SUI>(v2));
        let v5 = 12;
        let v6 = &mut arg1.deposit_vault_registry.id;
        let v7 = get_mut_deposit_vault<0x2::sui::SUI>(v6, v5);
        let v8 = AdditionalConfigKey{
            index : v5,
            tag   : b"hotfix_balance_value",
        };
        update_additional_config<u64>(arg2, v8, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, 0x2::sui::SUI>(v7));
        let v9 = AdditionalConfigKey{
            index : v5,
            tag   : b"hotfix_share_supply",
        };
        update_additional_config<u64>(arg2, v9, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, 0x2::sui::SUI>(v7));
        let v10 = 13;
        let v11 = &mut arg1.deposit_vault_registry.id;
        let v12 = get_mut_deposit_vault<0x2::sui::SUI>(v11, v10);
        let v13 = AdditionalConfigKey{
            index : v10,
            tag   : b"hotfix_balance_value",
        };
        update_additional_config<u64>(arg2, v13, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, 0x2::sui::SUI>(v12));
        let v14 = AdditionalConfigKey{
            index : v10,
            tag   : b"hotfix_share_supply",
        };
        update_additional_config<u64>(arg2, v14, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, 0x2::sui::SUI>(v12));
    }

    public(friend) entry fun new_auction<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 10);
        oracle_check(arg2, arg3, arg4);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg3);
        let v2 = v1.config.activation_ts_ms;
        new_auction_<T0, T1, T2>(arg2, v1, v2, arg4, arg5, arg6);
        update_portfolio_step(arg2, arg3, 11);
    }

    fun new_auction_<T0, T1, T2>(arg0: &mut AdditionalConfigRegistry, arg1: &mut PortfolioVault<T0, T1, T2>, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&arg1.auction), 13);
        assert!(0x1::option::is_none<DeliveryInfo>(&arg1.info.delivery_info) || 0x1::option::borrow<DeliveryInfo>(&arg1.info.delivery_info).round != arg1.info.round, 15);
        assert!(arg2 >= arg1.config.activation_ts_ms, 7);
        let (v0, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg3, arg4);
        let v2 = AdditionalConfigKey{
            index : arg1.info.index,
            tag   : b"auction_start_delay_ts_ms",
        };
        let v3 = get_additional_config<u64>(arg0, v2);
        let v4 = 0;
        let v5 = arg2 + *0x1::option::borrow_with_default<u64>(&v3, &v4);
        let v6 = arg1.config.active_vault_config.strike_increment;
        let v7 = AdditionalConfigKey{
            index : arg1.info.index,
            tag   : b"auction_benchmark_price",
        };
        update_additional_config<u64>(arg0, v7, v0);
        let v8 = &mut arg1.config.active_vault_config.payoff_configs;
        set_strike(v8, v0, v6);
        if (arg1.config.option_type == 1) {
            let v9 = &mut arg1.config.active_vault_config.payoff_configs;
            adjust_put_strike(v9, v0, v6);
        };
        0x1::option::fill<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut arg1.auction, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::new<ManagerCap, T1>(v5, v5 + arg1.config.active_vault_config.auction_duration_in_ms, arg1.config.active_vault_config.decay_speed, arg1.config.active_vault_config.initial_price, arg1.config.active_vault_config.final_price, false, arg5));
        let v10 = NewAuction{
            signer             : 0x2::tx_context::sender(arg5),
            index              : arg1.info.index,
            round              : arg1.info.round,
            vault_config       : arg1.config.active_vault_config,
            able_to_remove_bid : false,
        };
        0x2::event::emit<NewAuction>(v10);
    }

    entry fun new_bid<T0, T1, T2>(arg0: &mut Registry, arg1: &mut AdditionalConfigRegistry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock, arg5: vector<0x2::coin::Coin<T1>>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        f_new_bid<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun oracle_check(arg0: &AdditionalConfigRegistry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle) {
        let v0 = AdditionalConfigKey{
            index : arg1,
            tag   : b"oracle_id",
        };
        assert!(get_additional_config<address>(arg0, v0) == 0x1::option::some<address>(0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg2)), 21);
    }

    public(friend) entry fun refund_active<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 13);
        let v0 = &mut arg1.deposit_vault_registry.id;
        let v1 = AdditionalConfigKey{
            index : arg3,
            tag   : b"total_share_supply",
        };
        let v2 = get_additional_config<u64>(arg2, v1);
        let v3 = AdditionalConfigKey{
            index : arg3,
            tag   : b"refund_shares",
        };
        let v4 = get_additional_config<u64>(arg2, v3);
        let v5 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        let v6 = get_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v5);
        let v7 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::refund_active<ManagerCap, T0>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, get_mut_deposit_vault<T0>(v0, arg3), *0x1::option::borrow<u64>(&v2), *0x1::option::borrow<u64>(&v4), 0x1::option::get_with_default<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v6, 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>()), arg4);
        if (0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>(&v7)) {
            update_portfolio_step(arg2, arg3, 14);
        };
        let v8 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        update_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v8, v7);
    }

    public(friend) entry fun refund_deactivating<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 14);
        let v0 = &mut arg1.deposit_vault_registry.id;
        let v1 = get_mut_deposit_vault<T0>(v0, arg3);
        let v2 = AdditionalConfigKey{
            index : arg3,
            tag   : b"total_share_supply",
        };
        let v3 = get_additional_config<u64>(arg2, v2);
        let v4 = AdditionalConfigKey{
            index : arg3,
            tag   : b"refund_shares",
        };
        let v5 = get_additional_config<u64>(arg2, v4);
        let v6 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        let v7 = get_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v6);
        let v8 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::refund_deactivating<ManagerCap, T0>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, v1, *0x1::option::borrow<u64>(&v3), *0x1::option::borrow<u64>(&v5), 0x1::option::get_with_default<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v7, 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>()), arg4);
        if (0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>(&v8)) {
            update_portfolio_step(arg2, arg3, 15);
            let v9 = AdditionalConfigKey{
                index : arg3,
                tag   : b"total_share_supply",
            };
            update_additional_config<u64>(arg2, v9, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, T0>(v1) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_share_supply<ManagerCap, T0>(v1));
        };
        let v10 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        update_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v10, v8);
    }

    public(friend) fun registry_mut_uid(arg0: &mut Registry) : &mut 0x2::object::UID {
        version_check(arg0);
        &mut arg0.id
    }

    public(friend) fun registry_uid(arg0: &Registry) : &0x2::object::UID {
        version_check(arg0);
        &arg0.id
    }

    fun remove_additional_config<T0: copy + drop + store>(arg0: &mut AdditionalConfigRegistry, arg1: AdditionalConfigKey) {
        if (0x2::dynamic_field::exists_<AdditionalConfigKey>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<AdditionalConfigKey, T0>(&mut arg0.id, arg1);
        };
    }

    fun set_strike(arg0: &mut vector<PayoffConfig>, arg1: u64, arg2: u64) {
        let v0 = 0x1::vector::length<PayoffConfig>(arg0);
        while (v0 > 0) {
            let v1 = 0x1::vector::borrow_mut<PayoffConfig>(arg0, v0 - 1);
            0x1::option::fill<u64>(&mut v1.strike, calculate_strike(arg1, v1.strike_pct, arg2));
            v0 = v0 - 1;
        };
    }

    public(friend) entry fun settle<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 0);
        let v0 = get_portfolio_vault<T0, T1, T2>(&arg1.id, arg3);
        assert!(0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v0.auction), 14);
        if (0x1::option::is_some<DeliveryInfo>(&v0.info.delivery_info) && 0x1::option::borrow<DeliveryInfo>(&v0.info.delivery_info).round == v0.info.round && 0x2::clock::timestamp_ms(arg5) >= v0.config.expiration_ts_ms) {
            settle_<T0, T1, T2>(arg0, arg1, arg3, arg4, arg5, arg6);
        };
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::has_next<ManagerCap, T0>(get_deposit_vault<T0>(&mut arg1.deposit_vault_registry.id, arg3))) {
            update_portfolio_step(arg2, arg3, 8);
        };
    }

    fun settle_<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2);
        assert!(0x2::clock::timestamp_ms(arg4) >= v0.config.expiration_ts_ms, 1);
        if (0x1::option::is_none<DeliveryInfo>(&v0.info.delivery_info) || 0x1::option::borrow<DeliveryInfo>(&v0.info.delivery_info).round != v0.info.round) {
            assert!(0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v0.auction), 14);
            abort 12
        };
        let v1 = get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2);
        let v2 = 0x1::option::borrow<DeliveryInfo>(&v1.info.delivery_info).size;
        let (v3, v4) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_twap_price(arg3, arg4);
        let v5 = calculate_portfolio_payoff_by_price(v1.config.option_type, v3, v4, v1.config.d_token_decimal, v1.config.active_vault_config.payoff_configs, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(2), v2, v1.config.o_token_decimal);
        let v6 = 0x1::option::borrow<DeliveryInfo>(&v1.info.delivery_info).premium;
        let v7 = if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T0, T1>()) {
            v6
        } else if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T0, T2>()) {
            (((v6 as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v4) as u128) / (v3 as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v1.config.d_token_decimal) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v1.config.b_token_decimal) as u128)) as u64)
        } else {
            (((v6 as u128) * (v3 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v4) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v1.config.d_token_decimal) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v1.config.b_token_decimal) as u128)) as u64)
        };
        let v8 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from(v7);
        let v9 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::add(&v5, &v8);
        let v10 = get_deposit_vault<T0>(&mut arg1.deposit_vault_registry.id, arg2);
        let v11 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v10) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v10);
        let v12 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from(v11);
        let v13 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::add(&v12, &v9);
        let v14 = if (v11 != 0) {
            (((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(8) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v13) as u128) / (v11 as u128)) as u64)
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(8)
        };
        let v15 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T0, T1>();
        let (v16, v17) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_twap_price(arg3, arg4);
        let v18 = if (v15) {
            10
        } else {
            v16
        };
        let v19 = if (v15) {
            1
        } else {
            v17
        };
        let v20 = &mut arg1.deposit_vault_registry.id;
        let v21 = get_mut_deposit_vault<T0>(v20, arg2);
        let v22 = &mut arg1.bid_vault_registry.id;
        let v23 = get_mut_bid_vault<T1>(v22, arg2);
        let v24 = &mut arg1.id;
        let v25 = get_mut_portfolio_vault<T0, T1, T2>(v24, arg2);
        v25.config.activation_ts_ms = v25.config.expiration_ts_ms;
        if (v25.config.period == 0) {
            v25.config.expiration_ts_ms = v25.config.expiration_ts_ms + 86400000;
        } else if (v25.config.period == 1) {
            v25.config.expiration_ts_ms = v25.config.expiration_ts_ms + 604800000;
        } else if (v25.config.period == 2) {
            let (_, v27, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::get_date_from_ts(v25.config.expiration_ts_ms / 1000 + 2419200);
            let (_, v30, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::get_date_from_ts(v25.config.expiration_ts_ms / 1000 + 3024000);
            if (v27 != v30) {
                v25.config.expiration_ts_ms = v25.config.expiration_ts_ms + 2419200000;
            } else {
                v25.config.expiration_ts_ms = v25.config.expiration_ts_ms + 3024000000;
            };
        };
        let v32 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::abs(&v5);
        let v33 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::abs(&v9);
        let v34 = Settle<T0, T1, T2>{
            signer                        : 0x2::tx_context::sender(arg5),
            index                         : v25.info.index,
            round                         : v25.info.round,
            oracle_price                  : v16,
            delivery_size                 : v2,
            portfolio_payoff              : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v32),
            portfolio_payoff_is_neg       : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::is_neg(&v5),
            original_premium              : v6,
            portfolio_final_payoff        : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v33),
            portfolio_final_payoff_is_neg : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::is_neg(&v9),
            total_balance                 : v11,
            share_price                   : v14,
            performance_fee               : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::settle_fund<ManagerCap, T0, T1, T2>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, &mut arg1.bid_vault_registry.user_share_registry, v21, v23, get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2).config.d_token_decimal, get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2).config.b_token_decimal, v14, 8, v18, v19, arg5),
            activation_ts_ms              : v25.config.activation_ts_ms,
            expiration_ts_ms              : v25.config.expiration_ts_ms,
        };
        0x2::event::emit<Settle<T0, T1, T2>>(v34);
    }

    public(friend) entry fun settle_adjust_active_user_share_ratio_v2<T0>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 2);
        let v0 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        let v1 = get_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v0);
        let v2 = &mut arg1.deposit_vault_registry.id;
        let v3 = get_mut_deposit_vault<T0>(v2, arg3);
        let v4 = if (0x1::option::is_none<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v1)) {
            true
        } else if (0x1::option::is_some<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v1)) {
            let v5 = 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>();
            0x1::option::borrow<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v1) == &v5
        } else {
            false
        };
        if (v4) {
            let v6 = AdditionalConfigKey{
                index : arg3,
                tag   : b"active_share_supply",
            };
            update_additional_config<u64>(arg2, v6, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, T0>(v3));
            let v7 = AdditionalConfigKey{
                index : arg3,
                tag   : b"active_balance_value",
            };
            update_additional_config<u64>(arg2, v7, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v3));
        };
        let v8 = AdditionalConfigKey{
            index : arg3,
            tag   : b"active_share_supply",
        };
        let v9 = get_additional_config<u64>(arg2, v8);
        let v10 = AdditionalConfigKey{
            index : arg3,
            tag   : b"active_balance_value",
        };
        let v11 = get_additional_config<u64>(arg2, v10);
        let (v12, v13, v14) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::settle_adjust_active_user_share_ratio_v2<ManagerCap, T0>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, v3, *0x1::option::borrow<u64>(&v9), *0x1::option::borrow<u64>(&v11), 0x1::option::get_with_default<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v1, 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>()), arg4);
        let v15 = v12;
        if (!0x1::option::is_some<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>(&v15)) {
            update_portfolio_step(arg2, arg3, 3);
        };
        let v16 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        update_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v16, v15);
        let v17 = AdditionalConfigKey{
            index : arg3,
            tag   : b"active_share_supply",
        };
        update_additional_config<u64>(arg2, v17, v14);
        let v18 = AdditionalConfigKey{
            index : arg3,
            tag   : b"active_balance_value",
        };
        update_additional_config<u64>(arg2, v18, v13);
    }

    public(friend) entry fun settle_adjust_deactivating_user_share_ratio_v2<T0>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 3);
        let v0 = &mut arg1.deposit_vault_registry.id;
        let v1 = get_mut_deposit_vault<T0>(v0, arg3);
        let v2 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        let v3 = get_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v2);
        let v4 = if (0x1::option::is_none<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v3)) {
            true
        } else if (0x1::option::is_some<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v3)) {
            let v5 = 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>();
            0x1::option::borrow<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v3) == &v5
        } else {
            false
        };
        if (v4) {
            let v6 = AdditionalConfigKey{
                index : arg3,
                tag   : b"deactivating_share_supply",
            };
            update_additional_config<u64>(arg2, v6, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_share_supply<ManagerCap, T0>(v1));
            let v7 = AdditionalConfigKey{
                index : arg3,
                tag   : b"deactivating_balance_value",
            };
            update_additional_config<u64>(arg2, v7, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v1));
        };
        let v8 = AdditionalConfigKey{
            index : arg3,
            tag   : b"deactivating_share_supply",
        };
        let v9 = get_additional_config<u64>(arg2, v8);
        let v10 = AdditionalConfigKey{
            index : arg3,
            tag   : b"deactivating_balance_value",
        };
        let v11 = get_additional_config<u64>(arg2, v10);
        let (v12, v13, v14) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::settle_adjust_deactivating_user_share_ratio_v2<ManagerCap, T0>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, v1, *0x1::option::borrow<u64>(&v9), *0x1::option::borrow<u64>(&v11), 0x1::option::get_with_default<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v3, 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>()), arg4);
        let v15 = v12;
        if (!0x1::option::is_some<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>(&v15)) {
            update_portfolio_step(arg2, arg3, 4);
        };
        let v16 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        update_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v16, v15);
        let v17 = AdditionalConfigKey{
            index : arg3,
            tag   : b"deactivating_share_supply",
        };
        update_additional_config<u64>(arg2, v17, v14);
        let v18 = AdditionalConfigKey{
            index : arg3,
            tag   : b"deactivating_balance_value",
        };
        update_additional_config<u64>(arg2, v18, v13);
    }

    public(friend) entry fun settle_bidder_balance<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 1);
        let v0 = AdditionalConfigKey{
            index : arg3,
            tag   : b"settled_share_price_without_premium",
        };
        let v1 = get_additional_config<u64>(arg2, v0);
        let v2 = AdditionalConfigKey{
            index : arg3,
            tag   : b"active_balance_value",
        };
        let v3 = get_additional_config<u64>(arg2, v2);
        let v4 = AdditionalConfigKey{
            index : arg3,
            tag   : b"deactivating_balance_value",
        };
        let v5 = get_additional_config<u64>(arg2, v4);
        let v6 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_bidder",
        };
        let v7 = get_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v6);
        let v8 = &mut arg1.deposit_vault_registry.id;
        let v9 = get_mut_deposit_vault<T0>(v8, arg3);
        let v10 = &mut arg1.bid_vault_registry.id;
        let v11 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::settle_bidder_balance<ManagerCap, T0, T1, T2>(arg0, &arg1.bid_vault_registry.user_share_registry, v9, get_mut_bid_vault<T1>(v10, arg3), *0x1::option::borrow<u64>(&v1), 8, *0x1::option::borrow<u64>(&v3), *0x1::option::borrow<u64>(&v5), 0x1::option::get_with_default<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v7, 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>()), arg4, arg5);
        if (!0x1::option::is_some<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>(&v11) || *0x1::option::borrow<u64>(&v3) == 0) {
            update_portfolio_step(arg2, arg3, 2);
        };
        let v12 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_bidder",
        };
        update_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v12, v11);
    }

    public(friend) entry fun settle_performance_fee_balance<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 0);
        let v0 = get_portfolio_vault<T0, T1, T2>(&arg1.id, arg3);
        let v1 = get_deposit_vault<T0>(&arg1.deposit_vault_registry.id, arg3);
        let v2 = 0x1::option::is_some<DeliveryInfo>(&v0.info.delivery_info) && 0x1::option::borrow<DeliveryInfo>(&v0.info.delivery_info).round == v0.info.round && 0x2::clock::timestamp_ms(arg5) >= v0.config.expiration_ts_ms;
        if (!v2 && 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::has_next<ManagerCap, T0>(v1)) {
            update_portfolio_step(arg2, arg3, 8);
            return
        };
        if (0x1::option::is_none<DeliveryInfo>(&v0.info.delivery_info) || 0x1::option::borrow<DeliveryInfo>(&v0.info.delivery_info).round != v0.info.round) {
            assert!(0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v0.auction), 14);
            abort 12
        };
        assert!(0x2::clock::timestamp_ms(arg5) >= v0.config.expiration_ts_ms, 1);
        let (v3, v4) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_twap_price(arg4, arg5);
        let v5 = &mut arg1.id;
        let v6 = get_mut_portfolio_vault<T0, T1, T2>(v5, arg3);
        let v7 = 0x1::option::borrow<DeliveryInfo>(&v6.info.delivery_info).size;
        let v8 = calculate_portfolio_payoff_by_price(v6.config.option_type, v3, v4, v6.config.d_token_decimal, v6.config.active_vault_config.payoff_configs, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(2), v7, v6.config.o_token_decimal);
        let v9 = 0x1::option::borrow<DeliveryInfo>(&v6.info.delivery_info).premium;
        let v10 = if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T0, T1>()) {
            v9
        } else if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T0, T2>()) {
            (((v9 as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v4) as u128) / (v3 as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v6.config.d_token_decimal) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v6.config.b_token_decimal) as u128)) as u64)
        } else {
            (((v9 as u128) * (v3 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v4) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v6.config.d_token_decimal) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v6.config.b_token_decimal) as u128)) as u64)
        };
        let v11 = &mut arg1.deposit_vault_registry.id;
        let v12 = get_mut_deposit_vault<T0>(v11, arg3);
        let v13 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from(v10);
        let v14 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::add(&v8, &v13);
        let v15 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v12) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v12);
        let v16 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from(v15);
        let v17 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::add(&v16, &v14);
        let v18 = if (v15 != 0) {
            (((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(8) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v17) as u128) / (v15 as u128)) as u64)
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(8)
        };
        let v19 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T0, T1>();
        let v20 = if (v19) {
            10
        } else {
            v3
        };
        let v21 = if (v19) {
            1
        } else {
            v4
        };
        let v22 = &mut arg1.deposit_vault_registry.id;
        let v23 = get_mut_deposit_vault<T0>(v22, arg3);
        let v24 = &mut arg1.bid_vault_registry.id;
        let (v25, v26, v27, v28) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::settle_performance_fee_balance<ManagerCap, T0, T1, T2>(arg0, v23, get_mut_bid_vault<T1>(v24, arg3), get_portfolio_vault<T0, T1, T2>(&arg1.id, arg3).config.d_token_decimal, get_portfolio_vault<T0, T1, T2>(&arg1.id, arg3).config.b_token_decimal, v18, 8, v20, v21, arg6);
        let v29 = AdditionalConfigKey{
            index : arg3,
            tag   : b"settled_share_price",
        };
        update_additional_config<u64>(arg2, v29, v18);
        let v30 = AdditionalConfigKey{
            index : arg3,
            tag   : b"settled_share_price_without_premium",
        };
        update_additional_config<u64>(arg2, v30, v26);
        let v31 = AdditionalConfigKey{
            index : arg3,
            tag   : b"active_balance_value",
        };
        update_additional_config<u64>(arg2, v31, v27);
        let v32 = AdditionalConfigKey{
            index : arg3,
            tag   : b"deactivating_balance_value",
        };
        update_additional_config<u64>(arg2, v32, v28);
        let v33 = AdditionalConfigKey{
            index : arg3,
            tag   : b"active_share_supply",
        };
        update_additional_config<u64>(arg2, v33, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, T0>(get_deposit_vault<T0>(&arg1.deposit_vault_registry.id, arg3)));
        update_portfolio_step(arg2, arg3, 1);
        let v34 = &mut arg1.id;
        let v35 = get_mut_portfolio_vault<T0, T1, T2>(v34, arg3);
        v35.config.activation_ts_ms = v35.config.expiration_ts_ms;
        if (v35.config.period == 0) {
            v35.config.expiration_ts_ms = v35.config.expiration_ts_ms + 86400000;
        } else if (v35.config.period == 1) {
            v35.config.expiration_ts_ms = v35.config.expiration_ts_ms + 604800000;
        } else if (v35.config.period == 2) {
            let (_, v37, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::get_date_from_ts(v35.config.expiration_ts_ms / 1000 + 2419200);
            let (_, v40, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::get_date_from_ts(v35.config.expiration_ts_ms / 1000 + 3024000);
            if (v37 != v40) {
                v35.config.expiration_ts_ms = v35.config.expiration_ts_ms + 2419200000;
            } else {
                v35.config.expiration_ts_ms = v35.config.expiration_ts_ms + 3024000000;
            };
        };
        let v42 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::abs(&v8);
        let v43 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::abs(&v14);
        let v44 = Settle<T0, T1, T2>{
            signer                        : 0x2::tx_context::sender(arg6),
            index                         : v35.info.index,
            round                         : v35.info.round,
            oracle_price                  : v3,
            delivery_size                 : v7,
            portfolio_payoff              : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v42),
            portfolio_payoff_is_neg       : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::is_neg(&v8),
            original_premium              : v9,
            portfolio_final_payoff        : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v43),
            portfolio_final_payoff_is_neg : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::is_neg(&v14),
            total_balance                 : v15,
            share_price                   : v18,
            performance_fee               : v25,
            activation_ts_ms              : v35.config.activation_ts_ms,
            expiration_ts_ms              : v35.config.expiration_ts_ms,
        };
        0x2::event::emit<Settle<T0, T1, T2>>(v44);
    }

    public(friend) entry fun settle_remained_performance_fee_combination<T0>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 5);
        let v0 = &mut arg1.bid_vault_registry.id;
        let v1 = get_mut_bid_vault<T0>(v0, arg3);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::settle_remained_performance_fee_combination<ManagerCap, T0>(arg0, &mut arg1.bid_vault_registry.user_share_registry, v1, arg4);
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::is_empty<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, u64>(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::performance_fee_shares<ManagerCap, T0>(v1))) {
            update_portfolio_step(arg2, arg3, 6);
        };
    }

    public(friend) entry fun settle_reset_bidder_user_share<T0>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 4);
        let v0 = &mut arg1.bid_vault_registry.id;
        let v1 = get_mut_bid_vault<T0>(v0, arg3);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::settle_reset_bidder_user_share<ManagerCap, T0>(arg0, &mut arg1.bid_vault_registry.user_share_registry, v1, arg4);
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::is_empty<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, u64>(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::bidder_shares<ManagerCap, T0>(v1))) {
            update_portfolio_step(arg2, arg3, 5);
        };
    }

    public(friend) entry fun settle_rock_n_roll_active<T0>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 7);
        let v0 = &mut arg1.deposit_vault_registry.id;
        let v1 = get_mut_deposit_vault<T0>(v0, arg3);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::settle_rock_n_roll_active<ManagerCap, T0>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, v1, arg4);
        let v2 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_user_shares<ManagerCap, T0>(v1);
        let v3 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::has_next<ManagerCap, T0>(v1);
        let v4 = !v3 || 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::is_empty<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, u64>(v2);
        if (v4 || v3) {
            update_portfolio_step(arg2, arg3, 8);
        };
    }

    public(friend) entry fun settle_rock_n_roll_deactivating<T0>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        ensure_portfolio_step(arg2, arg3, 6);
        let v0 = &mut arg1.deposit_vault_registry.id;
        let v1 = get_mut_deposit_vault<T0>(v0, arg3);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::settle_rock_n_roll_deactivating<ManagerCap, T0>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, v1, arg4);
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::is_empty<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey, u64>(0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_user_shares<ManagerCap, T0>(v1))) {
            update_portfolio_step(arg2, arg3, 7);
        };
    }

    public(friend) entry fun terminate_auction<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        let v0 = &mut arg1.id;
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::close<ManagerCap, T1>(arg0, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut get_mut_portfolio_vault<T0, T1, T2>(v0, arg2).auction), arg3, arg4);
        let v1 = TerminateAuction<T0, T1, T2>{
            signer : 0x2::tx_context::sender(arg4),
            index  : arg2,
        };
        0x2::event::emit<TerminateAuction<T0, T1, T2>>(v1);
    }

    public(friend) entry fun terminate_vault<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        let PortfolioVault {
            id        : v0,
            info      : _,
            config    : _,
            auction   : v3,
            authority : v4,
        } = 0x2::dynamic_object_field::remove<u64, PortfolioVault<T0, T1, T2>>(&mut arg1.id, arg2);
        let v5 = v4;
        let v6 = v3;
        0x2::object::delete(v0);
        let (_, _, _, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::close_deposit_vault<ManagerCap, T0>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, 0x2::dynamic_field::remove<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0>>(&mut arg1.deposit_vault_registry.id, arg2), arg4);
        let (_, _, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::close_bid_vault<ManagerCap, T1>(arg0, &mut arg1.bid_vault_registry.user_share_registry, 0x2::dynamic_field::remove<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T1>>(&mut arg1.bid_vault_registry.id, arg2), arg4);
        if (0x1::option::is_some<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v6)) {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::close<ManagerCap, T1>(arg0, 0x1::option::destroy_some<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(v6), arg3, arg4);
        } else {
            0x1::option::destroy_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(v6);
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::remove_all<ManagerCap>(&mut v5);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::destroy_empty<ManagerCap>(v5);
        let v14 = TerminateVault<T0, T1, T2>{
            signer : 0x2::tx_context::sender(arg4),
            index  : arg2,
        };
        0x2::event::emit<TerminateVault<T0, T1, T2>>(v14);
    }

    public(friend) entry fun unsubscribe<T0>(arg0: &mut Registry, arg1: &AdditionalConfigRegistry, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = get_portfolio_step(arg1, arg2);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = *0x1::option::borrow<u64>(&v0) == 0 || *0x1::option::borrow<u64>(&v0) == 11;
            if (!v1) {
                abort 23
            };
        };
        let v2 = &mut arg0.deposit_vault_registry.id;
        let v3 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::unsubscribe<ManagerCap, T0>(&mut arg0.deposit_vault_registry.user_share_registry, get_mut_deposit_vault<T0>(v2, arg2), arg3, arg4);
        if (v3 == 0) {
            abort 22
        };
        let v4 = Unsubscribe<T0>{
            signer : 0x2::tx_context::sender(arg4),
            index  : arg2,
            amount : v3,
        };
        0x2::event::emit<Unsubscribe<T0>>(v4);
    }

    public(friend) entry fun update_active_vault_config<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        version_check(arg1);
        check_auction_settings(arg5, arg6, arg7);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg2);
        assert!(0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v1.auction), 13);
        if (0x1::option::is_some<DeliveryInfo>(&v1.info.delivery_info) && 0x1::option::borrow<DeliveryInfo>(&v1.info.delivery_info).round == v1.info.round) {
            abort 15
        };
        v1.config.active_vault_config.strike_increment = arg3;
        v1.config.active_vault_config.decay_speed = arg4;
        v1.config.active_vault_config.initial_price = arg5;
        v1.config.active_vault_config.final_price = arg6;
        v1.config.active_vault_config.auction_duration_in_ms = arg7;
        let v2 = UpdateActiveVaultConfig<T0, T1, T2>{
            signer   : 0x2::tx_context::sender(arg8),
            index    : arg2,
            previous : v1.config.active_vault_config,
            current  : v1.config.active_vault_config,
        };
        0x2::event::emit<UpdateActiveVaultConfig<T0, T1, T2>>(v2);
    }

    fun update_additional_config<T0: copy + drop + store>(arg0: &mut AdditionalConfigRegistry, arg1: AdditionalConfigKey, arg2: T0) {
        if (0x2::dynamic_field::exists_<AdditionalConfigKey>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow_mut<AdditionalConfigKey, T0>(&mut arg0.id, arg1) = arg2;
        } else {
            0x2::dynamic_field::add<AdditionalConfigKey, T0>(&mut arg0.id, arg1, arg2);
        };
    }

    public(friend) entry fun update_auction_lot_size(arg0: &ManagerCap, arg1: &Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        let v0 = AdditionalConfigKey{
            index : arg3,
            tag   : b"auction_lot_size",
        };
        update_additional_config<u64>(arg2, v0, arg4);
    }

    public(friend) entry fun update_auction_start_delay_ts_ms(arg0: &ManagerCap, arg1: &Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        let v0 = AdditionalConfigKey{
            index : arg3,
            tag   : b"auction_start_delay_ts_ms",
        };
        update_additional_config<u64>(arg2, v0, arg4);
    }

    public(friend) entry fun update_capacity<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        version_check(arg1);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg2);
        v1.config.capacity = arg3;
        let v2 = UpdateCapacity<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg4),
            index      : arg2,
            previous   : v1.config.capacity,
            current    : arg3,
            is_manager : true,
        };
        0x2::event::emit<UpdateCapacity<T0, T1, T2>>(v2);
    }

    public(friend) entry fun update_depositor_incentive_rate_bp(arg0: &ManagerCap, arg1: &Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        let v0 = AdditionalConfigKey{
            index : arg3,
            tag   : b"depositor_incentive_rate_bp",
        };
        update_additional_config<u64>(arg2, v0, arg4);
    }

    public(friend) entry fun update_incentive_flag(arg0: &ManagerCap, arg1: &Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: bool) {
        version_check(arg1);
        let v0 = AdditionalConfigKey{
            index : arg3,
            tag   : b"incentive_flag",
        };
        update_additional_config<bool>(arg2, v0, arg4);
    }

    public(friend) entry fun update_incentive_rate_bp(arg0: &ManagerCap, arg1: &Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        let v0 = AdditionalConfigKey{
            index : arg3,
            tag   : b"incentive_rate_bp",
        };
        update_additional_config<u64>(arg2, v0, arg4);
    }

    public(friend) entry fun update_lot_size<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        version_check(arg1);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg2);
        v1.config.lot_size = arg3;
        let v2 = UpdateLotSize<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg4),
            index      : arg2,
            previous   : v1.config.lot_size,
            current    : arg3,
            is_manager : true,
        };
        0x2::event::emit<UpdateLotSize<T0, T1, T2>>(v2);
    }

    public(friend) entry fun update_min_bid_size(arg0: &ManagerCap, arg1: &Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        let v0 = AdditionalConfigKey{
            index : arg3,
            tag   : b"min_bid_size",
        };
        update_additional_config<u64>(arg2, v0, arg4);
    }

    public(friend) entry fun update_min_deposit(arg0: &ManagerCap, arg1: &Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        let v0 = AdditionalConfigKey{
            index : arg3,
            tag   : b"min_deposit",
        };
        update_additional_config<u64>(arg2, v0, arg4);
    }

    public(friend) entry fun update_oracle_id(arg0: &ManagerCap, arg1: &Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle) {
        version_check(arg1);
        let v0 = AdditionalConfigKey{
            index : arg3,
            tag   : b"oracle_id",
        };
        update_additional_config<address>(arg2, v0, 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg4));
    }

    fun update_portfolio_step(arg0: &mut AdditionalConfigRegistry, arg1: u64, arg2: u64) {
        let v0 = AdditionalConfigKey{
            index : arg1,
            tag   : b"portfolio_step",
        };
        update_additional_config<u64>(arg0, v0, arg2);
    }

    public(friend) entry fun update_remaining_incentive_sui(arg0: &ManagerCap, arg1: &Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u64) {
        version_check(arg1);
        let v0 = AdditionalConfigKey{
            index : arg3,
            tag   : b"remaining_incentive_sui",
        };
        update_additional_config<u64>(arg2, v0, arg4);
    }

    public(friend) entry fun update_restrict_activation_time_period(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        version_check(arg1);
        assert!(arg2 <= arg3, 3);
        assert!(arg2 / 86400000 == 0, 3);
        assert!(arg3 / 86400000 == 0, 3);
        arg1.restrict_activation_time_period.from_ts_ms = arg2;
        arg1.restrict_activation_time_period.to_ts_ms = arg3;
        let v0 = UpdateRestrictActivationTimePeriod{
            signer              : 0x2::tx_context::sender(arg4),
            previous_from_ts_ms : arg1.restrict_activation_time_period.from_ts_ms,
            previous_to_ts_ms   : arg1.restrict_activation_time_period.to_ts_ms,
            current_from_ts_ms  : arg2,
            current_to_ts_ms    : arg3,
        };
        0x2::event::emit<UpdateRestrictActivationTimePeriod>(v0);
    }

    public(friend) entry fun update_risk_level(arg0: &ManagerCap, arg1: &Registry, arg2: &mut AdditionalConfigRegistry, arg3: u64, arg4: u8) {
        version_check(arg1);
        let v0 = AdditionalConfigKey{
            index : arg3,
            tag   : b"risk_level",
        };
        update_additional_config<u8>(arg2, v0, arg4);
    }

    public(friend) entry fun update_upcoming_vault_config<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<bool>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::tx_context::TxContext) {
        version_check(arg1);
        check_auction_settings(arg8, arg9, arg10);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg2);
        v1.config.upcoming_vault_config.payoff_configs = create_payoff_configs(arg3, arg4, arg5);
        v1.config.upcoming_vault_config.strike_increment = arg6;
        v1.config.upcoming_vault_config.decay_speed = arg7;
        v1.config.upcoming_vault_config.initial_price = arg8;
        v1.config.upcoming_vault_config.final_price = arg9;
        v1.config.upcoming_vault_config.auction_duration_in_ms = arg10;
        v1.config.warmup_vault_config = v1.config.upcoming_vault_config;
        let v2 = UpdateUpcomingVaultConfig<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg11),
            index      : arg2,
            previous   : v1.config.upcoming_vault_config,
            current    : v1.config.upcoming_vault_config,
            is_manager : true,
        };
        0x2::event::emit<UpdateUpcomingVaultConfig<T0, T1, T2>>(v2);
    }

    public(friend) entry fun update_warmup_vault_config<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        version_check(arg1);
        check_auction_settings(arg5, arg6, arg7);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg2);
        v1.config.warmup_vault_config.strike_increment = arg3;
        v1.config.warmup_vault_config.decay_speed = arg4;
        v1.config.warmup_vault_config.initial_price = arg5;
        v1.config.warmup_vault_config.final_price = arg6;
        v1.config.warmup_vault_config.auction_duration_in_ms = arg7;
        let v2 = UpdateWarmupVaultConfig<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg8),
            index      : arg2,
            previous   : v1.config.warmup_vault_config,
            current    : v1.config.warmup_vault_config,
            is_manager : true,
        };
        0x2::event::emit<UpdateWarmupVaultConfig<T0, T1, T2>>(v2);
    }

    public(friend) entry fun upgrade_registry(arg0: &ManagerCap, arg1: &mut Registry) {
        assert!(300 > arg1.version, 1000);
        arg1.version = 300;
    }

    fun version_check(arg0: &Registry) {
        assert!(300 == arg0.version, 1000);
    }

    public(friend) entry fun withdraw<T0>(arg0: &mut Registry, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.deposit_vault_registry.id;
        let v1 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::withdraw<ManagerCap, T0>(&mut arg0.deposit_vault_registry.user_share_registry, get_mut_deposit_vault<T0>(v0, arg1), arg2, arg3);
        if (v1 == 0) {
            abort 22
        };
        let v2 = Withdraw<T0>{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg1,
            amount : v1,
        };
        0x2::event::emit<Withdraw<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

