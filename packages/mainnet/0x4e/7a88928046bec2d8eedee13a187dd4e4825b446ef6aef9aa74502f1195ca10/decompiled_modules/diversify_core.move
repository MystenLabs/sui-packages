module 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core {
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
        coin_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
        admin: address,
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
        is_cross_token: bool,
        is_public: bool,
        min_deposit: u64,
        timestamp_ms: u64,
        creator: address,
    }

    struct RebalanceRequired has copy, drop {
        strategy_id: 0x2::object::ID,
        new_rebalance_index: u64,
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

    struct PartnerCap has store, key {
        id: 0x2::object::UID,
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
        coin_type: 0x1::type_name::TypeName,
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
        cross_token_enabled: bool,
        cross_token_min_stake: u64,
        autobalance_gas_per_credit: u64,
    }

    struct Strategy has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator_position_cap_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        subscribers: 0x2::table::Table<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>,
        autobalance_subscribers: 0x2::table::Table<0x2::object::ID, u64>,
        rebalance_index: u64,
        service_config: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        last_config_change_ms: u64,
        is_discontinued: bool,
        is_cross_token: bool,
        min_deposit: u64,
        is_public: bool,
    }

    struct RebalancePotato<phantom T0> {
        strategy_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct StrategyMakerPotato {
        position_cap_id: 0x2::object::ID,
        minimum_stake: u64,
    }

    public fun add_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun add_to_potato<T0>(arg0: &mut RebalancePotato<T0>, arg1: &ServiceCap, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg2);
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

    fun assert_version(arg0: &Config) {
        assert!(arg0.version <= 1, 2012);
    }

    public fun change_config(arg0: &PositionCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: 0x2::vec_map::VecMap<0x2::object::ID, u64>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(0x2::object_table::contains<0x2::object::ID, Strategy>(&arg1.strategies, arg2), 2013);
        let v1 = 0x2::object_table::borrow<0x2::object::ID, Strategy>(&arg1.strategies, arg2);
        assert!(v1.creator_position_cap_id == 0x2::object::uid_to_inner(&arg0.id), 2000);
        assert!(v0 - v1.last_config_change_ms >= arg1.config_cooldown_ms, 2006);
        assert!(!v1.is_discontinued, 2001);
        let v2 = 0x2::vec_map::keys<0x2::object::ID, u64>(&arg3);
        assert!(0x1::vector::length<0x2::object::ID>(&v2) <= arg1.max_services_per_strategy, 2015);
        validate_strategy_services(arg1, v1.coin_type, v1.is_cross_token, &v2);
        let v3 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg1.strategies, arg2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&v2)) {
            let v5 = *0x1::vector::borrow<0x2::object::ID>(&v2, v4);
            if (0x2::vec_map::contains<0x2::object::ID, u64>(&v3.service_config, &v5)) {
                *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut v3.service_config, &v5) = *0x2::vec_map::get<0x2::object::ID, u64>(&arg3, &v5);
            } else {
                0x2::vec_map::insert<0x2::object::ID, u64>(&mut v3.service_config, v5, *0x2::vec_map::get<0x2::object::ID, u64>(&arg3, &v5));
            };
            v4 = v4 + 1;
        };
        let v6 = 0x2::vec_map::keys<0x2::object::ID, u64>(&v3.service_config);
        let v7 = 0x1::vector::empty<0x2::object::ID>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x2::object::ID>(&v6)) {
            let v9 = *0x1::vector::borrow<0x2::object::ID>(&v6, v8);
            if (!0x2::vec_map::contains<0x2::object::ID, u64>(&arg3, &v9) || *0x2::vec_map::get<0x2::object::ID, u64>(&v3.service_config, &v9) == 0) {
                0x1::vector::push_back<0x2::object::ID>(&mut v7, v9);
            };
            v8 = v8 + 1;
        };
        let v10 = 0;
        while (v10 < 0x1::vector::length<0x2::object::ID>(&v7)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut v3.service_config, 0x1::vector::borrow<0x2::object::ID>(&v7, v10));
            v10 = v10 + 1;
        };
        let v13 = 0x2::vec_map::keys<0x2::object::ID, u64>(&v3.service_config);
        let v14 = 0;
        let v15 = 0;
        while (v15 < 0x1::vector::length<0x2::object::ID>(&v13)) {
            v14 = v14 + *0x2::vec_map::get<0x2::object::ID, u64>(&v3.service_config, 0x1::vector::borrow<0x2::object::ID>(&v13, v15));
            v15 = v15 + 1;
        };
        assert!(v14 == 10000, 2019);
        v3.rebalance_index = v3.rebalance_index + 1;
        v3.last_config_change_ms = v0;
        v3.description = arg4;
        let v16 = RebalanceRequired{
            strategy_id         : arg2,
            new_rebalance_index : v3.rebalance_index,
            timestamp_ms        : v0,
        };
        0x2::event::emit<RebalanceRequired>(v16);
        let v17 = StrategyDescriptionUpdated{
            strategy_id     : arg2,
            position_cap_id : 0x2::object::uid_to_inner(&arg0.id),
            position_id     : arg0.position_id,
            new_description : v3.description,
            timestamp_ms    : v0,
            sender          : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<StrategyDescriptionUpdated>(v17);
    }

    public fun complete_self_rebalance(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 2000);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
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
            id                         : 0x2::object::new(arg3),
            version                    : 1,
            user_positions             : 0x2::object_table::new<0x2::object::ID, UserPosition>(arg3),
            strategies                 : 0x2::object_table::new<0x2::object::ID, Strategy>(arg3),
            rebalance_wallet           : arg1,
            max_services_per_strategy  : 10,
            config_cooldown_ms         : 86400000,
            services                   : 0x2::table::new<0x2::object::ID, ServiceInfo>(arg3),
            cross_token_enabled        : false,
            cross_token_min_stake      : arg2,
            autobalance_gas_per_credit : 10000000,
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

    public fun create_rebalance_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : RebalanceCap {
        RebalanceCap{id: 0x2::object::new(arg1)}
    }

    public fun create_service_cap<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : ServiceCap {
        assert_version(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, ServiceInfo>(&arg1.services, arg2), 2024);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = ServiceInfo{coin_type: v0};
        0x2::table::add<0x2::object::ID, ServiceInfo>(&mut arg1.services, arg2, v1);
        let v2 = ServiceCapIssued{
            service_id   : arg2,
            coin_type    : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            admin        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ServiceCapIssued>(v2);
        ServiceCap{
            id         : 0x2::object::new(arg4),
            service_id : arg2,
        }
    }

    public fun create_strategy<T0>(arg0: &mut Config, arg1: &mut PositionCap, arg2: &PartnerCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x2::object::ID>, arg6: vector<u64>, arg7: bool, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, StrategyMakerPotato) {
        assert_version(arg0);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg5);
        assert!(v0 == 0x1::vector::length<u64>(&arg6), 2019);
        assert!(v0 <= arg0.max_services_per_strategy, 2015);
        let v1 = 0x2::object::new(arg11);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        validate_strategy_services(arg0, v3, arg7, &arg5);
        let v4 = if (arg7) {
            arg0.cross_token_min_stake
        } else {
            0
        };
        let v5 = StrategyMakerPotato{
            position_cap_id : 0x2::object::uid_to_inner(&arg1.id),
            minimum_stake   : v4,
        };
        let v6 = 0x2::vec_map::empty<0x2::object::ID, u64>();
        let v7 = 0;
        let v8 = 0;
        while (v7 < v0) {
            v8 = v8 + *0x1::vector::borrow<u64>(&arg6, v7);
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v6, *0x1::vector::borrow<0x2::object::ID>(&arg5, v7), *0x1::vector::borrow<u64>(&arg6, v7));
            v7 = v7 + 1;
        };
        assert!(v8 == 10000, 2019);
        let v9 = Strategy{
            id                      : v1,
            name                    : arg3,
            description             : arg4,
            creator_position_cap_id : 0x2::object::uid_to_inner(&arg1.id),
            coin_type               : v3,
            subscribers             : 0x2::table::new<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(arg11),
            autobalance_subscribers : 0x2::table::new<0x2::object::ID, u64>(arg11),
            rebalance_index         : 0,
            service_config          : v6,
            last_config_change_ms   : 0,
            is_discontinued         : false,
            is_cross_token          : arg7,
            min_deposit             : arg8,
            is_public               : arg9,
        };
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, vector<0x2::object::ID>>(&arg1.created_strategies, &v3)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, vector<0x2::object::ID>>(&mut arg1.created_strategies, v3, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::vec_map::get_mut<0x1::type_name::TypeName, vector<0x2::object::ID>>(&mut arg1.created_strategies, &v3), v2);
        0x2::object_table::add<0x2::object::ID, Strategy>(&mut arg0.strategies, v2, v9);
        let v10 = StrategyCreated{
            strategy_id     : v2,
            position_cap_id : 0x2::object::uid_to_inner(&arg1.id),
            position_id     : arg1.position_id,
            coin_type       : v3,
            is_cross_token  : arg7,
            is_public       : arg9,
            min_deposit     : arg8,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg10),
            creator         : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<StrategyCreated>(v10);
        (v2, v5)
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

    public fun disable_autobalance(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
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
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg0.strategies, arg2);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&v1.subscribers, v0), 2018);
        assert!(!v1.is_cross_token, 2020);
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

    public fun finish_rebalance_for_position_cap<T0>(arg0: &RebalanceCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: RebalancePotato<T0>, arg5: &0x2::clock::Clock) {
        assert_version(arg1);
        let RebalancePotato {
            strategy_id     : v0,
            position_cap_id : v1,
            balance         : v2,
        } = arg4;
        let v3 = v2;
        assert!(v1 == arg3, 2005);
        assert!(v0 == arg2, 2005);
        assert!(0x2::balance::value<T0>(&v3) == 0, 2004);
        0x2::balance::destroy_zero<T0>(v3);
        let v4 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg1.strategies, arg2);
        *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut v4.autobalance_subscribers, arg3) = v4.rebalance_index;
        let v5 = v4.rebalance_index;
        let v6 = 0x2::object_table::borrow_mut<0x2::object::ID, UserPosition>(&mut arg1.user_positions, arg3);
        v6.rebalance_credits = v6.rebalance_credits - 1;
        let v7 = BotRebalanceCompleted{
            strategy_id         : arg2,
            position_cap_id     : arg3,
            position_id         : 0x2::object::id<UserPosition>(v6),
            credits_remaining   : v6.rebalance_credits,
            new_rebalance_index : v5,
            timestamp_ms        : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<BotRebalanceCompleted>(v7);
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

    public fun initialise_rebalance_for_position_cap<T0>(arg0: &RebalanceCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : RebalancePotato<T0> {
        assert_version(arg1);
        let v0 = 0x2::object_table::borrow<0x2::object::ID, Strategy>(&arg1.strategies, arg2);
        assert!(!v0.is_cross_token, 2020);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&v0.autobalance_subscribers, arg3), 2021);
        assert!(*0x2::table::borrow<0x2::object::ID, u64>(&v0.autobalance_subscribers, arg3) < v0.rebalance_index, 2003);
        assert!(0x2::object_table::borrow<0x2::object::ID, UserPosition>(&arg1.user_positions, arg3).rebalance_credits > 0, 2002);
        RebalancePotato<T0>{
            strategy_id     : arg2,
            position_cap_id : arg3,
            balance         : 0x2::balance::zero<T0>(),
        }
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

    public fun position_cap_id<T0>(arg0: &RebalancePotato<T0>) : 0x2::object::ID {
        arg0.position_cap_id
    }

    public fun record_service_investment(arg0: &ServiceCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: 0x1::type_name::TypeName) {
        assert_version(arg1);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, UserPosition>(&mut arg1.user_positions, arg2);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, Investment>(&v0.investments, &arg3)) {
            let v1 = Investment{
                service_ids           : 0x1::vector::empty<0x2::object::ID>(),
                subscribed_strategies : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, Investment>(&mut v0.investments, arg3, v1);
        };
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Investment>(&mut v0.investments, &arg3);
        if (!0x1::vector::contains<0x2::object::ID>(&v2.service_ids, &arg0.service_id)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v2.service_ids, arg0.service_id);
        };
    }

    public fun set_cross_token_enabled(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        assert_version(arg1);
        arg1.cross_token_enabled = arg2;
    }

    public fun strategy_id<T0>(arg0: &RebalancePotato<T0>) : 0x2::object::ID {
        arg0.strategy_id
    }

    public fun subscribe(arg0: &mut Config, arg1: &PositionCap, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
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

    public fun take_from_potato<T0>(arg0: &mut RebalancePotato<T0>, arg1: &ServiceCap, arg2: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.balance, arg2)
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

    public fun update_cross_token_min_stake(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        arg1.cross_token_min_stake = arg2;
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

    public fun update_rebalance_wallet(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert_version(arg1);
        arg1.rebalance_wallet = arg2;
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
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Strategy>(&mut arg1.strategies, arg3);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&v0.subscribers, arg2), 2018);
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

    fun validate_strategy_services(arg0: &Config, arg1: 0x1::type_name::TypeName, arg2: bool, arg3: &vector<0x2::object::ID>) {
        if (arg2) {
            assert!(arg0.cross_token_enabled, 2007);
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg3)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(arg3, v0);
            assert!(0x2::table::contains<0x2::object::ID, ServiceInfo>(&arg0.services, v1), 2025);
            if (!arg2) {
                assert!(0x2::table::borrow<0x2::object::ID, ServiceInfo>(&arg0.services, v1).coin_type == arg1, 2008);
            };
            v0 = v0 + 1;
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

