module 0x238382b2ca2c90a2d00e9430122cd439781ad082c395b35a0fc4dc26a894b27a::node_staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NodeConfig has copy, drop, store {
        node_type: u8,
        lock_period_ms: u64,
        max_addresses: u64,
        min_stake: u64,
        max_stake: u64,
        power_weight: u64,
        is_active: bool,
    }

    struct StakeInfo has copy, drop, store {
        stake_id: 0x2::object::ID,
        staker: address,
        node_type: u8,
        amount: u64,
        start_time: u64,
        delegate_to: 0x1::option::Option<address>,
        power: u64,
    }

    struct StakeReceipt has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        stake_id: 0x2::object::ID,
        staker: address,
        node_type: u8,
        amount: u64,
        start_time: u64,
    }

    struct SuperNodeInfo has copy, drop, store {
        owner: address,
        total_staked: u64,
        stake_count: u64,
        total_delegated: u64,
        delegator_count: u64,
        total_delegated_power: u64,
        is_active: bool,
        name: vector<u8>,
        description: vector<u8>,
        created_at: u64,
    }

    struct NodeTypeTracker has store {
        addresses: 0x2::vec_set::VecSet<address>,
        address_stake_count: 0x2::table::Table<address, u64>,
    }

    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        node_configs: 0x2::table::Table<u8, NodeConfig>,
        redemption_window_ms: u64,
        stakes: 0x2::table::Table<0x2::object::ID, StakeInfo>,
        user_stakes: 0x2::table::Table<address, vector<0x2::object::ID>>,
        node_type_trackers: 0x2::table::Table<u8, NodeTypeTracker>,
        super_nodes: 0x2::table::Table<address, SuperNodeInfo>,
        delegations: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        total_staked: 0x2::balance::Balance<T0>,
        total_stakes_count: u64,
        total_power: u64,
        is_paused: bool,
    }

    struct StakeCreated has copy, drop {
        stake_id: 0x2::object::ID,
        staker: address,
        node_type: u8,
        amount: u64,
        power: u64,
        start_time: u64,
        delegate_to: 0x1::option::Option<address>,
    }

    struct StakeRedeemed has copy, drop {
        stake_id: 0x2::object::ID,
        staker: address,
        node_type: u8,
        amount: u64,
        completed_periods: u64,
    }

    struct SuperNodeRegistered has copy, drop {
        owner: address,
    }

    struct SuperNodeRemoved has copy, drop {
        owner: address,
    }

    struct DelegationChanged has copy, drop {
        stake_id: 0x2::object::ID,
        delegator: address,
        old_delegate: 0x1::option::Option<address>,
        new_delegate: 0x1::option::Option<address>,
        amount: u64,
        power: u64,
    }

    struct NodeConfigUpdated has copy, drop {
        node_type: u8,
        lock_period_ms: u64,
        max_addresses: u64,
        min_stake: u64,
        max_stake: u64,
        power_weight: u64,
        is_active: bool,
    }

    fun add_address_to_tracker<T0>(arg0: &mut StakingPool<T0>, arg1: u8, arg2: address) {
        let v0 = 0x2::table::borrow_mut<u8, NodeTypeTracker>(&mut arg0.node_type_trackers, arg1);
        if (!0x2::vec_set::contains<address>(&v0.addresses, &arg2)) {
            0x2::vec_set::insert<address>(&mut v0.addresses, arg2);
            0x2::table::add<address, u64>(&mut v0.address_stake_count, arg2, 1);
        } else {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut v0.address_stake_count, arg2);
            *v1 = *v1 + 1;
        };
    }

    fun add_delegation<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        let v0 = 0x2::table::borrow_mut<address, SuperNodeInfo>(&mut arg0.super_nodes, arg1);
        v0.total_delegated = v0.total_delegated + arg3;
        v0.delegator_count = v0.delegator_count + 1;
        v0.total_delegated_power = v0.total_delegated_power + arg4;
        let v1 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.delegations, arg1);
        if (!0x2::vec_set::contains<0x2::object::ID>(v1, &arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(v1, arg2);
        };
    }

    public entry fun add_node_type<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u8, NodeConfig>(&arg0.node_configs, arg2), 5);
        let v0 = arg3 * 86400000;
        let v1 = NodeConfig{
            node_type      : arg2,
            lock_period_ms : v0,
            max_addresses  : arg4,
            min_stake      : arg5,
            max_stake      : arg6,
            power_weight   : arg7,
            is_active      : arg8,
        };
        0x2::table::add<u8, NodeConfig>(&mut arg0.node_configs, arg2, v1);
        let v2 = NodeTypeTracker{
            addresses           : 0x2::vec_set::empty<address>(),
            address_stake_count : 0x2::table::new<address, u64>(arg9),
        };
        0x2::table::add<u8, NodeTypeTracker>(&mut arg0.node_type_trackers, arg2, v2);
        let v3 = NodeConfigUpdated{
            node_type      : arg2,
            lock_period_ms : v0,
            max_addresses  : arg4,
            min_stake      : arg5,
            max_stake      : arg6,
            power_weight   : arg7,
            is_active      : arg8,
        };
        0x2::event::emit<NodeConfigUpdated>(v3);
    }

    public fun batch_can_redeem<T0>(arg0: &StakingPool<T0>, arg1: vector<0x2::object::ID>, arg2: &0x2::clock::Clock) : vector<bool> {
        let v0 = 0x1::vector::empty<bool>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            0x1::vector::push_back<bool>(&mut v0, can_redeem<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v1), arg2));
            v1 = v1 + 1;
        };
        v0
    }

    public fun calculate_current_period(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg1 < arg0) {
            return 0
        };
        (arg1 - arg0) / (arg2 + arg3)
    }

    public fun calculate_period_expire_time(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        calculate_period_start_time(arg0, arg1, arg2, arg3) + arg2
    }

    public fun calculate_period_start_time(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        arg0 + calculate_current_period(arg0, arg1, arg2, arg3) * (arg2 + arg3)
    }

    public fun calculate_power<T0>(arg0: &StakingPool<T0>, arg1: u8, arg2: u64) : u64 {
        assert!(0x2::table::contains<u8, NodeConfig>(&arg0.node_configs, arg1), 5);
        arg2 * 0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, arg1).power_weight / 10000
    }

    public fun calculate_redemption_window_end(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        calculate_period_expire_time(arg0, arg1, arg2, arg3) + arg3
    }

    fun can_add_address_for_node_type<T0>(arg0: &StakingPool<T0>, arg1: u8, arg2: address) : bool {
        let v0 = 0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, arg1);
        if (v0.max_addresses == 0) {
            return true
        };
        let v1 = 0x2::table::borrow<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1);
        if (0x2::vec_set::contains<address>(&v1.addresses, &arg2)) {
            return true
        };
        0x2::vec_set::size<address>(&v1.addresses) < v0.max_addresses
    }

    public fun can_become_super_node<T0>(arg0: &StakingPool<T0>, arg1: address) : bool {
        can_add_address_for_node_type<T0>(arg0, 1, arg1)
    }

    public fun can_redeem<T0>(arg0: &StakingPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1);
        is_in_redemption_window_calc(v0.start_time, 0x2::clock::timestamp_ms(arg2), 0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, v0.node_type).lock_period_ms, arg0.redemption_window_ms)
    }

    public entry fun change_delegation<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1), 6);
        let v1 = *0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1);
        assert!(v1.staker == v0, 8);
        assert!(v1.node_type != 1, 12);
        let v2 = v1.amount;
        let v3 = v1.power;
        let v4 = v1.delegate_to;
        assert!(0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, arg2), 7);
        assert!(0x2::table::borrow<address, SuperNodeInfo>(&arg0.super_nodes, arg2).is_active, 7);
        if (0x1::option::is_some<address>(&v4)) {
            remove_delegation<T0>(arg0, *0x1::option::borrow<address>(&v4), arg1, v2, v3);
        };
        add_delegation<T0>(arg0, arg2, arg1, v2, v3);
        0x2::table::borrow_mut<0x2::object::ID, StakeInfo>(&mut arg0.stakes, arg1).delegate_to = 0x1::option::some<address>(arg2);
        let v5 = DelegationChanged{
            stake_id     : arg1,
            delegator    : v0,
            old_delegate : v4,
            new_delegate : 0x1::option::some<address>(arg2),
            amount       : v2,
            power        : v3,
        };
        0x2::event::emit<DelegationChanged>(v5);
    }

    public entry fun create_pool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool<T0>{
            id                   : 0x2::object::new(arg1),
            node_configs         : 0x2::table::new<u8, NodeConfig>(arg1),
            redemption_window_ms : 86400000,
            stakes               : 0x2::table::new<0x2::object::ID, StakeInfo>(arg1),
            user_stakes          : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
            node_type_trackers   : 0x2::table::new<u8, NodeTypeTracker>(arg1),
            super_nodes          : 0x2::table::new<address, SuperNodeInfo>(arg1),
            delegations          : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg1),
            total_staked         : 0x2::balance::zero<T0>(),
            total_stakes_count   : 0,
            total_power          : 0,
            is_paused            : false,
        };
        let v1 = NodeTypeTracker{
            addresses           : 0x2::vec_set::empty<address>(),
            address_stake_count : 0x2::table::new<address, u64>(arg1),
        };
        0x2::table::add<u8, NodeTypeTracker>(&mut v0.node_type_trackers, 1, v1);
        let v2 = NodeTypeTracker{
            addresses           : 0x2::vec_set::empty<address>(),
            address_stake_count : 0x2::table::new<address, u64>(arg1),
        };
        0x2::table::add<u8, NodeTypeTracker>(&mut v0.node_type_trackers, 2, v2);
        let v3 = NodeTypeTracker{
            addresses           : 0x2::vec_set::empty<address>(),
            address_stake_count : 0x2::table::new<address, u64>(arg1),
        };
        0x2::table::add<u8, NodeTypeTracker>(&mut v0.node_type_trackers, 3, v3);
        let v4 = NodeConfig{
            node_type      : 1,
            lock_period_ms : 360 * 86400000,
            max_addresses  : 49,
            min_stake      : 3000000000000,
            max_stake      : 15000000000000,
            power_weight   : 50000,
            is_active      : true,
        };
        0x2::table::add<u8, NodeConfig>(&mut v0.node_configs, 1, v4);
        let v5 = NodeConfig{
            node_type      : 2,
            lock_period_ms : 90 * 86400000,
            max_addresses  : 0,
            min_stake      : 500000000000,
            max_stake      : 1500000000000,
            power_weight   : 30000,
            is_active      : true,
        };
        0x2::table::add<u8, NodeConfig>(&mut v0.node_configs, 2, v5);
        let v6 = NodeConfig{
            node_type      : 3,
            lock_period_ms : 7 * 86400000,
            max_addresses  : 0,
            min_stake      : 30000000000,
            max_stake      : 60000000000,
            power_weight   : 20000,
            is_active      : true,
        };
        0x2::table::add<u8, NodeConfig>(&mut v0.node_configs, 3, v6);
        0x2::transfer::share_object<StakingPool<T0>>(v0);
    }

    public entry fun emergency_withdraw<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, arg2), arg4), arg3);
    }

    public fun get_active_super_nodes<T0>(arg0: &StakingPool<T0>) : vector<address> {
        let v0 = 0x2::vec_set::into_keys<address>(0x2::table::borrow<u8, NodeTypeTracker>(&arg0.node_type_trackers, 1).addresses);
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0)) {
            let v3 = *0x1::vector::borrow<address>(&v0, v2);
            if (0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, v3)) {
                if (0x2::table::borrow<address, SuperNodeInfo>(&arg0.super_nodes, v3).is_active) {
                    0x1::vector::push_back<address>(&mut v1, v3);
                };
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_all_node_type_stats<T0>(arg0: &StakingPool<T0>) : (u64, u64, u64, u64, u64, u64) {
        (get_node_type_address_count<T0>(arg0, 1), 0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, 1).max_addresses, get_node_type_address_count<T0>(arg0, 2), 0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, 2).max_addresses, get_node_type_address_count<T0>(arg0, 3), 0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, 3).max_addresses)
    }

    public fun get_node_config<T0>(arg0: &StakingPool<T0>, arg1: u8) : NodeConfig {
        assert!(0x2::table::contains<u8, NodeConfig>(&arg0.node_configs, arg1), 5);
        *0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, arg1)
    }

    public fun get_node_type_address_count<T0>(arg0: &StakingPool<T0>, arg1: u8) : u64 {
        if (!0x2::table::contains<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1)) {
            return 0
        };
        0x2::vec_set::size<address>(&0x2::table::borrow<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1).addresses)
    }

    public fun get_node_type_addresses<T0>(arg0: &StakingPool<T0>, arg1: u8) : vector<address> {
        if (!0x2::table::contains<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1)) {
            return 0x1::vector::empty<address>()
        };
        0x2::vec_set::into_keys<address>(0x2::table::borrow<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1).addresses)
    }

    public fun get_pool_stats<T0>(arg0: &StakingPool<T0>) : (u64, u64, u64, u64, u64, bool) {
        (0x2::balance::value<T0>(&arg0.total_staked), arg0.total_power, arg0.total_stakes_count, get_super_node_count<T0>(arg0), get_super_node_limit<T0>(arg0), arg0.is_paused)
    }

    public fun get_redemption_window_ms<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.redemption_window_ms
    }

    public fun get_redemption_window_remaining_calc(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (!is_in_redemption_window_calc(arg0, arg1, arg2, arg3)) {
            return 0
        };
        let v0 = arg2 + arg3;
        v0 - (arg1 - arg0) % v0
    }

    public fun get_stake_detailed_status<T0>(arg0: &StakingPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u8, u64, u64, u64, bool) {
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1), 6);
        let v0 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1);
        let v1 = 0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, v0.node_type);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = get_stake_status_calc(v0.start_time, v2, v1.lock_period_ms, arg0.redemption_window_ms);
        (v3, calculate_current_period(v0.start_time, v2, v1.lock_period_ms, arg0.redemption_window_ms), get_time_to_next_redemption_window(v0.start_time, v2, v1.lock_period_ms, arg0.redemption_window_ms), get_redemption_window_remaining_calc(v0.start_time, v2, v1.lock_period_ms, arg0.redemption_window_ms), v3 == 1)
    }

    public fun get_stake_info<T0>(arg0: &StakingPool<T0>, arg1: 0x2::object::ID) : StakeInfo {
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1), 6);
        *0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1)
    }

    public fun get_stake_period_info<T0>(arg0: &StakingPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1), 6);
        let v0 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1);
        let v1 = 0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, v0.node_type);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        (calculate_current_period(v0.start_time, v2, v1.lock_period_ms, arg0.redemption_window_ms), calculate_period_start_time(v0.start_time, v2, v1.lock_period_ms, arg0.redemption_window_ms), calculate_period_expire_time(v0.start_time, v2, v1.lock_period_ms, arg0.redemption_window_ms), calculate_redemption_window_end(v0.start_time, v2, v1.lock_period_ms, arg0.redemption_window_ms))
    }

    public fun get_stake_status_calc(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u8 {
        if (is_in_redemption_window_calc(arg0, arg1, arg2, arg3)) {
            1
        } else {
            0
        }
    }

    public fun get_super_node_count<T0>(arg0: &StakingPool<T0>) : u64 {
        get_node_type_address_count<T0>(arg0, 1)
    }

    public fun get_super_node_delegations<T0>(arg0: &StakingPool<T0>, arg1: address) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.delegations, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        0x2::vec_set::into_keys<0x2::object::ID>(*0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.delegations, arg1))
    }

    public fun get_super_node_info<T0>(arg0: &StakingPool<T0>, arg1: address) : SuperNodeInfo {
        assert!(0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, arg1), 7);
        *0x2::table::borrow<address, SuperNodeInfo>(&arg0.super_nodes, arg1)
    }

    public fun get_super_node_limit<T0>(arg0: &StakingPool<T0>) : u64 {
        0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, 1).max_addresses
    }

    public fun get_super_node_ranking<T0>(arg0: &StakingPool<T0>) : (vector<address>, vector<u64>) {
        let v0 = get_active_super_nodes<T0>(arg0);
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v0)) {
            let v4 = *0x1::vector::borrow<address>(&v0, v3);
            let v5 = get_user_total_power<T0>(arg0, v4) + 0x2::table::borrow<address, SuperNodeInfo>(&arg0.super_nodes, v4).total_delegated_power;
            let v6 = false;
            let v7 = 0;
            while (v7 < 0x1::vector::length<address>(&v1)) {
                if (v5 > *0x1::vector::borrow<u64>(&v2, v7)) {
                    0x1::vector::insert<address>(&mut v1, v4, v7);
                    0x1::vector::insert<u64>(&mut v2, v5, v7);
                    v6 = true;
                    break
                };
                v7 = v7 + 1;
            };
            if (!v6) {
                0x1::vector::push_back<address>(&mut v1, v4);
                0x1::vector::push_back<u64>(&mut v2, v5);
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun get_time_to_next_redemption_window(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg1 < arg0) {
            return arg2
        };
        let v0 = (arg1 - arg0) % (arg2 + arg3);
        if (v0 >= arg2) {
            0
        } else {
            arg2 - v0
        }
    }

    public fun get_total_power<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.total_power
    }

    public fun get_total_staked<T0>(arg0: &StakingPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_staked)
    }

    public fun get_total_stakes_count<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.total_stakes_count
    }

    public fun get_user_redeemable_stakes<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stakes, arg1)) {
            return v0
        };
        let v1 = 0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_stakes, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(v1, v2);
            if (can_redeem<T0>(arg0, v3, arg2)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v0, v3);
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_user_stake_count_for_type<T0>(arg0: &StakingPool<T0>, arg1: u8, arg2: address) : u64 {
        if (!0x2::table::contains<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1);
        if (0x2::table::contains<address, u64>(&v0.address_stake_count, arg2)) {
            *0x2::table::borrow<address, u64>(&v0.address_stake_count, arg2)
        } else {
            0
        }
    }

    public fun get_user_stakes<T0>(arg0: &StakingPool<T0>, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stakes, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_stakes, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_user_stakes_by_type<T0>(arg0: &StakingPool<T0>, arg1: address) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stakes, arg1)) {
            return (0, 0, 0, 0, 0, 0)
        };
        let v6 = 0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_stakes, arg1);
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
            let v8 = *0x1::vector::borrow<0x2::object::ID>(v6, v7);
            if (0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, v8)) {
                let v9 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, v8);
                if (v9.node_type == 1) {
                    v0 = v0 + 1;
                    v1 = v1 + v9.amount;
                } else if (v9.node_type == 2) {
                    v2 = v2 + 1;
                    v3 = v3 + v9.amount;
                } else if (v9.node_type == 3) {
                    v4 = v4 + 1;
                    v5 = v5 + v9.amount;
                };
            };
            v7 = v7 + 1;
        };
        (v0, v1, v2, v3, v4, v5)
    }

    public fun get_user_total_power<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stakes, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_stakes, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v0)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(v0, v2);
            if (0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, v3)) {
                v1 = v1 + 0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, v3).power;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_user_total_staked<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stakes, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_stakes, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v0)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(v0, v2);
            if (0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, v3)) {
                v1 = v1 + 0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, v3).amount;
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun handle_super_node_stake_removal<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, SuperNodeInfo>(&mut arg0.super_nodes, arg1);
            if (v0.total_staked >= arg2) {
                v0.total_staked = v0.total_staked - arg2;
            };
            if (v0.stake_count > 0) {
                v0.stake_count = v0.stake_count - 1;
            };
            if (v0.stake_count == 0) {
                v0.is_active = false;
                let v1 = SuperNodeRemoved{owner: arg1};
                0x2::event::emit<SuperNodeRemoved>(v1);
            };
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_in_redemption_window_calc(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (arg1 < arg0) {
            return false
        };
        let v0 = arg2 + arg3;
        let v1 = (arg1 - arg0) % v0;
        v1 >= arg2 && v1 < v0
    }

    public fun is_pool_paused<T0>(arg0: &StakingPool<T0>) : bool {
        arg0.is_paused
    }

    public fun is_super_node<T0>(arg0: &StakingPool<T0>, arg1: address) : bool {
        if (!0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, arg1)) {
            return false
        };
        0x2::table::borrow<address, SuperNodeInfo>(&arg0.super_nodes, arg1).is_active
    }

    public fun is_user_in_node_type<T0>(arg0: &StakingPool<T0>, arg1: u8, arg2: address) : bool {
        if (!0x2::table::contains<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1)) {
            return false
        };
        0x2::vec_set::contains<address>(&0x2::table::borrow<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1).addresses, &arg2)
    }

    public fun node_type_normal() : u8 {
        3
    }

    public fun node_type_proposal() : u8 {
        2
    }

    public fun node_type_super() : u8 {
        1
    }

    public entry fun redeem<T0>(arg0: &mut StakingPool<T0>, arg1: StakeReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::object::id<StakeReceipt>(&arg1);
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, v2), 6);
        let v3 = *0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, v2);
        assert!(v3.staker == v0, 8);
        let v4 = *0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, v3.node_type);
        assert!(is_in_redemption_window_calc(v3.start_time, v1, v4.lock_period_ms, arg0.redemption_window_ms), 4);
        let v5 = calculate_current_period(v3.start_time, v1, v4.lock_period_ms, arg0.redemption_window_ms) + 1;
        let v6 = v3.amount;
        let v7 = v3.node_type;
        let v8 = v3.power;
        let v9 = v3.delegate_to;
        if (0x1::option::is_some<address>(&v9)) {
            remove_delegation<T0>(arg0, *0x1::option::borrow<address>(&v9), v2, v6, v8);
        };
        if (v7 == 1) {
            handle_super_node_stake_removal<T0>(arg0, v0, v6);
        };
        0x2::table::remove<0x2::object::ID, StakeInfo>(&mut arg0.stakes, v2);
        remove_stake_from_user_list<T0>(arg0, v0, v2);
        remove_address_from_tracker<T0>(arg0, v7, v0);
        arg0.total_power = arg0.total_power - v8;
        arg0.total_stakes_count = arg0.total_stakes_count - 1;
        let StakeReceipt {
            id         : v10,
            pool_id    : _,
            stake_id   : _,
            staker     : _,
            node_type  : _,
            amount     : _,
            start_time : _,
        } = arg1;
        0x2::object::delete(v10);
        let v17 = StakeRedeemed{
            stake_id          : v2,
            staker            : v0,
            node_type         : v7,
            amount            : v6,
            completed_periods : v5,
        };
        0x2::event::emit<StakeRedeemed>(v17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, v6), arg3), v0);
    }

    fun remove_address_from_tracker<T0>(arg0: &mut StakingPool<T0>, arg1: u8, arg2: address) {
        let v0 = 0x2::table::borrow_mut<u8, NodeTypeTracker>(&mut arg0.node_type_trackers, arg1);
        if (0x2::table::contains<address, u64>(&v0.address_stake_count, arg2)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut v0.address_stake_count, arg2);
            if (*v1 > 1) {
                *v1 = *v1 - 1;
            } else {
                0x2::table::remove<address, u64>(&mut v0.address_stake_count, arg2);
                if (0x2::vec_set::contains<address>(&v0.addresses, &arg2)) {
                    0x2::vec_set::remove<address>(&mut v0.addresses, &arg2);
                };
            };
        };
    }

    fun remove_delegation<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        if (0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, SuperNodeInfo>(&mut arg0.super_nodes, arg1);
            if (v0.total_delegated >= arg3) {
                v0.total_delegated = v0.total_delegated - arg3;
            };
            if (v0.delegator_count > 0) {
                v0.delegator_count = v0.delegator_count - 1;
            };
            if (v0.total_delegated_power >= arg4) {
                v0.total_delegated_power = v0.total_delegated_power - arg4;
            };
        };
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.delegations, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.delegations, arg1);
            if (0x2::vec_set::contains<0x2::object::ID>(v1, &arg2)) {
                0x2::vec_set::remove<0x2::object::ID>(v1, &arg2);
            };
        };
    }

    fun remove_stake_from_user_list<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stakes, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_stakes, arg1);
            let v1 = 0;
            while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                    0x1::vector::remove<0x2::object::ID>(v0, v1);
                    break
                };
                v1 = v1 + 1;
            };
        };
    }

    public entry fun set_pool_paused<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.is_paused = arg2;
    }

    public entry fun set_super_node_info<T0>(arg0: &mut StakingPool<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, v0), 7);
        let v1 = 0x2::table::borrow_mut<address, SuperNodeInfo>(&mut arg0.super_nodes, v0);
        assert!(v1.is_active, 7);
        v1.name = arg1;
        v1.description = arg2;
    }

    public entry fun stake_super_node<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 9);
        let v0 = 1;
        assert!(0x2::table::contains<u8, NodeConfig>(&arg0.node_configs, v0), 5);
        let v1 = *0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, v0);
        assert!(v1.is_active, 10);
        let v2 = 0x2::coin::value<T0>(&arg1);
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = 0x2::clock::timestamp_ms(arg2);
        assert!(v2 >= v1.min_stake, 2);
        assert!(v2 <= v1.max_stake, 3);
        assert!(can_add_address_for_node_type<T0>(arg0, v0, v3), 1);
        let v5 = v2 * v1.power_weight / 10000;
        let v6 = !0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, v3);
        let v7 = 0x2::object::new(arg3);
        let v8 = 0x2::object::uid_to_inner(&v7);
        let v9 = StakeReceipt{
            id         : v7,
            pool_id    : 0x2::object::id<StakingPool<T0>>(arg0),
            stake_id   : v8,
            staker     : v3,
            node_type  : v0,
            amount     : v2,
            start_time : v4,
        };
        let v10 = StakeInfo{
            stake_id    : v8,
            staker      : v3,
            node_type   : v0,
            amount      : v2,
            start_time  : v4,
            delegate_to : 0x1::option::none<address>(),
            power       : v5,
        };
        0x2::table::add<0x2::object::ID, StakeInfo>(&mut arg0.stakes, v8, v10);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stakes, v3)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.user_stakes, v3, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_stakes, v3), v8);
        add_address_to_tracker<T0>(arg0, v0, v3);
        arg0.total_power = arg0.total_power + v5;
        if (v6) {
            let v11 = SuperNodeInfo{
                owner                 : v3,
                total_staked          : v2,
                stake_count           : 1,
                total_delegated       : 0,
                delegator_count       : 0,
                total_delegated_power : 0,
                is_active             : true,
                name                  : 0x1::vector::empty<u8>(),
                description           : 0x1::vector::empty<u8>(),
                created_at            : v4,
            };
            0x2::table::add<address, SuperNodeInfo>(&mut arg0.super_nodes, v3, v11);
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.delegations, v3, 0x2::vec_set::empty<0x2::object::ID>());
            let v12 = SuperNodeRegistered{owner: v3};
            0x2::event::emit<SuperNodeRegistered>(v12);
        } else {
            let v13 = 0x2::table::borrow_mut<address, SuperNodeInfo>(&mut arg0.super_nodes, v3);
            v13.total_staked = v13.total_staked + v2;
            v13.stake_count = v13.stake_count + 1;
            if (!v13.is_active) {
                v13.is_active = true;
            };
        };
        0x2::balance::join<T0>(&mut arg0.total_staked, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_stakes_count = arg0.total_stakes_count + 1;
        let v14 = StakeCreated{
            stake_id    : v8,
            staker      : v3,
            node_type   : v0,
            amount      : v2,
            power       : v5,
            start_time  : v4,
            delegate_to : 0x1::option::none<address>(),
        };
        0x2::event::emit<StakeCreated>(v14);
        0x2::transfer::transfer<StakeReceipt>(v9, v3);
    }

    public entry fun stake_with_delegation<T0>(arg0: &mut StakingPool<T0>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 9);
        assert!(arg1 == 2 || arg1 == 3, 5);
        assert!(0x2::table::contains<u8, NodeConfig>(&arg0.node_configs, arg1), 5);
        let v0 = *0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, arg1);
        assert!(v0.is_active, 10);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= v0.min_stake, 2);
        assert!(v1 <= v0.max_stake, 3);
        assert!(can_add_address_for_node_type<T0>(arg0, arg1, v2), 1);
        assert!(0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, arg3), 7);
        assert!(0x2::table::borrow<address, SuperNodeInfo>(&arg0.super_nodes, arg3).is_active, 7);
        let v4 = v1 * v0.power_weight / 10000;
        let v5 = 0x2::object::new(arg5);
        let v6 = 0x2::object::uid_to_inner(&v5);
        let v7 = StakeReceipt{
            id         : v5,
            pool_id    : 0x2::object::id<StakingPool<T0>>(arg0),
            stake_id   : v6,
            staker     : v2,
            node_type  : arg1,
            amount     : v1,
            start_time : v3,
        };
        let v8 = StakeInfo{
            stake_id    : v6,
            staker      : v2,
            node_type   : arg1,
            amount      : v1,
            start_time  : v3,
            delegate_to : 0x1::option::some<address>(arg3),
            power       : v4,
        };
        0x2::table::add<0x2::object::ID, StakeInfo>(&mut arg0.stakes, v6, v8);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stakes, v2)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.user_stakes, v2, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_stakes, v2), v6);
        add_address_to_tracker<T0>(arg0, arg1, v2);
        arg0.total_power = arg0.total_power + v4;
        let v9 = 0x2::table::borrow_mut<address, SuperNodeInfo>(&mut arg0.super_nodes, arg3);
        v9.total_delegated = v9.total_delegated + v1;
        v9.delegator_count = v9.delegator_count + 1;
        v9.total_delegated_power = v9.total_delegated_power + v4;
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.delegations, arg3), v6);
        0x2::balance::join<T0>(&mut arg0.total_staked, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_stakes_count = arg0.total_stakes_count + 1;
        let v10 = StakeCreated{
            stake_id    : v6,
            staker      : v2,
            node_type   : arg1,
            amount      : v1,
            power       : v4,
            start_time  : v3,
            delegate_to : 0x1::option::some<address>(arg3),
        };
        0x2::event::emit<StakeCreated>(v10);
        0x2::transfer::transfer<StakeReceipt>(v7, v2);
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public entry fun update_node_config<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u8, NodeConfig>(&arg0.node_configs, arg2), 5);
        let v0 = arg3 * 86400000;
        let v1 = 0x2::table::borrow_mut<u8, NodeConfig>(&mut arg0.node_configs, arg2);
        v1.lock_period_ms = v0;
        v1.max_addresses = arg4;
        v1.min_stake = arg5;
        v1.max_stake = arg6;
        v1.power_weight = arg7;
        v1.is_active = arg8;
        let v2 = NodeConfigUpdated{
            node_type      : arg2,
            lock_period_ms : v0,
            max_addresses  : arg4,
            min_stake      : arg5,
            max_stake      : arg6,
            power_weight   : arg7,
            is_active      : arg8,
        };
        0x2::event::emit<NodeConfigUpdated>(v2);
    }

    public entry fun update_redemption_window<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.redemption_window_ms = arg2 * 3600000;
    }

    // decompiled from Move bytecode v6
}

