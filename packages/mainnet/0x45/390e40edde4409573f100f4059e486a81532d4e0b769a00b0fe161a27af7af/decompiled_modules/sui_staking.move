module 0x45390e40edde4409573f100f4059e486a81532d4e0b769a00b0fe161a27af7af::sui_staking {
    struct FarmingPool has key {
        id: 0x2::object::UID,
        stake_amount: 0x2::balance::Balance<0x2::sui::SUI>,
        reward_amount: 0x2::balance::Balance<0x2::sui::SUI>,
        reward_interval: u64,
        enabled: bool,
        user_info: 0x2::vec_map::VecMap<address, UserInfo>,
        dev_reward_multiplier: u64,
    }

    struct UserInfo has copy, drop, store {
        deposits: vector<Stake>,
    }

    struct Stake has copy, drop, store {
        addr: address,
        amount: u128,
        reward: u128,
        last_time: u64,
        lock_time: u64,
    }

    struct Admin has key {
        id: 0x2::object::UID,
        owner: address,
        dev: address,
    }

    fun assert_enabled(arg0: &FarmingPool, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 112);
    }

    fun assert_owner(arg0: &Admin, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 101);
    }

    public entry fun change_enabled(arg0: &Admin, arg1: &mut FarmingPool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        arg1.enabled = arg2;
    }

    public entry fun change_owner(arg0: &mut Admin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.owner = arg1;
    }

    public entry fun change_reward_interval(arg0: &Admin, arg1: &mut FarmingPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        arg1.reward_interval = arg2;
    }

    public entry fun claim_reward(arg0: &Admin, arg1: &mut FarmingPool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_enabled(arg1, arg3);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = update_reward(arg1, v0, arg2, arg3);
        assert!(v1 > 0, 113);
        let v3 = 0x2::vec_map::get_mut<address, UserInfo>(&mut arg1.user_info, &v0);
        let v4 = 0;
        while (v4 < 0x1::vector::length<Stake>(&v3.deposits)) {
            0x1::vector::borrow_mut<Stake>(&mut v3.deposits, v4).reward = 0;
        };
        let v5 = &mut arg1.reward_amount;
        send_reward(arg0.dev, v2, v5, arg3);
        let v6 = &mut arg1.reward_amount;
        send_reward(v0, v1 - v2, v6, arg3);
    }

    public entry fun deposit_reward(arg0: &mut FarmingPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v1 = 0x2::coin::take<0x2::sui::SUI>(&mut v0, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), 0x2::tx_context::sender(arg3));
        assert!(0x2::coin::value<0x2::sui::SUI>(&v1) > 0, 111);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.reward_amount, v1);
    }

    public fun get_pool_config(arg0: &FarmingPool) : (u64, u64, u64, bool) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.stake_amount), 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_amount), arg0.reward_interval, arg0.enabled)
    }

    public fun get_user_info(arg0: address, arg1: &FarmingPool) : (vector<u128>, vector<u128>, vector<u64>, vector<u64>) {
        let v0 = 0x2::vec_map::get<address, UserInfo>(&arg1.user_info, &arg0);
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0x1::vector::empty<u128>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<Stake>(&v0.deposits)) {
            let v6 = 0x1::vector::borrow<Stake>(&v0.deposits, v5);
            0x1::vector::push_back<u128>(&mut v1, v6.amount);
            0x1::vector::push_back<u128>(&mut v2, v6.reward);
            0x1::vector::push_back<u64>(&mut v3, v6.last_time);
            0x1::vector::push_back<u64>(&mut v4, v6.lock_time);
            v5 = v5 + 1;
        };
        (v1, v2, v3, v4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Admin{
            id    : 0x2::object::new(arg0),
            owner : v0,
            dev   : v0,
        };
        0x2::transfer::share_object<Admin>(v1);
        let v2 = FarmingPool{
            id                    : 0x2::object::new(arg0),
            stake_amount          : 0x2::balance::zero<0x2::sui::SUI>(),
            reward_amount         : 0x2::balance::zero<0x2::sui::SUI>(),
            reward_interval       : 604800000,
            enabled               : true,
            user_info             : 0x2::vec_map::empty<address, UserInfo>(),
            dev_reward_multiplier : 1000,
        };
        0x2::transfer::share_object<FarmingPool>(v2);
    }

    fun send_reward(arg0: address, arg1: u128, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(arg2, (arg1 as u64), arg3), arg0);
    }

    public entry fun stake(arg0: &mut FarmingPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = 0x2::coin::take<0x2::sui::SUI>(&mut v1, arg2, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5), v0);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        assert!(v3 > 0, 111);
        let v4 = 0;
        if (arg3 == 0) {
            v4 = 2592000000;
        } else if (arg3 == 1) {
            v4 = 7776000000;
        } else if (arg3 == 2) {
            v4 = 15552000000;
        } else if (arg3 == 3) {
            v4 = 31104000000;
        };
        if (!0x2::vec_map::contains<address, UserInfo>(&mut arg0.user_info, &v0)) {
            let v5 = 0x1::vector::empty<Stake>();
            let v6 = Stake{
                addr      : v0,
                amount    : (v3 as u128),
                reward    : 0,
                last_time : 0x2::clock::timestamp_ms(arg4),
                lock_time : (v4 as u64),
            };
            0x1::vector::push_back<Stake>(&mut v5, v6);
            let v7 = UserInfo{deposits: v5};
            0x2::vec_map::insert<address, UserInfo>(&mut arg0.user_info, v0, v7);
        } else {
            let v8 = Stake{
                addr      : v0,
                amount    : (v3 as u128),
                reward    : 0,
                last_time : 0x2::clock::timestamp_ms(arg4),
                lock_time : (v4 as u64),
            };
            0x1::vector::push_back<Stake>(&mut 0x2::vec_map::get_mut<address, UserInfo>(&mut arg0.user_info, &v0).deposits, v8);
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.stake_amount, v2);
    }

    public entry fun unstake(arg0: &mut FarmingPool, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_enabled(arg0, arg4);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::vec_map::get_mut<address, UserInfo>(&mut arg0.user_info, &v0);
        assert!(0x1::vector::length<Stake>(&v1.deposits) > arg1, 107);
        let v2 = 0x1::vector::borrow<Stake>(&v1.deposits, arg1);
        assert!(v2.amount >= arg2, 108);
        assert!(v2.lock_time < 0x2::clock::timestamp_ms(arg3) - v2.last_time, 109);
        let v3 = v2.amount - arg2;
        if (v3 == 0) {
            0x1::vector::remove<Stake>(&mut v1.deposits, arg1);
        } else {
            0x1::vector::borrow_mut<Stake>(&mut v1.deposits, arg1).amount = v3;
        };
        let v4 = &mut arg0.stake_amount;
        send_reward(v0, arg2, v4, arg4);
    }

    fun update_reward(arg0: &mut FarmingPool, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (u128, u128) {
        let v0 = 0x2::vec_map::get_mut<address, UserInfo>(&mut arg0.user_info, &arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Stake>(&v0.deposits)) {
            let v3 = 0x1::vector::borrow_mut<Stake>(&mut v0.deposits, v2);
            let v4 = 0x2::clock::timestamp_ms(arg2) - v3.last_time;
            let v5 = 0;
            if (v4 < v3.lock_time) {
                v5 = 0;
            } else {
                if ((v3.lock_time as u128) == 2592000000) {
                    v5 = v3.amount * 23900 / 10000;
                } else if ((v3.lock_time as u128) == 7776000000) {
                    v5 = v3.amount * 89000 / 10000;
                } else if ((v3.lock_time as u128) == 15552000000) {
                    v5 = v3.amount * 220000 / 10000;
                } else if ((v3.lock_time as u128) == 31104000000) {
                    v5 = v3.amount * 580000 / 10000;
                };
                v3.last_time = 0x2::clock::timestamp_ms(arg2);
            };
            v1 = v1 + v5 * (arg0.reward_interval as u128) / 31536000000 * (v4 as u128) / (arg0.reward_interval as u128);
        };
        (v1, 0x45390e40edde4409573f100f4059e486a81532d4e0b769a00b0fe161a27af7af::math::mul_div_u128(v1, (arg0.dev_reward_multiplier as u128), 10000))
    }

    public entry fun withdraw_reward(arg0: &Admin, arg1: &mut FarmingPool, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        let v0 = &mut arg1.reward_amount;
        send_reward(arg0.owner, arg2, v0, arg3);
    }

    // decompiled from Move bytecode v6
}

