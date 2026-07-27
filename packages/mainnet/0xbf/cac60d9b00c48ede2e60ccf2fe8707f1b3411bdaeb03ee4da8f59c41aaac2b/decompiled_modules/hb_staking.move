module 0xbfcac60d9b00c48ede2e60ccf2fe8707f1b3411bdaeb03ee4da8f59c41aaac2b::hb_staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakerInfo has store {
        active: u64,
        pending: u64,
        pending_boundary: u64,
        acc_snapshot: u128,
        accrued: u64,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        boundaries: vector<u64>,
        next_boundary: u64,
        reward_per_quarter: u64,
        queued_reward: 0x1::option::Option<u64>,
        treasury: 0x2::balance::Balance<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>,
        allocated: u64,
        acc_per_share: u128,
        acc_history: vector<u128>,
        total_active: u64,
        total_pending: u64,
        stakes: 0x2::balance::Balance<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>,
        registry: 0x2::table::Table<address, StakerInfo>,
        total_rewards_paid: u64,
    }

    struct Staked has copy, drop {
        staker: address,
        amount: u64,
        activates_at_boundary: u64,
    }

    struct Unstaked has copy, drop {
        staker: address,
        from_pending: u64,
        from_active: u64,
    }

    struct RewardsClaimed has copy, drop {
        staker: address,
        amount: u64,
    }

    struct QuarterRolled has copy, drop {
        boundary_index: u64,
        pot_distributed: u64,
        total_active_after: u64,
    }

    struct ConfigChanged has copy, drop {
        field: vector<u8>,
        old_value: u64,
        new_value: u64,
    }

    public fun allocated(arg0: &StakingPool) : u64 {
        arg0.allocated
    }

    public fun append_boundaries(arg0: &AdminCap, arg1: &mut StakingPool, arg2: vector<u64>) {
        0x1::vector::reverse<u64>(&mut arg2);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            0x1::vector::push_back<u64>(&mut arg1.boundaries, 0x1::vector::pop_back<u64>(&mut arg2));
        };
        0x1::vector::destroy_empty<u64>(arg2);
        assert_increasing(&arg1.boundaries);
    }

    fun assert_increasing(arg0: &vector<u64>) {
        let v0 = 1;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            assert!(*0x1::vector::borrow<u64>(arg0, v0) > *0x1::vector::borrow<u64>(arg0, v0 - 1), 7);
            v0 = v0 + 1;
        };
    }

    fun assert_not_stale(arg0: &StakingPool, arg1: &0x2::clock::Clock) {
        if (arg0.next_boundary < 0x1::vector::length<u64>(&arg0.boundaries)) {
            assert!(0x2::clock::timestamp_ms(arg1) < *0x1::vector::borrow<u64>(&arg0.boundaries, arg0.next_boundary), 8);
        };
    }

    public fun claim(arg0: &mut StakingPool, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, StakerInfo>(&arg0.registry, v0), 6);
        sync(arg0, v0);
        let v1 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.registry, v0);
        let v2 = v1.accrued;
        assert!(v2 > 0, 4);
        v1.accrued = 0;
        arg0.allocated = arg0.allocated - v2;
        arg0.total_rewards_paid = arg0.total_rewards_paid + v2;
        let v3 = RewardsClaimed{
            staker : v0,
            amount : v2,
        };
        0x2::event::emit<RewardsClaimed>(v3);
        0x2::coin::from_balance<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(0x2::balance::split<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&mut arg0.treasury, v2), arg1)
    }

    public fun claimable(arg0: &StakingPool, arg1: address) : u64 {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.registry, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, StakerInfo>(&arg0.registry, arg1);
        let v1 = arg0.acc_per_share;
        let v2 = v0.accrued;
        let v3 = v2;
        if (v0.active > 0 && v1 > v0.acc_snapshot) {
            v3 = v2 + (((v0.active as u128) * (v1 - v0.acc_snapshot) / 1000000000000) as u64);
        };
        if (v0.pending > 0 && arg0.next_boundary > v0.pending_boundary) {
            let v4 = *0x1::vector::borrow<u128>(&arg0.acc_history, v0.pending_boundary);
            if (v1 > v4) {
                v3 = v3 + (((v0.pending as u128) * (v1 - v4) / 1000000000000) as u64);
            };
        };
        v3
    }

    public fun create_staking_pool(arg0: &AdminCap, arg1: vector<u64>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg1) >= 2, 0);
        assert_increasing(&arg1);
        let v0 = StakingPool{
            id                 : 0x2::object::new(arg3),
            boundaries         : arg1,
            next_boundary      : 0,
            reward_per_quarter : arg2,
            queued_reward      : 0x1::option::none<u64>(),
            treasury           : 0x2::balance::zero<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(),
            allocated          : 0,
            acc_per_share      : 0,
            acc_history        : 0x1::vector::empty<u128>(),
            total_active       : 0,
            total_pending      : 0,
            stakes             : 0x2::balance::zero<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(),
            registry           : 0x2::table::new<address, StakerInfo>(arg3),
            total_rewards_paid : 0,
        };
        0x2::transfer::share_object<StakingPool>(v0);
    }

    public fun deposit_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>) {
        0x2::balance::join<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&mut arg0.treasury, 0x2::coin::into_balance<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(arg1));
    }

    fun do_unstake(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB> {
        assert!(arg1 > 0, 4);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, StakerInfo>(&arg0.registry, v0), 6);
        sync(arg0, v0);
        let v1 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.registry, v0);
        assert!(v1.pending + v1.active >= arg1, 5);
        let v2 = if (arg1 <= v1.pending) {
            arg1
        } else {
            v1.pending
        };
        let v3 = arg1 - v2;
        v1.pending = v1.pending - v2;
        v1.active = v1.active - v3;
        arg0.total_pending = arg0.total_pending - v2;
        arg0.total_active = arg0.total_active - v3;
        let v4 = Unstaked{
            staker       : v0,
            from_pending : v2,
            from_active  : v3,
        };
        0x2::event::emit<Unstaked>(v4);
        0x2::coin::from_balance<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(0x2::balance::split<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&mut arg0.stakes, arg1), arg2)
    }

    public fun emergency_unstake(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB> {
        do_unstake(arg0, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun next_boundary_index(arg0: &StakingPool) : u64 {
        arg0.next_boundary
    }

    public fun rollover(arg0: &mut StakingPool, arg1: &0x2::clock::Clock) {
        assert!(arg0.next_boundary < 0x1::vector::length<u64>(&arg0.boundaries), 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= *0x1::vector::borrow<u64>(&arg0.boundaries, arg0.next_boundary), 1);
        let v0 = 0;
        let v1 = if (arg0.next_boundary > 0) {
            if (arg0.total_active > 0) {
                arg0.reward_per_quarter > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            let v2 = arg0.reward_per_quarter;
            v0 = v2;
            assert!(0x2::balance::value<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&arg0.treasury) >= arg0.allocated + v2, 3);
            arg0.allocated = arg0.allocated + v2;
            arg0.acc_per_share = arg0.acc_per_share + (v2 as u128) * 1000000000000 / (arg0.total_active as u128);
        };
        0x1::vector::push_back<u128>(&mut arg0.acc_history, arg0.acc_per_share);
        arg0.total_active = arg0.total_active + arg0.total_pending;
        arg0.total_pending = 0;
        arg0.next_boundary = arg0.next_boundary + 1;
        let v3 = QuarterRolled{
            boundary_index     : arg0.next_boundary - 1,
            pot_distributed    : v0,
            total_active_after : arg0.total_active,
        };
        0x2::event::emit<QuarterRolled>(v3);
        if (0x1::option::is_some<u64>(&arg0.queued_reward)) {
            let v4 = 0x1::option::extract<u64>(&mut arg0.queued_reward);
            let v5 = ConfigChanged{
                field     : b"reward_per_quarter",
                old_value : arg0.reward_per_quarter,
                new_value : v4,
            };
            0x2::event::emit<ConfigChanged>(v5);
            arg0.reward_per_quarter = v4;
        };
    }

    public fun set_reward_per_quarter(arg0: &AdminCap, arg1: &mut StakingPool, arg2: u64) {
        let v0 = ConfigChanged{
            field     : b"reward_per_quarter_queued",
            old_value : arg1.reward_per_quarter,
            new_value : arg2,
        };
        0x2::event::emit<ConfigChanged>(v0);
        arg1.queued_reward = 0x1::option::some<u64>(arg2);
    }

    public fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&arg1);
        assert!(v0 > 0, 4);
        assert!(arg0.next_boundary < 0x1::vector::length<u64>(&arg0.boundaries), 2);
        assert_not_stale(arg0, arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        sync(arg0, v1);
        0x2::balance::join<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&mut arg0.stakes, 0x2::coin::into_balance<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(arg1));
        let v2 = arg0.next_boundary;
        let v3 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.registry, v1);
        v3.pending = v3.pending + v0;
        v3.pending_boundary = v2;
        arg0.total_pending = arg0.total_pending + v0;
        let v4 = Staked{
            staker                : v1,
            amount                : v0,
            activates_at_boundary : v2,
        };
        0x2::event::emit<Staked>(v4);
    }

    public fun staked_of(arg0: &StakingPool, arg1: address) : (u64, u64) {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.registry, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<address, StakerInfo>(&arg0.registry, arg1);
        (v0.active, v0.pending)
    }

    fun sync(arg0: &mut StakingPool, arg1: address) {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.registry, arg1)) {
            let v0 = StakerInfo{
                active           : 0,
                pending          : 0,
                pending_boundary : 0,
                acc_snapshot     : arg0.acc_per_share,
                accrued          : 0,
            };
            0x2::table::add<address, StakerInfo>(&mut arg0.registry, arg1, v0);
            return
        };
        let v1 = arg0.acc_per_share;
        let v2 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.registry, arg1);
        if (v2.active > 0 && v1 > v2.acc_snapshot) {
            v2.accrued = v2.accrued + (((v2.active as u128) * (v1 - v2.acc_snapshot) / 1000000000000) as u64);
        };
        if (v2.pending > 0 && arg0.next_boundary > v2.pending_boundary) {
            let v3 = *0x1::vector::borrow<u128>(&arg0.acc_history, v2.pending_boundary);
            if (v1 > v3) {
                v2.accrued = v2.accrued + (((v2.pending as u128) * (v1 - v3) / 1000000000000) as u64);
            };
            v2.active = v2.active + v2.pending;
            v2.pending = 0;
        };
        v2.acc_snapshot = v1;
    }

    public fun totals(arg0: &StakingPool) : (u64, u64) {
        (arg0.total_active, arg0.total_pending)
    }

    public fun treasury_balance(arg0: &StakingPool) : u64 {
        0x2::balance::value<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&arg0.treasury)
    }

    public fun unstake(arg0: &mut StakingPool, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB> {
        assert_not_stale(arg0, arg2);
        do_unstake(arg0, arg1, arg3)
    }

    public fun withdraw_unallocated(arg0: &AdminCap, arg1: &mut StakingPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB> {
        let v0 = 0x2::balance::value<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&arg1.treasury) - arg1.allocated;
        let v1 = if (arg1.next_boundary > 0) {
            if (arg1.next_boundary < 0x1::vector::length<u64>(&arg1.boundaries)) {
                arg1.total_active > 0
            } else {
                false
            }
        } else {
            false
        };
        let v2 = if (v1) {
            arg1.reward_per_quarter
        } else {
            0
        };
        let v3 = if (v0 > v2) {
            v0 - v2
        } else {
            0
        };
        assert!(arg2 <= v3, 3);
        0x2::coin::from_balance<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(0x2::balance::split<0x8680fbd7639ad389d57f3acde423164d41e85b8f177d18b5fc5263983f7187cc::hb::HB>(&mut arg1.treasury, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

