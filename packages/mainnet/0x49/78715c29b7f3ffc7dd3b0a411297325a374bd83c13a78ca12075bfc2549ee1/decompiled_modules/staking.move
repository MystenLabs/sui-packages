module 0xa1d539afbc36f742a0f4a557c1c84eeead8952313e29a1e456f58433e9e61042::staking {
    struct STAKING has drop {
        dummy_field: bool,
    }

    struct Staking<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin: address,
        version: u64,
    }

    struct StakingPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_suai_stake: u128,
        total_reward_token: 0x2::balance::Balance<T0>,
        total_reward: u128,
        reward_per_second: u128,
        start_time: u128,
        end_time: u128,
        last_reward_time: u128,
        acc_token_per_share: u128,
        precision_factor: u128,
        total_user: u64,
    }

    struct UserStake<phantom T0> has store {
        suai_stake: u128,
        reward_debt: u128,
        suai: 0x2::balance::Balance<T0>,
        pending_reward: u128,
    }

    struct CreateStakingEvent has copy, drop, store {
        pid: 0x2::object::ID,
        token_address: 0x1::type_name::TypeName,
        start_time: u128,
        end_time: u128,
        sender: address,
        total_reward: u128,
        reward_per_second: u128,
    }

    struct ChangeStakingPoolEvent has copy, drop, store {
        pid: 0x2::object::ID,
        total_reward: u128,
        total_suai_stake: u128,
        reward_per_second: u128,
        start_time: u128,
        end_time: u128,
        total_user: u64,
    }

    public entry fun add_reward_pool<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.total_reward_token, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_reward = arg0.total_reward + (0x2::coin::value<T0>(&arg1) as u128);
        arg0.reward_per_second = arg0.total_reward / (arg0.end_time - arg0.start_time);
        let v0 = ChangeStakingPoolEvent{
            pid               : 0x2::object::id<StakingPool<T0>>(arg0),
            total_reward      : arg0.total_reward,
            total_suai_stake  : arg0.total_suai_stake,
            reward_per_second : arg0.reward_per_second,
            start_time        : arg0.start_time,
            end_time          : arg0.end_time,
            total_user        : arg0.total_user,
        };
        0x2::event::emit<ChangeStakingPoolEvent>(v0);
    }

    public entry fun admin_update<T0, T1>(arg0: &mut StakingPool<T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xf2db7827e4f6ea694f3f1526a7d61b802bdd8fddc176ac86a37db250703090fc, 2);
        let v0 = 0x2::dynamic_field::borrow_mut<address, UserStake<T0>>(&mut arg0.id, arg1);
        if (v0.suai_stake * arg0.acc_token_per_share / arg0.precision_factor < v0.reward_debt) {
            v0.reward_debt = 0;
        };
    }

    fun cal_acc_token_per_share(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: &0x2::clock::Clock) : u128 {
        let v0 = get_multiplier(arg5, ((0x2::clock::timestamp_ms(arg6) / 1000) as u128), arg2);
        if (v0 == 0) {
            return arg0
        };
        arg0 + arg3 * v0 * arg4 / arg1
    }

    fun cal_pending_reward(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        if (arg0 * arg2 / arg3 < arg1) {
            0
        } else {
            arg0 * arg2 / arg3 - arg1
        }
    }

    public entry fun create_staking_pool<T0, T1>(arg0: &mut Staking<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u128, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == @0xf2db7827e4f6ea694f3f1526a7d61b802bdd8fddc176ac86a37db250703090fc, 2);
        assert!(arg0.version == 1, 3);
        let v1 = (0x2::coin::value<T1>(&arg1) as u128);
        let v2 = StakingPool<T1>{
            id                  : 0x2::object::new(arg4),
            total_suai_stake    : 0,
            total_reward_token  : 0x2::coin::into_balance<T1>(arg1),
            total_reward        : v1,
            reward_per_second   : v1 / (arg3 - arg2),
            start_time          : arg2,
            end_time            : arg3,
            last_reward_time    : arg2,
            acc_token_per_share : 0,
            precision_factor    : 1,
            total_user          : 0,
        };
        let v3 = CreateStakingEvent{
            pid               : 0x2::object::id<StakingPool<T1>>(&v2),
            token_address     : 0x1::type_name::get<T1>(),
            start_time        : arg2,
            end_time          : arg3,
            sender            : v0,
            total_reward      : v1,
            reward_per_second : v1 / (arg3 - arg2),
        };
        0x2::event::emit<CreateStakingEvent>(v3);
        0x2::transfer::share_object<StakingPool<T1>>(v2);
    }

    fun get_multiplier(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg1 <= arg2) {
            arg1 - arg0
        } else if (arg0 >= arg2) {
            0
        } else {
            arg2 - arg0
        }
    }

    public entry fun init_module<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xf2db7827e4f6ea694f3f1526a7d61b802bdd8fddc176ac86a37db250703090fc, 2);
        let v0 = Staking<T0>{
            id      : 0x2::object::new(arg0),
            admin   : @0xf2db7827e4f6ea694f3f1526a7d61b802bdd8fddc176ac86a37db250703090fc,
            version : 1,
        };
        0x2::transfer::share_object<Staking<T0>>(v0);
    }

    fun reward_debt(arg0: u128, arg1: u128, arg2: u128) : u128 {
        arg0 * arg1 / arg2
    }

    public entry fun stake_suai<T0, T1>(arg0: &mut Staking<T0>, arg1: &mut StakingPool<T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.end_time > ((0x2::clock::timestamp_ms(arg3) / 1000) as u128), 4);
        if (!0x2::dynamic_field::exists_<address>(&arg1.id, v0)) {
            let v1 = UserStake<T0>{
                suai_stake     : 0,
                reward_debt    : 0,
                suai           : 0x2::balance::zero<T0>(),
                pending_reward : 0,
            };
            0x2::dynamic_field::add<address, UserStake<T0>>(&mut arg1.id, v0, v1);
            arg1.total_user = arg1.total_user + 1;
        };
        update_pool<T1>(arg1, arg3);
        let v2 = 0x2::dynamic_field::borrow_mut<address, UserStake<T0>>(&mut arg1.id, v0);
        if (v2.suai_stake > 0) {
            v2.pending_reward = v2.pending_reward + cal_pending_reward(v2.suai_stake, v2.reward_debt, arg1.acc_token_per_share, arg1.precision_factor);
        };
        let v3 = (0x2::coin::value<T0>(&arg2) as u128);
        v2.suai_stake = v2.suai_stake + v3;
        arg1.total_suai_stake = arg1.total_suai_stake + v3;
        0x2::balance::join<T0>(&mut v2.suai, 0x2::coin::into_balance<T0>(arg2));
        v2.reward_debt = reward_debt(v2.suai_stake, arg1.acc_token_per_share, arg1.precision_factor);
        let v4 = ChangeStakingPoolEvent{
            pid               : 0x2::object::id<StakingPool<T1>>(arg1),
            total_reward      : arg1.total_reward,
            total_suai_stake  : arg1.total_suai_stake,
            reward_per_second : arg1.reward_per_second,
            start_time        : arg1.start_time,
            end_time          : arg1.end_time,
            total_user        : arg1.total_user,
        };
        0x2::event::emit<ChangeStakingPoolEvent>(v4);
    }

    fun update_pool<T0>(arg0: &mut StakingPool<T0>, arg1: &0x2::clock::Clock) {
        let v0 = ((0x2::clock::timestamp_ms(arg1) / 1000) as u128);
        if (v0 <= arg0.last_reward_time) {
            return
        };
        if (arg0.total_suai_stake == 0) {
            arg0.last_reward_time = v0;
            return
        };
        let v1 = cal_acc_token_per_share(arg0.acc_token_per_share, arg0.total_suai_stake, arg0.end_time, arg0.reward_per_second, arg0.precision_factor, arg0.last_reward_time, arg1);
        if (arg0.acc_token_per_share == v1) {
            return
        };
        arg0.acc_token_per_share = v1;
        arg0.last_reward_time = v0;
    }

    public entry fun update_precision_factor<T0>(arg0: &mut StakingPool<T0>, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xf2db7827e4f6ea694f3f1526a7d61b802bdd8fddc176ac86a37db250703090fc, 2);
        arg0.precision_factor = arg1;
    }

    public entry fun withdraw_reward<T0, T1>(arg0: &mut Staking<T0>, arg1: &mut StakingPool<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 3);
        let v0 = 0x2::tx_context::sender(arg3);
        update_pool<T1>(arg1, arg2);
        assert!(0x2::dynamic_field::exists_with_type<address, UserStake<T0>>(&arg1.id, v0), 5);
        let v1 = 0x2::dynamic_field::borrow_mut<address, UserStake<T0>>(&mut arg1.id, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.total_reward_token, ((cal_pending_reward(v1.suai_stake, v1.reward_debt, arg1.acc_token_per_share, arg1.precision_factor) + v1.pending_reward) as u64), arg3), v0);
        v1.reward_debt = reward_debt(v1.suai_stake, arg1.acc_token_per_share, arg1.precision_factor);
        v1.pending_reward = 0;
    }

    public entry fun withdraw_suai<T0, T1>(arg0: &mut Staking<T0>, arg1: &mut StakingPool<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        update_pool<T1>(arg1, arg3);
        assert!(0x2::dynamic_field::exists_with_type<address, UserStake<T0>>(&arg1.id, v0), 5);
        let v1 = 0x2::dynamic_field::borrow_mut<address, UserStake<T0>>(&mut arg1.id, v0);
        let v2 = (arg2 as u128);
        assert!(v1.suai_stake >= v2, 1);
        let v3 = cal_pending_reward(v1.suai_stake, v1.reward_debt, arg1.acc_token_per_share, arg1.precision_factor);
        if (v3 > 0) {
            v1.pending_reward = v1.pending_reward + v3;
        };
        v1.suai_stake = v1.suai_stake - v2;
        arg1.total_suai_stake = arg1.total_suai_stake - v2;
        v1.reward_debt = reward_debt(v1.suai_stake, arg1.acc_token_per_share, arg1.precision_factor);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v1.suai, arg2, arg4), v0);
        let v4 = ChangeStakingPoolEvent{
            pid               : 0x2::object::id<StakingPool<T1>>(arg1),
            total_reward      : arg1.total_reward,
            total_suai_stake  : arg1.total_suai_stake,
            reward_per_second : arg1.reward_per_second,
            start_time        : arg1.start_time,
            end_time          : arg1.end_time,
            total_user        : arg1.total_user,
        };
        0x2::event::emit<ChangeStakingPoolEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

