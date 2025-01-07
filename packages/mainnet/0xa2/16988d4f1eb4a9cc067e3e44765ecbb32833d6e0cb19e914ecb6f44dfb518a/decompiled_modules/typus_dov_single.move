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

    public(friend) entry fun authorized_delivery<T0, T1, T2>(arg0: &mut Registry, arg1: &mut AdditionalConfigRegistry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        oracle_check(arg1, arg2, arg3);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&get_portfolio_vault<T0, T1, T2>(&arg0.id, arg2).authority, arg5);
        let v0 = ManagerCap{id: 0x2::object::new(arg5)};
        delivery_<T0, T1, T2>(&v0, arg0, arg2, arg1, arg3, arg4, arg5);
        remove_manager_(v0);
        update_portfolio_step(arg1, arg2, 0);
    }

    public(friend) entry fun authorized_deposit_incentive_fund<T0>(arg0: &mut Registry, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&arg0.authority, arg3);
        let v0 = b"incentivise_sui";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::extract_balance<T0>(arg1, arg2, arg3));
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::extract_balance<T0>(arg1, arg2, arg3));
        };
    }

    public(friend) entry fun authorized_new_portfolio_vault<T0, T1, T2>(arg0: &mut Registry, arg1: &mut AdditionalConfigRegistry, arg2: &0x2::clock::Clock, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<bool>, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u8, arg22: bool, arg23: vector<address>, arg24: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&arg0.authority, arg24);
        let (v0, v1, v2) = new_portfolio_vault_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, create_payoff_configs(arg11, arg12, arg13), arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
        let v3 = NewPortfolioVault<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg24),
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

    public(friend) entry fun authorized_update_lot_size<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg1);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&v1.authority, arg3);
        v1.config.lot_size = arg2;
        let v2 = UpdateLotSize<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg3),
            index      : arg1,
            previous   : v1.config.lot_size,
            current    : arg2,
            is_manager : false,
        };
        0x2::event::emit<UpdateLotSize<T0, T1, T2>>(v2);
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
        v1.config.warmup_vault_config = v1.config.upcoming_vault_config;
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
        abort 99999
    }

    public(friend) entry fun claim_and_harvest<T0, T1>(arg0: &mut Registry, arg1: &AdditionalConfigRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 99999
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
        abort 99999
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
            let v27 = &mut arg1.id;
            let v28 = get_mut_portfolio_vault<T0, T1, T2>(v27, arg2);
            let v29 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                v0
            } else {
                1
            };
            let v30 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                0x1::option::some<u64>(v1)
            } else {
                0x1::option::none<u64>()
            };
            let (v31, v32, v33, v34, v35, v36, v37, v38) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::delivery_with_rewards<ManagerCap, T1>(arg0, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v28.auction), v10, v28.config.b_token_decimal, v28.config.o_token_decimal, v29, v30, *0x1::option::borrow_with_default<u64>(&v25, &v26), arg5, arg6);
            let v39 = v38;
            let v40 = b"incentivise_sui";
            if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v40)) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v40, 0x2::balance::zero<T0>());
            };
            if (0x2::balance::value<T1>(&v39) > 0) {
                let v41 = AdditionalConfigKey{
                    index : arg2,
                    tag   : b"remaining_incentive_sui",
                };
                update_additional_config<u64>(arg3, v41, *0x1::option::borrow_with_default<u64>(&v22, &v23) + 0x2::balance::value<T1>(&v39));
            };
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"incentivise_sui"), v39);
            (v31, v32, v33, v34, v35, v36, v37, 0x2::balance::value<T1>(&v39))
        } else {
            let v42 = &mut arg1.id;
            let v43 = get_mut_portfolio_vault<T0, T1, T2>(v42, arg2);
            let v44 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                v0
            } else {
                1
            };
            let v45 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                0x1::option::some<u64>(v1)
            } else {
                0x1::option::none<u64>()
            };
            let (v46, v47, v48, v49, v50, v51, v52) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::delivery<ManagerCap, T1>(arg0, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v43.auction), v10, v43.config.b_token_decimal, v43.config.o_token_decimal, v44, v45, arg5, arg6);
            (v46, v47, v48, v49, v50, v51, v52, 0)
        };
        let v53 = &mut arg1.id;
        let v54 = get_mut_portfolio_vault<T0, T1, T2>(v53, arg2);
        let v55 = DeliveryInfo{
            round   : v54.info.round,
            price   : v16,
            size    : v17,
            premium : v15,
            ts_ms   : 0x2::clock::timestamp_ms(arg5),
        };
        v54.info.delivery_info = 0x1::option::some<DeliveryInfo>(v55);
        let v56 = &mut arg1.deposit_vault_registry.id;
        let v57 = get_mut_deposit_vault<T0>(v56, arg2);
        let v58 = &mut arg1.bid_vault_registry.id;
        let v59 = get_mut_bid_vault<T1>(v58, arg2);
        let v60 = if (v10 > 0) {
            ((((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, T0>(v57) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_share_supply<ManagerCap, T0>(v57)) as u128) * ((v10 - v17) as u128) / (v10 as u128)) as u64)
        } else {
            0
        };
        if (0x1::option::is_some<bool>(&v12) && *0x1::option::borrow<bool>(&v12)) {
            let v61 = AdditionalConfigKey{
                index : arg2,
                tag   : b"remaining_incentive_sui",
            };
            let v62 = get_additional_config<u64>(arg3, v61);
            let v63 = 0;
            let v64 = *0x1::option::borrow_with_default<u64>(&v62, &v63);
            let v65 = get_portfolio_vault<T0, T1, T2>(&arg1.id, arg2);
            let v66 = AdditionalConfigKey{
                index : arg2,
                tag   : b"depositor_incentive_rate_bp",
            };
            let v67 = get_additional_config<u64>(arg3, v66);
            let v68 = 0;
            let v69 = 0x1::vector::borrow<PayoffConfig>(&v65.config.active_vault_config.payoff_configs, 0);
            let v70 = calculate_spot(*0x1::option::borrow<u64>(&v69.strike), v69.strike_pct);
            let v71 = AdditionalConfigKey{
                index : v65.info.index,
                tag   : b"auction_benchmark_price",
            };
            let v72 = get_additional_config<u64>(arg3, v71);
            let v73 = if (v10 > 0) {
                ((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v57) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v57)) as u128) * (v17 as u128) / (v10 as u128)
            } else {
                0
            };
            let v74 = if (v65.config.option_type == 1) {
                v73 * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v1) as u128) / (*0x1::option::borrow_with_default<u64>(&v72, &v70) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v65.config.b_token_decimal) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v65.config.d_token_decimal) as u128)
            } else {
                v73
            };
            let v75 = ((v74 * (*0x1::option::borrow_with_default<u64>(&v67, &v68) as u128) / 10000) as u64);
            let v76 = b"incentivise_sui";
            if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v76)) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v76, 0x2::balance::zero<T0>());
            };
            let v77 = if (v75 > 0) {
                if (v64 > v75) {
                    v75
                } else {
                    v64
                }
            } else {
                0
            };
            let v78 = AdditionalConfigKey{
                index : arg2,
                tag   : b"remaining_incentive_sui",
            };
            update_additional_config<u64>(arg3, v78, v64 - v77);
            let v79 = 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"incentivise_sui"), v77);
            let v80 = &mut arg1.id;
            let v81 = get_mut_portfolio_vault<T0, T1, T2>(v80, arg2);
            let v82 = IncentiveDelivery<T1>{
                signer                     : 0x2::tx_context::sender(arg6),
                index                      : v81.info.index,
                round                      : v81.info.round,
                refunded_incentive_fund    : v20,
                depositor_incentive_amount : 0x2::balance::value<T1>(&v79),
            };
            0x2::event::emit<IncentiveDelivery<T1>>(v82);
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery_with_rewards<ManagerCap, T0, T1>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, &mut arg1.bid_vault_registry.user_share_registry, v57, v59, v60, v13, v14, v79, arg6);
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery<ManagerCap, T0, T1>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, &mut arg1.bid_vault_registry.user_share_registry, v57, v59, v60, v13, v14, arg6);
        };
        let v83 = &mut arg1.id;
        let v84 = get_mut_portfolio_vault<T0, T1, T2>(v83, arg2);
        update_portfolio_step(arg3, v84.info.index, 0);
        let v85 = Delivery<T0, T1, T2>{
            signer          : 0x2::tx_context::sender(arg6),
            index           : v84.info.index,
            round           : v84.info.round,
            max_size        : v10,
            delivery_price  : v16,
            delivery_size   : v17,
            premium_value   : v15,
            refund_shares   : v60,
            fee_per_unit    : v18,
            accumulated_fee : v19,
        };
        0x2::event::emit<Delivery<T0, T1, T2>>(v85);
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
            let v31 = &mut arg1.id;
            let v32 = get_mut_portfolio_vault<T0, T1, T2>(v31, arg3);
            let v33 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                v13
            } else {
                1
            };
            let v34 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                0x1::option::some<u64>(v14)
            } else {
                0x1::option::none<u64>()
            };
            let (v35, v36, v37, v38, v39, v40, v41, v42) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::delivery_with_rewards<ManagerCap, T1>(arg0, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v32.auction), v12, v32.config.b_token_decimal, v32.config.o_token_decimal, v33, v34, *0x1::option::borrow_with_default<u64>(&v29, &v30), arg5, arg6);
            let v43 = v42;
            let v44 = b"incentivise_sui";
            if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v44)) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, v44, 0x2::balance::zero<T1>());
            };
            if (0x2::balance::value<T1>(&v43) > 0) {
                let v45 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"remaining_incentive_sui",
                };
                update_additional_config<u64>(arg2, v45, *0x1::option::borrow_with_default<u64>(&v26, &v27) + 0x2::balance::value<T1>(&v43));
            };
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"incentivise_sui"), v43);
            (v35, v36, v37, v38, v39, v40, v41, 0x2::balance::value<T1>(&v43))
        } else {
            let v46 = &mut arg1.id;
            let v47 = get_mut_portfolio_vault<T0, T1, T2>(v46, arg3);
            let v48 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                v13
            } else {
                1
            };
            let v49 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                0x1::option::some<u64>(v14)
            } else {
                0x1::option::none<u64>()
            };
            let (v50, v51, v52, v53, v54, v55, v56) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::delivery<ManagerCap, T1>(arg0, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v47.auction), v12, v47.config.b_token_decimal, v47.config.o_token_decimal, v48, v49, arg5, arg6);
            (v50, v51, v52, v53, v54, v55, v56, 0)
        };
        let v57 = &mut arg1.deposit_vault_registry.id;
        let v58 = get_mut_deposit_vault<T0>(v57, arg3);
        let v59 = &mut arg1.bid_vault_registry.id;
        let v60 = get_mut_bid_vault<T1>(v59, arg3);
        let v61 = &mut arg1.id;
        let v62 = get_mut_portfolio_vault<T0, T1, T2>(v61, arg3);
        let v63 = DeliveryInfo{
            round   : v62.info.round,
            price   : v20,
            size    : v21,
            premium : v19,
            ts_ms   : 0x2::clock::timestamp_ms(arg5),
        };
        v62.info.delivery_info = 0x1::option::some<DeliveryInfo>(v63);
        let (v64, v65) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery_premium<ManagerCap, T1>(arg0, v60, v17);
        let v66 = if (v12 > 0) {
            ((((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, T0>(v58) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_share_supply<ManagerCap, T0>(v58)) as u128) * ((v12 - v21) as u128) / (v12 as u128)) as u64)
        } else {
            0
        };
        let v67 = AdditionalConfigKey{
            index : arg3,
            tag   : b"total_share_supply",
        };
        update_additional_config<u64>(arg2, v67, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, T0>(v58) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_share_supply<ManagerCap, T0>(v58));
        let v68 = AdditionalConfigKey{
            index : arg3,
            tag   : b"refund_shares",
        };
        update_additional_config<u64>(arg2, v68, v66);
        let v69 = AdditionalConfigKey{
            index : arg3,
            tag   : b"bidder_shares",
        };
        update_additional_config<0x2::vec_map::VecMap<address, u64>>(arg2, v69, v18);
        let v70 = AdditionalConfigKey{
            index : arg3,
            tag   : b"premium_balance_value",
        };
        update_additional_config<u64>(arg2, v70, v64);
        let v71 = AdditionalConfigKey{
            index : arg3,
            tag   : b"performance_fee_value",
        };
        update_additional_config<u64>(arg2, v71, v65);
        let v72 = if (0x1::option::is_some<bool>(&v16) && *0x1::option::borrow<bool>(&v16)) {
            let v73 = AdditionalConfigKey{
                index : arg3,
                tag   : b"remaining_incentive_sui",
            };
            let v74 = get_additional_config<u64>(arg2, v73);
            let v75 = 0;
            let v76 = *0x1::option::borrow_with_default<u64>(&v74, &v75);
            let v77 = get_portfolio_vault<T0, T1, T2>(&arg1.id, arg3);
            let v78 = &mut arg1.deposit_vault_registry.id;
            let v79 = get_mut_deposit_vault<T0>(v78, arg3);
            let v80 = AdditionalConfigKey{
                index : arg3,
                tag   : b"depositor_incentive_rate_bp",
            };
            let v81 = get_additional_config<u64>(arg2, v80);
            let v82 = 0;
            let v83 = 0x1::vector::borrow<PayoffConfig>(&v77.config.active_vault_config.payoff_configs, 0);
            let v84 = calculate_spot(*0x1::option::borrow<u64>(&v83.strike), v83.strike_pct);
            let v85 = AdditionalConfigKey{
                index : v77.info.index,
                tag   : b"auction_benchmark_price",
            };
            let v86 = get_additional_config<u64>(arg2, v85);
            let v87 = if (v12 > 0) {
                ((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v79) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v79)) as u128) * (v21 as u128) / (v12 as u128)
            } else {
                0
            };
            let v88 = if (v77.config.option_type == 1) {
                v87 * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v14) as u128) / (*0x1::option::borrow_with_default<u64>(&v86, &v84) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v77.config.b_token_decimal) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v77.config.d_token_decimal) as u128)
            } else {
                v87
            };
            let v89 = ((v88 * (*0x1::option::borrow_with_default<u64>(&v81, &v82) as u128) / 10000) as u64);
            let v90 = b"incentivise_sui";
            if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v90)) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v90, 0x2::balance::zero<T0>());
            };
            let v91 = if (v89 > 0) {
                if (v76 > v89) {
                    v89
                } else {
                    v76
                }
            } else {
                0
            };
            let v92 = AdditionalConfigKey{
                index : arg3,
                tag   : b"remaining_incentive_sui",
            };
            update_additional_config<u64>(arg2, v92, v76 - v91);
            let v93 = 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"incentivise_sui"), v91);
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery_reward<ManagerCap, T1>(arg0, v60, v93);
            0x2::balance::value<T1>(&v93)
        } else {
            0
        };
        if (0x1::option::is_some<bool>(&v16) && *0x1::option::borrow<bool>(&v16)) {
            let v94 = &mut arg1.id;
            let v95 = get_mut_portfolio_vault<T0, T1, T2>(v94, arg3);
            let v96 = AdditionalConfigKey{
                index : v95.info.index,
                tag   : b"premium_balance_value",
            };
            let v97 = get_additional_config<u64>(arg2, v96);
            let v98 = AdditionalConfigKey{
                index : arg3,
                tag   : b"premium_balance_value",
            };
            update_additional_config<u64>(arg2, v98, *0x1::option::borrow<u64>(&v97) + v72);
            let v99 = IncentiveDelivery<T1>{
                signer                     : 0x2::tx_context::sender(arg6),
                index                      : v95.info.index,
                round                      : v95.info.round,
                refunded_incentive_fund    : v24,
                depositor_incentive_amount : v72,
            };
            0x2::event::emit<IncentiveDelivery<T1>>(v99);
        };
        update_portfolio_step(arg2, arg3, 13);
        let v100 = &mut arg1.id;
        let v101 = get_mut_portfolio_vault<T0, T1, T2>(v100, arg3);
        let v102 = Delivery<T0, T1, T2>{
            signer          : 0x2::tx_context::sender(arg6),
            index           : v101.info.index,
            round           : v101.info.round,
            max_size        : v12,
            delivery_price  : v20,
            delivery_size   : v21,
            premium_value   : v19,
            refund_shares   : v66,
            fee_per_unit    : v22,
            accumulated_fee : v23,
        };
        0x2::event::emit<Delivery<T0, T1, T2>>(v102);
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
        let v14 = &mut arg1.id;
        let v15 = get_mut_portfolio_vault<T0, T1, T2>(v14, arg3);
        let (v16, v17, v18, _, v20, v21, v22) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::delivery_premium_loop<ManagerCap, T1>(arg0, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v15.auction), v15.config.o_token_decimal, *0x1::option::borrow<u64>(&v9), *0x1::option::borrow<u64>(&v8), *0x1::option::borrow<u64>(&v7), arg5, v10, arg6, arg7);
        let v23 = v22;
        let v24 = v18;
        let v25 = v16;
        if (0x2::balance::value<T1>(&v23) > 0) {
            let v26 = AdditionalConfigKey{
                index : arg3,
                tag   : b"refunded_incentive_fund_record",
            };
            let v27 = get_additional_config<u64>(arg2, v26);
            let v28 = AdditionalConfigKey{
                index : arg3,
                tag   : b"refunded_incentive_fund_record",
            };
            update_additional_config<u64>(arg2, v28, *0x1::option::borrow<u64>(&v27) + 0x2::balance::value<T1>(&v23));
            let v29 = b"incentivise_sui";
            if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v29)) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, v29, 0x2::balance::zero<T1>());
            };
            let v30 = AdditionalConfigKey{
                index : arg3,
                tag   : b"remaining_incentive_sui",
            };
            let v31 = get_additional_config<u64>(arg2, v30);
            let v32 = 0;
            let v33 = AdditionalConfigKey{
                index : arg3,
                tag   : b"remaining_incentive_sui",
            };
            update_additional_config<u64>(arg2, v33, *0x1::option::borrow_with_default<u64>(&v31, &v32) + 0x2::balance::value<T1>(&v23));
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"incentivise_sui"), v23);
        } else {
            0x2::balance::destroy_zero<T1>(v23);
        };
        let (v34, v35) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery_premium<ManagerCap, T1>(arg0, v1, v17);
        let v36 = AdditionalConfigKey{
            index : arg3,
            tag   : b"remaining_delivery_size",
        };
        update_additional_config<u64>(arg2, v36, v20);
        let v37 = &mut arg1.id;
        let v38 = get_mut_portfolio_vault<T0, T1, T2>(v37, arg3);
        let v39 = AdditionalConfigKey{
            index : v38.info.index,
            tag   : b"premium_balance_value",
        };
        let v40 = get_additional_config<u64>(arg2, v39);
        let v41 = AdditionalConfigKey{
            index : v38.info.index,
            tag   : b"performance_fee_value",
        };
        let v42 = get_additional_config<u64>(arg2, v41);
        let v43 = AdditionalConfigKey{
            index : arg3,
            tag   : b"premium_balance_value",
        };
        update_additional_config<u64>(arg2, v43, *0x1::option::borrow<u64>(&v40) + v34);
        let v44 = AdditionalConfigKey{
            index : arg3,
            tag   : b"performance_fee_value",
        };
        update_additional_config<u64>(arg2, v44, *0x1::option::borrow<u64>(&v42) + v35);
        let v45 = AdditionalConfigKey{
            index : v38.info.index,
            tag   : b"accumulated_fee",
        };
        let v46 = get_additional_config<u64>(arg2, v45);
        let v47 = AdditionalConfigKey{
            index : arg3,
            tag   : b"accumulated_fee",
        };
        update_additional_config<u64>(arg2, v47, *0x1::option::borrow<u64>(&v46) + v21);
        let v48 = AdditionalConfigKey{
            index : v38.info.index,
            tag   : b"bidder_shares",
        };
        let v49 = get_additional_config<0x2::vec_map::VecMap<address, u64>>(arg2, v48);
        let v50 = 0x1::option::borrow_mut<0x2::vec_map::VecMap<address, u64>>(&mut v49);
        while (!0x2::vec_map::is_empty<address, u64>(&v24)) {
            let (v51, v52) = 0x2::vec_map::pop<address, u64>(&mut v24);
            let v53 = v51;
            if (0x2::vec_map::contains<address, u64>(v50, &v53)) {
                let v54 = 0x2::vec_map::get_mut<address, u64>(v50, &v53);
                *v54 = *v54 + v52;
                continue
            };
            0x2::vec_map::insert<address, u64>(v50, v53, v52);
        };
        let v55 = AdditionalConfigKey{
            index : arg3,
            tag   : b"bidder_shares",
        };
        update_additional_config<0x2::vec_map::VecMap<address, u64>>(arg2, v55, *v50);
        if (0x1::option::is_some<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v25)) {
            let v56 = &mut arg1.id;
            0x1::option::fill<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut get_mut_portfolio_vault<T0, T1, T2>(v56, arg3).auction, 0x1::option::extract<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v25));
        } else {
            let v57 = &mut arg1.id;
            let v58 = get_mut_portfolio_vault<T0, T1, T2>(v57, arg3);
            let v59 = AdditionalConfigKey{
                index : v58.info.index,
                tag   : b"delivery_size",
            };
            let v60 = get_additional_config<u64>(arg2, v59);
            let v61 = AdditionalConfigKey{
                index : v58.info.index,
                tag   : b"premium_balance_value",
            };
            let v62 = get_additional_config<u64>(arg2, v61);
            let v63 = AdditionalConfigKey{
                index : v58.info.index,
                tag   : b"performance_fee_value",
            };
            let v64 = get_additional_config<u64>(arg2, v63);
            let v65 = DeliveryInfo{
                round   : v58.info.round,
                price   : *0x1::option::borrow<u64>(&v9),
                size    : *0x1::option::borrow<u64>(&v60),
                premium : *0x1::option::borrow<u64>(&v62) + *0x1::option::borrow<u64>(&v64),
                ts_ms   : 0x2::clock::timestamp_ms(arg5),
            };
            v58.info.delivery_info = 0x1::option::some<DeliveryInfo>(v65);
            let v66 = if (0x1::option::is_some<bool>(&v6) && *0x1::option::borrow<bool>(&v6)) {
                let v67 = get_portfolio_vault<T0, T1, T2>(&arg1.id, arg3);
                let v68 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"remaining_incentive_sui",
                };
                let v69 = get_additional_config<u64>(arg2, v68);
                let v70 = 0;
                let v71 = *0x1::option::borrow_with_default<u64>(&v69, &v70);
                let v72 = &mut arg1.deposit_vault_registry.id;
                let v73 = get_mut_deposit_vault<T0>(v72, arg3);
                let v74 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"depositor_incentive_rate_bp",
                };
                let v75 = get_additional_config<u64>(arg2, v74);
                let v76 = 0;
                let v77 = 0x1::vector::borrow<PayoffConfig>(&v67.config.active_vault_config.payoff_configs, 0);
                let v78 = calculate_spot(*0x1::option::borrow<u64>(&v77.strike), v77.strike_pct);
                let v79 = AdditionalConfigKey{
                    index : v67.info.index,
                    tag   : b"auction_benchmark_price",
                };
                let v80 = get_additional_config<u64>(arg2, v79);
                let v81 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"delivery_size",
                };
                let v82 = get_additional_config<u64>(arg2, v81);
                let v83 = 0;
                let v84 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"max_delivery_size",
                };
                let v85 = get_additional_config<u64>(arg2, v84);
                let v86 = 0;
                let v87 = *0x1::option::borrow_with_default<u64>(&v85, &v86);
                let (_, v89) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg4, arg5);
                let v90 = if (v87 > 0) {
                    ((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v73) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v73)) as u128) * (*0x1::option::borrow_with_default<u64>(&v82, &v83) as u128) / (v87 as u128)
                } else {
                    0
                };
                let v91 = if (v67.config.option_type == 1) {
                    v90 * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v89) as u128) / (*0x1::option::borrow_with_default<u64>(&v80, &v78) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v67.config.b_token_decimal) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(v67.config.d_token_decimal) as u128)
                } else {
                    v90
                };
                let v92 = ((v91 * (*0x1::option::borrow_with_default<u64>(&v75, &v76) as u128) / 10000) as u64);
                let v93 = b"incentivise_sui";
                if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v93)) {
                    0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v93, 0x2::balance::zero<T0>());
                };
                let v94 = if (v92 > 0) {
                    if (v71 > v92) {
                        v92
                    } else {
                        v71
                    }
                } else {
                    0
                };
                let v95 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"remaining_incentive_sui",
                };
                update_additional_config<u64>(arg2, v95, v71 - v94);
                let v96 = 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"incentivise_sui"), v94);
                0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::delivery_reward<ManagerCap, T1>(arg0, v1, v96);
                0x2::balance::value<T1>(&v96)
            } else {
                0
            };
            let v97 = &mut arg1.id;
            let v98 = get_mut_portfolio_vault<T0, T1, T2>(v97, arg3);
            let v99 = AdditionalConfigKey{
                index : v98.info.index,
                tag   : b"total_share_supply",
            };
            let v100 = get_additional_config<u64>(arg2, v99);
            let v101 = AdditionalConfigKey{
                index : v98.info.index,
                tag   : b"max_delivery_size",
            };
            let v102 = get_additional_config<u64>(arg2, v101);
            let v103 = *0x1::option::borrow<u64>(&v102);
            let v104 = AdditionalConfigKey{
                index : v98.info.index,
                tag   : b"delivery_size",
            };
            let v105 = get_additional_config<u64>(arg2, v104);
            let v106 = *0x1::option::borrow<u64>(&v105);
            let v107 = if (v103 > 0) {
                (((*0x1::option::borrow<u64>(&v100) as u128) * ((v103 - v106) as u128) / (v103 as u128)) as u64)
            } else {
                0
            };
            let v108 = AdditionalConfigKey{
                index : arg3,
                tag   : b"refund_shares",
            };
            update_additional_config<u64>(arg2, v108, v107);
            update_portfolio_step(arg2, arg3, 13);
            let v109 = AdditionalConfigKey{
                index : v98.info.index,
                tag   : b"accumulated_fee",
            };
            let v110 = get_additional_config<u64>(arg2, v109);
            let v111 = AdditionalConfigKey{
                index : v98.info.index,
                tag   : b"premium_balance_value",
            };
            let v112 = get_additional_config<u64>(arg2, v111);
            let v113 = AdditionalConfigKey{
                index : v98.info.index,
                tag   : b"performance_fee_value",
            };
            let v114 = get_additional_config<u64>(arg2, v113);
            let v115 = Delivery<T0, T1, T2>{
                signer          : 0x2::tx_context::sender(arg7),
                index           : v98.info.index,
                round           : v98.info.round,
                max_size        : v103,
                delivery_price  : *0x1::option::borrow<u64>(&v9),
                delivery_size   : v106,
                premium_value   : *0x1::option::borrow<u64>(&v112) + *0x1::option::borrow<u64>(&v114),
                refund_shares   : v107,
                fee_per_unit    : *0x1::option::borrow<u64>(&v7),
                accumulated_fee : *0x1::option::borrow<u64>(&v110),
            };
            0x2::event::emit<Delivery<T0, T1, T2>>(v115);
            let v116 = AdditionalConfigKey{
                index : arg3,
                tag   : b"refunded_incentive_fund_record",
            };
            let v117 = get_additional_config<u64>(arg2, v116);
            let v118 = 0;
            let v119 = IncentiveDelivery<T1>{
                signer                     : 0x2::tx_context::sender(arg7),
                index                      : v98.info.index,
                round                      : v98.info.round,
                refunded_incentive_fund    : *0x1::option::borrow_with_default<u64>(&v117, &v118),
                depositor_incentive_amount : v66,
            };
            0x2::event::emit<IncentiveDelivery<T1>>(v119);
            if (0x1::option::is_some<bool>(&v6) && *0x1::option::borrow<bool>(&v6)) {
                let v120 = AdditionalConfigKey{
                    index : arg3,
                    tag   : b"premium_balance_value",
                };
                update_additional_config<u64>(arg2, v120, *0x1::option::borrow<u64>(&v112) + v66);
            };
        };
        0x1::option::destroy_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(v25);
    }

    public(friend) entry fun deposit<T0, T1, T2>(arg0: &mut Registry, arg1: &AdditionalConfigRegistry, arg2: u64, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        abort 99999
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
        abort 99999
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
            tag   : b"hotfix_fix_balance_value",
        };
        let v5 = get_additional_config<u64>(arg2, v4);
        let v6 = *0x1::option::borrow<u64>(&v5);
        let v7 = AdditionalConfigKey{
            index : arg3,
            tag   : b"hotfix_share_supply",
        };
        let v8 = get_additional_config<u64>(arg2, v7);
        let v9 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        let v10 = get_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v9);
        if (v6 == 0) {
            abort 0
        };
        let (v11, v12, v13, v14) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::hotfix_deposit_vault<ManagerCap, 0x2::sui::SUI>(&mut arg1.deposit_vault_registry.user_share_registry, v1, *0x1::option::borrow<u64>(&v3), v6, *0x1::option::borrow<u64>(&v8), 0x1::option::get_with_default<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v10, 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>()), arg4);
        let v15 = AdditionalConfigKey{
            index : arg3,
            tag   : b"hotfix_balance_value",
        };
        update_additional_config<u64>(arg2, v15, v12);
        let v16 = AdditionalConfigKey{
            index : arg3,
            tag   : b"hotfix_fix_balance_value",
        };
        update_additional_config<u64>(arg2, v16, v13);
        let v17 = AdditionalConfigKey{
            index : arg3,
            tag   : b"hotfix_share_supply",
        };
        update_additional_config<u64>(arg2, v17, v14);
        let v18 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        update_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v18, v11);
    }

    public(friend) entry fun hotfix_balance(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry) {
        let v0 = 0;
        let v1 = &mut arg1.deposit_vault_registry.id;
        let v2 = get_mut_deposit_vault<0x2::sui::SUI>(v1, v0);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::hotfix_deposit_vault_balance<ManagerCap, 0x2::sui::SUI>(v2, 0x2::balance::split<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.id, b"incentivise_sui"), 1500000000000));
        let v3 = AdditionalConfigKey{
            index : v0,
            tag   : b"hotfix_balance_value",
        };
        update_additional_config<u64>(arg2, v3, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, 0x2::sui::SUI>(v2));
        let v4 = AdditionalConfigKey{
            index : v0,
            tag   : b"hotfix_fix_balance_value",
        };
        update_additional_config<u64>(arg2, v4, 1500000000000);
        let v5 = AdditionalConfigKey{
            index : v0,
            tag   : b"hotfix_share_supply",
        };
        update_additional_config<u64>(arg2, v5, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, 0x2::sui::SUI>(v2));
        let v6 = 8;
        let v7 = &mut arg1.deposit_vault_registry.id;
        let v8 = get_mut_deposit_vault<0x2::sui::SUI>(v7, v6);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::hotfix_deposit_vault_balance<ManagerCap, 0x2::sui::SUI>(v8, 0x2::balance::split<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.id, b"incentivise_sui"), 1500000000000));
        let v9 = AdditionalConfigKey{
            index : v6,
            tag   : b"hotfix_balance_value",
        };
        update_additional_config<u64>(arg2, v9, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, 0x2::sui::SUI>(v8));
        let v10 = AdditionalConfigKey{
            index : v6,
            tag   : b"hotfix_fix_balance_value",
        };
        update_additional_config<u64>(arg2, v10, 1500000000000);
        let v11 = AdditionalConfigKey{
            index : v6,
            tag   : b"hotfix_share_supply",
        };
        update_additional_config<u64>(arg2, v11, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, 0x2::sui::SUI>(v8));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ManagerCap>(v0, 0x2::tx_context::sender(arg0));
        new_registry_(arg0);
    }

    public(friend) entry fun new_additional_config_registry(arg0: &ManagerCap, arg1: &mut 0x2::tx_context::TxContext) {
        new_additional_config_registry_(arg1);
    }

    fun new_additional_config_registry_(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdditionalConfigRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AdditionalConfigRegistry>(v0);
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

    public(friend) entry fun new_bid<T0, T1, T2>(arg0: &mut Registry, arg1: &mut AdditionalConfigRegistry, arg2: u64, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: &0x2::clock::Clock, arg5: vector<0x2::coin::Coin<T1>>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        oracle_check(arg1, arg2, arg3);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::prepare_bid_vault_bidder_share_node(&mut arg0.bid_vault_registry.user_share_registry, arg2, arg7);
        let v0 = &mut arg0.id;
        let v1 = get_mut_portfolio_vault<T0, T1, T2>(v0, arg2);
        assert!(0x1::option::is_none<DeliveryInfo>(&v1.info.delivery_info) || 0x1::option::borrow<DeliveryInfo>(&v1.info.delivery_info).round != v1.info.round, 15);
        if (0x1::option::is_none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v1.auction)) {
            abort 12
        };
        let v2 = &mut arg0.id;
        let v3 = get_mut_portfolio_vault<T0, T1, T2>(v2, arg2);
        let v4 = &mut arg0.deposit_vault_registry.id;
        let v5 = get_mut_deposit_vault<T0>(v4, arg2);
        let v6 = AdditionalConfigKey{
            index : v3.info.index,
            tag   : b"min_bid_size",
        };
        let v7 = get_additional_config<u64>(arg1, v6);
        let v8 = 0;
        assert!(arg6 >= *0x1::option::borrow_with_default<u64>(&v7, &v8), 24);
        let (_, v10) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg3, arg4);
        let v11 = 0x1::vector::borrow<PayoffConfig>(&v3.config.active_vault_config.payoff_configs, 0);
        let v12 = calculate_spot(*0x1::option::borrow<u64>(&v11.strike), v11.strike_pct);
        let v13 = AdditionalConfigKey{
            index : v3.info.index,
            tag   : b"auction_benchmark_price",
        };
        let v14 = get_additional_config<u64>(arg1, v13);
        let v15 = AdditionalConfigKey{
            index : v3.info.index,
            tag   : b"auction_lot_size",
        };
        let v16 = get_additional_config<u64>(arg1, v15);
        let v17 = calculate_max_auction_size(v3.config.o_token_decimal, v3.config.leverage, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v5) + 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::deactivating_balance<ManagerCap, T0>(v5), calculate_max_loss_per_unit(v3.config.option_type, *0x1::option::borrow_with_default<u64>(&v14, &v12), v10, v3.config.d_token_decimal, v3.config.o_token_decimal, v3.config.active_vault_config.payoff_configs, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(2)), *0x1::option::borrow_with_default<u64>(&v16, &v3.config.lot_size));
        let v18 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::total_bid_size<ManagerCap, T1>(0x1::option::borrow<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v3.auction));
        assert!(v18 < v17, 11);
        if (v18 + arg6 > v17) {
            arg6 = v17 - v18;
        };
        let v19 = &mut arg0.id;
        let v20 = get_mut_portfolio_vault<T0, T1, T2>(v19, arg2);
        let (v21, v22) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg3, arg4);
        let v23 = AdditionalConfigKey{
            index : v20.info.index,
            tag   : b"incentive_flag",
        };
        let v24 = get_additional_config<bool>(arg1, v23);
        let (v25, v26) = if (0x1::option::is_some<bool>(&v24) && *0x1::option::borrow<bool>(&v24)) {
            let v27 = AdditionalConfigKey{
                index : v20.info.index,
                tag   : b"incentive_rate_bp",
            };
            let v28 = get_additional_config<u64>(arg1, v27);
            let v29 = 0;
            let v30 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                v21
            } else {
                1
            };
            let v31 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                0x1::option::some<u64>(v22)
            } else {
                0x1::option::none<u64>()
            };
            let v32 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::get_dutch_total_bid_value<ManagerCap, T1>(0x1::option::borrow<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&v20.auction), arg6, v20.config.b_token_decimal, v20.config.o_token_decimal, v30, v31, arg4);
            let v33 = (((v32 as u128) * (*0x1::option::borrow_with_default<u64>(&v28, &v29) as u128) / 10000) as u64);
            let v34 = AdditionalConfigKey{
                index : arg2,
                tag   : b"remaining_incentive_sui",
            };
            let v35 = get_additional_config<u64>(arg1, v34);
            let v36 = 0;
            let v37 = *0x1::option::borrow_with_default<u64>(&v35, &v36);
            let v38 = b"incentivise_sui";
            if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v38)) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg0.id, v38, 0x2::balance::zero<T1>());
            };
            let v39 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg0.id, b"incentivise_sui");
            let v40 = 0x2::balance::value<T1>(v39);
            let v41 = 0x2::balance::split<T1>(v39, v37);
            let (v42, v43) = if (0x2::balance::value<T1>(&v41) < v33) {
                let v44 = 0x2::balance::value<T1>(&v41);
                let v45 = 0x2::balance::split<T1>(&mut v41, v44);
                0x2::balance::join<T1>(&mut v45, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::extract_balance<T1>(arg5, v32 - v44, arg7));
                (v45, v44)
            } else {
                let v46 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::extract_balance<T1>(arg5, v32 - v33, arg7);
                0x2::balance::join<T1>(&mut v46, 0x2::balance::split<T1>(&mut v41, v33));
                (v46, v33)
            };
            0x2::balance::join<T1>(v39, v41);
            let v47 = 0x2::balance::value<T1>(v39);
            if (v40 > v47) {
                let v48 = AdditionalConfigKey{
                    index : arg2,
                    tag   : b"remaining_incentive_sui",
                };
                update_additional_config<u64>(arg1, v48, v37 - v40 - v47);
            };
            (0x1::vector::singleton<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v42, arg7)), v43)
        } else {
            (arg5, 0)
        };
        let v49 = &mut arg0.id;
        let v50 = get_mut_portfolio_vault<T0, T1, T2>(v49, arg2);
        let (v51, v52) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg3, arg4);
        let v53 = AdditionalConfigKey{
            index : v50.info.index,
            tag   : b"auction_lot_size",
        };
        let v54 = get_additional_config<u64>(arg1, v53);
        let v55 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
            v51
        } else {
            1
        };
        let v56 = if (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
            0x1::option::some<u64>(v52)
        } else {
            0x1::option::none<u64>()
        };
        let (v57, v58, v59, v60, v61, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::new_bid<ManagerCap, T1>(0x1::option::borrow_mut<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(&mut v50.auction), arg6, v50.config.b_token_decimal, v50.config.o_token_decimal, *0x1::option::borrow_with_default<u64>(&v54, &v50.config.lot_size), v25, v55, v56, arg4, arg7);
        let v63 = AdditionalConfigKey{
            index : arg2,
            tag   : b"incentive_flag",
        };
        let v64 = get_additional_config<bool>(arg1, v63);
        if (0x1::option::is_some<bool>(&v64) && *0x1::option::borrow<bool>(&v64)) {
            let v65 = IncentiveNewBid<T1>{
                signer          : 0x2::tx_context::sender(arg7),
                index           : arg2,
                bid_index       : v57,
                incentive_value : v26,
            };
            0x2::event::emit<IncentiveNewBid<T1>>(v65);
        };
        let v66 = NewBid<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg7),
            index      : arg2,
            bid_index  : v57,
            price      : v58,
            size       : v59,
            coin_value : v60,
            ts_ms      : v61,
        };
        0x2::event::emit<NewBid<T0, T1, T2>>(v66);
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

    public(friend) entry fun new_portfolio_vault<T0, T1, T2>(arg0: &ManagerCap, arg1: &mut Registry, arg2: &mut AdditionalConfigRegistry, arg3: &0x2::clock::Clock, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<bool>, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u8, arg23: bool, arg24: vector<address>, arg25: &mut 0x2::tx_context::TxContext) {
        version_check(arg1);
        let (v0, v1, v2) = new_portfolio_vault_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, create_payoff_configs(arg12, arg13, arg14), arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25);
        let v3 = NewPortfolioVault<T0, T1, T2>{
            signer     : 0x2::tx_context::sender(arg25),
            index      : v0,
            info       : v1,
            config     : v2,
            is_manager : true,
        };
        0x2::event::emit<NewPortfolioVault<T0, T1, T2>>(v3);
    }

    fun new_portfolio_vault_<T0, T1, T2>(arg0: &mut Registry, arg1: &mut AdditionalConfigRegistry, arg2: &0x2::clock::Clock, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<PayoffConfig>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u8, arg20: bool, arg21: vector<address>, arg22: &mut 0x2::tx_context::TxContext) : (u64, Info, Config) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg4 == 0 || arg4 == 1 || arg4 == 2, 2);
        let v1 = arg5 % 86400000;
        assert!(v1 >= arg0.restrict_activation_time_period.from_ts_ms, 4);
        assert!(v1 <= arg0.restrict_activation_time_period.to_ts_ms, 4);
        assert!(arg5 >= v0, 4);
        assert!(arg6 > v0, 5);
        check_auction_settings(arg15, arg16, arg17);
        if (arg4 == 0) {
            assert!(arg6 - arg5 == 86400000, 5);
        } else if (arg4 == 1) {
            assert!(arg6 - arg5 == 604800000, 5);
        } else {
            assert!(arg6 - arg5 == 2419200000 || arg6 - arg5 == 3024000000, 5);
        };
        let v2 = arg0.num_of_vault;
        let v3 = VaultConfig{
            payoff_configs         : arg11,
            strike_increment       : arg12,
            decay_speed            : arg14,
            initial_price          : arg15,
            final_price            : arg16,
            auction_duration_in_ms : arg17,
        };
        let v4 = Info{
            index         : v2,
            creator       : 0x2::tx_context::sender(arg22),
            create_ts_ms  : v0,
            round         : 0,
            delivery_info : 0x1::option::none<DeliveryInfo>(),
        };
        let v5 = Config{
            option_type           : arg3,
            period                : arg4,
            activation_ts_ms      : arg5,
            expiration_ts_ms      : arg6,
            d_token_decimal       : arg7,
            b_token_decimal       : arg8,
            o_token_decimal       : arg9,
            lot_size              : arg13,
            capacity              : arg10,
            leverage              : arg18,
            has_next              : arg20,
            active_vault_config   : v3,
            warmup_vault_config   : v3,
            upcoming_vault_config : v3,
        };
        let v6 = PortfolioVault<T0, T1, T2>{
            id        : 0x2::object::new(arg22),
            info      : v4,
            config    : v5,
            auction   : 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch::Auction<ManagerCap, T1>>(),
            authority : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::new<ManagerCap>(arg21, arg22),
        };
        0x2::dynamic_object_field::add<u64, PortfolioVault<T0, T1, T2>>(&mut arg0.id, v2, v6);
        0x2::dynamic_field::add<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0>>(&mut arg0.deposit_vault_registry.id, v2, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::new_deposit_vault<ManagerCap, T0>(v2, &mut arg0.deposit_vault_registry.user_share_registry, arg22));
        0x2::dynamic_field::add<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T1>>(&mut arg0.bid_vault_registry.id, v2, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::new_bid_vault<ManagerCap, T1>(v2, &mut arg0.bid_vault_registry.user_share_registry, arg22));
        let v7 = AdditionalConfigKey{
            index : v2,
            tag   : b"risk_level",
        };
        update_additional_config<u8>(arg1, v7, arg19);
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
            version                         : 20,
        };
        0x2::transfer::share_object<Registry>(v3);
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

    fun remove_additional_config<T0: copy + drop + store>(arg0: &mut AdditionalConfigRegistry, arg1: AdditionalConfigKey) {
        if (0x2::dynamic_field::exists_<AdditionalConfigKey>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<AdditionalConfigKey, T0>(&mut arg0.id, arg1);
        };
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
        if (0x1::option::is_none<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v1)) {
            let v4 = AdditionalConfigKey{
                index : arg3,
                tag   : b"active_share_supply",
            };
            update_additional_config<u64>(arg2, v4, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_share_supply<ManagerCap, T0>(v3));
            let v5 = AdditionalConfigKey{
                index : arg3,
                tag   : b"active_balance_value",
            };
            update_additional_config<u64>(arg2, v5, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::active_balance<ManagerCap, T0>(v3));
        };
        let v6 = AdditionalConfigKey{
            index : arg3,
            tag   : b"active_share_supply",
        };
        let v7 = get_additional_config<u64>(arg2, v6);
        let v8 = AdditionalConfigKey{
            index : arg3,
            tag   : b"active_balance_value",
        };
        let v9 = get_additional_config<u64>(arg2, v8);
        let (v10, v11, v12) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::settle_adjust_active_user_share_ratio_v2<ManagerCap, T0>(arg0, &mut arg1.deposit_vault_registry.user_share_registry, v3, *0x1::option::borrow<u64>(&v7), *0x1::option::borrow<u64>(&v9), 0x1::option::get_with_default<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(&v1, 0x1::option::none<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>()), arg4);
        let v13 = v10;
        if (!0x1::option::is_some<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>(&v13)) {
            update_portfolio_step(arg2, arg3, 3);
        };
        let v14 = AdditionalConfigKey{
            index : arg3,
            tag   : b"first_user",
        };
        update_additional_config<0x1::option::Option<0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::UserShareKey>>(arg2, v14, v13);
        let v15 = AdditionalConfigKey{
            index : arg3,
            tag   : b"active_share_supply",
        };
        update_additional_config<u64>(arg2, v15, v12);
        let v16 = AdditionalConfigKey{
            index : arg3,
            tag   : b"active_balance_value",
        };
        update_additional_config<u64>(arg2, v16, v11);
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
        abort 99999
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
        assert!(20 > arg1.version, 1000);
        arg1.version = 20;
    }

    fun version_check(arg0: &Registry) {
        assert!(20 == arg0.version, 1000);
    }

    public(friend) entry fun withdraw<T0>(arg0: &mut Registry, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 99999
    }

    // decompiled from Move bytecode v6
}

