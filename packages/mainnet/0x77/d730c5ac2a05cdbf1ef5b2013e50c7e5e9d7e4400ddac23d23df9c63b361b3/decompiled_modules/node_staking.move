module 0xc39a52b2e96b637b7f8251e4a646d432ee848ae1cc077dd65ee22f031b66e9b9::node_staking {
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
        lock_period_ms: u64,
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

    struct StakingPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<T0>,
        total_power: u64,
        total_stakes_count: u64,
        node_configs: 0x2::table::Table<u8, NodeConfig>,
        stakes: 0x2::table::Table<0x2::object::ID, StakeInfo>,
        user_stakes: 0x2::table::Table<address, vector<0x2::object::ID>>,
        super_nodes: 0x2::table::Table<address, SuperNodeInfo>,
        delegations: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        node_type_trackers: 0x2::table::Table<u8, NodeTypeTracker>,
        is_paused: bool,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct StakeCreated has copy, drop {
        stake_id: 0x2::object::ID,
        staker: address,
        node_type: u8,
        amount: u64,
        power: u64,
        start_time: u64,
        lock_period_ms: u64,
        delegate_to: 0x1::option::Option<address>,
    }

    struct StakeRedeemed has copy, drop {
        stake_id: 0x2::object::ID,
        staker: address,
        node_type: u8,
        amount: u64,
        completed_periods: u64,
    }

    struct SuperNodeCreated has copy, drop {
        owner: address,
        stake_id: 0x2::object::ID,
        amount: u64,
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

    public entry fun add_node_type<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u8, NodeConfig>(&arg0.node_configs, arg2), 5);
        let v0 = NodeConfig{
            node_type      : arg2,
            lock_period_ms : arg3 * 86400000,
            max_addresses  : arg4,
            min_stake      : arg5,
            max_stake      : arg6,
            power_weight   : arg7,
            is_active      : arg8,
        };
        0x2::table::add<u8, NodeConfig>(&mut arg0.node_configs, arg2, v0);
        let v1 = NodeTypeTracker{
            addresses           : 0x2::vec_set::empty<address>(),
            address_stake_count : 0x2::table::new<address, u64>(arg9),
        };
        0x2::table::add<u8, NodeTypeTracker>(&mut arg0.node_type_trackers, arg2, v1);
        let v2 = NodeConfigUpdated{
            node_type      : arg2,
            lock_period_ms : v0.lock_period_ms,
            max_addresses  : arg4,
            min_stake      : arg5,
            max_stake      : arg6,
            power_weight   : arg7,
            is_active      : arg8,
        };
        0x2::event::emit<NodeConfigUpdated>(v2);
    }

    fun calculate_current_period(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 <= arg0) {
            return 0
        };
        (arg1 - arg0) / arg2
    }

    fun calculate_period_expire_time(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 + (calculate_current_period(arg0, arg1, arg2) + 1) * arg2
    }

    fun calculate_period_start_time(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 + calculate_current_period(arg0, arg1, arg2) * arg2
    }

    fun calculate_power(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    fun can_add_address_for_node_type<T0>(arg0: &StakingPool<T0>, arg1: u8, arg2: address) : bool {
        let v0 = 0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, arg1);
        if (v0.max_addresses == 0) {
            return true
        };
        if (!0x2::table::contains<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1)) {
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
        is_mature(v0.start_time, 0x2::clock::timestamp_ms(arg2), v0.lock_period_ms)
    }

    public entry fun change_delegation<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1), 6);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, StakeInfo>(&mut arg0.stakes, arg1);
        assert!(v0.node_type != 1, 13);
        assert!(0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, arg2), 8);
        assert!(0x2::table::borrow<address, SuperNodeInfo>(&arg0.super_nodes, arg2).is_active, 8);
        let v1 = v0.delegate_to;
        let v2 = v0.amount;
        let v3 = v0.power;
        let v4 = v0.staker;
        if (0x1::option::is_some<address>(&v1)) {
            let v5 = *0x1::option::borrow<address>(&v1);
            if (0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, v5)) {
                let v6 = 0x2::table::borrow_mut<address, SuperNodeInfo>(&mut arg0.super_nodes, v5);
                v6.total_delegated = v6.total_delegated - v2;
                v6.delegator_count = v6.delegator_count - 1;
                v6.total_delegated_power = v6.total_delegated_power - v3;
            };
            if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.delegations, v5)) {
                let v7 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.delegations, v5);
                if (0x2::vec_set::contains<0x2::object::ID>(v7, &arg1)) {
                    0x2::vec_set::remove<0x2::object::ID>(v7, &arg1);
                };
            };
        };
        let v8 = 0x2::table::borrow_mut<address, SuperNodeInfo>(&mut arg0.super_nodes, arg2);
        v8.total_delegated = v8.total_delegated + v2;
        v8.delegator_count = v8.delegator_count + 1;
        v8.total_delegated_power = v8.total_delegated_power + v3;
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.delegations, arg2), arg1);
        v0.delegate_to = 0x1::option::some<address>(arg2);
        let v9 = DelegationChanged{
            stake_id     : arg1,
            delegator    : v4,
            old_delegate : v1,
            new_delegate : 0x1::option::some<address>(arg2),
            amount       : v2,
            power        : v3,
        };
        0x2::event::emit<DelegationChanged>(v9);
    }

    public entry fun create_pool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::table::new<u8, NodeConfig>(arg1);
        let v2 = 0x2::table::new<u8, NodeTypeTracker>(arg1);
        let v3 = NodeConfig{
            node_type      : 1,
            lock_period_ms : 360 * 86400000,
            max_addresses  : 99,
            min_stake      : 3000000000000,
            max_stake      : 15000000000000,
            power_weight   : 50000,
            is_active      : true,
        };
        0x2::table::add<u8, NodeConfig>(&mut v1, 1, v3);
        let v4 = NodeTypeTracker{
            addresses           : 0x2::vec_set::empty<address>(),
            address_stake_count : 0x2::table::new<address, u64>(arg1),
        };
        0x2::table::add<u8, NodeTypeTracker>(&mut v2, 1, v4);
        let v5 = NodeConfig{
            node_type      : 2,
            lock_period_ms : 180 * 86400000,
            max_addresses  : 0,
            min_stake      : 500000000000,
            max_stake      : 15000000000000,
            power_weight   : 30000,
            is_active      : true,
        };
        0x2::table::add<u8, NodeConfig>(&mut v1, 2, v5);
        let v6 = NodeTypeTracker{
            addresses           : 0x2::vec_set::empty<address>(),
            address_stake_count : 0x2::table::new<address, u64>(arg1),
        };
        0x2::table::add<u8, NodeTypeTracker>(&mut v2, 2, v6);
        let v7 = NodeConfig{
            node_type      : 3,
            lock_period_ms : 90 * 86400000,
            max_addresses  : 0,
            min_stake      : 20000000000,
            max_stake      : 15000000000000,
            power_weight   : 20000,
            is_active      : true,
        };
        0x2::table::add<u8, NodeConfig>(&mut v1, 3, v7);
        let v8 = NodeTypeTracker{
            addresses           : 0x2::vec_set::empty<address>(),
            address_stake_count : 0x2::table::new<address, u64>(arg1),
        };
        0x2::table::add<u8, NodeTypeTracker>(&mut v2, 3, v8);
        let v9 = StakingPool<T0>{
            id                 : v0,
            total_staked       : 0x2::balance::zero<T0>(),
            total_power        : 0,
            total_stakes_count : 0,
            node_configs       : v1,
            stakes             : 0x2::table::new<0x2::object::ID, StakeInfo>(arg1),
            user_stakes        : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
            super_nodes        : 0x2::table::new<address, SuperNodeInfo>(arg1),
            delegations        : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg1),
            node_type_trackers : v2,
            is_paused          : false,
        };
        let v10 = PoolCreated{pool_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<PoolCreated>(v10);
        0x2::transfer::share_object<StakingPool<T0>>(v9);
    }

    public entry fun emergency_withdraw<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.total_staked) >= arg2, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, arg2), arg4), arg3);
    }

    public fun get_active_super_nodes<T0>(arg0: &StakingPool<T0>) : vector<address> {
        if (!0x2::table::contains<u8, NodeTypeTracker>(&arg0.node_type_trackers, 1)) {
            return 0x1::vector::empty<address>()
        };
        0x2::vec_set::into_keys<address>(0x2::table::borrow<u8, NodeTypeTracker>(&arg0.node_type_trackers, 1).addresses)
    }

    public fun get_node_config<T0>(arg0: &StakingPool<T0>, arg1: u8) : (u64, u64, u64, u64, u64, bool) {
        assert!(0x2::table::contains<u8, NodeConfig>(&arg0.node_configs, arg1), 5);
        let v0 = 0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, arg1);
        (v0.lock_period_ms, v0.max_addresses, v0.min_stake, v0.max_stake, v0.power_weight, v0.is_active)
    }

    fun get_node_type_address_count<T0>(arg0: &StakingPool<T0>, arg1: u8) : u64 {
        if (!0x2::table::contains<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1)) {
            return 0
        };
        0x2::vec_set::size<address>(&0x2::table::borrow<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1).addresses)
    }

    public fun get_node_type_address_count_public<T0>(arg0: &StakingPool<T0>, arg1: u8) : u64 {
        get_node_type_address_count<T0>(arg0, arg1)
    }

    public fun get_pool_stats<T0>(arg0: &StakingPool<T0>) : (u64, u64, u64, u64, u64, bool) {
        (0x2::balance::value<T0>(&arg0.total_staked), arg0.total_power, arg0.total_stakes_count, get_super_node_count<T0>(arg0), get_super_node_limit<T0>(arg0), arg0.is_paused)
    }

    public fun get_stake_detailed_status<T0>(arg0: &StakingPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u8, u64, u64, bool) {
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1), 6);
        let v0 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = is_mature(v0.start_time, v1, v0.lock_period_ms);
        let v3 = if (v2) {
            1
        } else {
            0
        };
        (v3, calculate_current_period(v0.start_time, v1, v0.lock_period_ms), get_time_to_maturity(v0.start_time, v1, v0.lock_period_ms), v2)
    }

    public fun get_stake_info<T0>(arg0: &StakingPool<T0>, arg1: 0x2::object::ID) : (address, u8, u64, u64, u64, 0x1::option::Option<address>, u64) {
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1), 6);
        let v0 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1);
        (v0.staker, v0.node_type, v0.amount, v0.start_time, v0.lock_period_ms, v0.delegate_to, v0.power)
    }

    public fun get_stake_period_info<T0>(arg0: &StakingPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1), 6);
        let v0 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        (calculate_current_period(v0.start_time, v1, v0.lock_period_ms), calculate_period_start_time(v0.start_time, v1, v0.lock_period_ms), calculate_period_expire_time(v0.start_time, v1, v0.lock_period_ms))
    }

    public fun get_super_node_count<T0>(arg0: &StakingPool<T0>) : u64 {
        get_node_type_address_count<T0>(arg0, 1)
    }

    public fun get_super_node_info<T0>(arg0: &StakingPool<T0>, arg1: address) : (u64, u64, u64, u64, u64, bool, vector<u8>, vector<u8>, u64) {
        assert!(0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, arg1), 8);
        let v0 = 0x2::table::borrow<address, SuperNodeInfo>(&arg0.super_nodes, arg1);
        (v0.total_staked, v0.stake_count, v0.total_delegated, v0.delegator_count, v0.total_delegated_power, v0.is_active, v0.name, v0.description, v0.created_at)
    }

    public fun get_super_node_limit<T0>(arg0: &StakingPool<T0>) : u64 {
        0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, 1).max_addresses
    }

    public fun get_super_node_ranking<T0>(arg0: &StakingPool<T0>, arg1: address) : (address, u64) {
        assert!(0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, arg1), 8);
        let v0 = 0x2::table::borrow<address, SuperNodeInfo>(&arg0.super_nodes, arg1);
        (arg1, calculate_power(v0.total_staked, 0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, 1).power_weight) + v0.total_delegated_power)
    }

    fun get_time_to_maturity(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 + arg2;
        if (arg1 >= v0) {
            0
        } else {
            v0 - arg1
        }
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
            if (0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, v3)) {
                let v4 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, v3);
                if (is_mature(v4.start_time, 0x2::clock::timestamp_ms(arg2), v4.lock_period_ms)) {
                    0x1::vector::push_back<0x2::object::ID>(&mut v0, v3);
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_user_stake_count_by_type<T0>(arg0: &StakingPool<T0>, arg1: u8, arg2: address) : u64 {
        if (!0x2::table::contains<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1);
        if (!0x2::table::contains<address, u64>(&v0.address_stake_count, arg2)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&v0.address_stake_count, arg2)
    }

    public fun get_user_stakes<T0>(arg0: &StakingPool<T0>, arg1: address) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stakes, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_stakes, arg1)
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_mature(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 >= arg0 + arg2
    }

    public entry fun redeem<T0>(arg0: &mut StakingPool<T0>, arg1: StakeReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let StakeReceipt {
            id         : v2,
            pool_id    : _,
            stake_id   : v4,
            staker     : v5,
            node_type  : v6,
            amount     : _,
            start_time : _,
        } = arg1;
        let v9 = v4;
        0x2::object::delete(v2);
        assert!(v5 == v0, 3);
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, v9), 6);
        let v10 = *0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, v9);
        assert!(is_mature(v10.start_time, v1, v10.lock_period_ms), 4);
        0x2::table::remove<0x2::object::ID, StakeInfo>(&mut arg0.stakes, v9);
        let v11 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_stakes, v0);
        let (v12, v13) = 0x1::vector::index_of<0x2::object::ID>(v11, &v9);
        if (v12) {
            0x1::vector::remove<0x2::object::ID>(v11, v13);
        };
        remove_address_from_tracker<T0>(arg0, v6, v0);
        if (v6 == 1) {
            if (0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, v0)) {
                let v14 = 0x2::table::borrow_mut<address, SuperNodeInfo>(&mut arg0.super_nodes, v0);
                v14.total_staked = v14.total_staked - v10.amount;
                v14.stake_count = v14.stake_count - 1;
                if (v14.stake_count == 0) {
                    v14.is_active = false;
                    let v15 = SuperNodeRemoved{owner: v0};
                    0x2::event::emit<SuperNodeRemoved>(v15);
                };
            };
        } else if (0x1::option::is_some<address>(&v10.delegate_to)) {
            let v16 = *0x1::option::borrow<address>(&v10.delegate_to);
            if (0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, v16)) {
                let v17 = 0x2::table::borrow_mut<address, SuperNodeInfo>(&mut arg0.super_nodes, v16);
                v17.total_delegated = v17.total_delegated - v10.amount;
                v17.delegator_count = v17.delegator_count - 1;
                v17.total_delegated_power = v17.total_delegated_power - v10.power;
            };
            if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.delegations, v16)) {
                let v18 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.delegations, v16);
                if (0x2::vec_set::contains<0x2::object::ID>(v18, &v9)) {
                    0x2::vec_set::remove<0x2::object::ID>(v18, &v9);
                };
            };
        };
        arg0.total_power = arg0.total_power - v10.power;
        arg0.total_stakes_count = arg0.total_stakes_count - 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, v10.amount), arg3), v0);
        let v19 = StakeRedeemed{
            stake_id          : v9,
            staker            : v0,
            node_type         : v6,
            amount            : v10.amount,
            completed_periods : calculate_current_period(v10.start_time, v1, v10.lock_period_ms),
        };
        0x2::event::emit<StakeRedeemed>(v19);
    }

    fun remove_address_from_tracker<T0>(arg0: &mut StakingPool<T0>, arg1: u8, arg2: address) {
        if (!0x2::table::contains<u8, NodeTypeTracker>(&arg0.node_type_trackers, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<u8, NodeTypeTracker>(&mut arg0.node_type_trackers, arg1);
        if (0x2::table::contains<address, u64>(&v0.address_stake_count, arg2)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut v0.address_stake_count, arg2);
            if (*v1 > 1) {
                *v1 = *v1 - 1;
            } else {
                0x2::table::remove<address, u64>(&mut v0.address_stake_count, arg2);
                0x2::vec_set::remove<address>(&mut v0.addresses, &arg2);
            };
        };
    }

    public entry fun set_pool_paused<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: bool) {
        arg0.is_paused = arg2;
    }

    public entry fun set_super_node_info<T0>(arg0: &mut StakingPool<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, v0), 8);
        let v1 = 0x2::table::borrow_mut<address, SuperNodeInfo>(&mut arg0.super_nodes, v0);
        v1.name = arg1;
        v1.description = arg2;
    }

    public entry fun stake_normal_node<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        stake_with_delegation<T0>(arg0, 3, arg1, arg2, arg3, arg4);
    }

    public entry fun stake_proposal_node<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        stake_with_delegation<T0>(arg0, 2, arg1, arg2, arg3, arg4);
    }

    public entry fun stake_super_node<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = *0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, 1);
        assert!(v2.is_active, 11);
        assert!(v1 >= v2.min_stake && v1 <= v2.max_stake, 1);
        assert!(can_add_address_for_node_type<T0>(arg0, 1, v0), 7);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = calculate_power(v1, v2.power_weight);
        let v5 = 0x2::object::new(arg3);
        let v6 = 0x2::object::uid_to_inner(&v5);
        0x2::object::delete(v5);
        let v7 = StakeInfo{
            stake_id       : v6,
            staker         : v0,
            node_type      : 1,
            amount         : v1,
            start_time     : v3,
            lock_period_ms : v2.lock_period_ms,
            delegate_to    : 0x1::option::none<address>(),
            power          : v4,
        };
        if (0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, v0)) {
            let v8 = 0x2::table::borrow_mut<address, SuperNodeInfo>(&mut arg0.super_nodes, v0);
            v8.total_staked = v8.total_staked + v1;
            v8.stake_count = v8.stake_count + 1;
            v8.is_active = true;
        } else {
            let v9 = SuperNodeInfo{
                owner                 : v0,
                total_staked          : v1,
                stake_count           : 1,
                total_delegated       : 0,
                delegator_count       : 0,
                total_delegated_power : 0,
                is_active             : true,
                name                  : 0x1::vector::empty<u8>(),
                description           : 0x1::vector::empty<u8>(),
                created_at            : v3,
            };
            0x2::table::add<address, SuperNodeInfo>(&mut arg0.super_nodes, v0, v9);
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.delegations, v0, 0x2::vec_set::empty<0x2::object::ID>());
            let v10 = SuperNodeCreated{
                owner    : v0,
                stake_id : v6,
                amount   : v1,
            };
            0x2::event::emit<SuperNodeCreated>(v10);
        };
        add_address_to_tracker<T0>(arg0, 1, v0);
        0x2::table::add<0x2::object::ID, StakeInfo>(&mut arg0.stakes, v6, v7);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stakes, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.user_stakes, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_stakes, v0), v6);
        0x2::balance::join<T0>(&mut arg0.total_staked, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_power = arg0.total_power + v4;
        arg0.total_stakes_count = arg0.total_stakes_count + 1;
        let v11 = StakeReceipt{
            id         : 0x2::object::new(arg3),
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            stake_id   : v6,
            staker     : v0,
            node_type  : 1,
            amount     : v1,
            start_time : v3,
        };
        let v12 = StakeCreated{
            stake_id       : v6,
            staker         : v0,
            node_type      : 1,
            amount         : v1,
            power          : v4,
            start_time     : v3,
            lock_period_ms : v2.lock_period_ms,
            delegate_to    : 0x1::option::none<address>(),
        };
        0x2::event::emit<StakeCreated>(v12);
        0x2::transfer::transfer<StakeReceipt>(v11, v0);
    }

    public entry fun stake_with_delegation<T0>(arg0: &mut StakingPool<T0>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 2);
        let v0 = if (arg1 == 2) {
            true
        } else if (arg1 == 3) {
            true
        } else if (arg1 == 4) {
            true
        } else if (arg1 == 5) {
            true
        } else {
            arg1 == 6
        };
        assert!(v0, 5);
        assert!(0x2::table::contains<address, SuperNodeInfo>(&arg0.super_nodes, arg3), 8);
        assert!(0x2::table::borrow<address, SuperNodeInfo>(&arg0.super_nodes, arg3).is_active, 8);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::coin::value<T0>(&arg2);
        let v3 = *0x2::table::borrow<u8, NodeConfig>(&arg0.node_configs, arg1);
        assert!(v3.is_active, 11);
        assert!(v2 >= v3.min_stake && v2 <= v3.max_stake, 1);
        assert!(can_add_address_for_node_type<T0>(arg0, arg1, v1), 7);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        let v5 = calculate_power(v2, v3.power_weight);
        let v6 = 0x2::object::new(arg5);
        let v7 = 0x2::object::uid_to_inner(&v6);
        0x2::object::delete(v6);
        let v8 = StakeInfo{
            stake_id       : v7,
            staker         : v1,
            node_type      : arg1,
            amount         : v2,
            start_time     : v4,
            lock_period_ms : v3.lock_period_ms,
            delegate_to    : 0x1::option::some<address>(arg3),
            power          : v5,
        };
        let v9 = 0x2::table::borrow_mut<address, SuperNodeInfo>(&mut arg0.super_nodes, arg3);
        v9.total_delegated = v9.total_delegated + v2;
        v9.delegator_count = v9.delegator_count + 1;
        v9.total_delegated_power = v9.total_delegated_power + v5;
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.delegations, arg3), v7);
        add_address_to_tracker<T0>(arg0, arg1, v1);
        0x2::table::add<0x2::object::ID, StakeInfo>(&mut arg0.stakes, v7, v8);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_stakes, v1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.user_stakes, v1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_stakes, v1), v7);
        0x2::balance::join<T0>(&mut arg0.total_staked, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_power = arg0.total_power + v5;
        arg0.total_stakes_count = arg0.total_stakes_count + 1;
        let v10 = StakeReceipt{
            id         : 0x2::object::new(arg5),
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            stake_id   : v7,
            staker     : v1,
            node_type  : arg1,
            amount     : v2,
            start_time : v4,
        };
        let v11 = StakeCreated{
            stake_id       : v7,
            staker         : v1,
            node_type      : arg1,
            amount         : v2,
            power          : v5,
            start_time     : v4,
            lock_period_ms : v3.lock_period_ms,
            delegate_to    : 0x1::option::some<address>(arg3),
        };
        0x2::event::emit<StakeCreated>(v11);
        0x2::transfer::transfer<StakeReceipt>(v10, v1);
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public entry fun update_node_config<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool) {
        assert!(0x2::table::contains<u8, NodeConfig>(&arg0.node_configs, arg2), 5);
        let v0 = 0x2::table::borrow_mut<u8, NodeConfig>(&mut arg0.node_configs, arg2);
        v0.lock_period_ms = arg3 * 86400000;
        v0.max_addresses = arg4;
        v0.min_stake = arg5;
        v0.max_stake = arg6;
        v0.power_weight = arg7;
        v0.is_active = arg8;
        let v1 = NodeConfigUpdated{
            node_type      : arg2,
            lock_period_ms : v0.lock_period_ms,
            max_addresses  : arg4,
            min_stake      : arg5,
            max_stake      : arg6,
            power_weight   : arg7,
            is_active      : arg8,
        };
        0x2::event::emit<NodeConfigUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

