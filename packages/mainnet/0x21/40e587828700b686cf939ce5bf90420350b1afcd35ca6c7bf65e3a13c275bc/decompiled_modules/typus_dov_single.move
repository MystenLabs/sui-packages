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

    struct FeePool has store, key {
        id: 0x2::object::UID,
        fee_infos: vector<FeeInfo>,
    }

    struct FeeInfo has copy, drop, store {
        token: 0x1::type_name::TypeName,
        value: u64,
    }

    struct SendFeeEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct RedeemEvent has copy, drop {
        index: u64,
        d_token: 0x1::type_name::TypeName,
        b_token: 0x1::type_name::TypeName,
        log: vector<u64>,
    }

    struct WithdrawAllEvent has copy, drop {
        index: u64,
        log: vector<u64>,
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

    entry fun drop_bid_nodes(arg0: &mut Registry, arg1: u64, arg2: u8, arg3: vector<address>, arg4: &0x2::tx_context::TxContext) {
        version_check(arg0);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&arg0.authority, arg4);
        while (0x1::vector::length<address>(&arg3) > 0) {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::drop_share(&mut arg0.bid_vault_registry.user_share_registry, arg1, arg2, 0x1::vector::pop_back<address>(&mut arg3));
        };
    }

    entry fun drop_deposit_nodes(arg0: &mut Registry, arg1: u64, arg2: u8, arg3: vector<address>, arg4: &0x2::tx_context::TxContext) {
        version_check(arg0);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&arg0.authority, arg4);
        while (0x1::vector::length<address>(&arg3) > 0) {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::drop_share(&mut arg0.deposit_vault_registry.user_share_registry, arg1, arg2, 0x1::vector::pop_back<address>(&mut arg3));
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

    public(friend) fun get_incentive_fund_value<T0>(arg0: &Registry) : u64 {
        let v0 = b"incentivise_sui";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    fun get_mut_bid_vault<T0>(arg0: &mut 0x2::object::UID, arg1: u64) : &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T0> {
        0x2::dynamic_field::borrow_mut<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::BidVault<ManagerCap, T0>>(arg0, arg1)
    }

    fun get_mut_deposit_vault<T0>(arg0: &mut 0x2::object::UID, arg1: u64) : &mut 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0> {
        0x2::dynamic_field::borrow_mut<u64, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::DepositVault<ManagerCap, T0>>(arg0, arg1)
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

    public(friend) fun registry_uid(arg0: &Registry) : &0x2::object::UID {
        version_check(arg0);
        &arg0.id
    }

    entry fun send_fee<T0>(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, FeePool>(&mut arg0.id, b"fee_pool");
        let v1 = 0;
        while (v1 < 0x1::vector::length<FeeInfo>(&v0.fee_infos)) {
            let v2 = 0x1::vector::borrow_mut<FeeInfo>(&mut v0.fee_infos, v1);
            if (v2.token == 0x1::type_name::get<T0>()) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>())), arg1), @0x3e3f1ca852358b50837758b5197fedf61e2ea69186c469595baa717560963f9);
                let v3 = SendFeeEvent{
                    token  : 0x1::type_name::get<T0>(),
                    amount : v2.value,
                };
                0x2::event::emit<SendFeeEvent>(v3);
                v2.value = 0;
            };
            v1 = v1 + 1;
        };
    }

    entry fun upgrade_registry(arg0: &mut Registry) {
        assert!(500 > arg0.version, 1000);
        arg0.version = 500;
    }

    fun version_check(arg0: &Registry) {
        assert!(500 >= arg0.version, 1000);
    }

    entry fun withdraw_all_balance<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::authority::verify<ManagerCap>(&arg0.authority, arg2);
        let v0 = &mut arg0.deposit_vault_registry.id;
        let v1 = get_mut_deposit_vault<T0>(v0, arg1);
        let v2 = &mut arg0.bid_vault_registry.id;
        let (v3, v4, v5) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault::withdraw_all_balance<ManagerCap, T0, T1>(v1, get_mut_bid_vault<T1>(v2, arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg2), @0x3e3f1ca852358b50837758b5197fedf61e2ea69186c469595baa717560963f9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg2), @0x3e3f1ca852358b50837758b5197fedf61e2ea69186c469595baa717560963f9);
        let v6 = WithdrawAllEvent{
            index : arg1,
            log   : v5,
        };
        0x2::event::emit<WithdrawAllEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

