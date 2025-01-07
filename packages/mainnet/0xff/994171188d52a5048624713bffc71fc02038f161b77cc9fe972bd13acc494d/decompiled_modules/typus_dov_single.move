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

    struct UserShare {
        index: u64,
        tag: u8,
        user: address,
        share: u64,
    }

    fun activate_<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareRegistry, arg2: &mut PortfolioVault<T0, T1, T2>, arg3: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0>, arg4: &0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::Oracle<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) >= arg2.config.activation_ts_ms, 0);
        let (v0, v1) = 0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::get_price<T2>(arg4, arg5);
        let v2 = arg2.config.warmup_vault_config.payoff_configs;
        let v3 = &mut v2;
        set_strike(v3, v0, arg2.config.warmup_vault_config.strike_increment);
        calculate_max_loss_per_unit(arg2.config.option_type, v0, v1, arg2.config.d_token_decimal, arg2.config.o_token_decimal, v2, arg2.config.leverage);
        arg2.info.round = arg2.info.round + 1;
        arg2.config.active_vault_config = arg2.config.warmup_vault_config;
        arg2.config.warmup_vault_config = arg2.config.upcoming_vault_config;
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::activate<ManagerCap, T0>(arg0, arg1, arg3, arg2.config.has_next, arg6);
        let v4 = arg2.config.activation_ts_ms;
        new_auction_<T0, T1, T2>(arg2, v4, arg4, arg5, arg6);
    }

    public(friend) entry fun add_authorized_user(arg0: &ManagerCap, arg1: &mut Registry, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        version_check(arg1);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::add_authorized_user<ManagerCap>(arg0, &mut arg1.authority, 0x1::vector::pop_back<address>(&mut arg2));
        };
        let v0 = AddAuthorizedUser{
            signer : 0x2::tx_context::sender(arg3),
            users  : arg2,
        };
        0x2::event::emit<AddAuthorizedUser>(v0);
    }

    public(friend) entry fun add_portfolio_vault_authorized_user<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: vector<address>, arg4: &0x2::tx_context::TxContext) {
        version_check(arg1);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg2);
        while (!0x1::vector::is_empty<address>(&arg3)) {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::add_authorized_user<ManagerCap>(arg0, &mut v1.authority, 0x1::vector::pop_back<address>(&mut arg3));
        };
        let v2 = AddPortfolioVaultAuthorizedUser<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg4),
            index      : arg2,
            users      : arg3,
            is_manager : true,
        };
        0x2::event::emit<AddPortfolioVaultAuthorizedUser<T0, T1, T2>>(v2);
    }

    public(friend) entry fun authorized_add_portfolio_vault_authorized_user<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg1);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&v1.authority, arg3);
        let v2 = ManagerCap{id: 0x2::object::new(arg3)};
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::add_authorized_user<ManagerCap>(&v2, &mut v1.authority, 0x1::vector::pop_back<address>(&mut arg2));
        };
        remove_manager_(v2);
        let v3 = AddPortfolioVaultAuthorizedUser<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg3),
            index      : arg1,
            users      : arg2,
            is_manager : false,
        };
        0x2::event::emit<AddPortfolioVaultAuthorizedUser<T0, T1, T2>>(v3);
    }

    public(friend) entry fun authorized_delivery<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: &0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::Oracle<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg1);
        let v2 = &mut arg0.deposit_vault_registry.id;
        let v3 = get_mut_deposit_vault<T0>(v2, arg1);
        let v4 = &mut arg0.bid_vault_registry.id;
        let v5 = get_mut_bid_vault<T1>(v4, arg1);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&v1.authority, arg4);
        let v6 = ManagerCap{id: 0x2::object::new(arg4)};
        let v7 = &mut arg0.deposit_vault_registry.user_share_registry;
        let v8 = &mut arg0.bid_vault_registry.user_share_registry;
        delivery_<T0, T1, T2>(&v6, v7, v8, v1, v3, v5, arg2, arg3, arg4);
        remove_manager_(v6);
    }

    public(friend) entry fun authorized_new_portfolio_vault<T0, T1, T2>(arg0: &mut Registry, arg1: &0x2::clock::Clock, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<bool>, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: bool, arg21: vector<address>, arg22: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&arg0.authority, arg22);
        let (v0, v1, v2) = new_portfolio_vault_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, create_payoff_configs(arg10, arg11, arg12), arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22);
        let v3 = NewPortfolioVault<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg22),
            index      : v0,
            info       : v1,
            config     : v2,
            is_manager : false,
        };
        0x2::event::emit<NewPortfolioVault<T0, T1, T2>>(v3);
    }

    public(friend) entry fun authorized_remove_portfolio_vault_authorized_user<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg1);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&v1.authority, arg3);
        let v2 = ManagerCap{id: 0x2::object::new(arg3)};
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::remove_authorized_user<ManagerCap>(&v2, &mut v1.authority, 0x1::vector::pop_back<address>(&mut arg2));
        };
        remove_manager_(v2);
        let v3 = RemovePortfolioVaultAuthorizedUser<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg3),
            index      : arg1,
            users      : arg2,
            is_manager : true,
        };
        0x2::event::emit<RemovePortfolioVaultAuthorizedUser<T0, T1, T2>>(v3);
    }

    public(friend) entry fun authorized_update_capacity<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg1);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&v1.authority, arg3);
        v1.config.capacity = arg2;
        let v2 = UpdateCapacity<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg3),
            index      : arg1,
            previous   : v1.config.capacity,
            current    : arg2,
            is_manager : false,
        };
        0x2::event::emit<UpdateCapacity<T0, T1, T2>>(v2);
    }

    public(friend) entry fun authorized_update_upcoming_vault_config<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<bool>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        check_auction_settings(arg7, arg8, arg9);
        let v0 = &mut arg0.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg1);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&v1.authority, arg10);
        v1.config.upcoming_vault_config.payoff_configs = create_payoff_configs(arg2, arg3, arg4);
        v1.config.upcoming_vault_config.strike_increment = arg5;
        v1.config.upcoming_vault_config.decay_speed = arg6;
        v1.config.upcoming_vault_config.initial_price = arg7;
        v1.config.upcoming_vault_config.final_price = arg8;
        v1.config.upcoming_vault_config.auction_duration_in_ms = arg9;
        let v2 = UpdateUpcomingVaultConfig<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg10),
            index      : arg1,
            previous   : v1.config.upcoming_vault_config,
            current    : v1.config.upcoming_vault_config,
            is_manager : false,
        };
        0x2::event::emit<UpdateUpcomingVaultConfig<T0, T1, T2>>(v2);
    }

    public(friend) entry fun authorized_update_warmup_vault_config<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        check_auction_settings(arg4, arg5, arg6);
        let v0 = &mut arg0.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg1);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&v1.authority, arg7);
        v1.config.warmup_vault_config.strike_increment = arg2;
        v1.config.warmup_vault_config.decay_speed = arg3;
        v1.config.warmup_vault_config.initial_price = arg4;
        v1.config.warmup_vault_config.final_price = arg5;
        v1.config.warmup_vault_config.auction_duration_in_ms = arg6;
        let v2 = UpdateWarmupVaultConfig<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg7),
            index      : arg1,
            previous   : v1.config.warmup_vault_config,
            current    : v1.config.warmup_vault_config,
            is_manager : false,
        };
        0x2::event::emit<UpdateWarmupVaultConfig<T0, T1, T2>>(v2);
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

    public(friend) entry fun claim<T0>(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.deposit_vault_registry.id;
        let (v1, v2) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::claim<ManagerCap, T0>(&mut arg0.deposit_vault_registry.user_share_registry, get_mut_deposit_vault<T0>(v0, arg1), arg2);
        let v3 = Claim<T0>{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg1,
            amount : v1,
            fee    : v2,
        };
        0x2::event::emit<Claim<T0>>(v3);
    }

    public(friend) entry fun claim_and_harvest<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        claim<T0>(arg0, arg1, arg2);
        harvest<T1>(arg0, arg1, arg2);
        let v0 = ClaimAndHarvest<T0, T1>{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg1,
        };
        0x2::event::emit<ClaimAndHarvest<T0, T1>>(v0);
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

    public(friend) entry fun compound<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.deposit_vault_registry.id;
        let v1 = get_mut_deposit_vault<T0>(v0, arg1);
        let v2 = &mut arg0.bid_vault_registry.id;
        let v3 = get_mut_bid_vault<T0>(v2, arg1);
        let v4 = &mut arg0.id;
        check_capacity<T0, T0, T1>(arg0, arg1);
        let v5 = Compound<T0>{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg1,
            amount : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::compound<ManagerCap, T0>(&mut arg0.deposit_vault_registry.user_share_registry, &mut arg0.bid_vault_registry.user_share_registry, v1, v3, get_mut_portfolio_vault<T0, T0, T1>(v4, arg1).config.lot_size, arg2),
        };
        0x2::event::emit<Compound<T0>>(v5);
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

    public(friend) entry fun delivery<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: &0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::Oracle<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg2);
        let v2 = &mut arg1.deposit_vault_registry.id;
        let v3 = get_mut_deposit_vault<T0>(v2, arg2);
        let v4 = &mut arg1.bid_vault_registry.id;
        let v5 = get_mut_bid_vault<T1>(v4, arg2);
        let v6 = &mut arg1.deposit_vault_registry.user_share_registry;
        let v7 = &mut arg1.bid_vault_registry.user_share_registry;
        delivery_<T0, T1, T2>(arg0, v6, v7, v1, v3, v5, arg3, arg4, arg5);
    }

    fun delivery_<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareRegistry, arg2: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareRegistry, arg3: &mut PortfolioVault<T0, T1, T2>, arg4: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0>, arg5: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T1>, arg6: &0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::Oracle<T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::get_price<T2>(arg6, arg7);
        let v2 = calculate_max_auction_size(arg3.config.o_token_decimal, arg3.config.leverage, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(arg4) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(arg4), calculate_max_loss_per_unit(arg3.config.option_type, v0, v1, arg3.config.d_token_decimal, arg3.config.o_token_decimal, arg3.config.active_vault_config.payoff_configs, arg3.config.leverage), arg3.config.lot_size);
        let v3 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
            v0
        } else {
            1
        };
        let v4 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
            0x1::option::some<u64>(v1)
        } else {
            0x1::option::none<u64>()
        };
        let (v5, v6, v7, v8, v9, v10, v11) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::delivery<ManagerCap, T1>(arg0, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut arg3.auction), v2, arg3.config.b_token_decimal, arg3.config.o_token_decimal, v3, v4, arg7, arg8);
        let v12 = DeliveryInfo{
            round   : arg3.info.round,
            price   : v8,
            size    : v9,
            premium : v7,
            ts_ms   : 0x2::clock::timestamp_ms(arg7),
        };
        arg3.info.delivery_info = 0x1::option::some<DeliveryInfo>(v12);
        let v13 = if (v2 > 0) {
            ((((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, T0>(arg4) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_share_supply<ManagerCap, T0>(arg4)) as u128) * ((v2 - v9) as u128) / (v2 as u128)) as u64)
        } else {
            0
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery<ManagerCap, T0, T1>(arg0, arg1, arg2, arg4, arg5, v13, v5, v6, arg8);
        let v14 = Delivery<T0, T1, T2>{
            signer          : 0x2::tx_context::sender(arg8),
            index           : arg3.info.index,
            round           : arg3.info.round,
            max_size        : v2,
            delivery_price  : v8,
            delivery_size   : v9,
            premium_value   : v7,
            refund_shares   : v13,
            fee_per_unit    : v10,
            accumulated_fee : v11,
        };
        0x2::event::emit<Delivery<T0, T1, T2>>(v14);
    }

    public(friend) entry fun deposit<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::prepare_deposit_vault_user_share_node(&mut arg0.deposit_vault_registry.user_share_registry, arg1, arg4);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::prepare_bid_vault_user_share_node(&mut arg0.bid_vault_registry.user_share_registry, arg1, arg4);
        let v0 = &mut arg0.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg1);
        let v2 = &mut arg0.deposit_vault_registry.id;
        check_capacity<T0, T1, T2>(arg0, arg1);
        let v3 = Deposit<T0>{
            signer : 0x2::tx_context::sender(arg4),
            index  : arg1,
            amount : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deposit<ManagerCap, T0>(&mut arg0.deposit_vault_registry.user_share_registry, get_mut_deposit_vault<T0>(v2, arg1), arg2, arg3, v1.config.lot_size, arg4),
        };
        0x2::event::emit<Deposit<T0>>(v3);
    }

    public(friend) entry fun evolution<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: &0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::Oracle<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        let v0 = &mut arg1.deposit_vault_registry.user_share_registry;
        let v1 = &mut arg1.bid_vault_registry.user_share_registry;
        let v2 = &mut arg1.id;
        let v3 = get_mut_portfolio_vault<T0, T1, T2>(v2, arg2);
        let v4 = &mut arg1.deposit_vault_registry.id;
        let v5 = get_mut_deposit_vault<T0>(v4, arg2);
        let v6 = &mut arg1.bid_vault_registry.id;
        let v7 = get_mut_bid_vault<T1>(v6, arg2);
        evolution_<T0, T1, T2>(arg0, v0, v1, v3, v5, v7, arg3, arg4, arg5);
        let v8 = Evolution<T0, T1, T2>{
            signer : 0x2::tx_context::sender(arg5),
            index  : arg2,
        };
        0x2::event::emit<Evolution<T0, T1, T2>>(v8);
    }

    fun evolution_<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareRegistry, arg2: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareRegistry, arg3: &mut PortfolioVault<T0, T1, T2>, arg4: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0>, arg5: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T1>, arg6: &0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::Oracle<T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&arg3.auction), 14);
        if (0x1::option::is_some<DeliveryInfo>(&arg3.info.delivery_info) && 0x1::option::borrow<DeliveryInfo>(&arg3.info.delivery_info).round == arg3.info.round) {
            settle_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        };
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::has_next<ManagerCap, T0>(arg4)) {
            activate_<T0, T1, T2>(arg0, arg1, arg3, arg4, arg6, arg7, arg8);
        };
    }

    public(friend) fun get_auction_max_size<T0, T1, T2>(arg0: &Registry, arg1: u64, arg2: &0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::Oracle<T2>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = get_portfolio_vault<T0, T1, T2>(&arg0.id, arg1);
        let v1 = get_deposit_vault<T0>(&arg0.deposit_vault_registry.id, arg1);
        let (v2, v3) = 0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::get_price<T2>(arg2, arg3);
        calculate_max_auction_size(v0.config.o_token_decimal, v0.config.leverage, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v1) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v1), calculate_max_loss_per_unit(v0.config.option_type, v2, v3, v0.config.d_token_decimal, v0.config.o_token_decimal, v0.config.active_vault_config.payoff_configs, v0.config.leverage), v0.config.lot_size)
    }

    fun get_bid_vault<T0>(arg0: &0x2::object::UID, arg1: u64) : &0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T0> {
        0x2::dynamic_field::borrow<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T0>>(arg0, arg1)
    }

    fun get_deposit_vault<T0>(arg0: &0x2::object::UID, arg1: u64) : &0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0> {
        0x2::dynamic_field::borrow<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0>>(arg0, arg1)
    }

    public(friend) fun get_max_loss_per_unit<T0, T1, T2>(arg0: &Registry, arg1: u64, arg2: &0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::Oracle<T2>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = get_portfolio_vault<T0, T1, T2>(&arg0.id, arg1);
        let (v1, v2) = 0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::get_price<T2>(arg2, arg3);
        calculate_max_loss_per_unit(v0.config.option_type, v1, v2, v0.config.d_token_decimal, v0.config.o_token_decimal, v0.config.active_vault_config.payoff_configs, v0.config.leverage)
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

    public(friend) entry fun harvest<T0>(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.bid_vault_registry.id;
        let (v1, v2) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::harvest<ManagerCap, T0>(&mut arg0.bid_vault_registry.user_share_registry, get_mut_bid_vault<T0>(v0, arg1), arg2);
        let v3 = Harvest<T0>{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg1,
            share  : v1,
            amount : v2,
        };
        0x2::event::emit<Harvest<T0>>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ManagerCap>(v0, 0x2::tx_context::sender(arg0));
        new_registry_(arg0);
    }

    public(friend) entry fun new_auction<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::Oracle<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg2);
        new_auction_<T0, T1, T2>(v1, arg3, arg4, arg5, arg6);
    }

    fun new_auction_<T0, T1, T2>(arg0: &mut PortfolioVault<T0, T1, T2>, arg1: u64, arg2: &0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::Oracle<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&arg0.auction), 13);
        assert!(0x1::option::is_none<DeliveryInfo>(&arg0.info.delivery_info) || 0x1::option::borrow<DeliveryInfo>(&arg0.info.delivery_info).round != arg0.info.round, 15);
        assert!(arg1 >= arg0.config.activation_ts_ms, 7);
        let (v0, _) = 0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::get_price<T2>(arg2, arg3);
        let v2 = &mut arg0.config.active_vault_config.payoff_configs;
        set_strike(v2, v0, arg0.config.active_vault_config.strike_increment);
        0x1::option::fill<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut arg0.auction, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::new<ManagerCap, T1>(arg1, arg1 + arg0.config.active_vault_config.auction_duration_in_ms, arg0.config.active_vault_config.decay_speed, arg0.config.active_vault_config.initial_price, arg0.config.active_vault_config.final_price, false, arg4));
        let v3 = NewAuction{
            signer             : 0x2::tx_context::sender(arg4),
            index              : arg0.info.index,
            round              : arg0.info.round,
            vault_config       : arg0.config.active_vault_config,
            able_to_remove_bid : false,
        };
        0x2::event::emit<NewAuction>(v3);
    }

    public(friend) entry fun new_bid<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: &0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::Oracle<T2>, arg3: &0x2::clock::Clock, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::prepare_bid_vault_bidder_share_node(&mut arg0.bid_vault_registry.user_share_registry, arg1, arg6);
        let v0 = &mut arg0.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg1);
        let v2 = &mut arg0.deposit_vault_registry.id;
        let v3 = get_mut_deposit_vault<T0>(v2, arg1);
        assert!(0x1::option::is_none<DeliveryInfo>(&v1.info.delivery_info) || 0x1::option::borrow<DeliveryInfo>(&v1.info.delivery_info).round != v1.info.round, 15);
        if (0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v1.auction)) {
            abort 12
        };
        let (v4, v5) = 0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::get_price<T2>(arg2, arg3);
        let v6 = calculate_max_auction_size(v1.config.o_token_decimal, v1.config.leverage, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v3) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v3), calculate_max_loss_per_unit(v1.config.option_type, v4, v5, v1.config.d_token_decimal, v1.config.o_token_decimal, v1.config.active_vault_config.payoff_configs, v1.config.leverage), v1.config.lot_size);
        let v7 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::total_bid_size<ManagerCap, T1>(0x1::option::borrow<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v1.auction));
        assert!(v7 < v6, 11);
        if (v7 + arg5 > v6) {
            arg5 = v6 - v7;
        };
        let v8 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
            v4
        } else {
            1
        };
        let v9 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
            0x1::option::some<u64>(v5)
        } else {
            0x1::option::none<u64>()
        };
        let (v10, v11, v12, v13, v14, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::new_bid<ManagerCap, T1>(0x1::option::borrow_mut<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v1.auction), arg5, v1.config.b_token_decimal, v1.config.o_token_decimal, v1.config.lot_size, arg4, v8, v9, arg3, arg6);
        let v16 = NewBid<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg6),
            index      : arg1,
            bid_index  : v10,
            price      : v11,
            size       : v12,
            coin_value : v13,
            ts_ms      : v14,
        };
        0x2::event::emit<NewBid<T0, T1, T2>>(v16);
    }

    public(friend) entry fun new_manager(arg0: &ManagerCap, arg1: &Registry, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        new_manager_(arg2, arg3);
        let v0 = NewManager{
            signer : 0x2::tx_context::sender(arg3),
            users  : arg2,
        };
        0x2::event::emit<NewManager>(v0);
    }

    fun new_manager_(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg0)) {
            let v0 = ManagerCap{id: 0x2::object::new(arg1)};
            0x2::transfer::transfer<ManagerCap>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public(friend) entry fun new_portfolio_vault<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &0x2::clock::Clock, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<bool>, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: bool, arg22: vector<address>, arg23: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        let (v0, v1, v2) = new_portfolio_vault_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, create_payoff_configs(arg11, arg12, arg13), arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23);
        let v3 = NewPortfolioVault<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg23),
            index      : v0,
            info       : v1,
            config     : v2,
            is_manager : true,
        };
        0x2::event::emit<NewPortfolioVault<T0, T1, T2>>(v3);
    }

    fun new_portfolio_vault_<T0, T1, T2>(arg0: &mut Registry, arg1: &0x2::clock::Clock, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: vector<PayoffConfig>, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: vector<address>, arg20: &mut 0x2::tx_context::TxContext) : (u64, Info, Config) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg3 == 0 || arg3 == 1 || arg3 == 2, 2);
        let v1 = arg4 % 86400000;
        assert!(v1 >= arg0.restrict_activation_time_period.from_ts_ms, 4);
        assert!(v1 <= arg0.restrict_activation_time_period.to_ts_ms, 4);
        assert!(arg4 >= v0, 4);
        assert!(arg5 > v0, 5);
        check_auction_settings(arg14, arg15, arg16);
        if (arg3 == 0) {
            assert!(arg5 - arg4 == 86400000, 5);
        } else if (arg3 == 1) {
            assert!(arg5 - arg4 == 604800000, 5);
        } else {
            assert!(arg5 - arg4 == 2419200000 || arg5 - arg4 == 3024000000, 5);
        };
        let v2 = arg0.num_of_vault;
        let v3 = VaultConfig{
            payoff_configs         : arg10,
            strike_increment       : arg11,
            decay_speed            : arg13,
            initial_price          : arg14,
            final_price            : arg15,
            auction_duration_in_ms : arg16,
        };
        let v4 = Info{
            index         : v2,
            creator       : 0x2::tx_context::sender(arg20),
            create_ts_ms  : v0,
            round         : 0,
            delivery_info : 0x1::option::none<DeliveryInfo>(),
        };
        let v5 = Config{
            option_type           : arg2,
            period                : arg3,
            activation_ts_ms      : arg4,
            expiration_ts_ms      : arg5,
            d_token_decimal       : arg6,
            b_token_decimal       : arg7,
            o_token_decimal       : arg8,
            lot_size              : arg12,
            capacity              : arg9,
            leverage              : arg17,
            has_next              : arg18,
            active_vault_config   : v3,
            warmup_vault_config   : v3,
            upcoming_vault_config : v3,
        };
        let v6 = PortfolioVault<T0, T1, T2>{
            id        : 0x2::object::new(arg20),
            info      : v4,
            config    : v5,
            auction   : 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(),
            authority : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::new<ManagerCap>(arg19, arg20),
        };
        0x2::dynamic_object_field::add<u64, PortfolioVault<T0, T1, T2>>(&mut arg0.id, v2, v6);
        0x2::dynamic_field::add<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0>>(&mut arg0.deposit_vault_registry.id, v2, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::new_deposit_vault<ManagerCap, T0>(v2, &mut arg0.deposit_vault_registry.user_share_registry, arg20));
        0x2::dynamic_field::add<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T1>>(&mut arg0.bid_vault_registry.id, v2, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::new_bid_vault<ManagerCap, T1>(v2, &mut arg0.bid_vault_registry.user_share_registry, arg20));
        arg0.num_of_vault = arg0.num_of_vault + 1;
        (v2, v4, v5)
    }

    public(friend) entry fun new_registry(arg0: &ManagerCap, arg1: &mut 0x2::tx_context::TxContext) {
        new_registry_(arg1);
    }

    fun new_registry_(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RestrictActivationTimePeriod{
            from_ts_ms : 28800000,
            to_ts_ms   : 36000000,
        };
        let v1 = DepositVaultRegistry{
            id                  : 0x2::object::new(arg0),
            user_share_registry : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::new_user_share_registry(arg0),
        };
        let v2 = BidVaultRegistry{
            id                  : 0x2::object::new(arg0),
            user_share_registry : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::new_user_share_registry(arg0),
        };
        let v3 = Registry{
            id                              : 0x2::object::new(arg0),
            num_of_vault                    : 0,
            authority                       : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::new<ManagerCap>(0x1::vector::empty<address>(), arg0),
            restrict_activation_time_period : v0,
            deposit_vault_registry          : v1,
            bid_vault_registry              : v2,
            version                         : 1,
        };
        0x2::transfer::share_object<Registry>(v3);
    }

    public(friend) entry fun remove_authorized_user(arg0: &ManagerCap, arg1: &mut Registry, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        version_check(arg1);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::remove_authorized_user<ManagerCap>(arg0, &mut arg1.authority, 0x1::vector::pop_back<address>(&mut arg2));
        };
        let v0 = RemoveAuthorizedUser{
            signer : 0x2::tx_context::sender(arg3),
            users  : arg2,
        };
        0x2::event::emit<RemoveAuthorizedUser>(v0);
    }

    public(friend) entry fun remove_manager(arg0: ManagerCap, arg1: &Registry, arg2: &0x2::tx_context::TxContext) {
        version_check(arg1);
        remove_manager_(arg0);
        let v0 = RemoveManager{signer: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<RemoveManager>(v0);
    }

    fun remove_manager_(arg0: ManagerCap) {
        let ManagerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) entry fun remove_portfolio_vault_authorized_user<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: u64, arg3: vector<address>, arg4: &0x2::tx_context::TxContext) {
        version_check(arg1);
        let v0 = &mut arg1.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg2);
        while (!0x1::vector::is_empty<address>(&arg3)) {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::remove_authorized_user<ManagerCap>(arg0, &mut v1.authority, 0x1::vector::pop_back<address>(&mut arg3));
        };
        let v2 = RemovePortfolioVaultAuthorizedUser<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg4),
            index      : arg2,
            users      : arg3,
            is_manager : true,
        };
        0x2::event::emit<RemovePortfolioVaultAuthorizedUser<T0, T1, T2>>(v2);
    }

    fun set_strike(arg0: &mut vector<PayoffConfig>, arg1: u64, arg2: u64) {
        let v0 = 0x1::vector::length<PayoffConfig>(arg0);
        while (v0 > 0) {
            let v1 = 0x1::vector::borrow_mut<PayoffConfig>(arg0, v0 - 1);
            0x1::option::fill<u64>(&mut v1.strike, calculate_strike(arg1, v1.strike_pct, arg2));
            v0 = v0 - 1;
        };
    }

    fun settle_<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareRegistry, arg2: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareRegistry, arg3: &mut PortfolioVault<T0, T1, T2>, arg4: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0>, arg5: &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T1>, arg6: &0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::Oracle<T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle::get_price<T2>(arg6, arg7);
        assert!(0x2::clock::timestamp_ms(arg7) >= arg3.config.expiration_ts_ms, 1);
        if (0x1::option::is_none<DeliveryInfo>(&arg3.info.delivery_info) || 0x1::option::borrow<DeliveryInfo>(&arg3.info.delivery_info).round != arg3.info.round) {
            assert!(0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&arg3.auction), 14);
            abort 12
        };
        let v2 = 0x1::option::borrow<DeliveryInfo>(&arg3.info.delivery_info).size;
        let v3 = calculate_portfolio_payoff_by_price(arg3.config.option_type, v0, v1, arg3.config.d_token_decimal, arg3.config.active_vault_config.payoff_configs, arg3.config.leverage, v2, arg3.config.o_token_decimal);
        let v4 = 0x1::option::borrow<DeliveryInfo>(&arg3.info.delivery_info).premium;
        let v5 = if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T0, T1>()) {
            v4
        } else if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T0, T2>()) {
            (((v4 as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v1) as u128) / (v0 as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg3.config.d_token_decimal) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg3.config.b_token_decimal) as u128)) as u64)
        } else {
            (((v4 as u128) * (v0 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v1) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg3.config.d_token_decimal) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg3.config.b_token_decimal) as u128)) as u64)
        };
        let v6 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from(v5);
        let v7 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::add(&v3, &v6);
        let v8 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(arg4) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(arg4);
        let v9 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from(v8);
        let v10 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::add(&v9, &v7);
        let v11 = if (v8 != 0) {
            (((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(8) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v10) as u128) / (v8 as u128)) as u64)
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(8)
        };
        let v12 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T0, T1>();
        let v13 = if (v12) {
            10
        } else {
            v0
        };
        let v14 = if (v12) {
            1
        } else {
            v1
        };
        arg3.config.activation_ts_ms = arg3.config.expiration_ts_ms;
        if (arg3.config.period == 0) {
            arg3.config.expiration_ts_ms = arg3.config.expiration_ts_ms + 86400000;
        } else if (arg3.config.period == 1) {
            arg3.config.expiration_ts_ms = arg3.config.expiration_ts_ms + 604800000;
        } else if (arg3.config.period == 2) {
            let (_, v16, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::get_date_from_ts(arg3.config.expiration_ts_ms / 1000 + 2419200);
            let (_, v19, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::get_date_from_ts(arg3.config.expiration_ts_ms / 1000 + 3024000);
            if (v16 != v19) {
                arg3.config.expiration_ts_ms = arg3.config.expiration_ts_ms + 2419200000;
            } else {
                arg3.config.expiration_ts_ms = arg3.config.expiration_ts_ms + 3024000000;
            };
        };
        let v21 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::abs(&v3);
        let v22 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::abs(&v7);
        let v23 = Settle<T0, T1, T2>{
            signer                        : 0x2::tx_context::sender(arg8),
            index                         : arg3.info.index,
            round                         : arg3.info.round,
            oracle_price                  : v0,
            delivery_size                 : v2,
            portfolio_payoff              : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v21),
            portfolio_payoff_is_neg       : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::is_neg(&v3),
            original_premium              : v4,
            portfolio_final_payoff        : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v22),
            portfolio_final_payoff_is_neg : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::is_neg(&v7),
            total_balance                 : v8,
            share_price                   : v11,
            performance_fee               : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::settle_fund<ManagerCap, T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, arg3.config.d_token_decimal, arg3.config.b_token_decimal, v11, 8, v13, v14, arg8),
            activation_ts_ms              : arg3.config.activation_ts_ms,
            expiration_ts_ms              : arg3.config.expiration_ts_ms,
        };
        0x2::event::emit<Settle<T0, T1, T2>>(v23);
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

    public(friend) entry fun unsubscribe<T0>(arg0: &mut Registry, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.deposit_vault_registry.id;
        let v1 = Unsubscribe<T0>{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg1,
            amount : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::unsubscribe<ManagerCap, T0>(&mut arg0.deposit_vault_registry.user_share_registry, get_mut_deposit_vault<T0>(v0, arg1), arg2, arg3),
        };
        0x2::event::emit<Unsubscribe<T0>>(v1);
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
        assert!(1 > arg1.version, 1000);
        arg1.version = 1;
    }

    fun version_check(arg0: &Registry) {
        assert!(1 == arg0.version, 1000);
    }

    public(friend) entry fun withdraw<T0>(arg0: &mut Registry, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.deposit_vault_registry.id;
        let v1 = Withdraw<T0>{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg1,
            amount : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::withdraw<ManagerCap, T0>(&mut arg0.deposit_vault_registry.user_share_registry, get_mut_deposit_vault<T0>(v0, arg1), arg2, arg3),
        };
        0x2::event::emit<Withdraw<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

