module 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::stake {
    struct STAKE has drop {
        dummy_field: bool,
    }

    struct StakeOwnerCap has key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct PoolInfo<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        total_staked_token: 0x2::balance::Balance<T0>,
        total_reward_token: 0x2::balance::Balance<T1>,
        reward_per_millisecond: u64,
        start_timestamp: u64,
        end_timestamp: u64,
        last_reward_timestamp: u64,
        seconds_for_user_limit: u64,
        pool_limit_per_user: u64,
        acc_token_per_share: u128,
        precision_factor: u128,
        users: 0x2::object_table::ObjectTable<address, UserRegistry<T0, T1>>,
    }

    struct Pools has key {
        id: 0x2::object::UID,
        quantity: u64,
    }

    struct ListedPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        symbol: 0x1::string::String,
        logo_url: 0x2::url::Url,
        decimals: u64,
        reward_per_millisecond: u64,
        start_timestamp: u64,
        end_timestamp: u64,
        pool_limit_per_user: u64,
        seconds_for_user_limit: u64,
    }

    struct UserInfo<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        reward_debt: u128,
        total_rewards_earned: u64,
    }

    struct UserRegistry<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        user: address,
    }

    struct CreatePoolEvent has copy, drop {
        user: address,
        stake_token_info: 0x1::string::String,
        reward_token_info: 0x1::string::String,
    }

    struct DepositEvent has copy, drop {
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        amount: u64,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        amount: u64,
    }

    struct EmergencyWithdrawRewardEvent has copy, drop {
        admin: address,
        amount: u64,
    }

    struct StopRewardEvent has copy, drop {
        timestamp: u64,
    }

    struct NewPoolLimitEvent has copy, drop {
        pool_limit_per_user: u64,
    }

    struct NewRewardPerSecondEvent has copy, drop {
        reward_per_millisecond: u64,
    }

    struct NewStartAndEndTimestampEvent has copy, drop {
        start_timestamp: u64,
        end_timestamp: u64,
    }

    public entry fun add_reward<T0, T1>(arg0: &StakeOwnerCap, arg1: &mut PoolInfo<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg2);
        0x2::pay::join_vec<T1>(&mut v0, arg2);
        assert!(0x2::coin::value<T1>(&v0) >= arg3, 4);
        0x2::balance::join<T1>(&mut arg1.total_reward_token, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v0, arg3, arg4)));
        if (0x2::coin::value<T1>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T1>(v0);
        };
    }

    fun cal_acc_token_per_share(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u64, arg6: u64) : u128 {
        let v0 = get_multiplier(arg5, arg6, arg2);
        if (v0 == 0) {
            return arg0
        };
        0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::as_u128(0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::add(0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::from_u128(arg0), 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::div(0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::mul(0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::from_u128((arg3 as u128) * (v0 as u128)), 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::from_u128(arg4)), 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::from_u64(arg1))))
    }

    fun cal_pending_reward(arg0: u64, arg1: u128, arg2: u128, arg3: u128) : u64 {
        0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::as_u64(0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::sub(0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::div(0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::mul(0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::from_u64(arg0), 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::from_u128(arg2)), 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::from_u128(arg3)), 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::from_u128(arg1)))
    }

    public entry fun create_pool<T0, T1>(arg0: &StakeOwnerCap, arg1: &0x2::clock::Clock, arg2: &mut Pools, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 < arg8, 13);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::comparator::compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::comparator::is_equal(&v2), 18);
        if (arg10 > 0) {
            assert!(arg9 > 0, 5);
        };
        assert!(0x2::clock::timestamp_ms(arg1) <= arg7, 21);
        assert!(arg8 >= arg7, 22);
        let v3 = 0x2::object::new(arg11);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = PoolInfo<T0, T1>{
            id                     : v3,
            total_staked_token     : 0x2::balance::zero<T0>(),
            total_reward_token     : 0x2::balance::zero<T1>(),
            reward_per_millisecond : arg6,
            start_timestamp        : arg7,
            end_timestamp          : arg8,
            last_reward_timestamp  : arg7,
            seconds_for_user_limit : arg10,
            pool_limit_per_user    : arg9,
            acc_token_per_share    : 0,
            precision_factor       : (0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::math::power_decimals(9 - arg4) as u128),
            users                  : 0x2::object_table::new<address, UserRegistry<T0, T1>>(arg11),
        };
        0x2::transfer::share_object<PoolInfo<T0, T1>>(v5);
        let v6 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v6, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v7 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v7, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        let v8 = ListedPool<T0, T1>{
            id                     : 0x2::object::new(arg11),
            pool_id                : v4,
            coin_type              : v7,
            symbol                 : 0x1::string::utf8(arg3),
            logo_url               : 0x2::url::new_unsafe_from_bytes(arg5),
            decimals               : arg4,
            reward_per_millisecond : arg6,
            start_timestamp        : arg7,
            end_timestamp          : arg8,
            pool_limit_per_user    : arg9,
            seconds_for_user_limit : arg10,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, ListedPool<T0, T1>>(&mut arg2.id, v4, v8);
        arg2.quantity = arg2.quantity + 1;
        let v9 = CreatePoolEvent{
            user              : 0x2::tx_context::sender(arg11),
            stake_token_info  : v6,
            reward_token_info : v7,
        };
        0x2::event::emit<CreatePoolEvent>(v9);
    }

    public entry fun deposit<T0, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: &mut UserInfo<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBLATCONTROLLER<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.end_timestamp > v1, 14);
        assert!(arg5 > 0, 4);
        update_pool<T0, T1>(arg0, v1);
        assert!(arg1.amount + arg5 <= arg0.pool_limit_per_user || v1 >= arg0.start_timestamp + arg0.seconds_for_user_limit, 8);
        if (arg1.amount > 0) {
            let v2 = cal_pending_reward(arg1.amount, arg1.reward_debt, arg0.acc_token_per_share, arg0.precision_factor);
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.total_reward_token, v2, arg6), v0);
                arg1.total_rewards_earned = arg1.total_rewards_earned + v2;
            };
        };
        let v3 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg4);
        0x2::pay::join_vec<T0>(&mut v3, arg4);
        assert!(0x2::coin::value<T0>(&v3) >= arg5, 4);
        0x2::balance::join<T0>(&mut arg0.total_staked_token, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, arg5, arg6)));
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::mint(arg3, arg5, v0, arg6);
        arg1.amount = arg1.amount + arg5;
        arg1.reward_debt = reward_debt(arg1.amount, arg0.acc_token_per_share, arg0.precision_factor);
        let v4 = DepositEvent{amount: arg5};
        0x2::event::emit<DepositEvent>(v4);
    }

    public entry fun emergency_reward_withdraw<T0, T1>(arg0: &StakeOwnerCap, arg1: &mut PoolInfo<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::balance::value<T1>(&arg1.total_reward_token);
        assert!(v1 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.total_reward_token, v1, arg2), v0);
        let v2 = EmergencyWithdrawRewardEvent{
            admin  : v0,
            amount : v1,
        };
        0x2::event::emit<EmergencyWithdrawRewardEvent>(v2);
    }

    public entry fun emergency_withdraw<T0, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: &mut UserInfo<T0, T1>, arg2: &mut 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBLATCONTROLLER<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>, arg3: vector<0x2::coin::Coin<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = arg1.amount;
        assert!(v1 > 0, 6);
        arg1.amount = 0;
        arg1.reward_debt = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.total_staked_token, v1, arg4), v0);
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>>(&mut arg3);
        0x2::pay::join_vec<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>(&mut v2, arg3);
        assert!(0x2::coin::value<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>(&v2) >= v1, 4);
        0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::burn(arg2, 0x2::coin::split<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>(&mut v2, v1, arg4));
        if (0x2::coin::value<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>>(v2, v0);
        } else {
            0x2::coin::destroy_zero<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>(v2);
        };
        let v3 = EmergencyWithdrawEvent{amount: v1};
        0x2::event::emit<EmergencyWithdrawEvent>(v3);
    }

    fun get_multiplier(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 <= arg2) {
            arg1 - arg0
        } else if (arg0 >= arg2) {
            0
        } else {
            arg2 - arg0
        }
    }

    public fun get_pending_reward<T0, T1>(arg0: &PoolInfo<T0, T1>, arg1: &UserInfo<T0, T1>, arg2: u64) : u64 {
        let v0 = if (0x2::balance::value<T0>(&arg0.total_staked_token) == 0 || arg2 < arg0.last_reward_timestamp) {
            arg0.acc_token_per_share
        } else {
            cal_acc_token_per_share(arg0.acc_token_per_share, 0x2::balance::value<T0>(&arg0.total_staked_token), arg0.end_timestamp, arg0.reward_per_millisecond, arg0.precision_factor, arg0.last_reward_timestamp, arg2)
        };
        cal_pending_reward(arg1.amount, arg1.reward_debt, v0, arg0.precision_factor)
    }

    public fun get_pool_info<T0, T1>(arg0: &PoolInfo<T0, T1>) : (u64, u64, u64, u64, u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.total_staked_token), 0x2::balance::value<T1>(&arg0.total_reward_token), arg0.reward_per_millisecond, arg0.start_timestamp, arg0.end_timestamp, arg0.seconds_for_user_limit, arg0.pool_limit_per_user)
    }

    public fun get_user_stake_amount<T0, T1>(arg0: &UserInfo<T0, T1>) : u64 {
        arg0.amount
    }

    public entry fun harvest<T0, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: &mut UserInfo<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        update_pool<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg2));
        let v0 = cal_pending_reward(arg1.amount, arg1.reward_debt, arg0.acc_token_per_share, arg0.precision_factor);
        assert!(v0 > 0, 20);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.total_reward_token, v0, arg3), 0x2::tx_context::sender(arg3));
        arg1.total_rewards_earned = arg1.total_rewards_earned + v0;
        arg1.reward_debt = reward_debt(arg1.amount, arg0.acc_token_per_share, arg0.precision_factor);
    }

    fun init(arg0: STAKE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<STAKE>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = StakeOwnerCap{
            id    : 0x2::object::new(arg1),
            admin : v0,
        };
        0x2::transfer::transfer<StakeOwnerCap>(v1, v0);
        let v2 = Pools{
            id       : 0x2::object::new(arg1),
            quantity : 0,
        };
        0x2::transfer::share_object<Pools>(v2);
    }

    public entry fun mint_user_info<T0, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::object_table::contains<address, UserRegistry<T0, T1>>(&arg0.users, v0), 19);
        let v1 = UserInfo<T0, T1>{
            id                   : 0x2::object::new(arg1),
            amount               : 0,
            reward_debt          : 0,
            total_rewards_earned : 0,
        };
        0x2::transfer::transfer<UserInfo<T0, T1>>(v1, v0);
        let v2 = UserRegistry<T0, T1>{
            id   : 0x2::object::new(arg1),
            user : v0,
        };
        0x2::object_table::add<address, UserRegistry<T0, T1>>(&mut arg0.users, v0, v2);
    }

    fun reward_debt(arg0: u64, arg1: u128, arg2: u128) : u128 {
        0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::as_u128(0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::div(0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::mul(0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::from_u64(arg0), 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::from_u128(arg1)), 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::u256::from_u128(arg2)))
    }

    public entry fun stop_reward<T0, T1>(arg0: &StakeOwnerCap, arg1: &mut PoolInfo<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg1.end_timestamp = v0;
        let v1 = StopRewardEvent{timestamp: v0};
        0x2::event::emit<StopRewardEvent>(v1);
    }

    fun update_pool<T0, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: u64) {
        if (arg1 <= arg0.last_reward_timestamp) {
            return
        };
        if (0x2::balance::value<T0>(&arg0.total_staked_token) == 0) {
            arg0.last_reward_timestamp = arg1;
            return
        };
        let v0 = cal_acc_token_per_share(arg0.acc_token_per_share, 0x2::balance::value<T0>(&arg0.total_staked_token), arg0.end_timestamp, arg0.reward_per_millisecond, arg0.precision_factor, arg0.last_reward_timestamp, arg1);
        if (arg0.acc_token_per_share == v0) {
            return
        };
        arg0.acc_token_per_share = v0;
        arg0.last_reward_timestamp = arg1;
    }

    public entry fun update_pool_limit_per_user<T0, T1, T2>(arg0: &StakeOwnerCap, arg1: &mut PoolInfo<T0, T1>, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.seconds_for_user_limit > 0 && 0x2::clock::timestamp_ms(arg2) < arg1.start_timestamp + arg1.seconds_for_user_limit, 10);
        if (arg3) {
            assert!(arg4 > arg1.pool_limit_per_user, 11);
            arg1.pool_limit_per_user = arg4;
        } else {
            arg1.seconds_for_user_limit = 0;
            arg1.pool_limit_per_user = 0;
        };
        let v0 = NewPoolLimitEvent{pool_limit_per_user: arg1.pool_limit_per_user};
        0x2::event::emit<NewPoolLimitEvent>(v0);
    }

    public entry fun update_reward_per_millisecond<T0, T1, T2>(arg0: &StakeOwnerCap, arg1: &mut PoolInfo<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg1.start_timestamp, 12);
        arg1.reward_per_millisecond = arg3;
        let v0 = NewRewardPerSecondEvent{reward_per_millisecond: arg3};
        0x2::event::emit<NewRewardPerSecondEvent>(v0);
    }

    public entry fun update_start_and_end_timestamp<T0, T1, T2>(arg0: &StakeOwnerCap, arg1: &mut PoolInfo<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 < arg1.start_timestamp, 12);
        assert!(arg3 < arg4, 13);
        assert!(v0 < arg3, 3);
        arg1.start_timestamp = arg3;
        arg1.end_timestamp = arg4;
        arg1.last_reward_timestamp = arg3;
        let v1 = NewStartAndEndTimestampEvent{
            start_timestamp : arg3,
            end_timestamp   : arg4,
        };
        0x2::event::emit<NewStartAndEndTimestampEvent>(v1);
    }

    public entry fun withdraw<T0, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: &mut UserInfo<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBLATCONTROLLER<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>, arg4: vector<0x2::coin::Coin<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        update_pool<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg2));
        assert!(arg1.amount >= arg5, 6);
        assert!(arg5 > 0, 4);
        let v1 = cal_pending_reward(arg1.amount, arg1.reward_debt, arg0.acc_token_per_share, arg0.precision_factor);
        arg1.amount = arg1.amount - arg5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.total_staked_token, arg5, arg6), v0);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.total_reward_token, v1, arg6), v0);
            arg1.total_rewards_earned = arg1.total_rewards_earned + v1;
        };
        arg1.reward_debt = reward_debt(arg1.amount, arg0.acc_token_per_share, arg0.precision_factor);
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>>(&mut arg4);
        0x2::pay::join_vec<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>(&mut v2, arg4);
        assert!(0x2::coin::value<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>(&v2) >= arg5, 4);
        0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::burn(arg3, 0x2::coin::split<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>(&mut v2, arg5, arg6));
        if (0x2::coin::value<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>>(v2, v0);
        } else {
            0x2::coin::destroy_zero<0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch::IBELAUNCH>(v2);
        };
        let v3 = WithdrawEvent{amount: arg5};
        0x2::event::emit<WithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

