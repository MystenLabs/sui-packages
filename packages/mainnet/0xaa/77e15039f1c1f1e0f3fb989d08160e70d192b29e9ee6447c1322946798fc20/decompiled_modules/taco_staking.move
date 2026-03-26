module 0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking {
    struct StakePool has key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco::TACO>,
        staking_cap: u64,
        min_coeff: u256,
        max_coeff: u256,
        max_lock_ms: u64,
        position_states: 0x2::table::Table<address, StakePositionState>,
        tracked_position_ids: vector<address>,
    }

    struct StakeAdminCap has key {
        id: 0x2::object::UID,
        pool_id: address,
    }

    struct StakePosition has key {
        id: 0x2::object::UID,
        pool_id: address,
        owner: address,
        amount: u64,
        staked_at_ms: u64,
        unlock_at_ms: u64,
        lock_ms: u64,
        initial_v_shares: u256,
    }

    struct StakePositionState has copy, drop, store {
        unlock_at_ms: u64,
        lock_ms: u64,
        initial_v_shares: u256,
    }

    struct Staked has copy, drop {
        position_id: address,
        amount: u64,
        lock_ms: u64,
        coeff: u256,
        initial_v_shares: u256,
        unlock_at_ms: u64,
    }

    struct Unstaked has copy, drop {
        position_id: address,
        amount: u64,
    }

    struct StakingConfigUpdated has copy, drop {
        staking_cap: u64,
        min_coeff: u256,
        max_coeff: u256,
        max_lock_ms: u64,
    }

    struct StakePoolCreated has copy, drop {
        pool_id: address,
        admin: address,
        staking_cap: u64,
        min_coeff: u256,
        max_coeff: u256,
        max_lock_ms: u64,
    }

    fun assert_cap(arg0: &StakePool, arg1: &StakeAdminCap) {
        assert!(0x2::object::id_address<StakePool>(arg0) == arg1.pool_id, 11001);
    }

    public(friend) fun assert_position_in_pool(arg0: &StakePool, arg1: &StakePosition) {
        assert!(arg1.pool_id == 0x2::object::id_address<StakePool>(arg0), 11007);
        assert!(0x2::table::contains<address, StakePositionState>(&arg0.position_states, position_id(arg1)), 11007);
    }

    public(friend) fun assert_position_in_pool_and_get_owner(arg0: &StakePool, arg1: address) : bool {
        is_position_registered(arg0, arg1)
    }

    public(friend) fun assert_position_owner(arg0: &StakePosition, arg1: address) {
        assert!(arg0.owner == arg1, 11004);
    }

    public fun create_pool(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_pool_internal(arg0, 200000000000000000, 1000000000000000000, 63072000000, arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        let v4 = StakePoolCreated{
            pool_id     : 0x2::object::id_address<StakePool>(&v2),
            admin       : v3,
            staking_cap : arg0,
            min_coeff   : 200000000000000000,
            max_coeff   : 1000000000000000000,
            max_lock_ms : 63072000000,
        };
        0x2::event::emit<StakePoolCreated>(v4);
        0x2::transfer::transfer<StakeAdminCap>(v1, v3);
        0x2::transfer::share_object<StakePool>(v2);
    }

    fun create_pool_internal(arg0: u64, arg1: u256, arg2: u256, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (StakePool, StakeAdminCap) {
        validate_config(arg0, arg1, arg2, arg3);
        let v0 = StakePool{
            id                   : 0x2::object::new(arg4),
            total_staked         : 0x2::balance::zero<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco::TACO>(),
            staking_cap          : arg0,
            min_coeff            : arg1,
            max_coeff            : arg2,
            max_lock_ms          : arg3,
            position_states      : 0x2::table::new<address, StakePositionState>(arg4),
            tracked_position_ids : 0x1::vector::empty<address>(),
        };
        let v1 = StakeAdminCap{
            id      : 0x2::object::new(arg4),
            pool_id : 0x2::object::id_address<StakePool>(&v0),
        };
        (v0, v1)
    }

    public(friend) fun current_total_vtaco_shares(arg0: &StakePool, arg1: &0x2::clock::Clock) : u256 {
        current_total_vtaco_shares_at(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public(friend) fun current_total_vtaco_shares_at(arg0: &StakePool, arg1: u64) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.tracked_position_ids)) {
            let v2 = *0x1::vector::borrow<address>(&arg0.tracked_position_ids, v1);
            if (0x2::table::contains<address, StakePositionState>(&arg0.position_states, v2)) {
                v0 = v0 + current_vtaco_shares_from_state(0x2::table::borrow<address, StakePositionState>(&arg0.position_states, v2), arg1);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun current_vtaco_shares(arg0: &StakePosition, arg1: &0x2::clock::Clock) : u256 {
        current_vtaco_shares_at(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public(friend) fun current_vtaco_shares_at(arg0: &StakePosition, arg1: u64) : u256 {
        current_vtaco_shares_from_components(arg0.initial_v_shares, arg0.lock_ms, arg0.unlock_at_ms, arg1)
    }

    public(friend) fun current_vtaco_shares_by_position_id(arg0: &StakePool, arg1: address, arg2: &0x2::clock::Clock) : u256 {
        current_vtaco_shares_by_position_id_at(arg0, arg1, 0x2::clock::timestamp_ms(arg2))
    }

    public(friend) fun current_vtaco_shares_by_position_id_at(arg0: &StakePool, arg1: address, arg2: u64) : u256 {
        if (!0x2::table::contains<address, StakePositionState>(&arg0.position_states, arg1)) {
            return 0
        };
        current_vtaco_shares_from_state(0x2::table::borrow<address, StakePositionState>(&arg0.position_states, arg1), arg2)
    }

    fun current_vtaco_shares_from_components(arg0: u256, arg1: u64, arg2: u64, arg3: u64) : u256 {
        if (arg1 == 0) {
            return arg0
        };
        if (arg3 >= arg2) {
            return 0
        };
        arg0 * ((arg2 - arg3) as u256) / (arg1 as u256)
    }

    fun current_vtaco_shares_from_state(arg0: &StakePositionState, arg1: u64) : u256 {
        current_vtaco_shares_from_components(arg0.initial_v_shares, arg0.lock_ms, arg0.unlock_at_ms, arg1)
    }

    public(friend) fun is_position_registered(arg0: &StakePool, arg1: address) : bool {
        0x2::table::contains<address, StakePositionState>(&arg0.position_states, arg1)
    }

    public(friend) fun is_position_unlocked_or_missing(arg0: &StakePool, arg1: address, arg2: &0x2::clock::Clock) : bool {
        is_position_unlocked_or_missing_at(arg0, arg1, 0x2::clock::timestamp_ms(arg2))
    }

    public(friend) fun is_position_unlocked_or_missing_at(arg0: &StakePool, arg1: address, arg2: u64) : bool {
        if (!0x2::table::contains<address, StakePositionState>(&arg0.position_states, arg1)) {
            return true
        };
        arg2 >= 0x2::table::borrow<address, StakePositionState>(&arg0.position_states, arg1).unlock_at_ms
    }

    fun lock_coeff(arg0: &StakePool, arg1: u64) : u256 {
        if (arg1 == 0) {
            return arg0.min_coeff
        };
        arg0.min_coeff + (arg0.max_coeff - arg0.min_coeff) * (arg1 as u256) / (arg0.max_lock_ms as u256)
    }

    public(friend) fun position_id(arg0: &StakePosition) : address {
        0x2::object::id_address<StakePosition>(arg0)
    }

    public(friend) fun position_initial_v_shares(arg0: &StakePosition) : u256 {
        arg0.initial_v_shares
    }

    public(friend) fun position_lock_ms(arg0: &StakePosition) : u64 {
        arg0.lock_ms
    }

    public(friend) fun position_staked_at_ms(arg0: &StakePosition) : u64 {
        arg0.staked_at_ms
    }

    fun remove_position_id(arg0: &mut vector<address>, arg1: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                0x1::vector::remove<address>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 11010
    }

    fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 > 18446744073709551615 - arg1) {
            abort 11009
        };
        arg0 + arg1
    }

    public fun set_staking_config(arg0: &mut StakePool, arg1: &StakeAdminCap, arg2: u64, arg3: u256, arg4: u256, arg5: u64) {
        assert_cap(arg0, arg1);
        validate_config(arg2, arg3, arg4, arg5);
        assert!(0x2::balance::value<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco::TACO>(&arg0.total_staked) <= arg2, 11008);
        arg0.staking_cap = arg2;
        arg0.min_coeff = arg3;
        arg0.max_coeff = arg4;
        arg0.max_lock_ms = arg5;
        let v0 = StakingConfigUpdated{
            staking_cap : arg2,
            min_coeff   : arg3,
            max_coeff   : arg4,
            max_lock_ms : arg5,
        };
        0x2::event::emit<StakingConfigUpdated>(v0);
    }

    public fun stake(arg0: &mut StakePool, arg1: 0x2::coin::Coin<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco::TACO>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        transfer_position(stake_ptb(arg0, arg1, arg2, arg3, arg4), v0);
    }

    public fun stake_ptb(arg0: &mut StakePool, arg1: 0x2::coin::Coin<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco::TACO>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StakePosition {
        assert!(arg2 <= arg0.max_lock_ms, 11002);
        let v0 = 0x2::coin::value<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco::TACO>(&arg1);
        assert!(v0 > 0, 11006);
        assert!(0x2::balance::value<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco::TACO>(&arg0.total_staked) + v0 <= arg0.staking_cap, 11003);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = lock_coeff(arg0, arg2);
        let v3 = (v0 as u256) * v2 / 1000000000000000000;
        let v4 = safe_add_u64(v1, arg2);
        0x2::balance::join<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco::TACO>(&mut arg0.total_staked, 0x2::coin::into_balance<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco::TACO>(arg1));
        let v5 = StakePosition{
            id               : 0x2::object::new(arg4),
            pool_id          : 0x2::object::id_address<StakePool>(arg0),
            owner            : 0x2::tx_context::sender(arg4),
            amount           : v0,
            staked_at_ms     : v1,
            unlock_at_ms     : v4,
            lock_ms          : arg2,
            initial_v_shares : v3,
        };
        let v6 = 0x2::object::id_address<StakePosition>(&v5);
        let v7 = StakePositionState{
            unlock_at_ms     : v4,
            lock_ms          : arg2,
            initial_v_shares : v3,
        };
        0x2::table::add<address, StakePositionState>(&mut arg0.position_states, v6, v7);
        0x1::vector::push_back<address>(&mut arg0.tracked_position_ids, v6);
        let v8 = Staked{
            position_id      : v6,
            amount           : v0,
            lock_ms          : arg2,
            coeff            : v2,
            initial_v_shares : v3,
            unlock_at_ms     : v4,
        };
        0x2::event::emit<Staked>(v8);
        v5
    }

    public fun transfer_position(arg0: StakePosition, arg1: address) {
        arg0.owner = arg1;
        0x2::transfer::transfer<StakePosition>(arg0, arg1);
    }

    public fun unstake(arg0: &mut StakePool, arg1: StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco::TACO>>(unstake_ptb(arg0, arg1, arg2, arg3), v0);
    }

    public fun unstake_ptb(arg0: &mut StakePool, arg1: StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco::TACO> {
        assert_position_owner(&arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.unlock_at_ms, 11005);
        assert_position_in_pool(arg0, &arg1);
        let v0 = 0x2::object::id_address<StakePosition>(&arg1);
        let v1 = arg1.amount;
        0x2::table::remove<address, StakePositionState>(&mut arg0.position_states, v0);
        let v2 = &mut arg0.tracked_position_ids;
        remove_position_id(v2, v0);
        let StakePosition {
            id               : v3,
            pool_id          : _,
            owner            : _,
            amount           : _,
            staked_at_ms     : _,
            unlock_at_ms     : _,
            lock_ms          : _,
            initial_v_shares : _,
        } = arg1;
        0x2::object::delete(v3);
        let v11 = Unstaked{
            position_id : v0,
            amount      : v1,
        };
        0x2::event::emit<Unstaked>(v11);
        0x2::coin::from_balance<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco::TACO>(0x2::balance::split<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco::TACO>(&mut arg0.total_staked, v1), arg3)
    }

    fun validate_config(arg0: u64, arg1: u256, arg2: u256, arg3: u64) {
        assert!(arg0 > 0, 11002);
        assert!(arg3 > 0, 11002);
        assert!(arg1 > 0, 11002);
        assert!(arg1 <= arg2, 11002);
        assert!(arg2 <= 1000000000000000000, 11002);
    }

    // decompiled from Move bytecode v6
}

