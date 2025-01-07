module 0x713970501171e9d23d58857a59660bc6f91cc44919f313df581c3e83cca5d8c6::farm {
    struct UserInfo has copy, drop, store {
        ve_balance_of: u128,
        user_reward_per_token_paid: u64,
        pending_reward: u64,
        user_total_claimed_reward: u64,
        locked_amount: u64,
        unlock_at: u64,
    }

    struct PoolCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        current_version: u64,
        pool_cap_id: 0x2::object::ID,
        start_at: u64,
        end_at: u64,
        stake_coin_unit: u64,
        is_paused: bool,
        updated_at: u64,
        total_staked_balance: 0x2::balance::Balance<T0>,
        total_ve_amount: u128,
        reward_start_at: u64,
        reward_per_second: u64,
        reward_per_token_stored: u64,
        total_reward_balance: 0x2::balance::Balance<T1>,
        userInfos: 0x2::table::Table<address, UserInfo>,
    }

    struct QueryDataEvent<phantom T0> has copy, drop {
        max_allowed_upgrade_version: u64,
        current_version: u64,
        start_at: u64,
        end_at: u64,
        stake_coin_unit: u64,
        reward_coin_type_name: 0x1::type_name::TypeName,
        is_paused: bool,
        updated_at: u64,
        reward_per_second: u64,
        reward_per_token_stored: u64,
        total_staked_balance: u64,
        total_ve_amount: u128,
        pool_cap_id: 0x2::object::ID,
        reward_start_at: u64,
        current_reward_balance: u64,
        user_total_claimed_reward: u64,
        user_locked_amount: u64,
        user_ve_amount: u128,
        user_reward_per_token_paid: u64,
        user_pending_earned: u64,
        user_unlock_at: u64,
        apr: u64,
        tvl: u64,
    }

    public entry fun add_reward_balance<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &PoolCap, arg2: u64, arg3: 0x2::coin::Coin<T1>) {
        only_admin<T0, T1>(arg0, arg1);
        arg0.reward_start_at = arg2;
        0x2::balance::join<T1>(&mut arg0.total_reward_balance, 0x2::coin::into_balance<T1>(arg3));
    }

    public entry fun create_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: &0x2::coin::CoinMetadata<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        create_pool_with_unit<T0, T1>(arg0, arg1, arg2, get_coin_unit<T0>(arg3), arg4, arg5, arg6);
    }

    public entry fun create_pool_with_unit<T0, T1>(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 1, 1015);
        let v0 = PoolCap{id: 0x2::object::new(arg6)};
        let v1 = Pool<T0, T1>{
            id                      : 0x2::object::new(arg6),
            current_version         : 0,
            pool_cap_id             : 0x2::object::uid_to_inner(&v0.id),
            start_at                : arg1,
            end_at                  : arg2,
            stake_coin_unit         : arg3,
            is_paused               : false,
            updated_at              : 0x2::clock::timestamp_ms(arg0),
            total_staked_balance    : 0x2::balance::zero<T0>(),
            total_ve_amount         : 0,
            reward_start_at         : arg5,
            reward_per_second       : arg4 / 86400,
            reward_per_token_stored : 0,
            total_reward_balance    : 0x2::balance::zero<T1>(),
            userInfos               : 0x2::table::new<address, UserInfo>(arg6),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
        0x2::transfer::transfer<PoolCap>(v0, 0x2::tx_context::sender(arg6));
    }

    fun earned<T0, T1>(arg0: &Pool<T0, T1>, arg1: UserInfo, arg2: u64) : u64 {
        0x713970501171e9d23d58857a59660bc6f91cc44919f313df581c3e83cca5d8c6::math_extend::mul_div((arg1.ve_balance_of as u64), reward_per_token<T0, T1>(arg0, arg2) - arg1.user_reward_per_token_paid, arg0.stake_coin_unit) + arg1.pending_reward
    }

    public fun get_coin_unit<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < 0x2::coin::get_decimals<T0>(arg0)) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_pool_data<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        if (0x2::table::contains<address, UserInfo>(&arg0.userInfos, v0)) {
            let v7 = *0x2::table::borrow<address, UserInfo>(&arg0.userInfos, v0);
            v1 = v7.locked_amount;
            v5 = v7.ve_balance_of;
            v2 = v7.user_reward_per_token_paid;
            v3 = earned<T0, T1>(arg0, v7, 0x2::clock::timestamp_ms(arg1) / 1000);
            v4 = v7.user_total_claimed_reward;
            v6 = v7.unlock_at;
        };
        let v8 = QueryDataEvent<T0>{
            max_allowed_upgrade_version : 1,
            current_version             : arg0.current_version,
            start_at                    : arg0.start_at,
            end_at                      : arg0.end_at,
            stake_coin_unit             : arg0.stake_coin_unit,
            reward_coin_type_name       : 0x1::type_name::get<T1>(),
            is_paused                   : arg0.is_paused,
            updated_at                  : arg0.updated_at,
            reward_per_second           : arg0.reward_per_second,
            reward_per_token_stored     : arg0.reward_per_token_stored,
            total_staked_balance        : 0x2::balance::value<T0>(&arg0.total_staked_balance),
            total_ve_amount             : arg0.total_ve_amount,
            pool_cap_id                 : arg0.pool_cap_id,
            reward_start_at             : arg0.reward_start_at,
            current_reward_balance      : 0x2::balance::value<T1>(&arg0.total_reward_balance),
            user_total_claimed_reward   : v4,
            user_locked_amount          : v1,
            user_ve_amount              : v5,
            user_reward_per_token_paid  : v2,
            user_pending_earned         : v3,
            user_unlock_at              : v6,
            apr                         : 0,
            tvl                         : 0,
        };
        0x2::event::emit<QueryDataEvent<T0>>(v8);
    }

    public entry fun get_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        only_allowed_version<T0, T1>(arg0);
        only_not_paused<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v1 >= arg0.reward_start_at, 1009);
        update_reward<T0, T1>(arg0, v0, v1);
        let v2 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.userInfos, v0);
        assert!(v2.pending_reward > 0, 1010);
        assert!(0x2::balance::value<T1>(&arg0.total_reward_balance) >= v2.pending_reward, 1011);
        v2.user_total_claimed_reward = v2.user_total_claimed_reward + v2.pending_reward;
        v2.pending_reward = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.total_reward_balance, v2.pending_reward, arg2), v0);
    }

    public fun has_exsits<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, UserInfo>(&arg0.userInfos, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    fun last_time_reward_applicable<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        if (arg1 < arg0.start_at) {
            arg0.start_at
        } else {
            0x2::math::min(arg1, arg0.end_at)
        }
    }

    public entry fun lock_stake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        only_allowed_version<T0, T1>(arg0);
        only_not_paused<T0, T1>(arg0);
        assert!(arg3 <= 2592000 * 24 + 100, 1014);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 1005);
        let v2 = 0x2::tx_context::sender(arg4);
        if (!0x2::table::contains<address, UserInfo>(&arg0.userInfos, v2)) {
            let v3 = UserInfo{
                ve_balance_of              : 0,
                user_reward_per_token_paid : 0,
                pending_reward             : 0,
                user_total_claimed_reward  : 0,
                locked_amount              : 0,
                unlock_at                  : 0,
            };
            0x2::table::add<address, UserInfo>(&mut arg0.userInfos, v2, v3);
        };
        update_reward<T0, T1>(arg0, v2, v0);
        let v4 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.userInfos, v2);
        if (v4.unlock_at < v0) {
            v4.unlock_at = v0;
        };
        v4.unlock_at = v4.unlock_at + arg3;
        assert!(v4.unlock_at - v0 <= 2592000 * 24 + 100, 1014);
        let v5 = 0x713970501171e9d23d58857a59660bc6f91cc44919f313df581c3e83cca5d8c6::math_extend::mul_div_to_u128(v1, v4.unlock_at - v0, 2592000);
        v4.ve_balance_of = v4.ve_balance_of + v5;
        v4.locked_amount = v4.locked_amount + v1;
        arg0.total_ve_amount = arg0.total_ve_amount + v5;
        0x2::balance::join<T0>(&mut arg0.total_staked_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    fun only_admin<T0, T1>(arg0: &Pool<T0, T1>, arg1: &PoolCap) {
        assert!(arg0.pool_cap_id == 0x2::object::uid_to_inner(&arg1.id), 1001);
    }

    fun only_allowed_version<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(arg0.current_version <= 1, 1000);
    }

    fun only_not_paused<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(!arg0.is_paused, 1001);
    }

    fun reward_per_token<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = arg0.total_ve_amount;
        if (v0 == 0 || arg1 <= arg0.start_at) {
            arg0.reward_per_token_stored
        } else {
            ((0x713970501171e9d23d58857a59660bc6f91cc44919f313df581c3e83cca5d8c6::math_extend::mul_to_u128(arg0.reward_per_second, last_time_reward_applicable<T0, T1>(arg0, arg1) - arg0.updated_at) * (arg0.stake_coin_unit as u128) / v0 + (arg0.reward_per_token_stored as u128)) as u64)
        }
    }

    public entry fun set_paused<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &PoolCap, arg2: bool) {
        only_admin<T0, T1>(arg0, arg1);
        arg0.is_paused = arg2;
    }

    public entry fun set_time<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &PoolCap, arg2: u64, arg3: u64, arg4: u64) {
        only_admin<T0, T1>(arg0, arg1);
        arg0.start_at = arg2;
        arg0.end_at = arg3;
        arg0.reward_start_at = arg4;
    }

    public entry fun set_version<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &PoolCap, arg2: u64) {
        only_admin<T0, T1>(arg0, arg1);
        arg0.current_version = arg2;
    }

    fun update_pool_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.reward_per_token_stored = reward_per_token<T0, T1>(arg0, arg1);
        arg0.updated_at = last_time_reward_applicable<T0, T1>(arg0, arg1);
    }

    fun update_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: address, arg2: u64) {
        update_pool_reward<T0, T1>(arg0, arg2);
        let v0 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.userInfos, arg1);
        v0.pending_reward = earned<T0, T1>(arg0, *0x2::table::borrow<address, UserInfo>(&arg0.userInfos, arg1), arg2);
        v0.user_reward_per_token_paid = arg0.reward_per_token_stored;
    }

    public entry fun update_reward_rate<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &PoolCap, arg2: &0x2::clock::Clock, arg3: u64) {
        only_admin<T0, T1>(arg0, arg1);
        update_pool_reward<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg2) / 1000);
        arg0.reward_per_second = arg3 / 86400;
    }

    public entry fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        only_allowed_version<T0, T1>(arg0);
        only_not_paused<T0, T1>(arg0);
        assert!(arg2 > 0, 1005);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::table::borrow<address, UserInfo>(&mut arg0.userInfos, v0);
        assert!(arg2 <= v1.locked_amount, 1007);
        let v2 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v2 >= v1.unlock_at, 1013);
        if (arg2 == v1.locked_amount && v2 >= arg0.reward_start_at) {
            get_reward<T0, T1>(arg0, arg1, arg3);
        } else {
            update_reward<T0, T1>(arg0, v0, v2);
        };
        let v3 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.userInfos, v0);
        v3.locked_amount = v3.locked_amount - arg2;
        let v4 = if (v3.unlock_at <= v2) {
            0
        } else {
            0x713970501171e9d23d58857a59660bc6f91cc44919f313df581c3e83cca5d8c6::math_extend::mul_div_to_u128(v3.locked_amount, v3.unlock_at - v2, 2592000)
        };
        v3.ve_balance_of = v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.total_staked_balance, arg2, arg3), v0);
    }

    // decompiled from Move bytecode v6
}

