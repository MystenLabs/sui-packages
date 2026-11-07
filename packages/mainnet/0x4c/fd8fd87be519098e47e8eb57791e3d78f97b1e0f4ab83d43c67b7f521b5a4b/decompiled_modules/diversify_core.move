module 0x4cfd8fd87be519098e47e8eb57791e3d78f97b1e0f4ab83d43c67b7f521b5a4b::diversify_core {
    struct PositionCreated has copy, drop {
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        timestamp_ms: u64,
    }

    struct PartnerCapIssued has copy, drop {
        partner_cap_id: 0x2::object::ID,
        recipient: address,
        timestamp_ms: u64,
        admin: address,
    }

    struct ServiceCapIssued has copy, drop {
        service_id: 0x2::object::ID,
        coins: vector<0x1::type_name::TypeName>,
        timestamp_ms: u64,
        admin: address,
    }

    struct VaultAdded has copy, drop {
        vault_id: u64,
        name: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct RebalanceCreditsRequiredSet has copy, drop {
        required: bool,
        timestamp_ms: u64,
    }

    struct VaultRenamed has copy, drop {
        vault_id: u64,
        new_name: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct VaultCoinAdded has copy, drop {
        vault_id: u64,
        coin_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct VaultCoinRemoved has copy, drop {
        vault_id: u64,
        coin_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct PositionCapTransferred has copy, drop {
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
        timestamp_ms: u64,
    }

    struct StrategyCreated has copy, drop {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        vault_id: u64,
        weights: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        is_public: bool,
        min_deposit: u64,
        timestamp_ms: u64,
        creator: address,
    }

    struct RebalanceRequired has copy, drop {
        strategy_id: 0x2::object::ID,
        new_rebalance_index: u64,
        weights: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        timestamp_ms: u64,
    }

    struct Subscribed has copy, drop {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        deposit_amount: u64,
        timestamp_ms: u64,
        subscriber: address,
    }

    struct Unsubscribed has copy, drop {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        timestamp_ms: u64,
        subscriber: address,
    }

    struct StrategyMadePublic has copy, drop {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct StrategyDiscontinued has copy, drop {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct StrategyDescriptionUpdated has copy, drop {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        new_description: 0x1::string::String,
        timestamp_ms: u64,
        sender: address,
    }

    struct MinimumDepositUpdated has copy, drop {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        new_minimum: u64,
        timestamp_ms: u64,
        sender: address,
    }

    struct StrategyNameUpdated has copy, drop {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        new_name: 0x1::string::String,
        timestamp_ms: u64,
        sender: address,
    }

    struct BotRebalanceCompleted has copy, drop {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        withdrawn: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        deposited: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        prices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
        credits_remaining: u64,
        new_rebalance_index: u64,
        timestamp_ms: u64,
    }

    struct AutobalanceEnabled has copy, drop {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct AutobalanceDisabled has copy, drop {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct AutobalanceGasDeposited has copy, drop {
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        credits_added: u64,
        total_credits: u64,
        amount_sui: u64,
        timestamp_ms: u64,
        sender: address,
    }

    struct SelfRebalanceCompleted has copy, drop {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        timestamp_ms: u64,
        sender: address,
    }

    struct AgentCapIssued has copy, drop {
        strategy_id: 0x2::object::ID,
        agent_cap_id: 0x2::object::ID,
        recipient: address,
        replaced: 0x1::option::Option<0x2::object::ID>,
        timestamp_ms: u64,
    }

    struct AgentCapRevoked has copy, drop {
        strategy_id: 0x2::object::ID,
        agent_cap_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct AllocationChangedByAgent has copy, drop {
        strategy_id: 0x2::object::ID,
        agent_cap_id: 0x2::object::ID,
        new_rebalance_index: u64,
        timestamp_ms: u64,
    }

    struct RebalanceCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        replaced: 0x1::option::Option<0x2::object::ID>,
        timestamp_ms: u64,
        admin: address,
    }

    struct RebalanceCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
        timestamp_ms: u64,
        admin: address,
    }

    struct PriceCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        replaced: 0x1::option::Option<0x2::object::ID>,
        timestamp_ms: u64,
        admin: address,
    }

    struct PriceCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
        timestamp_ms: u64,
        admin: address,
    }

    struct ActiveServiceAdded has copy, drop {
        strategy_id: 0x2::object::ID,
        service_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct ActiveServiceRemoved has copy, drop {
        strategy_id: 0x2::object::ID,
        service_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ServiceCap has store, key {
        id: 0x2::object::UID,
        service_id: 0x2::object::ID,
    }

    struct RebalanceCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceCap has store, key {
        id: 0x2::object::UID,
    }

    struct PartnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AgentCap has key {
        id: 0x2::object::UID,
        strategy_id: 0x2::object::ID,
    }

    struct PositionCap has key {
        id: 0x2::object::UID,
        owner: address,
        position_id: 0x2::object::ID,
        created_strategies: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<0x2::object::ID>>,
    }

    struct UserPosition has store, key {
        id: 0x2::object::UID,
        position_cap_id: 0x2::object::ID,
        rebalance_credits: u64,
        investments: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Investment>,
    }

    struct ServiceInfo has store {
        coins: vector<0x1::type_name::TypeName>,
    }

    struct VaultInfo has copy, drop, store {
        name: 0x1::string::String,
        coins: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct Investment has store {
        service_ids: vector<0x2::object::ID>,
        subscribed_strategies: vector<0x2::object::ID>,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        user_positions: 0x2::object_table::ObjectTable<0x2::object::ID, UserPosition>,
        strategies: 0x2::object_table::ObjectTable<0x2::object::ID, Strategy>,
        rebalance_wallet: address,
        max_services_per_strategy: u64,
        config_cooldown_ms: u64,
        services: 0x2::table::Table<0x2::object::ID, ServiceInfo>,
        strategy_min_stake: u64,
        autobalance_gas_per_credit: u64,
        rebalance_cap_id: 0x1::option::Option<0x2::object::ID>,
        price_cap_id: 0x1::option::Option<0x2::object::ID>,
        rebalance_slippage_bps: u64,
        rebalance_weight_tolerance_bps: u64,
        vaults: 0x2::vec_map::VecMap<u64, VaultInfo>,
        rebalance_credits_required: bool,
    }

    struct Strategy has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator_position_cap_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        vault_id: u64,
        active_agent_cap_id: 0x1::option::Option<0x2::object::ID>,
        subscribers: 0x2::table::Table<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>,
        autobalance_subscribers: 0x2::table::Table<0x2::object::ID, u64>,
        rebalance_index: u64,
        service_config: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        active_services: 0x2::vec_set::VecSet<0x2::object::ID>,
        last_config_change_ms: u64,
        is_discontinued: bool,
        min_deposit: u64,
        is_public: bool,
    }

    struct RebalancePotato {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        coins: 0x2::bag::Bag,
        withdrawn: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        deposited: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        prices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::option::Option<u128>>,
        touched: 0x2::vec_set::VecSet<0x2::object::ID>,
        allowed: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct StrategyMakerPotato {
        position_cap_id: 0x2::object::ID,
        minimum_stake: u64,
    }

    public fun add_active_service(arg0: &ServiceCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg1.strategies, arg2), 2013);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg1.strategies, arg2);
        if (0x2::vec_set::contains<0x2::object::ID>(&v0.active_services, &arg0.service_id)) {
            return
        };
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&v0.service_config, &arg0.service_id), 2027);
        0x2::vec_set::insert<0x2::object::ID>(&mut v0.active_services, arg0.service_id);
        let v1 = ActiveServiceAdded{
            strategy_id  : arg2,
            service_id   : arg0.service_id,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ActiveServiceAdded>(v1);
    }

    public fun add_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun add_coin_to_vault<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        assert!(0x2::vec_map::contains<u64, VaultInfo>(&arg1.vaults, &arg2), 2046);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &mut 0x2::vec_map::get_mut<u64, VaultInfo>(&mut arg1.vaults, &arg2).coins;
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(v1, &v0), 2048);
        0x2::vec_set::insert<0x1::type_name::TypeName>(v1, v0);
        let v2 = VaultCoinAdded{
            vault_id     : arg2,
            coin_type    : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VaultCoinAdded>(v2);
    }

    public fun add_to_potato<T0>(arg0: &mut RebalancePotato, arg1: &ServiceCap, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 > 0) {
            let v1 = &mut arg0.withdrawn;
            record_move(v1, 0x1::type_name::with_defining_ids<T0>(), v0);
        };
        join_coins<T0>(arg0, arg2);
        mark_refreshed(arg0, arg1);
    }

    public fun add_vault(arg0: &AdminCap, arg1: &mut Config, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) : u64 {
        assert_version(arg1);
        assert_vault_name_free(arg1, &arg2);
        let v0 = 0x2::vec_map::length<u64, VaultInfo>(&arg1.vaults) + 1;
        let v1 = VaultInfo{
            name  : arg2,
            coins : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::vec_map::insert<u64, VaultInfo>(&mut arg1.vaults, v0, v1);
        let v2 = VaultAdded{
            vault_id     : v0,
            name         : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VaultAdded>(v2);
        v0
    }

    public(friend) fun assert_price_cap(arg0: &Config, arg1: &PriceCap) {
        assert!(arg0.price_cap_id == 0x1::option::some<0x2::object::ID>(0x2::object::id<PriceCap>(arg1)), 2029);
    }

    public(friend) fun assert_rebalance_cap(arg0: &Config, arg1: &RebalanceCap) {
        assert!(arg0.rebalance_cap_id == 0x1::option::some<0x2::object::ID>(0x2::object::id<RebalanceCap>(arg1)), 2028);
    }

    fun assert_service_in_strategy(arg0: &Strategy, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = 0x2::table::contains<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&arg0.subscribers, arg1) && 0x2::vec_map::contains<0x2::object::ID, u64>(0x2::table::borrow<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&arg0.subscribers, arg1), &arg2);
        let v1 = if (0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.service_config, &arg2)) {
            true
        } else if (0x2::vec_set::contains<0x2::object::ID>(&arg0.active_services, &arg2)) {
            true
        } else {
            v0
        };
        assert!(v1, 2045);
    }

    public fun assert_strategy_active(arg0: &Config, arg1: 0x2::object::ID) {
        assert_version(arg0);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg0.strategies, arg1), 2013);
        assert!(!0x2::object_table::borrow<0x2::object::ID, Strategy>(&arg0.strategies, arg1).is_discontinued, 2001);
    }

    public fun assert_strategy_creator(arg0: &Config, arg1: 0x2::object::ID, arg2: &PositionCap) {
        assert_version(arg0);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg0.strategies, arg1), 2013);
        assert!(0x2::object_table::borrow<0x2::object::ID, Strategy>(&arg0.strategies, arg1).creator_position_cap_id == 0x2::object::uid_to_inner(&arg2.id), 2000);
    }

    fun assert_vault_name_free(arg0: &Config, arg1: &0x1::string::String) {
        let v0 = 0x2::vec_map::keys<u64, VaultInfo>(&arg0.vaults);
        0x1::vector::reverse<u64>(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&v0)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut v0);
            assert!(&0x2::vec_map::get<u64, VaultInfo>(&arg0.vaults, &v2).name != arg1, 2047);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(v0);
    }

    fun assert_version(arg0: &Config) {
        assert!(arg0.version <= 1, 2012);
    }

    fun change_allocation(arg0: &mut Config, arg1: 0x2::object::ID, arg2: 0x2::vec_map::VecMap<0x2::object::ID, u64>, arg3: u64) : u64 {
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg0.strategies, arg1), 2013);
        let v0 = 0x2::object_table::borrow<0x2::object::ID, Strategy>(&arg0.strategies, arg1);
        assert!(arg3 - v0.last_config_change_ms >= arg0.config_cooldown_ms, 2006);
        assert!(!v0.is_discontinued, 2001);
        let v1 = 0x2::vec_map::keys<0x2::object::ID, u64>(&arg2);
        assert!(0x1::vector::length<0x2::object::ID>(&v1) <= arg0.max_services_per_strategy, 2015);
        let v2 = &v1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(v2)) {
            assert!(*0x2::vec_map::get<0x2::object::ID, u64>(&arg2, 0x1::vector::borrow<0x2::object::ID>(v2, v3)) > 0, 2019);
            v3 = v3 + 1;
        };
        validate_strategy_services(arg0, v0.vault_id, &v1);
        let v4 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg0.strategies, arg1);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v6 = *0x1::vector::borrow<0x2::object::ID>(&v1, v5);
            if (0x2::vec_map::contains<0x2::object::ID, u64>(&v4.service_config, &v6)) {
                *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut v4.service_config, &v6) = *0x2::vec_map::get<0x2::object::ID, u64>(&arg2, &v6);
            } else {
                0x2::vec_map::insert<0x2::object::ID, u64>(&mut v4.service_config, v6, *0x2::vec_map::get<0x2::object::ID, u64>(&arg2, &v6));
            };
            v5 = v5 + 1;
        };
        let v7 = 0x2::vec_map::keys<0x2::object::ID, u64>(&v4.service_config);
        let v8 = 0x1::vector::empty<0x2::object::ID>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x2::object::ID>(&v7)) {
            let v10 = *0x1::vector::borrow<0x2::object::ID>(&v7, v9);
            if (!0x2::vec_map::contains<0x2::object::ID, u64>(&arg2, &v10)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v8, v10);
            };
            v9 = v9 + 1;
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<0x2::object::ID>(&v8)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut v4.service_config, 0x1::vector::borrow<0x2::object::ID>(&v8, v11));
            v11 = v11 + 1;
        };
        let v14 = 0x2::vec_map::keys<0x2::object::ID, u64>(&v4.service_config);
        let v15 = 0;
        let v16 = 0;
        while (v16 < 0x1::vector::length<0x2::object::ID>(&v14)) {
            v15 = v15 + *0x2::vec_map::get<0x2::object::ID, u64>(&v4.service_config, 0x1::vector::borrow<0x2::object::ID>(&v14, v16));
            v16 = v16 + 1;
        };
        assert!(v15 == 10000, 2019);
        v4.rebalance_index = v4.rebalance_index + 1;
        v4.last_config_change_ms = arg3;
        let v17 = v4.rebalance_index;
        let v18 = RebalanceRequired{
            strategy_id         : arg1,
            new_rebalance_index : v17,
            weights             : v4.service_config,
            timestamp_ms        : arg3,
        };
        0x2::event::emit<RebalanceRequired>(v18);
        v17
    }

    public fun change_allocation_by_agent(arg0: &AgentCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: 0x2::vec_map::VecMap<0x2::object::ID, u64>, arg4: &0x2::clock::Clock) {
        assert_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg1.strategies, arg2), 2013);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(arg0.strategy_id == arg2 && 0x2::object_table::borrow<0x2::object::ID, Strategy>(&arg1.strategies, arg2).active_agent_cap_id == 0x1::option::some<0x2::object::ID>(v1), 2055);
        let v2 = AllocationChangedByAgent{
            strategy_id         : arg2,
            agent_cap_id        : v1,
            new_rebalance_index : change_allocation(arg1, arg2, arg3, v0),
            timestamp_ms        : v0,
        };
        0x2::event::emit<AllocationChangedByAgent>(v2);
    }

    public fun change_config(arg0: &PositionCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: 0x2::vec_map::VecMap<0x2::object::ID, u64>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg1.strategies, arg2), 2013);
        assert!(0x2::object_table::borrow<0x2::object::ID, Strategy>(&arg1.strategies, arg2).creator_position_cap_id == 0x2::object::uid_to_inner(&arg0.id), 2000);
        change_allocation(arg1, arg2, arg3, v0);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg1.strategies, arg2);
        v1.description = arg4;
        let v2 = StrategyDescriptionUpdated{
            strategy_id     : arg2,
            position_cap_id : 0x2::object::uid_to_inner(&arg0.id),
            position_id     : arg0.position_id,
            new_description : v1.description,
            timestamp_ms    : v0,
            sender          : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<StrategyDescriptionUpdated>(v2);
    }

    public fun coin_balance<T0>(arg0: &RebalancePotato) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.coins, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.coins, v0))
    }

    public fun complete_self_rebalance(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 2000);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg0.strategies, arg2), 2013);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg0.strategies, arg2);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&v1.subscribers, v0), 2018);
        if (0x2::table::contains<0x2::object::ID, u64>(&v1.autobalance_subscribers, v0)) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut v1.autobalance_subscribers, v0) = v1.rebalance_index;
        };
        let v2 = SelfRebalanceCompleted{
            strategy_id     : arg2,
            position_cap_id : v0,
            position_id     : arg1.position_id,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
            sender          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SelfRebalanceCompleted>(v2);
    }

    public fun consume_maker_potato(arg0: StrategyMakerPotato) {
        let StrategyMakerPotato {
            position_cap_id : _,
            minimum_stake   : v1,
        } = arg0;
        assert!(v1 == 0, 2011);
    }

    public fun create_and_transfer_partner_cap(arg0: &AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PartnerCap{id: 0x2::object::new(arg3)};
        let v1 = PartnerCapIssued{
            partner_cap_id : 0x2::object::id<PartnerCap>(&v0),
            recipient      : arg1,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg2),
            admin          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PartnerCapIssued>(v1);
        0x2::transfer::public_transfer<PartnerCap>(v0, arg1);
    }

    public fun create_config(arg0: &AdminCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                             : 0x2::object::new(arg3),
            version                        : 1,
            user_positions                 : 0x2::object_table::new<0x2::object::ID, UserPosition>(arg3),
            strategies                     : 0x2::object_table::new<0x2::object::ID, Strategy>(arg3),
            rebalance_wallet               : arg1,
            max_services_per_strategy      : 10,
            config_cooldown_ms             : 86400000,
            services                       : 0x2::table::new<0x2::object::ID, ServiceInfo>(arg3),
            strategy_min_stake             : arg2,
            autobalance_gas_per_credit     : 10000000,
            rebalance_cap_id               : 0x1::option::none<0x2::object::ID>(),
            price_cap_id                   : 0x1::option::none<0x2::object::ID>(),
            rebalance_slippage_bps         : 10,
            rebalance_weight_tolerance_bps : 100,
            vaults                         : 0x2::vec_map::empty<u64, VaultInfo>(),
            rebalance_credits_required     : false,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun create_position_cap(arg0: &mut Config, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : PositionCap {
        assert_version(arg0);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::object::uid_to_inner(&v0);
        let v4 = UserPosition{
            id                : v0,
            position_cap_id   : v2,
            rebalance_credits : 0,
            investments       : 0x2::vec_map::empty<0x1::type_name::TypeName, Investment>(),
        };
        let v5 = PositionCap{
            id                 : v1,
            owner              : 0x2::tx_context::sender(arg2),
            position_id        : v3,
            created_strategies : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<0x2::object::ID>>(),
        };
        0x2::object_table::add<0x2::object::ID, UserPosition>(&mut arg0.user_positions, v2, v4);
        let v6 = PositionCreated{
            position_cap_id : v2,
            position_id     : v3,
            owner           : 0x2::tx_context::sender(arg2),
            timestamp_ms    : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PositionCreated>(v6);
        v5
    }

    public fun create_price_cap(arg0: &AdminCap, arg1: &mut Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : PriceCap {
        assert_version(arg1);
        let v0 = PriceCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<PriceCap>(&v0);
        arg1.price_cap_id = 0x1::option::some<0x2::object::ID>(v1);
        let v2 = PriceCapIssued{
            cap_id       : v1,
            replaced     : arg1.price_cap_id,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            admin        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PriceCapIssued>(v2);
        v0
    }

    public fun create_rebalance_cap(arg0: &AdminCap, arg1: &mut Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : RebalanceCap {
        assert_version(arg1);
        let v0 = RebalanceCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<RebalanceCap>(&v0);
        arg1.rebalance_cap_id = 0x1::option::some<0x2::object::ID>(v1);
        let v2 = RebalanceCapIssued{
            cap_id       : v1,
            replaced     : arg1.rebalance_cap_id,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            admin        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RebalanceCapIssued>(v2);
        v0
    }

    public fun create_service_cap(arg0: &AdminCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: vector<0x1::type_name::TypeName>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : ServiceCap {
        assert_version(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, ServiceInfo>(&arg1.services, arg2), 2024);
        assert!(!0x1::vector::is_empty<0x1::type_name::TypeName>(&arg3), 2051);
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        let v1 = &arg3;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            let v3 = 0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2);
            assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&v0, v3), 2052);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, *v3);
            v2 = v2 + 1;
        };
        let v4 = ServiceInfo{coins: arg3};
        0x2::table::add<0x2::object::ID, ServiceInfo>(&mut arg1.services, arg2, v4);
        let v5 = ServiceCapIssued{
            service_id   : arg2,
            coins        : arg3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
            admin        : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ServiceCapIssued>(v5);
        ServiceCap{
            id         : 0x2::object::new(arg5),
            service_id : arg2,
        }
    }

    public fun create_strategy<T0>(arg0: &mut Config, arg1: &mut PositionCap, arg2: &PartnerCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: vector<0x2::object::ID>, arg7: vector<u64>, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, StrategyMakerPotato) {
        assert_version(arg0);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg6);
        assert!(v0 == 0x1::vector::length<u64>(&arg7), 2019);
        assert!(v0 <= arg0.max_services_per_strategy, 2015);
        let v1 = 0x2::object::new(arg11);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<u64, VaultInfo>(&arg0.vaults, &arg5), 2046);
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&0x2::vec_map::get<u64, VaultInfo>(&arg0.vaults, &arg5).coins, &v3), 2049);
        validate_strategy_services(arg0, arg5, &arg6);
        let v4 = StrategyMakerPotato{
            position_cap_id : 0x2::object::uid_to_inner(&arg1.id),
            minimum_stake   : arg0.strategy_min_stake,
        };
        let v5 = 0x2::vec_map::empty<0x2::object::ID, u64>();
        let v6 = 0;
        let v7 = 0;
        while (v6 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg7, v6) > 0, 2019);
            v7 = v7 + *0x1::vector::borrow<u64>(&arg7, v6);
            assert!(!0x2::vec_map::contains<0x2::object::ID, u64>(&v5, 0x1::vector::borrow<0x2::object::ID>(&arg6, v6)), 2057);
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v5, *0x1::vector::borrow<0x2::object::ID>(&arg6, v6), *0x1::vector::borrow<u64>(&arg7, v6));
            v6 = v6 + 1;
        };
        assert!(v7 == 10000, 2019);
        let v8 = Strategy{
            id                      : v1,
            name                    : arg3,
            description             : arg4,
            creator_position_cap_id : 0x2::object::uid_to_inner(&arg1.id),
            coin_type               : v3,
            vault_id                : arg5,
            active_agent_cap_id     : 0x1::option::none<0x2::object::ID>(),
            subscribers             : 0x2::table::new<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(arg11),
            autobalance_subscribers : 0x2::table::new<0x2::object::ID, u64>(arg11),
            rebalance_index         : 0,
            service_config          : v5,
            active_services         : 0x2::vec_set::empty<0x2::object::ID>(),
            last_config_change_ms   : 0x2::clock::timestamp_ms(arg10),
            is_discontinued         : false,
            min_deposit             : arg8,
            is_public               : arg9,
        };
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, vector<0x2::object::ID>>(&arg1.created_strategies, &v3)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, vector<0x2::object::ID>>(&mut arg1.created_strategies, v3, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::vec_map::get_mut<0x1::type_name::TypeName, vector<0x2::object::ID>>(&mut arg1.created_strategies, &v3), v2);
        0x2::object_table::add<0x2::object::ID, Strategy>(&mut arg0.strategies, v2, v8);
        let v9 = StrategyCreated{
            strategy_id     : v2,
            position_cap_id : 0x2::object::uid_to_inner(&arg1.id),
            position_id     : arg1.position_id,
            coin_type       : v3,
            vault_id        : arg5,
            weights         : 0x2::object_table::borrow<0x2::object::ID, Strategy>(&arg0.strategies, v2).service_config,
            is_public       : arg9,
            min_deposit     : arg8,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg10),
            creator         : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<StrategyCreated>(v9);
        (v2, v4)
    }

    public fun deposit_autobalance_gas(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_version(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        let v1 = arg0.autobalance_gas_per_credit;
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v3 = v2 / v1;
        let v4 = v3 * v1;
        let v5 = 0x2::object_table::borrow_mut<0x2::object::ID, UserPosition>(&mut arg0.user_positions, v0);
        v5.rebalance_credits = v5.rebalance_credits + v3;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.rebalance_wallet);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v6 = AutobalanceGasDeposited{
            position_cap_id : v0,
            position_id     : arg1.position_id,
            credits_added   : v3,
            total_credits   : v5.rebalance_credits,
            amount_sui      : v4,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
            sender          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<AutobalanceGasDeposited>(v6);
        0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2 - v4, arg4)
    }

    public fun destroy_agent_cap(arg0: AgentCap, arg1: &mut Config, arg2: &0x2::clock::Clock) {
        assert_version(arg1);
        let AgentCap {
            id          : v0,
            strategy_id : v1,
        } = arg0;
        let v2 = v0;
        let v3 = 0x2::object::uid_to_inner(&v2);
        if (0x2::object_table::contains<0x2::object::ID, Strategy>(&arg1.strategies, v1)) {
            let v4 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg1.strategies, v1);
            if (v4.active_agent_cap_id == 0x1::option::some<0x2::object::ID>(v3)) {
                v4.active_agent_cap_id = 0x1::option::none<0x2::object::ID>();
                let v5 = AgentCapRevoked{
                    strategy_id  : v1,
                    agent_cap_id : v3,
                    timestamp_ms : 0x2::clock::timestamp_ms(arg2),
                };
                0x2::event::emit<AgentCapRevoked>(v5);
            };
        };
        0x2::object::delete(v2);
    }

    public fun disable_autobalance(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg0.strategies, arg2), 2013);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg0.strategies, arg2);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&v1.autobalance_subscribers, v0), 2021);
        0x2::table::remove<0x2::object::ID, u64>(&mut v1.autobalance_subscribers, v0);
        let v2 = AutobalanceDisabled{
            strategy_id     : arg2,
            position_cap_id : v0,
            position_id     : arg1.position_id,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AutobalanceDisabled>(v2);
    }

    public fun discontinue_strategy(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg0.strategies, arg2), 2013);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg0.strategies, arg2);
        assert!(v0.creator_position_cap_id == 0x2::object::uid_to_inner(&arg1.id), 2000);
        v0.is_discontinued = true;
        let v1 = StrategyDiscontinued{
            strategy_id     : arg2,
            position_cap_id : 0x2::object::uid_to_inner(&arg1.id),
            position_id     : arg1.position_id,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StrategyDiscontinued>(v1);
    }

    public fun enable_autobalance(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg0.strategies, arg2), 2013);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg0.strategies, arg2);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&v1.subscribers, v0), 2018);
        assert!(!v1.is_discontinued, 2001);
        assert!(!0x2::table::contains<0x2::object::ID, u64>(&v1.autobalance_subscribers, v0), 2026);
        0x2::table::add<0x2::object::ID, u64>(&mut v1.autobalance_subscribers, v0, v1.rebalance_index);
        let v2 = AutobalanceEnabled{
            strategy_id     : arg2,
            position_cap_id : v0,
            position_id     : arg1.position_id,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AutobalanceEnabled>(v2);
    }

    public fun finish_bot_rebalance(arg0: &RebalanceCap, arg1: &mut Config, arg2: RebalancePotato, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        assert_rebalance_cap(arg1, arg0);
        let RebalancePotato {
            strategy_id     : v0,
            position_cap_id : v1,
            coins           : v2,
            withdrawn       : v3,
            deposited       : v4,
            prices          : v5,
            touched         : v6,
            allowed         : v7,
        } = arg2;
        let v8 = v7;
        let v9 = v6;
        let v10 = v4;
        let v11 = v3;
        let v12 = v2;
        assert!(0x2::bag::is_empty(&v12), 2040);
        0x2::bag::destroy_empty(v12);
        let (v13, v14) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, 0x1::option::Option<u128>>(v5);
        let v15 = 0x2::vec_map::empty<0x1::type_name::TypeName, u128>();
        let v16 = v13;
        let v17 = v14;
        0x1::vector::reverse<0x1::option::Option<u128>>(&mut v17);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v16) == 0x1::vector::length<0x1::option::Option<u128>>(&v17), 13906841080650792959);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v16);
        let v18 = 0;
        while (v18 < 0x1::vector::length<0x1::type_name::TypeName>(&v16)) {
            let v19 = 0x1::vector::pop_back<0x1::option::Option<u128>>(&mut v17);
            assert!(0x1::option::is_some<u128>(&v19), 2041);
            0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut v15, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v16), 0x1::option::destroy_some<u128>(v19));
            v18 = v18 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v16);
        0x1::vector::destroy_empty<0x1::option::Option<u128>>(v17);
        let v20 = *0x2::table::borrow<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&0x2::object_table::borrow<0x2::object::ID, Strategy>(&arg1.strategies, v0).subscribers, v1);
        let v21 = 0x1::vector::empty<0x2::object::ID>();
        let v22 = 0x2::vec_map::keys<0x2::object::ID, u64>(&v20);
        0x1::vector::reverse<0x2::object::ID>(&mut v22);
        let v23 = 0;
        while (v23 < 0x1::vector::length<0x2::object::ID>(&v22)) {
            let v24 = 0x1::vector::pop_back<0x2::object::ID>(&mut v22);
            if (*0x2::vec_map::get<0x2::object::ID, u64>(&v20, &v24) > 0) {
                assert!(0x2::vec_set::contains<0x2::object::ID>(&v9, &v24), 2042);
                0x1::vector::push_back<0x2::object::ID>(&mut v21, v24);
            };
            v23 = v23 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v22);
        let v25 = 0x2::object_table::borrow<0x2::object::ID, Strategy>(&arg1.strategies, v0).service_config;
        let v26 = 0x2::vec_map::keys<0x2::object::ID, u64>(&v25);
        0x1::vector::reverse<0x2::object::ID>(&mut v26);
        let v27 = 0;
        while (v27 < 0x1::vector::length<0x2::object::ID>(&v26)) {
            let v28 = 0x1::vector::pop_back<0x2::object::ID>(&mut v26);
            if (!0x1::vector::contains<0x2::object::ID>(&v21, &v28)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v21, v28);
            };
            v27 = v27 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v26);
        let v29 = 0x2::vec_set::into_keys<0x2::object::ID>(v9);
        0x1::vector::reverse<0x2::object::ID>(&mut v29);
        let v30 = 0;
        while (v30 < 0x1::vector::length<0x2::object::ID>(&v29)) {
            let v31 = 0x1::vector::pop_back<0x2::object::ID>(&mut v29);
            assert!(0x2::vec_set::contains<0x2::object::ID>(&v8, &v31), 2045);
            v30 = v30 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v29);
        let v32 = 0x2::vec_map::keys<0x1::type_name::TypeName, u64>(&v11);
        let v33 = 0x2::vec_map::keys<0x1::type_name::TypeName, u64>(&v10);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v33);
        let v34 = 0;
        while (v34 < 0x1::vector::length<0x1::type_name::TypeName>(&v33)) {
            let v35 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v33);
            if (!0x1::vector::contains<0x1::type_name::TypeName>(&v32, &v35)) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v32, v35);
            };
            v34 = v34 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v33);
        let v36 = 0;
        let v37 = 0;
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v32);
        let v38 = 0;
        while (v38 < 0x1::vector::length<0x1::type_name::TypeName>(&v32)) {
            let v39 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v32);
            let v40 = moved(&v11, &v39);
            let v41 = moved(&v10, &v39);
            if (v41 > v40) {
                v37 = v37 + ((v41 - v40) as u256) * price_of(&v15, &v39);
            } else {
                v36 = v36 + ((v40 - v41) as u256) * price_of(&v15, &v39);
            };
            v38 = v38 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v32);
        let v42 = (10000 as u256);
        assert!(v37 * v42 >= v36 * (v42 - (arg1.rebalance_slippage_bps as u256)), 2043);
        let v43 = &v21;
        let v44 = vector[];
        let v45 = 0;
        while (v45 < 0x1::vector::length<0x2::object::ID>(v43)) {
            let v46 = 0x1::vector::borrow<0x2::object::ID>(v43, v45);
            let v47 = &mut v44;
            let v48 = if (0x2::vec_map::contains<0x2::object::ID, u64>(&v20, v46)) {
                *0x2::vec_map::get<0x2::object::ID, u64>(&v20, v46)
            } else {
                0
            };
            let v49 = &0x2::table::borrow<0x2::object::ID, ServiceInfo>(&arg1.services, *v46).coins;
            assert!(0x1::vector::length<0x1::type_name::TypeName>(v49) == 1, 2053);
            0x1::vector::push_back<u256>(v47, (v48 as u256) * price_of(&v15, 0x1::vector::borrow<0x1::type_name::TypeName>(v49, 0)));
            v45 = v45 + 1;
        };
        let v50 = 0;
        let v51 = &v44;
        let v52 = 0;
        while (v52 < 0x1::vector::length<u256>(v51)) {
            v50 = v50 + *0x1::vector::borrow<u256>(v51, v52);
            v52 = v52 + 1;
        };
        let v53 = &v21;
        let v54 = &v44;
        let v55 = 0x1::vector::length<0x2::object::ID>(v53);
        assert!(v55 == 0x1::vector::length<u256>(v54), 13906841303989092351);
        let v56 = 0;
        while (v56 < v55) {
            let v57 = 0x1::vector::borrow<0x2::object::ID>(v53, v56);
            let v58 = if (0x2::vec_map::contains<0x2::object::ID, u64>(&v25, v57)) {
                *0x2::vec_map::get<0x2::object::ID, u64>(&v25, v57)
            } else {
                0
            };
            let v59 = *0x1::vector::borrow<u256>(v54, v56) * (10000 as u256);
            let v60 = (v58 as u256) * v50;
            let v61 = if (v59 > v60) {
                v59 - v60
            } else {
                v60 - v59
            };
            assert!(v61 <= (arg1.rebalance_weight_tolerance_bps as u256) * v50, 2044);
            v56 = v56 + 1;
        };
        let v62 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg1.strategies, v0);
        let v63 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut v62.autobalance_subscribers, v1);
        assert!(*v63 < v62.rebalance_index, 2003);
        *v63 = v62.rebalance_index;
        let v64 = v62.rebalance_index;
        let v65 = 0x2::object_table::borrow_mut<0x2::object::ID, UserPosition>(&mut arg1.user_positions, v1);
        if (arg1.rebalance_credits_required) {
            assert!(v65.rebalance_credits > 0, 2002);
            v65.rebalance_credits = v65.rebalance_credits - 1;
        };
        let v66 = BotRebalanceCompleted{
            strategy_id         : v0,
            position_cap_id     : v1,
            position_id         : 0x2::object::id<UserPosition>(v65),
            withdrawn           : v11,
            deposited           : v10,
            prices              : v15,
            credits_remaining   : v65.rebalance_credits,
            new_rebalance_index : v64,
            timestamp_ms        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BotRebalanceCompleted>(v66);
    }

    public fun get_maker_potato_pos_id(arg0: &Config, arg1: &StrategyMakerPotato) : 0x2::object::ID {
        arg1.position_cap_id
    }

    public fun get_service_id(arg0: &ServiceCap) : 0x2::object::ID {
        arg0.service_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun issue_agent_cap(arg0: &PositionCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg1.strategies, arg2), 2013);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg1.strategies, arg2);
        assert!(v0.creator_position_cap_id == 0x2::object::uid_to_inner(&arg0.id), 2000);
        assert!(!v0.is_discontinued, 2001);
        let v1 = AgentCap{
            id          : 0x2::object::new(arg5),
            strategy_id : arg2,
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        v0.active_agent_cap_id = 0x1::option::some<0x2::object::ID>(v2);
        let v3 = AgentCapIssued{
            strategy_id  : arg2,
            agent_cap_id : v2,
            recipient    : arg3,
            replaced     : v0.active_agent_cap_id,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AgentCapIssued>(v3);
        0x2::transfer::transfer<AgentCap>(v1, arg3);
    }

    fun join_coins<T0>(arg0: &mut RebalancePotato, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.coins, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.coins, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.coins, v0, arg1);
        };
    }

    fun list_price(arg0: &Config, arg1: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::option::Option<u128>>, arg2: 0x2::object::ID) {
        let v0 = &0x2::table::borrow<0x2::object::ID, ServiceInfo>(&arg0.services, arg2).coins;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            let v2 = 0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<u128>>(arg1, v2)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, 0x1::option::Option<u128>>(arg1, *v2, 0x1::option::none<u128>());
            };
            v1 = v1 + 1;
        };
    }

    public fun make_public(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg0.strategies, arg2), 2013);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg0.strategies, arg2);
        assert!(v0.creator_position_cap_id == 0x2::object::uid_to_inner(&arg1.id), 2000);
        assert!(!v0.is_public, 2014);
        v0.is_public = true;
        let v1 = StrategyMadePublic{
            strategy_id     : arg2,
            position_cap_id : 0x2::object::uid_to_inner(&arg1.id),
            position_id     : arg1.position_id,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StrategyMadePublic>(v1);
    }

    public fun mark_refreshed(arg0: &mut RebalancePotato, arg1: &ServiceCap) {
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.touched, &arg1.service_id)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.touched, arg1.service_id);
        };
    }

    fun moved(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: &0x1::type_name::TypeName) : u64 {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(arg0, arg1)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(arg0, arg1)
        } else {
            0
        }
    }

    public fun position_cap_id(arg0: &RebalancePotato) : 0x2::object::ID {
        arg0.position_cap_id
    }

    public fun price_needed(arg0: &RebalancePotato, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<u128>>(&arg0.prices, &arg1) && 0x1::option::is_none<u128>(0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<u128>>(&arg0.prices, &arg1))
    }

    fun price_of(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>, arg1: &0x1::type_name::TypeName) : u256 {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u128>(arg0, arg1), 2041);
        (*0x2::vec_map::get<0x1::type_name::TypeName, u128>(arg0, arg1) as u256)
    }

    fun record_move(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(arg0, &arg1)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(arg0, &arg1) = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(arg0, &arg1) + arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(arg0, arg1, arg2);
        };
    }

    public fun record_service_investment(arg0: &ServiceCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::type_name::TypeName) {
        assert_version(arg1);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg1.strategies, arg3), 2013);
        assert_service_in_strategy(0x2::object_table::borrow<0x2::object::ID, Strategy>(&arg1.strategies, arg3), arg2, arg0.service_id);
        assert!(0x2::object_table::contains<0x2::object::ID, UserPosition>(&arg1.user_positions, arg2), 2056);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, UserPosition>(&mut arg1.user_positions, arg2);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, Investment>(&v0.investments, &arg4)) {
            let v1 = Investment{
                service_ids           : 0x1::vector::empty<0x2::object::ID>(),
                subscribed_strategies : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, Investment>(&mut v0.investments, arg4, v1);
        };
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Investment>(&mut v0.investments, &arg4);
        if (!0x1::vector::contains<0x2::object::ID>(&v2.service_ids, &arg0.service_id)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v2.service_ids, arg0.service_id);
        };
    }

    public fun remove_active_service(arg0: &ServiceCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg1.strategies, arg2), 2013);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg1.strategies, arg2);
        if (!0x2::vec_set::contains<0x2::object::ID>(&v0.active_services, &arg0.service_id)) {
            return
        };
        0x2::vec_set::remove<0x2::object::ID>(&mut v0.active_services, &arg0.service_id);
        let v1 = ActiveServiceRemoved{
            strategy_id  : arg2,
            service_id   : arg0.service_id,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ActiveServiceRemoved>(v1);
    }

    public fun remove_coin_from_vault<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        assert!(0x2::vec_map::contains<u64, VaultInfo>(&arg1.vaults, &arg2), 2046);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &mut 0x2::vec_map::get_mut<u64, VaultInfo>(&mut arg1.vaults, &arg2).coins;
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(v1, &v0), 2049);
        0x2::vec_set::remove<0x1::type_name::TypeName>(v1, &v0);
        let v2 = VaultCoinRemoved{
            vault_id     : arg2,
            coin_type    : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VaultCoinRemoved>(v2);
    }

    public fun rename_vault(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        assert_version(arg1);
        assert!(0x2::vec_map::contains<u64, VaultInfo>(&arg1.vaults, &arg2), 2046);
        if (0x2::vec_map::get<u64, VaultInfo>(&arg1.vaults, &arg2).name != arg3) {
            assert_vault_name_free(arg1, &arg3);
        };
        0x2::vec_map::get_mut<u64, VaultInfo>(&mut arg1.vaults, &arg2).name = arg3;
        let v0 = VaultRenamed{
            vault_id     : arg2,
            new_name     : arg3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<VaultRenamed>(v0);
    }

    public fun return_from_swap<T0>(arg0: &mut RebalancePotato, arg1: 0x2::balance::Balance<T0>) {
        join_coins<T0>(arg0, arg1);
    }

    public fun revoke_agent_cap(arg0: &PositionCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg1.strategies, arg2), 2013);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg1.strategies, arg2);
        assert!(v0.creator_position_cap_id == 0x2::object::uid_to_inner(&arg0.id), 2000);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0.active_agent_cap_id), 2054);
        let v1 = AgentCapRevoked{
            strategy_id  : arg2,
            agent_cap_id : 0x1::option::extract<0x2::object::ID>(&mut v0.active_agent_cap_id),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AgentCapRevoked>(v1);
    }

    public fun revoke_price_cap(arg0: &AdminCap, arg1: &mut Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg1.price_cap_id), 2030);
        let v0 = PriceCapRevoked{
            cap_id       : 0x1::option::extract<0x2::object::ID>(&mut arg1.price_cap_id),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            admin        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PriceCapRevoked>(v0);
    }

    public fun revoke_rebalance_cap(arg0: &AdminCap, arg1: &mut Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg1.rebalance_cap_id), 2030);
        let v0 = RebalanceCapRevoked{
            cap_id       : 0x1::option::extract<0x2::object::ID>(&mut arg1.rebalance_cap_id),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            admin        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RebalanceCapRevoked>(v0);
    }

    public fun set_price(arg0: &mut RebalancePotato, arg1: &PriceCap, arg2: &Config, arg3: 0x1::type_name::TypeName, arg4: u128) {
        assert_version(arg2);
        assert_price_cap(arg2, arg1);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<u128>>(&arg0.prices, &arg3), 2037);
        let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x1::option::Option<u128>>(&mut arg0.prices, &arg3);
        assert!(0x1::option::is_none<u128>(v0), 2038);
        assert!(arg4 > 0, 2039);
        0x1::option::fill<u128>(v0, arg4);
    }

    public fun set_rebalance_credits_required(arg0: &AdminCap, arg1: &mut Config, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        arg1.rebalance_credits_required = arg2;
        let v0 = RebalanceCreditsRequiredSet{
            required     : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RebalanceCreditsRequiredSet>(v0);
    }

    fun split_coins<T0>(arg0: &mut RebalancePotato, arg1: 0x1::option::Option<u64>) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.coins, v0), 2034);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.coins, v0);
        let v2 = if (0x1::option::is_some<u64>(&arg1)) {
            let v3 = 0x1::option::destroy_some<u64>(arg1);
            assert!(v3 <= 0x2::balance::value<T0>(v1), 2035);
            0x2::balance::split<T0>(v1, v3)
        } else {
            0x2::balance::withdraw_all<T0>(v1)
        };
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.coins, v0));
        };
        v2
    }

    public fun start_bot_rebalance(arg0: &RebalanceCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : RebalancePotato {
        assert_version(arg1);
        assert_rebalance_cap(arg1, arg0);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg1.strategies, arg2), 2013);
        let v0 = 0x2::object_table::borrow<0x2::object::ID, Strategy>(&arg1.strategies, arg2);
        assert!(!v0.is_discontinued, 2001);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&v0.autobalance_subscribers, arg3), 2021);
        assert!(*0x2::table::borrow<0x2::object::ID, u64>(&v0.autobalance_subscribers, arg3) < v0.rebalance_index, 2003);
        if (arg1.rebalance_credits_required) {
            assert!(0x2::object_table::borrow<0x2::object::ID, UserPosition>(&arg1.user_positions, arg3).rebalance_credits > 0, 2002);
        };
        let v1 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x1::option::Option<u128>>();
        let v2 = 0x2::vec_map::keys<0x2::object::ID, u64>(&v0.service_config);
        let v3 = &v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(v3)) {
            let v5 = &mut v1;
            list_price(arg1, v5, *0x1::vector::borrow<0x2::object::ID>(v3, v4));
            v4 = v4 + 1;
        };
        let v6 = 0x2::table::borrow<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&v0.subscribers, arg3);
        let v7 = 0;
        while (v7 < 0x2::vec_map::length<0x2::object::ID, u64>(v6)) {
            let (v8, v9) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u64>(v6, v7);
            if (*v9 > 0) {
                let v10 = &mut v1;
                list_price(arg1, v10, *v8);
            };
            v7 = v7 + 1;
        };
        let v11 = v0.active_services;
        let v12 = 0x2::vec_map::keys<0x2::object::ID, u64>(&v0.service_config);
        0x1::vector::reverse<0x2::object::ID>(&mut v12);
        let v13 = 0;
        while (v13 < 0x1::vector::length<0x2::object::ID>(&v12)) {
            let v14 = 0x1::vector::pop_back<0x2::object::ID>(&mut v12);
            if (!0x2::vec_set::contains<0x2::object::ID>(&v11, &v14)) {
                0x2::vec_set::insert<0x2::object::ID>(&mut v11, v14);
            };
            v13 = v13 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v12);
        RebalancePotato{
            strategy_id     : arg2,
            position_cap_id : arg3,
            coins           : 0x2::bag::new(arg4),
            withdrawn       : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            deposited       : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            prices          : v1,
            touched         : 0x2::vec_set::empty<0x2::object::ID>(),
            allowed         : v11,
        }
    }

    public fun strategy_id(arg0: &RebalancePotato) : 0x2::object::ID {
        arg0.strategy_id
    }

    public fun subscribe(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg0.strategies, arg2), 2013);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg0.strategies, arg2);
        assert!(!v1.is_discontinued, 2001);
        assert!(v1.is_public || v0 == v1.creator_position_cap_id, 2016);
        assert!(arg3 >= v1.min_deposit, 2009);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&v1.subscribers, v0), 2017);
        0x2::table::add<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v1.subscribers, v0, 0x2::vec_map::empty<0x2::object::ID, u64>());
        let v2 = v1.coin_type;
        let v3 = 0x2::object_table::borrow_mut<0x2::object::ID, UserPosition>(&mut arg0.user_positions, v0);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, Investment>(&v3.investments, &v2)) {
            let v4 = Investment{
                service_ids           : 0x1::vector::empty<0x2::object::ID>(),
                subscribed_strategies : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, Investment>(&mut v3.investments, v2, v4);
        };
        let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Investment>(&mut v3.investments, &v2);
        if (!0x1::vector::contains<0x2::object::ID>(&v5.subscribed_strategies, &arg2)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v5.subscribed_strategies, arg2);
        };
        let v6 = Subscribed{
            strategy_id     : arg2,
            position_cap_id : v0,
            position_id     : arg1.position_id,
            deposit_amount  : arg3,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg4),
            subscriber      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<Subscribed>(v6);
    }

    public fun take_for_swap<T0>(arg0: &mut RebalancePotato, arg1: &RebalanceCap, arg2: &Config, arg3: u64) : 0x2::balance::Balance<T0> {
        assert_version(arg2);
        assert_rebalance_cap(arg2, arg1);
        split_coins<T0>(arg0, 0x1::option::some<u64>(arg3))
    }

    public fun take_from_potato<T0>(arg0: &mut RebalancePotato, arg1: &ServiceCap, arg2: 0x1::option::Option<u64>) : 0x2::balance::Balance<T0> {
        let v0 = split_coins<T0>(arg0, arg2);
        let v1 = &mut arg0.deposited;
        record_move(v1, 0x1::type_name::with_defining_ids<T0>(), 0x2::balance::value<T0>(&v0));
        mark_refreshed(arg0, arg1);
        v0
    }

    public fun transfer_position_cap(arg0: PositionCap, arg1: address, arg2: &0x2::clock::Clock) {
        arg0.owner = arg1;
        let v0 = PositionCapTransferred{
            position_cap_id : 0x2::object::uid_to_inner(&arg0.id),
            position_id     : arg0.position_id,
            previous_owner  : arg0.owner,
            new_owner       : arg1,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PositionCapTransferred>(v0);
        0x2::transfer::transfer<PositionCap>(arg0, arg1);
    }

    public fun unsubscribe(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg0.strategies, arg2), 2013);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg0.strategies, arg2);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&v1.subscribers, v0), 2018);
        let v2 = 0x2::table::borrow<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&v1.subscribers, v0);
        let v3 = 0;
        while (v3 < 0x2::vec_map::length<0x2::object::ID, u64>(v2)) {
            let (_, v5) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u64>(v2, v3);
            assert!(*v5 == 0, 2010);
            v3 = v3 + 1;
        };
        0x2::table::remove<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v1.subscribers, v0);
        if (0x2::table::contains<0x2::object::ID, u64>(&v1.autobalance_subscribers, v0)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut v1.autobalance_subscribers, v0);
        };
        let v6 = v1.coin_type;
        let v7 = 0x2::object_table::borrow_mut<0x2::object::ID, UserPosition>(&mut arg0.user_positions, v0);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Investment>(&v7.investments, &v6)) {
            let v8 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Investment>(&mut v7.investments, &v6);
            let (v9, v10) = 0x1::vector::index_of<0x2::object::ID>(&v8.subscribed_strategies, &arg2);
            if (v9) {
                0x1::vector::remove<0x2::object::ID>(&mut v8.subscribed_strategies, v10);
            };
        };
        let v11 = Unsubscribed{
            strategy_id     : arg2,
            position_cap_id : v0,
            position_id     : arg1.position_id,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
            subscriber      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Unsubscribed>(v11);
    }

    public fun update_autobalance_gas_per_credit(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 > 0, 2023);
        arg1.autobalance_gas_per_credit = arg2;
    }

    public fun update_cooldown_period(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        arg1.config_cooldown_ms = arg2;
    }

    public fun update_max_services_per_strategy(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        arg1.max_services_per_strategy = arg2;
    }

    public fun update_minimum_deposit_amount(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg0.strategies, arg2), 2013);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg0.strategies, arg2);
        assert!(v0.creator_position_cap_id == 0x2::object::uid_to_inner(&arg1.id), 2000);
        v0.min_deposit = arg3;
        let v1 = MinimumDepositUpdated{
            strategy_id     : arg2,
            position_cap_id : 0x2::object::uid_to_inner(&arg1.id),
            position_id     : arg1.position_id,
            new_minimum     : arg3,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg4),
            sender          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MinimumDepositUpdated>(v1);
    }

    public fun update_rebalance_slippage_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 <= 200, 2031);
        arg1.rebalance_slippage_bps = arg2;
    }

    public fun update_rebalance_wallet(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert_version(arg1);
        arg1.rebalance_wallet = arg2;
    }

    public fun update_rebalance_weight_tolerance_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 > 0 && arg2 <= 10000, 2032);
        arg1.rebalance_weight_tolerance_bps = arg2;
    }

    public fun update_strategy_description(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg0.strategies, arg2), 2013);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg0.strategies, arg2);
        assert!(v0.creator_position_cap_id == 0x2::object::uid_to_inner(&arg1.id), 2000);
        v0.description = arg3;
        let v1 = StrategyDescriptionUpdated{
            strategy_id     : arg2,
            position_cap_id : 0x2::object::uid_to_inner(&arg1.id),
            position_id     : arg1.position_id,
            new_description : v0.description,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg4),
            sender          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<StrategyDescriptionUpdated>(v1);
    }

    public fun update_strategy_min_stake(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        arg1.strategy_min_stake = arg2;
    }

    public fun update_strategy_name(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg0.strategies, arg2), 2013);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg0.strategies, arg2);
        assert!(v0.creator_position_cap_id == 0x2::object::uid_to_inner(&arg1.id), 2000);
        assert!(!v0.is_public, 2022);
        v0.name = arg3;
        let v1 = StrategyNameUpdated{
            strategy_id     : arg2,
            position_cap_id : 0x2::object::uid_to_inner(&arg1.id),
            position_id     : arg1.position_id,
            new_name        : v0.name,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg4),
            sender          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<StrategyNameUpdated>(v1);
    }

    public fun update_subscriber_investment(arg0: &ServiceCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64) {
        assert_version(arg1);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg1.strategies, arg3), 2013);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg1.strategies, arg3);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&v0.subscribers, arg2), 2018);
        assert_service_in_strategy(v0, arg2, arg0.service_id);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0.subscribers, arg2);
        if (0x2::vec_map::contains<0x2::object::ID, u64>(v1, &arg0.service_id)) {
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(v1, &arg0.service_id) = arg4;
        } else {
            0x2::vec_map::insert<0x2::object::ID, u64>(v1, arg0.service_id, arg4);
        };
    }

    public fun update_version(arg0: &AdminCap, arg1: &mut Config) {
        assert_version(arg1);
        arg1.version = 1;
    }

    fun validate_strategy_services(arg0: &Config, arg1: u64, arg2: &vector<0x2::object::ID>) {
        let v0 = &0x2::vec_map::get<u64, VaultInfo>(&arg0.vaults, &arg1).coins;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(arg2)) {
            let v2 = 0x1::vector::borrow<0x2::object::ID>(arg2, v1);
            assert!(0x2::table::contains<0x2::object::ID, ServiceInfo>(&arg0.services, *v2), 2025);
            let v3 = &0x2::table::borrow<0x2::object::ID, ServiceInfo>(&arg0.services, *v2).coins;
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(v3)) {
                assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(v0, 0x1::vector::borrow<0x1::type_name::TypeName>(v3, v4)), 2050);
                v4 = v4 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun verify_and_consume_maker_potato(arg0: &ServiceCap, arg1: &mut Config, arg2: StrategyMakerPotato, arg3: u64) {
        assert_version(arg1);
        let StrategyMakerPotato {
            position_cap_id : _,
            minimum_stake   : v1,
        } = arg2;
        assert!(arg3 >= v1, 2011);
    }

    // decompiled from Move bytecode v7
}

