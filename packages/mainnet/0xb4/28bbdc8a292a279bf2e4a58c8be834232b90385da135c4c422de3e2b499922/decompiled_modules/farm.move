module 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::farm {
    struct Farm<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        farm_id: u64,
        stake_token: vector<u8>,
        reward_token: vector<u8>,
        total_staked: 0x2::balance::Balance<T0>,
        reward_pool: 0x2::balance::Balance<T1>,
        reward_rate: u64,
        reward_per_token_stored: u128,
        last_update_time: u64,
        start_time: u64,
        end_time: u64,
        is_active: bool,
        boost_multiplier: u64,
        min_stake_amount: u64,
        total_stakers: u64,
        owner: address,
    }

    struct StakePosition<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        position_id: u64,
        farm_id: u64,
        owner: address,
        staked_amount: u64,
        reward_per_token_paid: u128,
        pending_rewards: u64,
        staked_at: u64,
        last_harvest_at: u64,
        boost_level: u64,
    }

    struct FarmRegistry has key {
        id: 0x2::object::UID,
        farms: 0x2::table::Table<u64, 0x2::object::ID>,
        next_farm_id: u64,
        total_farms: u64,
        active_farms: u64,
    }

    struct PositionCounter has store, key {
        id: 0x2::object::UID,
        next_position_id: u64,
    }

    struct FarmCreated has copy, drop {
        farm_id: u64,
        stake_token: vector<u8>,
        reward_token: vector<u8>,
        reward_rate: u64,
        start_time: u64,
        end_time: u64,
        owner: address,
    }

    struct Staked has copy, drop {
        farm_id: u64,
        position_id: u64,
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct Unstaked has copy, drop {
        farm_id: u64,
        position_id: u64,
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct RewardHarvested has copy, drop {
        farm_id: u64,
        position_id: u64,
        user: address,
        reward_amount: u64,
        timestamp: u64,
    }

    struct FarmUpdated has copy, drop {
        farm_id: u64,
        new_reward_rate: u64,
        new_end_time: u64,
    }

    public entry fun add_rewards<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 4);
        update_reward<T0, T1>(arg0, arg2);
        0x2::coin::value<T1>(&arg1);
        0x2::balance::join<T1>(&mut arg0.reward_pool, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun calculate_apr<T0, T1>(arg0: &Farm<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.total_staked);
        if (v0 == 0) {
            return 0
        };
        (((arg0.reward_rate as u128) * (31536000 as u128) * 10000 / (v0 as u128)) as u64)
    }

    fun calculate_earned<T0, T1>(arg0: &StakePosition<T0, T1>, arg1: &Farm<T0, T1>) : u64 {
        let v0 = if (arg0.boost_level > 0) {
            ((arg0.staked_amount as u128) * (arg1.reward_per_token_stored - arg0.reward_per_token_paid) >> 64) * (arg1.boost_multiplier as u128) / 100
        } else {
            (arg0.staked_amount as u128) * (arg1.reward_per_token_stored - arg0.reward_per_token_paid) >> 64
        };
        (v0 as u64)
    }

    public entry fun create_farm<T0, T1>(arg0: &mut FarmRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 5);
        assert!(arg6 > arg5, 5);
        assert!(0x2::coin::value<T1>(&arg3) > 0, 6);
        let v0 = arg0.next_farm_id;
        let v1 = 0x2::object::new(arg9);
        let v2 = Farm<T0, T1>{
            id                      : v1,
            farm_id                 : v0,
            stake_token             : arg1,
            reward_token            : arg2,
            total_staked            : 0x2::balance::zero<T0>(),
            reward_pool             : 0x2::coin::into_balance<T1>(arg3),
            reward_rate             : arg4,
            reward_per_token_stored : 0,
            last_update_time        : arg5,
            start_time              : arg5,
            end_time                : arg6,
            is_active               : true,
            boost_multiplier        : arg7,
            min_stake_amount        : arg8,
            total_stakers           : 0,
            owner                   : 0x2::tx_context::sender(arg9),
        };
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.farms, v0, 0x2::object::uid_to_inner(&v1));
        arg0.next_farm_id = arg0.next_farm_id + 1;
        arg0.total_farms = arg0.total_farms + 1;
        arg0.active_farms = arg0.active_farms + 1;
        let v3 = FarmCreated{
            farm_id      : v0,
            stake_token  : arg1,
            reward_token : arg2,
            reward_rate  : arg4,
            start_time   : arg5,
            end_time     : arg6,
            owner        : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<FarmCreated>(v3);
        0x2::transfer::share_object<Farm<T0, T1>>(v2);
        let v4 = PositionCounter{
            id               : 0x2::object::new(arg9),
            next_position_id : 1,
        };
        0x2::transfer::share_object<PositionCounter>(v4);
    }

    public entry fun deactivate_farm<T0, T1>(arg0: &mut FarmRegistry, arg1: &mut Farm<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 4);
        arg1.is_active = false;
        arg0.active_farms = arg0.active_farms - 1;
    }

    public fun get_farm_state<T0, T1>(arg0: &Farm<T0, T1>) : (u64, u64, u64, u64, u64, bool) {
        (arg0.farm_id, 0x2::balance::value<T0>(&arg0.total_staked), 0x2::balance::value<T1>(&arg0.reward_pool), arg0.reward_rate, arg0.total_stakers, arg0.is_active)
    }

    public fun get_pending_rewards<T0, T1>(arg0: &StakePosition<T0, T1>, arg1: &Farm<T0, T1>, arg2: u64) : u64 {
        arg0.pending_rewards + (((arg0.staked_amount as u128) * (reward_per_token<T0, T1>(arg1, arg2) - arg0.reward_per_token_paid) >> 64) as u64)
    }

    public fun get_position_info<T0, T1>(arg0: &StakePosition<T0, T1>) : (u64, u64, u64, u64, u64) {
        (arg0.position_id, arg0.farm_id, arg0.staked_amount, arg0.pending_rewards, arg0.staked_at)
    }

    public fun harvest<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut StakePosition<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 4);
        update_reward<T0, T1>(arg0, arg2);
        let v0 = arg1.pending_rewards + calculate_earned<T0, T1>(arg1, arg0);
        assert!(v0 > 0, 6);
        arg1.reward_per_token_paid = arg0.reward_per_token_stored;
        arg1.pending_rewards = 0;
        arg1.last_harvest_at = arg2;
        let v1 = RewardHarvested{
            farm_id       : arg0.farm_id,
            position_id   : arg1.position_id,
            user          : arg1.owner,
            reward_amount : v0,
            timestamp     : arg2,
        };
        0x2::event::emit<RewardHarvested>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_pool, v0), arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FarmRegistry{
            id           : 0x2::object::new(arg0),
            farms        : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            next_farm_id : 1,
            total_farms  : 0,
            active_farms : 0,
        };
        0x2::transfer::share_object<FarmRegistry>(v0);
    }

    fun reward_per_token<T0, T1>(arg0: &Farm<T0, T1>, arg1: u64) : u128 {
        let v0 = 0x2::balance::value<T0>(&arg0.total_staked);
        if (v0 == 0) {
            return arg0.reward_per_token_stored
        };
        let v1 = if (arg1 < arg0.end_time) {
            arg1
        } else {
            arg0.end_time
        };
        if (v1 <= arg0.last_update_time) {
            return arg0.reward_per_token_stored
        };
        arg0.reward_per_token_stored + ((v1 - arg0.last_update_time) as u128) * (arg0.reward_rate as u128) * 18446744073709551616 / (v0 as u128)
    }

    public fun stake<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut PositionCounter, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : StakePosition<T0, T1> {
        assert!(arg0.is_active, 3);
        assert!(arg3 >= arg0.start_time, 3);
        assert!(arg3 < arg0.end_time, 7);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg0.min_stake_amount, 1);
        update_reward<T0, T1>(arg0, arg3);
        0x2::balance::join<T0>(&mut arg0.total_staked, 0x2::coin::into_balance<T0>(arg2));
        let v1 = arg1.next_position_id;
        arg1.next_position_id = arg1.next_position_id + 1;
        arg0.total_stakers = arg0.total_stakers + 1;
        let v2 = StakePosition<T0, T1>{
            id                    : 0x2::object::new(arg4),
            position_id           : v1,
            farm_id               : arg0.farm_id,
            owner                 : 0x2::tx_context::sender(arg4),
            staked_amount         : v0,
            reward_per_token_paid : arg0.reward_per_token_stored,
            pending_rewards       : 0,
            staked_at             : arg3,
            last_harvest_at       : arg3,
            boost_level           : 0,
        };
        let v3 = Staked{
            farm_id     : arg0.farm_id,
            position_id : v1,
            user        : 0x2::tx_context::sender(arg4),
            amount      : v0,
            timestamp   : arg3,
        };
        0x2::event::emit<Staked>(v3);
        v2
    }

    public fun unstake<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: StakePosition<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 4);
        update_reward<T0, T1>(arg0, arg2);
        let v0 = arg1.pending_rewards + calculate_earned<T0, T1>(&arg1, arg0);
        let StakePosition {
            id                    : v1,
            position_id           : v2,
            farm_id               : _,
            owner                 : v4,
            staked_amount         : v5,
            reward_per_token_paid : _,
            pending_rewards       : _,
            staked_at             : _,
            last_harvest_at       : _,
            boost_level           : _,
        } = arg1;
        let v11 = if (v0 > 0) {
            0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_pool, v0), arg3)
        } else {
            0x2::coin::zero<T1>(arg3)
        };
        arg0.total_stakers = arg0.total_stakers - 1;
        let v12 = Unstaked{
            farm_id     : arg0.farm_id,
            position_id : v2,
            user        : v4,
            amount      : v5,
            timestamp   : arg2,
        };
        0x2::event::emit<Unstaked>(v12);
        if (v0 > 0) {
            let v13 = RewardHarvested{
                farm_id       : arg0.farm_id,
                position_id   : v2,
                user          : v4,
                reward_amount : v0,
                timestamp     : arg2,
            };
            0x2::event::emit<RewardHarvested>(v13);
        };
        0x2::object::delete(v1);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, v5), arg3), v11)
    }

    public entry fun update_farm<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 4);
        update_reward<T0, T1>(arg0, arg3);
        arg0.reward_rate = arg1;
        arg0.end_time = arg2;
        let v0 = FarmUpdated{
            farm_id         : arg0.farm_id,
            new_reward_rate : arg1,
            new_end_time    : arg2,
        };
        0x2::event::emit<FarmUpdated>(v0);
    }

    fun update_reward<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: u64) {
        arg0.reward_per_token_stored = reward_per_token<T0, T1>(arg0, arg1);
        let v0 = if (arg1 < arg0.end_time) {
            arg1
        } else {
            arg0.end_time
        };
        arg0.last_update_time = v0;
    }

    // decompiled from Move bytecode v6
}

