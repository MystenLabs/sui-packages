module 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::yield_flow {
    struct YieldFlow has key {
        id: 0x2::object::UID,
        sui_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_from_pools: 0x2::linked_table::LinkedTable<address, PoolFlow>,
        honey_to_burn: 0x2::balance::Balance<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>,
        pools_config: PoolsConfig,
        pool_fee_config: DefaultFeeInfo,
        amm_fee_collectors: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        treasury_percent: u64,
        honey_buyback_pct: u64,
        voter_incentives_pct: u64,
    }

    struct PoolFlow has store {
        hive_balance: 0x2::balance::Balance<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::hive::HIVE>,
        honey_balance: 0x2::balance::Balance<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>,
        last_claimed_epoch: u64,
    }

    struct PoolsConfig has store {
        decimal_precisions: 0x2::linked_table::LinkedTable<0x1::string::String, u8>,
        stable_identifiers: 0x2::linked_table::LinkedTable<0x1::ascii::String, bool>,
    }

    struct DefaultFeeInfo has store {
        weighted_pool_fee: FeeInfo,
        stable_pool_fee: FeeInfo,
        curved_pool_fee: FeeInfo,
    }

    struct FeeInfo has copy, store {
        total_fee_bps: u64,
        bees_fee_pct: u64,
    }

    struct FeeCollector<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct DragonDaoCapability has store, key {
        id: 0x2::object::UID,
    }

    struct VoteByVestedTokensCapability has store, key {
        id: 0x2::object::UID,
    }

    struct DragonFoodCapability has store, key {
        id: 0x2::object::UID,
    }

    struct TwoAmmFlowAccess has store, key {
        id: 0x2::object::UID,
    }

    struct ThreeAmmFlowAccess has store, key {
        id: 0x2::object::UID,
    }

    struct DeployerCap has store, key {
        id: 0x2::object::UID,
        manager_initialized: bool,
        vault_initialized: bool,
        hidden_world_initialized: bool,
    }

    struct MasterAccessKey has store, key {
        id: 0x2::object::UID,
    }

    struct HiddenWorldCapability has store, key {
        id: 0x2::object::UID,
    }

    struct DecimalPrecisionForCoinTypesWhitelisted has copy, drop {
        coin_types: vector<0x1::string::String>,
        decimal_precisions: vector<u8>,
    }

    struct StableIdentifierAdded has copy, drop {
        identifier: 0x1::ascii::String,
    }

    struct StableIdentifierRemoved has copy, drop {
        identifier: 0x1::ascii::String,
    }

    struct DefaultFeeSet has copy, drop {
        curve: 0x1::type_name::TypeName,
        total_fee_bps: u64,
        bees_fee_pct: u64,
    }

    struct FeeDistributionPctUpdated has copy, drop {
        treasury_fee_percent: u64,
        honey_buyback_pct: u64,
        voter_incentives_pct: u64,
    }

    struct TreasuryResourcesDistributed has copy, drop {
        amount: u64,
    }

    struct NewFeeCollectorKrafted has copy, drop {
        coin_type: 0x1::ascii::String,
        fee_collector_addr: address,
    }

    struct FeeCollectedForCoin has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct FeeExtractedForCoin has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun add_balance_to_pool_flow(arg0: &mut YieldFlow, arg1: address, arg2: 0x2::balance::Balance<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::hive::HIVE>, arg3: 0x2::balance::Balance<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>) {
        let v0 = 0x2::linked_table::borrow_mut<address, PoolFlow>(&mut arg0.fee_from_pools, arg1);
        0x2::balance::join<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::hive::HIVE>(&mut v0.hive_balance, arg2);
        0x2::balance::join<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>(&mut v0.honey_balance, arg3);
    }

    public fun add_new_threepool_flow(arg0: &mut YieldFlow, arg1: &ThreeAmmFlowAccess, arg2: address) {
        if (0x2::linked_table::contains<address, PoolFlow>(&arg0.fee_from_pools, arg2)) {
            return
        };
        let v0 = PoolFlow{
            hive_balance       : 0x2::balance::zero<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::hive::HIVE>(),
            honey_balance      : 0x2::balance::zero<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>(),
            last_claimed_epoch : 0,
        };
        0x2::linked_table::push_back<address, PoolFlow>(&mut arg0.fee_from_pools, arg2, v0);
    }

    public fun add_new_two_pool_flow(arg0: &mut YieldFlow, arg1: &TwoAmmFlowAccess, arg2: address) {
        if (0x2::linked_table::contains<address, PoolFlow>(&arg0.fee_from_pools, arg2)) {
            return
        };
        let v0 = PoolFlow{
            hive_balance       : 0x2::balance::zero<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::hive::HIVE>(),
            honey_balance      : 0x2::balance::zero<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>(),
            last_claimed_epoch : 0,
        };
        0x2::linked_table::push_back<address, PoolFlow>(&mut arg0.fee_from_pools, arg2, v0);
    }

    public fun add_stable_identifier(arg0: &mut YieldFlow, arg1: &DragonDaoCapability, arg2: 0x1::ascii::String) {
        if (!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.pools_config.stable_identifiers, arg2)) {
            0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.pools_config.stable_identifiers, arg2, true);
        } else {
            *0x2::linked_table::borrow_mut<0x1::ascii::String, bool>(&mut arg0.pools_config.stable_identifiers, arg2) = true;
        };
        let v0 = StableIdentifierAdded{identifier: arg2};
        0x2::event::emit<StableIdentifierAdded>(v0);
    }

    public fun add_to_treasury(arg0: &mut YieldFlow, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_treasury, arg1);
    }

    public fun claim_fees_from_pool_flow(arg0: &mut YieldFlow, arg1: &DragonFoodCapability, arg2: address, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::hive::HIVE>, 0x2::balance::Balance<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>) {
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = 0x2::linked_table::borrow_mut<address, PoolFlow>(&mut arg0.fee_from_pools, arg2);
        if (v1.last_claimed_epoch < v0) {
            v1.last_claimed_epoch = v0;
        };
        (0x2::balance::withdraw_all<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::hive::HIVE>(&mut v1.hive_balance), 0x2::balance::withdraw_all<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>(&mut v1.honey_balance))
    }

    public fun collect_fee_for_coin<T0>(arg0: &mut FeeCollector<T0>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) > 0) {
            let v0 = FeeCollectedForCoin{
                token  : 0x1::type_name::get<T0>(),
                amount : 0x2::balance::value<T0>(&arg1),
            };
            0x2::event::emit<FeeCollectedForCoin>(v0);
        };
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::withdraw_all<T0>(&mut arg1));
        0x2::balance::destroy_zero<T0>(arg1);
    }

    public fun create_fee_collector<T0>(arg0: &mut YieldFlow, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.amm_fee_collectors, v2), 3040);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.amm_fee_collectors, v2, v1);
        let v3 = NewFeeCollectorKrafted{
            coin_type          : v2,
            fee_collector_addr : v1,
        };
        0x2::event::emit<NewFeeCollectorKrafted>(v3);
        let v4 = FeeCollector<T0>{
            id      : v0,
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<FeeCollector<T0>>(v4);
    }

    public fun deposit_honey_to_burn(arg0: &mut YieldFlow, arg1: 0x2::balance::Balance<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>) {
        0x2::balance::join<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>(&mut arg0.honey_to_burn, arg1);
    }

    public fun entry_add_to_treasury(arg0: &mut YieldFlow, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        add_to_treasury(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg2));
        if (0x2::balance::value<0x2::sui::SUI>(&v0) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun extract_fee_for_coin_2amm<T0>(arg0: &TwoAmmFlowAccess, arg1: &mut FeeCollector<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg1.balance);
        let v1 = FeeExtractedForCoin{
            token  : 0x1::type_name::get<T0>(),
            amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<FeeExtractedForCoin>(v1);
        v0
    }

    public fun extract_fee_for_coin_3amm<T0>(arg0: &ThreeAmmFlowAccess, arg1: &mut FeeCollector<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg1.balance);
        let v1 = FeeExtractedForCoin{
            token  : 0x1::type_name::get<T0>(),
            amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<FeeExtractedForCoin>(v1);
        v0
    }

    public fun get_all_pool_flow_balances(arg0: &YieldFlow, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, PoolFlow>(&arg0.fee_from_pools)
        };
        let v4 = v3;
        let v5 = 0;
        while (0x1::option::is_some<address>(&v4) && v5 < arg2) {
            let v6 = *0x1::option::borrow<address>(&v4);
            let v7 = 0x2::linked_table::borrow<address, PoolFlow>(&arg0.fee_from_pools, v6);
            0x1::vector::push_back<address>(&mut v0, v6);
            0x1::vector::push_back<u64>(&mut v1, 0x2::balance::value<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::hive::HIVE>(&v7.hive_balance));
            0x1::vector::push_back<u64>(&mut v2, 0x2::balance::value<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>(&v7.honey_balance));
            v4 = *0x2::linked_table::next<address, PoolFlow>(&arg0.fee_from_pools, v6);
            v5 = v5 + 1;
        };
        (v0, v1, v2)
    }

    public entry fun get_curved_pool_fee_info(arg0: &YieldFlow) : (u64, u64) {
        (arg0.pool_fee_config.curved_pool_fee.total_fee_bps, arg0.pool_fee_config.curved_pool_fee.bees_fee_pct)
    }

    public entry fun get_decimals_for_coin<T0>(arg0: &YieldFlow) : (bool, u8) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::linked_table::contains<0x1::string::String, u8>(&arg0.pools_config.decimal_precisions, v0)) {
            (true, *0x2::linked_table::borrow<0x1::string::String, u8>(&arg0.pools_config.decimal_precisions, v0))
        } else {
            (false, 0)
        }
    }

    public fun get_decimals_for_coin_type(arg0: &YieldFlow, arg1: 0x1::type_name::TypeName) : (bool, u8) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(arg1));
        if (0x2::linked_table::contains<0x1::string::String, u8>(&arg0.pools_config.decimal_precisions, v0)) {
            (true, *0x2::linked_table::borrow<0x1::string::String, u8>(&arg0.pools_config.decimal_precisions, v0))
        } else {
            (false, 0)
        }
    }

    public fun get_fee_available_for_pool(arg0: &YieldFlow, arg1: address) : (u64, u64) {
        let v0 = 0x2::linked_table::borrow<address, PoolFlow>(&arg0.fee_from_pools, arg1);
        (0x2::balance::value<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::hive::HIVE>(&v0.hive_balance), 0x2::balance::value<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>(&v0.honey_balance))
    }

    public entry fun get_fee_collector_id<T0>(arg0: &YieldFlow) : address {
        *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.amm_fee_collectors, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public entry fun get_fee_info<T0>(arg0: &YieldFlow) : (u64, u64) {
        if (0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::curves::is_stable<T0>()) {
            return (arg0.pool_fee_config.stable_pool_fee.total_fee_bps, arg0.pool_fee_config.stable_pool_fee.bees_fee_pct)
        };
        if (0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::curves::is_weighted<T0>()) {
            return (arg0.pool_fee_config.weighted_pool_fee.total_fee_bps, arg0.pool_fee_config.weighted_pool_fee.bees_fee_pct)
        };
        if (0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::curves::is_curved<T0>()) {
            return (arg0.pool_fee_config.curved_pool_fee.total_fee_bps, arg0.pool_fee_config.curved_pool_fee.bees_fee_pct)
        };
        (0, 0)
    }

    public entry fun get_stable_pool_fee_info(arg0: &YieldFlow) : (u64, u64) {
        (arg0.pool_fee_config.stable_pool_fee.total_fee_bps, arg0.pool_fee_config.stable_pool_fee.bees_fee_pct)
    }

    public entry fun get_sui_fee_distribution_info(arg0: &YieldFlow) : (u64, u64, u64) {
        (arg0.treasury_percent, arg0.honey_buyback_pct, arg0.voter_incentives_pct)
    }

    public entry fun get_treasury_balance(arg0: &YieldFlow) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury)
    }

    public entry fun get_weighted_pool_fee_info(arg0: &YieldFlow) : (u64, u64) {
        (arg0.pool_fee_config.weighted_pool_fee.total_fee_bps, arg0.pool_fee_config.weighted_pool_fee.bees_fee_pct)
    }

    public fun hidden_world_setup_by_deployer(arg0: &mut DeployerCap) {
        assert!(!arg0.hidden_world_initialized, 3130);
        arg0.hidden_world_initialized = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MasterAccessKey{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MasterAccessKey>(v0, 0x2::tx_context::sender(arg0));
        let v1 = DeployerCap{
            id                       : 0x2::object::new(arg0),
            manager_initialized      : false,
            vault_initialized        : false,
            hidden_world_initialized : false,
        };
        0x2::transfer::transfer<DeployerCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = DragonDaoCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DragonDaoCapability>(v2, 0x2::tx_context::sender(arg0));
        let v3 = VoteByVestedTokensCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VoteByVestedTokensCapability>(v3, 0x2::tx_context::sender(arg0));
        let v4 = DragonFoodCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DragonFoodCapability>(v4, 0x2::tx_context::sender(arg0));
        let v5 = TwoAmmFlowAccess{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TwoAmmFlowAccess>(v5, 0x2::tx_context::sender(arg0));
        let v6 = ThreeAmmFlowAccess{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ThreeAmmFlowAccess>(v6, 0x2::tx_context::sender(arg0));
        let v7 = HiddenWorldCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<HiddenWorldCapability>(v7, 0x2::tx_context::sender(arg0));
        let v8 = 0x2::linked_table::new<0x1::ascii::String, address>(arg0);
        let v9 = 0x2::object::new(arg0);
        let v10 = 0x2::object::uid_to_address(&v9);
        let v11 = 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>());
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut v8, v11, v10);
        let v12 = FeeCollector<0x2::sui::SUI>{
            id      : v9,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<FeeCollector<0x2::sui::SUI>>(v12);
        let v13 = NewFeeCollectorKrafted{
            coin_type          : v11,
            fee_collector_addr : v10,
        };
        0x2::event::emit<NewFeeCollectorKrafted>(v13);
        let v14 = FeeInfo{
            total_fee_bps : 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::weighted_total_fee_bps(),
            bees_fee_pct  : 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::weighted_bees_fee_pct(),
        };
        let v15 = FeeInfo{
            total_fee_bps : 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::stable_total_fee_bps(),
            bees_fee_pct  : 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::stable_bees_fee_pct(),
        };
        let v16 = FeeInfo{
            total_fee_bps : 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::curved_total_fee_bps(),
            bees_fee_pct  : 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::curved_bees_fee_pct(),
        };
        let v17 = PoolsConfig{
            decimal_precisions : 0x2::linked_table::new<0x1::string::String, u8>(arg0),
            stable_identifiers : 0x2::linked_table::new<0x1::ascii::String, bool>(arg0),
        };
        let v18 = DefaultFeeInfo{
            weighted_pool_fee : v14,
            stable_pool_fee   : v15,
            curved_pool_fee   : v16,
        };
        let v19 = YieldFlow{
            id                   : 0x2::object::new(arg0),
            sui_treasury         : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_from_pools       : 0x2::linked_table::new<address, PoolFlow>(arg0),
            honey_to_burn        : 0x2::balance::zero<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>(),
            pools_config         : v17,
            pool_fee_config      : v18,
            amm_fee_collectors   : v8,
            treasury_percent     : 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::init_treasury_percent(),
            honey_buyback_pct    : 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::init_honey_buyback_pct(),
            voter_incentives_pct : 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::init_voter_incentives_pct(),
        };
        0x2::transfer::share_object<YieldFlow>(v19);
    }

    public entry fun is_fee_collector_present<T0>(arg0: &YieldFlow) : bool {
        0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.amm_fee_collectors, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public entry fun is_stable_identifier<T0>(arg0: &YieldFlow) : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.pools_config.stable_identifiers, v0)) {
            return *0x2::linked_table::borrow<0x1::ascii::String, bool>(&arg0.pools_config.stable_identifiers, v0)
        };
        false
    }

    public fun manager_setup_by_deployer(arg0: &mut DeployerCap) {
        assert!(!arg0.manager_initialized, 3120);
        arg0.manager_initialized = true;
    }

    public fun query_amm_fee_collectors(arg0: &YieldFlow, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: u64) : (vector<0x1::ascii::String>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<0x1::ascii::String>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<0x1::ascii::String, address>(&arg0.amm_fee_collectors)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<0x1::ascii::String>(&v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.amm_fee_collectors, *v5));
            v3 = *0x2::linked_table::next<0x1::ascii::String, address>(&arg0.amm_fee_collectors, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, address>(&arg0.amm_fee_collectors))
    }

    public fun query_precisions_for_coin_types(arg0: &YieldFlow, arg1: 0x1::option::Option<0x1::string::String>, arg2: u64) : (vector<0x1::string::String>, vector<u8>, u64) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<0x1::string::String, u8>(&arg0.pools_config.decimal_precisions)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::string::String>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<0x1::string::String>(&v3);
            0x1::vector::push_back<0x1::string::String>(&mut v0, *v5);
            0x1::vector::push_back<u8>(&mut v1, *0x2::linked_table::borrow<0x1::string::String, u8>(&arg0.pools_config.decimal_precisions, *v5));
            v3 = *0x2::linked_table::next<0x1::string::String, u8>(&arg0.pools_config.decimal_precisions, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::string::String, u8>(&arg0.pools_config.decimal_precisions))
    }

    public fun query_stable_identifiers(arg0: &YieldFlow, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: u64) : (vector<0x1::ascii::String>, vector<bool>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<bool>();
        let v2 = if (0x1::option::is_some<0x1::ascii::String>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<0x1::ascii::String, bool>(&arg0.pools_config.stable_identifiers)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<0x1::ascii::String>(&v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *v5);
            0x1::vector::push_back<bool>(&mut v1, *0x2::linked_table::borrow<0x1::ascii::String, bool>(&arg0.pools_config.stable_identifiers, *v5));
            v3 = *0x2::linked_table::next<0x1::ascii::String, bool>(&arg0.pools_config.stable_identifiers, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, bool>(&arg0.pools_config.stable_identifiers))
    }

    public fun release_sui_from_treasury(arg0: &DragonDaoCapability, arg1: &mut YieldFlow, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_treasury, arg2), arg4), arg3);
        let v0 = TreasuryResourcesDistributed{amount: arg2};
        0x2::event::emit<TreasuryResourcesDistributed>(v0);
    }

    public fun release_sui_from_treasury_for_bet(arg0: &HiddenWorldCapability, arg1: &mut YieldFlow, arg2: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_treasury, arg2)
    }

    public fun remove_stable_identifier(arg0: &mut YieldFlow, arg1: &DragonDaoCapability, arg2: 0x1::ascii::String) {
        *0x2::linked_table::borrow_mut<0x1::ascii::String, bool>(&mut arg0.pools_config.stable_identifiers, arg2) = false;
        let v0 = StableIdentifierRemoved{identifier: arg2};
        0x2::event::emit<StableIdentifierRemoved>(v0);
    }

    public fun update_default_fee_for_curve<T0>(arg0: &mut YieldFlow, arg1: &DragonDaoCapability, arg2: u64, arg3: u64) {
        0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::curves::assert_valid_curve<T0>();
        if (0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::curves::is_stable<T0>()) {
            let v0 = &mut arg0.pool_fee_config.stable_pool_fee;
            update_fee(v0, arg2, arg3);
        } else if (0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::curves::is_weighted<T0>()) {
            let v1 = &mut arg0.pool_fee_config.weighted_pool_fee;
            update_fee(v1, arg2, arg3);
        } else if (0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::curves::is_curved<T0>()) {
            let v2 = &mut arg0.pool_fee_config.curved_pool_fee;
            update_fee(v2, arg2, arg3);
        };
        let v3 = DefaultFeeSet{
            curve         : 0x1::type_name::get<T0>(),
            total_fee_bps : arg2,
            bees_fee_pct  : arg3,
        };
        0x2::event::emit<DefaultFeeSet>(v3);
    }

    fun update_fee(arg0: &mut FeeInfo, arg1: u64, arg2: u64) {
        if (arg1 > 0) {
            assert!(arg1 >= 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::min_swap_fee() && arg1 <= 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::max_swap_fee(), 3020);
            arg0.total_fee_bps = arg1;
        };
        if (arg2 > 0) {
            assert!(arg2 >= 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::min_hive_fee() && arg2 <= 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::max_hive_fee(), 3020);
            arg0.bees_fee_pct = arg2;
        };
    }

    public fun update_yield_flow_config_pct(arg0: &mut YieldFlow, arg1: &DragonDaoCapability, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 >= 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::min_treasury_fee() && arg2 <= 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::max_treasury_fee(), 3020);
        assert!(arg3 >= 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::min_honey_buyback_pct() && arg3 <= 0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::constants::max_honey_buyback_pct(), 3020);
        arg0.treasury_percent = arg2;
        arg0.honey_buyback_pct = arg3;
        arg0.voter_incentives_pct = arg4;
        let v0 = FeeDistributionPctUpdated{
            treasury_fee_percent : arg2,
            honey_buyback_pct    : arg3,
            voter_incentives_pct : arg4,
        };
        0x2::event::emit<FeeDistributionPctUpdated>(v0);
    }

    public fun whitelist_decimal_precisions(arg0: &mut YieldFlow, arg1: &DragonDaoCapability, arg2: vector<0x1::string::String>, arg3: vector<u8>) {
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<u8>(&arg3), 3030);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            if (0x2::linked_table::contains<0x1::string::String, u8>(&arg0.pools_config.decimal_precisions, v1)) {
                *0x2::linked_table::borrow_mut<0x1::string::String, u8>(&mut arg0.pools_config.decimal_precisions, v1) = *0x1::vector::borrow<u8>(&arg3, v0);
            } else {
                0x2::linked_table::push_back<0x1::string::String, u8>(&mut arg0.pools_config.decimal_precisions, v1, *0x1::vector::borrow<u8>(&arg3, v0));
            };
            v0 = v0 + 1;
        };
        let v2 = DecimalPrecisionForCoinTypesWhitelisted{
            coin_types         : arg2,
            decimal_precisions : arg3,
        };
        0x2::event::emit<DecimalPrecisionForCoinTypesWhitelisted>(v2);
    }

    public fun withdraw_honey_to_burn(arg0: &mut YieldFlow, arg1: &0x2::coin::TreasuryCap<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>) : 0x2::balance::Balance<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY> {
        0x2::balance::withdraw_all<0x9bf5a8ad624d16a288cc187bf2eb5a7ff4b9794b08a8c3a2115de0544bb997fb::honey::HONEY>(&mut arg0.honey_to_burn)
    }

    // decompiled from Move bytecode v6
}

