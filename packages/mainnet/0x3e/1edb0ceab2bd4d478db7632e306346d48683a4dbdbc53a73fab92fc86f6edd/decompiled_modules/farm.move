module 0xc6b5f087beaee003d909fff9e3e02b12c8b3c90e9fda2e9271ca98941186aac4::farm {
    struct FarmRegistry has key {
        id: 0x2::object::UID,
        active_until: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    struct Farm<phantom T0> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        creator: address,
        coin_type: 0x1::ascii::String,
        reward_rate: u64,
        reward_supply: u64,
        rewards_remaining: 0x2::balance::Balance<T0>,
        staked: 0x2::balance::Balance<T0>,
        start_ms: u64,
        end_ms: u64,
        last_update_ms: u64,
        total_distributed: u64,
        acc_reward_per_share: u256,
        total_staked: u64,
        closed: bool,
    }

    struct Position<phantom T0> has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        stake: u64,
        reward_debt: u256,
        pending: u64,
    }

    struct FarmCreated has copy, drop {
        farm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        creator: address,
        coin_type: 0x1::ascii::String,
        reward_supply: u64,
        reward_rate: u64,
        start_ms: u64,
        end_ms: u64,
    }

    struct FarmStaked has copy, drop {
        farm_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        staker: address,
        amount: u64,
        total_staked_after: u64,
    }

    struct FarmUnstaked has copy, drop {
        farm_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        staker: address,
        amount: u64,
        total_staked_after: u64,
    }

    struct FarmRewardsClaimed has copy, drop {
        farm_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        staker: address,
        amount: u64,
    }

    struct FarmClosed has copy, drop {
        farm_id: 0x2::object::ID,
        leftover_to_treasury: u64,
    }

    struct FarmFunded has copy, drop {
        farm_id: 0x2::object::ID,
        amount: u64,
        funder: address,
        reward_supply_after: u64,
    }

    public fun claim_rewards<T0>(arg0: &mut Farm<T0>, arg1: &mut Position<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.farm_id == 0x2::object::id<Farm<T0>>(arg0), 4);
        update_farm<T0>(arg0, arg2);
        let v0 = pending_for<T0>(arg0, arg1);
        assert!(v0 > 0, 0);
        arg1.pending = 0;
        arg1.reward_debt = (arg1.stake as u256) * arg0.acc_reward_per_share / 1000000000000;
        let v1 = 0x2::balance::value<T0>(&arg0.rewards_remaining);
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        let v3 = FarmRewardsClaimed{
            farm_id     : 0x2::object::id<Farm<T0>>(arg0),
            position_id : 0x2::object::id<Position<T0>>(arg1),
            staker      : 0x2::tx_context::sender(arg3),
            amount      : v2,
        };
        0x2::event::emit<FarmRewardsClaimed>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards_remaining, v2), arg3)
    }

    public fun close_position<T0>(arg0: &mut Farm<T0>, arg1: Position<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg1.farm_id == 0x2::object::id<Farm<T0>>(arg0), 4);
        update_farm<T0>(arg0, arg2);
        let v0 = pending_for<T0>(arg0, &arg1);
        let Position {
            id          : v1,
            farm_id     : _,
            stake       : v3,
            reward_debt : _,
            pending     : _,
        } = arg1;
        let v6 = v1;
        let v7 = 0x2::object::uid_to_inner(&v6);
        arg0.total_staked = arg0.total_staked - v3;
        let v8 = 0x2::balance::value<T0>(&arg0.rewards_remaining);
        let v9 = if (v0 > v8) {
            v8
        } else {
            v0
        };
        0x2::object::delete(v6);
        let v10 = FarmUnstaked{
            farm_id            : 0x2::object::id<Farm<T0>>(arg0),
            position_id        : v7,
            staker             : 0x2::tx_context::sender(arg3),
            amount             : v3,
            total_staked_after : arg0.total_staked,
        };
        0x2::event::emit<FarmUnstaked>(v10);
        let v11 = FarmRewardsClaimed{
            farm_id     : 0x2::object::id<Farm<T0>>(arg0),
            position_id : v7,
            staker      : 0x2::tx_context::sender(arg3),
            amount      : v9,
        };
        0x2::event::emit<FarmRewardsClaimed>(v11);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staked, v3), arg3), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards_remaining, v9), arg3))
    }

    public fun create_farm<T0>(arg0: &mut FarmRegistry, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.active_until, v2)) {
            assert!(v1 >= *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.active_until, v2), 1);
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.active_until, v2);
        };
        let v3 = 18446744073709551615;
        let v4 = 0;
        let v5 = Farm<T0>{
            id                   : 0x2::object::new(arg4),
            pool_id              : arg1,
            creator              : 0x2::tx_context::sender(arg4),
            coin_type            : 0x1::type_name::into_string(v2),
            reward_rate          : v4,
            reward_supply        : v0,
            rewards_remaining    : 0x2::coin::into_balance<T0>(arg2),
            staked               : 0x2::balance::zero<T0>(),
            start_ms             : v1,
            end_ms               : v3,
            last_update_ms       : v1,
            total_distributed    : 0,
            acc_reward_per_share : 0,
            total_staked         : 0,
            closed               : false,
        };
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.active_until, v2, v3);
        let v6 = FarmCreated{
            farm_id       : 0x2::object::id<Farm<T0>>(&v5),
            pool_id       : arg1,
            creator       : v5.creator,
            coin_type     : v5.coin_type,
            reward_supply : v0,
            reward_rate   : v4,
            start_ms      : v1,
            end_ms        : v3,
        };
        0x2::event::emit<FarmCreated>(v6);
        0x2::transfer::share_object<Farm<T0>>(v5);
    }

    public fun end_farm<T0>(arg0: &mut Farm<T0>, arg1: &0xc6b5f087beaee003d909fff9e3e02b12c8b3c90e9fda2e9271ca98941186aac4::launchpad::LaunchpadConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 6
    }

    public fun end_ms<T0>(arg0: &Farm<T0>) : u64 {
        arg0.end_ms
    }

    public fun farm_id_of<T0>(arg0: &Position<T0>) : 0x2::object::ID {
        arg0.farm_id
    }

    public fun fund_farm<T0>(arg0: &mut Farm<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        0x2::balance::join<T0>(&mut arg0.rewards_remaining, 0x2::coin::into_balance<T0>(arg1));
        arg0.reward_supply = arg0.reward_supply + v0;
        let v1 = FarmFunded{
            farm_id             : 0x2::object::id<Farm<T0>>(arg0),
            amount              : v0,
            funder              : 0x2::tx_context::sender(arg2),
            reward_supply_after : arg0.reward_supply,
        };
        0x2::event::emit<FarmFunded>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FarmRegistry{
            id           : 0x2::object::new(arg0),
            active_until : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
        };
        0x2::transfer::share_object<FarmRegistry>(v0);
    }

    public fun is_ended<T0>(arg0: &Farm<T0>, arg1: &0x2::clock::Clock) : bool {
        false
    }

    fun pending_for<T0>(arg0: &Farm<T0>, arg1: &Position<T0>) : u64 {
        let v0 = (arg1.stake as u256) * arg0.acc_reward_per_share / 1000000000000;
        let v1 = if (v0 > arg1.reward_debt) {
            ((v0 - arg1.reward_debt) as u64)
        } else {
            0
        };
        arg1.pending + v1
    }

    public fun pending_rewards<T0>(arg0: &Farm<T0>, arg1: &Position<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = if (arg0.reward_supply > arg0.total_distributed) {
            arg0.reward_supply - arg0.total_distributed
        } else {
            0
        };
        let v2 = if (v0 > arg0.last_update_ms) {
            if (arg0.total_staked > 0) {
                v1 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v3 = if (v2) {
            let v4 = (v1 as u256) * (133687034 as u256) * ((v0 - arg0.last_update_ms) as u256) / 1000000000000000000;
            let v5 = if (v4 > (v1 as u256)) {
                v1
            } else {
                (v4 as u64)
            };
            arg0.acc_reward_per_share + (v5 as u256) * 1000000000000 / (arg0.total_staked as u256)
        } else {
            arg0.acc_reward_per_share
        };
        let v6 = (arg1.stake as u256) * v3 / 1000000000000;
        let v7 = if (v6 > arg1.reward_debt) {
            ((v6 - arg1.reward_debt) as u64)
        } else {
            0
        };
        arg1.pending + v7
    }

    public fun reward_rate<T0>(arg0: &Farm<T0>) : u64 {
        arg0.reward_rate
    }

    public fun reward_supply<T0>(arg0: &Farm<T0>) : u64 {
        arg0.reward_supply
    }

    public fun rewards_remaining<T0>(arg0: &Farm<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rewards_remaining)
    }

    public fun stake<T0>(arg0: &mut Farm<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Position<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        update_farm<T0>(arg0, arg2);
        arg0.total_staked = arg0.total_staked + v0;
        0x2::balance::join<T0>(&mut arg0.staked, 0x2::coin::into_balance<T0>(arg1));
        let v1 = Position<T0>{
            id          : 0x2::object::new(arg3),
            farm_id     : 0x2::object::id<Farm<T0>>(arg0),
            stake       : v0,
            reward_debt : (v0 as u256) * arg0.acc_reward_per_share / 1000000000000,
            pending     : 0,
        };
        let v2 = FarmStaked{
            farm_id            : 0x2::object::id<Farm<T0>>(arg0),
            position_id        : 0x2::object::id<Position<T0>>(&v1),
            staker             : 0x2::tx_context::sender(arg3),
            amount             : v0,
            total_staked_after : arg0.total_staked,
        };
        0x2::event::emit<FarmStaked>(v2);
        v1
    }

    public fun stake_more<T0>(arg0: &mut Farm<T0>, arg1: &mut Position<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.farm_id == 0x2::object::id<Farm<T0>>(arg0), 4);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0);
        update_farm<T0>(arg0, arg3);
        arg1.pending = pending_for<T0>(arg0, arg1);
        arg1.stake = arg1.stake + v0;
        arg1.reward_debt = (arg1.stake as u256) * arg0.acc_reward_per_share / 1000000000000;
        arg0.total_staked = arg0.total_staked + v0;
        0x2::balance::join<T0>(&mut arg0.staked, 0x2::coin::into_balance<T0>(arg2));
        let v1 = FarmStaked{
            farm_id            : 0x2::object::id<Farm<T0>>(arg0),
            position_id        : 0x2::object::id<Position<T0>>(arg1),
            staker             : 0x2::tx_context::sender(arg4),
            amount             : v0,
            total_staked_after : arg0.total_staked,
        };
        0x2::event::emit<FarmStaked>(v1);
    }

    public fun stake_of<T0>(arg0: &Position<T0>) : u64 {
        arg0.stake
    }

    public fun start_ms<T0>(arg0: &Farm<T0>) : u64 {
        arg0.start_ms
    }

    public fun total_staked<T0>(arg0: &Farm<T0>) : u64 {
        arg0.total_staked
    }

    public fun unstake<T0>(arg0: &mut Farm<T0>, arg1: &mut Position<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.farm_id == 0x2::object::id<Farm<T0>>(arg0), 4);
        assert!(arg2 > 0, 0);
        assert!(arg2 <= arg1.stake, 5);
        update_farm<T0>(arg0, arg3);
        arg1.pending = pending_for<T0>(arg0, arg1);
        arg1.stake = arg1.stake - arg2;
        arg1.reward_debt = (arg1.stake as u256) * arg0.acc_reward_per_share / 1000000000000;
        arg0.total_staked = arg0.total_staked - arg2;
        let v0 = FarmUnstaked{
            farm_id            : 0x2::object::id<Farm<T0>>(arg0),
            position_id        : 0x2::object::id<Position<T0>>(arg1),
            staker             : 0x2::tx_context::sender(arg4),
            amount             : arg2,
            total_staked_after : arg0.total_staked,
        };
        0x2::event::emit<FarmUnstaked>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staked, arg2), arg4)
    }

    fun update_farm<T0>(arg0: &mut Farm<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 <= arg0.last_update_ms) {
            return
        };
        let v1 = if (arg0.reward_supply > arg0.total_distributed) {
            arg0.reward_supply - arg0.total_distributed
        } else {
            0
        };
        if (arg0.total_staked > 0 && v1 > 0) {
            let v2 = (v1 as u256) * (133687034 as u256) * ((v0 - arg0.last_update_ms) as u256) / 1000000000000000000;
            let v3 = if (v2 > (v1 as u256)) {
                v1
            } else {
                (v2 as u64)
            };
            if (v3 > 0) {
                arg0.acc_reward_per_share = arg0.acc_reward_per_share + (v3 as u256) * 1000000000000 / (arg0.total_staked as u256);
                arg0.total_distributed = arg0.total_distributed + v3;
            };
        };
        arg0.last_update_ms = v0;
    }

    // decompiled from Move bytecode v7
}

