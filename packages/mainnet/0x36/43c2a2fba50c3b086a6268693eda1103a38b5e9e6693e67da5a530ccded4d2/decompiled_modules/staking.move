module 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::staking {
    struct PositionsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Position has store {
        shares: u64,
        reward_snap: u128,
        entered_epoch: u64,
    }

    struct BuybackFaithApplied has copy, drop {
        total: u64,
        burned: u64,
        rewards: u64,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        admin: address,
        staked: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>,
        rewards: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>,
        total_shares: u64,
        reward_index: u128,
        stakers: vector<address>,
        positions: vector<Position>,
    }

    struct StakingSnapshot has copy, drop {
        ts_ms: u64,
        total_staked_atoms: u64,
        total_rewards_atoms: u64,
        avg_blessings_bps: u64,
    }

    struct RewardsAccruedKey has copy, drop, store {
        user: address,
    }

    fun accrued_add(arg0: &mut StakingPool, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = RewardsAccruedKey{user: arg1};
        if (!0x2::dynamic_field::exists_<RewardsAccruedKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<RewardsAccruedKey, u64>(&mut arg0.id, v0, arg2);
        } else {
            let v1 = 0x2::dynamic_field::borrow_mut<RewardsAccruedKey, u64>(&mut arg0.id, v0);
            *v1 = *v1 + arg2;
        };
    }

    fun accrued_take_all(arg0: &mut StakingPool, arg1: address) : u64 {
        let v0 = RewardsAccruedKey{user: arg1};
        if (!0x2::dynamic_field::exists_<RewardsAccruedKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = 0x2::dynamic_field::borrow_mut<RewardsAccruedKey, u64>(&mut arg0.id, v0);
        *v1 = 0;
        *v1
    }

    fun add_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(arg1);
            return
        };
        0x2::coin::join<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&mut arg0.rewards, arg1);
        let v1 = 0x2::tx_context::epoch(arg2);
        let v2 = 0x1::vector::length<address>(&arg0.stakers);
        if (v2 == 0) {
            return
        };
        let v3 = 0;
        let v4 = &arg0.positions;
        let v5 = 0;
        while (v5 < 0x1::vector::length<Position>(v4)) {
            let v6 = 0x1::vector::borrow<Position>(v4, v5);
            v3 = v3 + (((v6.shares as u256) * (blessings_multiplier_bps(v6.entered_epoch, v1) as u256) / 10000) as u128);
            v5 = v5 + 1;
        };
        if (v3 == 0) {
            return
        };
        let v7 = 0;
        while (v7 < v2) {
            let v8 = *0x1::vector::borrow<address>(&arg0.stakers, v7);
            let v9 = 0x1::vector::borrow<Position>(&arg0.positions, v7);
            let v10 = (((v9.shares as u256) * (blessings_multiplier_bps(v9.entered_epoch, v1) as u256) / 10000) as u128);
            let v11 = 0;
            if (v7 == v2 - 1) {
                v11 = v0;
            } else if (v0 > 0 && v10 > 0) {
                let v12 = ((((v0 as u256) * (v10 as u256) / (v3 as u256)) as u128) as u64);
                let v13 = v12;
                if (v12 == 0 && v0 > 0) {
                    v13 = 1;
                };
                if (v13 > v0) {
                    v13 = v0;
                };
                v11 = v13;
            };
            if (v11 > 0) {
                v0 = v0 - v11;
                accrued_add(arg0, v8, v11);
            };
            v7 = v7 + 1;
        };
    }

    fun blessings_multiplier_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 <= arg0) {
            10000
        } else {
            10000 + 0x1::u64::min((arg1 - arg0) * 150, 15000)
        }
    }

    public entry fun burn90_and_deposit10(arg0: &mut StakingPool, arg1: &mut 0x2::coin::TreasuryCap<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg2: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun burn90_and_deposit10_v2(arg0: &mut StakingPool, arg1: &mut 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager::GlobalV2, arg2: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg2);
        if (v0 == 0) {
            0x2::coin::destroy_zero<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(arg2);
            return
        };
        let v1 = (((v0 as u256) * 9 / 10) as u64);
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager::burn_faith(arg1, 0x2::coin::split<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&mut arg2, v1, arg3));
        add_rewards(arg0, arg2, arg3);
        let v2 = BuybackFaithApplied{
            total   : v0,
            burned  : v1,
            rewards : 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg2),
        };
        0x2::event::emit<BuybackFaithApplied>(v2);
    }

    public entry fun claim_staking_rewards(arg0: &mut StakingPool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = accrued_take_all(arg0, v0);
        assert!(v1 > 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_NOTHING_TO_CLAIM());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(0x2::coin::split<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&mut arg0.rewards, v1, arg1), v0);
    }

    public fun create_pool(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : StakingPool {
        StakingPool{
            id           : 0x2::object::new(arg1),
            admin        : arg0,
            staked       : 0x2::coin::zero<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(arg1),
            rewards      : 0x2::coin::zero<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(arg1),
            total_shares : 0,
            reward_index : 0,
            stakers      : vector[],
            positions    : 0x1::vector::empty<Position>(),
        }
    }

    public entry fun create_pool_and_share(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<StakingPool>(create_pool(arg0, arg1));
    }

    public entry fun deposit_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg2: &mut 0x2::tx_context::TxContext) {
        add_rewards(arg0, arg1, arg2);
    }

    public fun emit_staking_snapshot(arg0: &StakingPool, arg1: u64) {
        let v0 = StakingSnapshot{
            ts_ms               : arg1,
            total_staked_atoms  : 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg0.staked),
            total_rewards_atoms : 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg0.rewards),
            avg_blessings_bps   : 0,
        };
        0x2::event::emit<StakingSnapshot>(v0);
    }

    public fun migrate_to_stakers_table(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<PositionsKey>(&arg0.id, v0)) {
            let v1 = PositionsKey{dummy_field: false};
            0x2::dynamic_field::add<PositionsKey, 0x2::table::Table<address, Position>>(&mut arg0.id, v1, 0x2::table::new<address, Position>(arg2));
        };
        let v2 = 0;
        while (v2 < 0x1::u64::min(0x1::vector::length<address>(&arg0.stakers), arg1)) {
            let v3 = 0x1::vector::pop_back<address>(&mut arg0.stakers);
            let v4 = 0x1::vector::pop_back<Position>(&mut arg0.positions);
            0x2::table::add<address, Position>(stakers_table_mut(arg0), v3, v4);
            v2 = v2 + 1;
        };
    }

    public entry fun snapshot_staking_entry(arg0: &StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        emit_staking_snapshot(arg0, arg1);
    }

    public entry fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg1);
        assert!(v1 > 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_NOTHING_TO_CLAIM());
        let v2 = &arg0.stakers;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<address>(v2)) {
            if (0x1::vector::borrow<address>(v2, v3) == &v0) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 9 */
                let (v5, v6) = if (0x1::option::is_some<u64>(&v4)) {
                    (true, 0x1::option::destroy_some<u64>(v4))
                } else {
                    (false, 0)
                };
                if (v5) {
                    let v7 = 0x1::vector::borrow_mut<Position>(&mut arg0.positions, v6);
                    v7.shares = v7.shares + v1;
                } else {
                    0x1::vector::push_back<address>(&mut arg0.stakers, v0);
                    let v8 = Position{
                        shares        : v1,
                        reward_snap   : arg0.reward_index,
                        entered_epoch : 0x2::tx_context::epoch(arg2),
                    };
                    0x1::vector::push_back<Position>(&mut arg0.positions, v8);
                };
                arg0.total_shares = arg0.total_shares + v1;
                0x2::coin::join<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&mut arg0.staked, arg1);
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    fun stakers_table_mut(arg0: &mut StakingPool) : &mut 0x2::table::Table<address, Position> {
        let v0 = PositionsKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PositionsKey, 0x2::table::Table<address, Position>>(&mut arg0.id, v0)
    }

    public entry fun sweep_all(arg0: &mut StakingPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin && arg1 == arg0.admin, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_UNAUTH());
        let v0 = 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg0.rewards);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(0x2::coin::split<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&mut arg0.rewards, v0, arg2), arg1);
        };
    }

    public entry fun unstake(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 > 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_NOTHING_TO_CLAIM());
        let v1 = &arg0.stakers;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<address>(v1)) {
            if (0x1::vector::borrow<address>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 8 */
                let (v4, v5) = if (0x1::option::is_some<u64>(&v3)) {
                    (true, 0x1::option::destroy_some<u64>(v3))
                } else {
                    (false, 0)
                };
                assert!(v4, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_NOTHING_TO_CLAIM());
                let v6 = 0x1::vector::borrow_mut<Position>(&mut arg0.positions, v5);
                assert!(v6.shares >= arg1, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_NOTHING_TO_CLAIM());
                v6.shares = v6.shares - arg1;
                arg0.total_shares = arg0.total_shares - arg1;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(0x2::coin::split<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&mut arg0.staked, arg1, arg2), v0);
                if ((arg1 as u128) * 100 >= (v6.shares as u128) * (90 as u128)) {
                    v6.entered_epoch = 0x2::tx_context::epoch(arg2);
                };
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 8 */
    }

    // decompiled from Move bytecode v6
}

