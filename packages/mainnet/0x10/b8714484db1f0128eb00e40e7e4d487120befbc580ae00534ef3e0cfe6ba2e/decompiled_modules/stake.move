module 0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake {
    struct StakePool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reward_per_sec: u64,
        accum_reward: u128,
        last_updated: u64,
        start_timestamp: u64,
        end_timestamp: u64,
        stakes: 0x2::table::Table<address, UserStake>,
        stake_coins: 0x2::coin::Coin<T0>,
        reward_coins: 0x2::coin::Coin<T1>,
        scale: u128,
        emergency_locked: bool,
        duration_unstake_time_sec: u64,
        max_stake: u64,
    }

    struct UserStake has store {
        amount: u64,
        unobtainable_reward: u128,
        earned_reward: u64,
        unlock_time: u64,
    }

    struct StakeEvent has copy, drop, store {
        pool_id: address,
        user_address: address,
        amount: u64,
        user_staked_amount: u64,
        accum_reward: u128,
        total_staked: u64,
        unlock_time_sec: u64,
        pool_last_updated_sec: u64,
        unobtainable_reward: u128,
        earned_reward: u64,
        unlock_time: u64,
    }

    struct UnstakeEvent has copy, drop, store {
        pool_id: address,
        user_address: address,
        amount: u64,
        user_staked_amount: u64,
        accum_reward: u128,
        total_staked: u64,
        pool_last_updated_sec: u64,
        unobtainable_reward: u128,
        earned_reward: u64,
        unlock_time: u64,
    }

    struct DepositRewardEvent has copy, drop, store {
        pool_id: address,
        user_address: address,
        amount: u64,
        new_end_timestamp: u64,
    }

    struct HarvestEvent has copy, drop, store {
        pool_id: address,
        user_address: address,
        amount: u64,
        staked_amount: u64,
        accum_reward: u128,
        total_staked: u64,
        pool_last_updated_sec: u64,
        unobtainable_reward: u128,
        earned_reward: u64,
        unlock_time: u64,
    }

    struct RegisterPoolEvent has copy, drop, store {
        pool_id: address,
        reward_per_sec: u64,
        last_updated: u64,
        start_timestamp: u64,
        end_timestamp: u64,
        reward_amount: u64,
    }

    public fun stake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::GlobalConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 105);
        assert!(!is_emergency_inner<T0, T1>(arg0, arg2), 109);
        assert!(!is_finished_inner<T0, T1>(arg0, arg3), 113);
        update_accum_reward<T0, T1>(arg0, arg3);
        let v1 = arg3 / 1000;
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = arg0.accum_reward;
        if (!0x2::table::contains<address, UserStake>(&arg0.stakes, v2)) {
            let v4 = UserStake{
                amount              : v0,
                unobtainable_reward : 0,
                earned_reward       : 0,
                unlock_time         : v1 + arg0.duration_unstake_time_sec,
            };
            v4.unobtainable_reward = v3 * (v0 as u128) / arg0.scale;
            0x2::table::add<address, UserStake>(&mut arg0.stakes, v2, v4);
        } else {
            let v5 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v2);
            update_user_earnings(v3, arg0.scale, v5);
            v5.amount = v5.amount + v0;
            v5.unobtainable_reward = v3 * user_stake_amount(v5) / arg0.scale;
            v5.unlock_time = v1 + arg0.duration_unstake_time_sec;
        };
        let v6 = 0x2::table::borrow<address, UserStake>(&mut arg0.stakes, v2);
        assert!(v6.amount <= arg0.max_stake, 124);
        0x2::coin::join<T0>(&mut arg0.stake_coins, arg1);
        let v7 = StakeEvent{
            pool_id               : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address          : v2,
            amount                : v0,
            user_staked_amount    : v6.amount,
            accum_reward          : arg0.accum_reward,
            total_staked          : 0x2::coin::value<T0>(&arg0.stake_coins),
            unlock_time_sec       : v1 + arg0.duration_unstake_time_sec,
            pool_last_updated_sec : arg0.last_updated,
            unobtainable_reward   : v6.unobtainable_reward,
            earned_reward         : v6.earned_reward,
            unlock_time           : v6.unlock_time,
        };
        0x2::event::emit<StakeEvent>(v7);
    }

    fun accum_rewards_since_last_updated<T0, T1>(arg0: &StakePool<T0, T1>, arg1: u64) : u128 {
        let v0 = arg1 - arg0.last_updated;
        if (v0 == 0) {
            return 0
        };
        let v1 = pool_total_staked<T0, T1>(arg0);
        if (v1 == 0) {
            return 0
        };
        (arg0.reward_per_sec as u128) * (v0 as u128) * arg0.scale / v1
    }

    public fun deposit_reward_coins<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::GlobalConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!is_emergency_inner<T0, T1>(arg0, arg2), 109);
        assert!(!is_finished_inner<T0, T1>(arg0, arg3), 113);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 105);
        let v1 = v0 / arg0.reward_per_sec;
        assert!(v1 > 0, 112);
        arg0.end_timestamp = arg0.end_timestamp + v1;
        0x2::coin::join<T1>(&mut arg0.reward_coins, arg1);
        let v2 = DepositRewardEvent{
            pool_id           : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address      : 0x2::tx_context::sender(arg4),
            amount            : v0,
            new_end_timestamp : arg0.end_timestamp,
        };
        0x2::event::emit<DepositRewardEvent>(v2);
    }

    public fun emergency_unstake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_emergency_inner<T0, T1>(arg0, arg1), 110);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, v0), 103);
        let UserStake {
            amount              : v1,
            unobtainable_reward : _,
            earned_reward       : _,
            unlock_time         : _,
        } = 0x2::table::remove<address, UserStake>(&mut arg0.stakes, v0);
        0x2::coin::split<T0>(&mut arg0.stake_coins, v1, arg2)
    }

    public fun enable_emergency<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::get_emergency_admin_address(arg1), 111);
        assert!(!is_emergency_inner<T0, T1>(arg0, arg1), 109);
        arg0.emergency_locked = true;
    }

    public fun get_end_timestamp<T0, T1>(arg0: &StakePool<T0, T1>) : u64 {
        arg0.end_timestamp
    }

    public fun get_pending_user_rewards<T0, T1>(arg0: &StakePool<T0, T1>, arg1: address, arg2: u64) : u64 {
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, arg1), 103);
        let v0 = 0x2::table::borrow<address, UserStake>(&arg0.stakes, arg1);
        v0.earned_reward + (user_earned_since_last_update(arg0.accum_reward + accum_rewards_since_last_updated<T0, T1>(arg0, get_time_for_last_update<T0, T1>(arg0, arg2)), arg0.scale, v0) as u64)
    }

    public fun get_pool_total_stake<T0, T1>(arg0: &StakePool<T0, T1>) : u64 {
        0x2::coin::value<T0>(&arg0.stake_coins)
    }

    public fun get_start_timestamp<T0, T1>(arg0: &StakePool<T0, T1>) : u64 {
        arg0.start_timestamp
    }

    fun get_time_for_last_update<T0, T1>(arg0: &StakePool<T0, T1>, arg1: u64) : u64 {
        0x2::math::min(arg0.end_timestamp, arg1 / 1000)
    }

    public fun get_unlock_time<T0, T1>(arg0: &StakePool<T0, T1>, arg1: address) : u64 {
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, arg1), 103);
        0x2::math::min(arg0.end_timestamp, 0x2::table::borrow<address, UserStake>(&arg0.stakes, arg1).unlock_time)
    }

    public fun get_user_stake<T0, T1>(arg0: &StakePool<T0, T1>, arg1: address) : u64 {
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, arg1), 103);
        0x2::table::borrow<address, UserStake>(&arg0.stakes, arg1).amount
    }

    public fun harvest<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!is_emergency_inner<T0, T1>(arg0, arg1), 109);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, v0), 103);
        update_accum_reward<T0, T1>(arg0, arg2);
        let v1 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v0);
        update_user_earnings(arg0.accum_reward, arg0.scale, v1);
        let v2 = v1.earned_reward;
        assert!(v2 > 0, 106);
        v1.earned_reward = 0;
        let v3 = HarvestEvent{
            pool_id               : 0x2::object::uid_to_address(&arg0.id),
            user_address          : v0,
            amount                : v2,
            staked_amount         : v1.amount,
            accum_reward          : arg0.accum_reward,
            total_staked          : 0x2::coin::value<T0>(&arg0.stake_coins),
            pool_last_updated_sec : arg0.last_updated,
            unobtainable_reward   : v1.unobtainable_reward,
            earned_reward         : v1.earned_reward,
            unlock_time           : v1.unlock_time,
        };
        0x2::event::emit<HarvestEvent>(v3);
        0x2::coin::split<T1>(&mut arg0.reward_coins, v2, arg3)
    }

    public fun is_emergency<T0, T1>(arg0: &StakePool<T0, T1>, arg1: &0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::GlobalConfig) : bool {
        is_emergency_inner<T0, T1>(arg0, arg1)
    }

    fun is_emergency_inner<T0, T1>(arg0: &StakePool<T0, T1>, arg1: &0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::GlobalConfig) : bool {
        arg0.emergency_locked || 0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::is_global_emergency(arg1)
    }

    public fun is_finished<T0, T1>(arg0: &StakePool<T0, T1>, arg1: u64) : bool {
        is_finished_inner<T0, T1>(arg0, arg1)
    }

    fun is_finished_inner<T0, T1>(arg0: &StakePool<T0, T1>, arg1: u64) : bool {
        arg1 / 1000 >= arg0.end_timestamp
    }

    public fun is_local_emergency<T0, T1>(arg0: &StakePool<T0, T1>) : bool {
        arg0.emergency_locked
    }

    public fun is_unlocked<T0, T1>(arg0: &StakePool<T0, T1>, arg1: address, arg2: u64) : bool {
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, arg1), 103);
        arg2 / 1000 >= 0x2::math::min(arg0.end_timestamp, 0x2::table::borrow<address, UserStake>(&arg0.stakes, arg1).unlock_time)
    }

    fun pool_total_staked<T0, T1>(arg0: &StakePool<T0, T1>) : u128 {
        (0x2::coin::value<T0>(&arg0.stake_coins) as u128)
    }

    public fun register_pool<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::GlobalConfig, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::is_global_emergency(arg2), 109);
        assert!(arg1 > 0, 112);
        let v0 = 0x2::coin::value<T1>(&arg0) / arg1;
        assert!(v0 > 0, 102);
        let v1 = arg5 / 1000;
        let v2 = v1 + arg1;
        let v3 = (arg4 as u128);
        assert!(v3 <= 10, 123);
        let v4 = StakePool<T0, T1>{
            id                        : 0x2::object::new(arg8),
            reward_per_sec            : v0,
            accum_reward              : 0,
            last_updated              : v1,
            start_timestamp           : v1,
            end_timestamp             : v2,
            stakes                    : 0x2::table::new<address, UserStake>(arg8),
            stake_coins               : 0x2::coin::zero<T0>(arg8),
            reward_coins              : arg0,
            scale                     : 0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::math128::pow(10, (arg3 as u128)) * 1000000000000 / 0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::math128::pow(10, v3),
            emergency_locked          : false,
            duration_unstake_time_sec : arg6 / 1000,
            max_stake                 : arg7,
        };
        let v5 = RegisterPoolEvent{
            pool_id         : 0x2::object::id_address<StakePool<T0, T1>>(&v4),
            reward_per_sec  : v0,
            last_updated    : v1,
            start_timestamp : v1,
            end_timestamp   : v2,
            reward_amount   : 0x2::coin::value<T1>(&arg0),
        };
        0x2::event::emit<RegisterPoolEvent>(v5);
        0x2::transfer::share_object<StakePool<T0, T1>>(v4);
    }

    public fun stake_exists<T0, T1>(arg0: &StakePool<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, UserStake>(&arg0.stakes, arg1)
    }

    public fun unstake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: u64, arg2: &0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::GlobalConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 105);
        assert!(!is_emergency_inner<T0, T1>(arg0, arg2), 109);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, v0), 103);
        update_accum_reward<T0, T1>(arg0, arg3);
        let v1 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v0);
        assert!(arg1 <= v1.amount, 104);
        let v2 = arg3 / 1000;
        if (arg0.end_timestamp >= v2) {
            assert!(v2 >= v1.unlock_time, 108);
        };
        update_user_earnings(arg0.accum_reward, arg0.scale, v1);
        v1.amount = v1.amount - arg1;
        v1.unobtainable_reward = arg0.accum_reward * user_stake_amount(v1) / arg0.scale;
        let v3 = UnstakeEvent{
            pool_id               : 0x2::object::uid_to_address(&arg0.id),
            user_address          : v0,
            amount                : arg1,
            user_staked_amount    : v1.amount,
            accum_reward          : arg0.accum_reward,
            total_staked          : 0x2::coin::value<T0>(&arg0.stake_coins),
            pool_last_updated_sec : arg0.last_updated,
            unobtainable_reward   : v1.unobtainable_reward,
            earned_reward         : v1.earned_reward,
            unlock_time           : v1.unlock_time,
        };
        0x2::event::emit<UnstakeEvent>(v3);
        0x2::coin::split<T0>(&mut arg0.stake_coins, arg1, arg4)
    }

    fun update_accum_reward<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: u64) {
        let v0 = get_time_for_last_update<T0, T1>(arg0, arg1);
        let v1 = accum_rewards_since_last_updated<T0, T1>(arg0, v0);
        arg0.last_updated = v0;
        if (v1 != 0) {
            arg0.accum_reward = arg0.accum_reward + v1;
        };
    }

    fun update_user_earnings(arg0: u128, arg1: u128, arg2: &mut UserStake) {
        let v0 = user_earned_since_last_update(arg0, arg1, arg2);
        arg2.earned_reward = arg2.earned_reward + (v0 as u64);
        arg2.unobtainable_reward = arg2.unobtainable_reward + v0;
    }

    fun user_earned_since_last_update(arg0: u128, arg1: u128, arg2: &UserStake) : u128 {
        arg0 * user_stake_amount(arg2) / arg1 - arg2.unobtainable_reward
    }

    fun user_stake_amount(arg0: &UserStake) : u128 {
        (arg0.amount as u128)
    }

    public fun withdraw_to_treasury<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: u64, arg2: &0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::GlobalConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::sender(arg4) == 0x10b8714484db1f0128eb00e40e7e4d487120befbc580ae00534ef3e0cfe6ba2e::stake_config::get_treasury_admin_address(arg2), 115);
        if (!is_emergency_inner<T0, T1>(arg0, arg2)) {
            assert!(arg3 / 1000 >= arg0.end_timestamp + 7257600, 114);
        };
        0x2::coin::split<T1>(&mut arg0.reward_coins, arg1, arg4)
    }

    // decompiled from Move bytecode v6
}

