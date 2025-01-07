module 0x9472afda3d6adfc9ec2fcf499d23f01f7ab8df20418edae9c0f00b44d35c93ae::farm {
    struct UserInfo has copy, drop, store {
        balance_of: u64,
        user_reward_per_token_paid: u64,
        pending_reward: u64,
        user_total_claimed_reward: u64,
    }

    struct PoolCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_cap_id: 0x2::object::ID,
        start_at: u64,
        end_at: u64,
        stake_coin_unit: u64,
        is_paused: bool,
        updated_at: u64,
        total_staked_balance: 0x2::balance::Balance<T0>,
        reward_start_at: u64,
        reward_per_second: u64,
        reward_per_token_stored: u64,
        total_reward_balance: 0x2::balance::Balance<T1>,
        userInfos: 0x2::table::Table<address, UserInfo>,
    }

    struct QueryDataEvent<phantom T0> has copy, drop {
        start_at: u64,
        end_at: u64,
        stake_coin_unit: u64,
        reward_coin_type_name: 0x1::type_name::TypeName,
        is_paused: bool,
        updated_at: u64,
        reward_per_second: u64,
        reward_per_token_stored: u64,
        total_staked_balance: u64,
        pool_cap_id: 0x2::object::ID,
        reward_start_at: u64,
        current_reward_balance: u64,
        user_total_claimed_reward: u64,
        user_staked_balance: u64,
        user_reward_per_token_paid: u64,
        user_pending_earned: u64,
        apr: u64,
        tvl: u64,
    }

    public entry fun add_reward_balance<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &PoolCap, arg2: u64, arg3: 0x2::coin::Coin<T1>) {
        only_admin<T0, T1>(arg0, arg1);
        arg0.reward_start_at = arg2;
        0x2::balance::join<T1>(&mut arg0.total_reward_balance, 0x2::coin::into_balance<T1>(arg3));
    }

    public entry fun create_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: &0x2::coin::CoinMetadata<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolCap{id: 0x2::object::new(arg6)};
        let v1 = Pool<T0, T1>{
            id                      : 0x2::object::new(arg6),
            pool_cap_id             : 0x2::object::uid_to_inner(&v0.id),
            start_at                : arg1,
            end_at                  : arg2,
            stake_coin_unit         : get_coin_unit<T0>(arg3),
            is_paused               : false,
            updated_at              : 0x2::clock::timestamp_ms(arg0),
            total_staked_balance    : 0x2::balance::zero<T0>(),
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
        0x9472afda3d6adfc9ec2fcf499d23f01f7ab8df20418edae9c0f00b44d35c93ae::math_extend::mul_div(arg1.balance_of, reward_per_token<T0, T1>(arg0, arg2) - arg1.user_reward_per_token_paid, arg0.stake_coin_unit) + arg1.pending_reward
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
        if (0x2::table::contains<address, UserInfo>(&arg0.userInfos, v0)) {
            let v5 = *0x2::table::borrow<address, UserInfo>(&arg0.userInfos, v0);
            v1 = v5.balance_of;
            v2 = v5.user_reward_per_token_paid;
            v3 = earned<T0, T1>(arg0, v5, 0x2::clock::timestamp_ms(arg1) / 1000);
            v4 = v5.user_total_claimed_reward;
        };
        let v6 = QueryDataEvent<T0>{
            start_at                   : arg0.start_at,
            end_at                     : arg0.end_at,
            stake_coin_unit            : arg0.stake_coin_unit,
            reward_coin_type_name      : 0x1::type_name::get<T1>(),
            is_paused                  : arg0.is_paused,
            updated_at                 : arg0.updated_at,
            reward_per_second          : arg0.reward_per_second,
            reward_per_token_stored    : arg0.reward_per_token_stored,
            total_staked_balance       : 0x2::balance::value<T0>(&arg0.total_staked_balance),
            pool_cap_id                : arg0.pool_cap_id,
            reward_start_at            : arg0.reward_start_at,
            current_reward_balance     : 0x2::balance::value<T1>(&arg0.total_reward_balance),
            user_total_claimed_reward  : v4,
            user_staked_balance        : v1,
            user_reward_per_token_paid : v2,
            user_pending_earned        : v3,
            apr                        : 0,
            tvl                        : 0,
        };
        0x2::event::emit<QueryDataEvent<T0>>(v6);
    }

    public entry fun get_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
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

    fun only_admin<T0, T1>(arg0: &Pool<T0, T1>, arg1: &PoolCap) {
        assert!(arg0.pool_cap_id == 0x2::object::uid_to_inner(&arg1.id), 1001);
    }

    fun only_not_paused<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(!arg0.is_paused, 1001);
    }

    fun reward_per_token<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.total_staked_balance);
        if (v0 == 0 || arg1 <= arg0.start_at) {
            arg0.reward_per_token_stored
        } else {
            ((0x9472afda3d6adfc9ec2fcf499d23f01f7ab8df20418edae9c0f00b44d35c93ae::math_extend::mul_to_u128(arg0.reward_per_second, last_time_reward_applicable<T0, T1>(arg0, arg1) - arg0.updated_at) * (arg0.stake_coin_unit as u128) / (v0 as u128) + (arg0.reward_per_token_stored as u128)) as u64)
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

    public entry fun stake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        only_not_paused<T0, T1>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1005);
        let v1 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, UserInfo>(&arg0.userInfos, v1)) {
            let v2 = UserInfo{
                balance_of                 : 0,
                user_reward_per_token_paid : 0,
                pending_reward             : 0,
                user_total_claimed_reward  : 0,
            };
            0x2::table::add<address, UserInfo>(&mut arg0.userInfos, v1, v2);
        };
        update_reward<T0, T1>(arg0, v1, 0x2::clock::timestamp_ms(arg1) / 1000);
        let v3 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.userInfos, v1);
        v3.balance_of = v3.balance_of + v0;
        0x2::balance::join<T0>(&mut arg0.total_staked_balance, 0x2::coin::into_balance<T0>(arg2));
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
        only_not_paused<T0, T1>(arg0);
        assert!(arg2 > 0, 1005);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::table::borrow<address, UserInfo>(&mut arg0.userInfos, v0);
        assert!(arg2 <= v1.balance_of, 1007);
        let v2 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (arg2 == v1.balance_of && v2 >= arg0.reward_start_at) {
            get_reward<T0, T1>(arg0, arg1, arg3);
        } else {
            update_reward<T0, T1>(arg0, v0, v2);
        };
        let v3 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.userInfos, v0);
        v3.balance_of = v3.balance_of - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.total_staked_balance, arg2, arg3), v0);
    }

    // decompiled from Move bytecode v6
}

