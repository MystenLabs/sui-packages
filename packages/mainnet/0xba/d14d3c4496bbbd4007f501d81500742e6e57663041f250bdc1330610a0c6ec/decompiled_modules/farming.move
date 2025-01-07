module 0xbad14d3c4496bbbd4007f501d81500742e6e57663041f250bdc1330610a0c6ec::farming {
    struct FarmingData has store, key {
        id: 0x2::object::UID,
        admin: address,
        version: u64,
    }

    struct PoolTime has copy, drop, store {
        lp_type: 0x1::string::String,
        end_time: u64,
    }

    struct StakingPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        user_infor: 0x2::table::Table<address, UserInfo>,
        coin_lp: 0x2::coin::Coin<T0>,
        reward_coin: 0x2::coin::Coin<T1>,
        total_user: u64,
        total_amount: u128,
        acc_x_per_share: u128,
        x_per_second: u64,
        last_reward_timestamp: u64,
        last_upkeep_timestamp: u64,
        end_timestamp: u64,
        reward_type: 0x1::string::String,
    }

    struct UserInfo has copy, drop, store {
        amount: u128,
        reward_x_debt: u128,
    }

    struct DepositEvent has copy, drop, store {
        user: address,
        pid: 0x2::object::ID,
        amount: u64,
        total_lp_staked: u128,
        lp_type: 0x1::string::String,
    }

    struct WithdrawEvent has copy, drop, store {
        user: address,
        pid: 0x2::object::ID,
        amount: u64,
        total_lp_staked: u128,
        lp_type: 0x1::string::String,
    }

    struct CreateStakingPoolEvent has copy, drop, store {
        pid: 0x2::object::ID,
        lp_type: 0x1::string::String,
        reward_type: 0x1::string::String,
        created_time: u64,
        end_time: u64,
        user: address,
    }

    struct AddRewardPoolEvent has copy, drop, store {
        pid: 0x2::object::ID,
        lp_type: 0x1::string::String,
        reward_type: 0x1::string::String,
        amount_reward: u64,
        reward_per_second: u64,
        user: address,
    }

    struct UpdatePoolEvent has copy, drop, store {
        pid: 0x2::object::ID,
        last_reward_timestamp: u64,
        lp_supply: u128,
        acc_x_per_share: u128,
    }

    struct GetUserInfor has copy, drop, store {
        stake_amount: u128,
        reward_debt: u128,
    }

    public entry fun add_reward_for_pool<T0>(arg0: &mut StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T0>(&mut arg0.reward_coin, arg1);
        let v0 = 0x2::coin::value<T0>(&arg0.reward_coin) / 2592000;
        arg0.x_per_second = v0;
        arg0.reward_type = 0xbad14d3c4496bbbd4007f501d81500742e6e57663041f250bdc1330610a0c6ec::utils::get_token_name<T0>();
        let v1 = AddRewardPoolEvent{
            pid               : 0x2::object::id<StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>>(arg0),
            lp_type           : 0xbad14d3c4496bbbd4007f501d81500742e6e57663041f250bdc1330610a0c6ec::utils::get_token_name<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>>(),
            reward_type       : 0xbad14d3c4496bbbd4007f501d81500742e6e57663041f250bdc1330610a0c6ec::utils::get_token_name<T0>(),
            amount_reward     : 0x2::coin::value<T0>(&arg1),
            reward_per_second : v0,
            user              : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AddRewardPoolEvent>(v1);
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 14);
    }

    fun calc_reward<T0>(arg0: &StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>, arg1: &0x2::clock::Clock) : (u64, u128) {
        let v0 = 0;
        let v1 = arg0.acc_x_per_share;
        let v2 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (v2 > arg0.last_reward_timestamp) {
            let v3 = arg0.total_amount;
            let v4 = if (arg0.end_timestamp <= arg0.last_reward_timestamp) {
                0
            } else if (v2 <= arg0.end_timestamp) {
                v2 - 0x1::u64::max(arg0.last_reward_timestamp, arg0.last_upkeep_timestamp)
            } else {
                arg0.end_timestamp - 0x1::u64::max(arg0.last_reward_timestamp, arg0.last_upkeep_timestamp)
            };
            if (v3 > 0) {
                let v5 = (v4 as u128) * (arg0.x_per_second as u128);
                v0 = v5;
                let v6 = arg0.acc_x_per_share + v5 * 1000000000000 / v3;
                v1 = v6;
                assert!(v5 <= 18446744073709551615 && v6 <= 340282366920938463463374607431768211455, 8);
            };
        };
        ((v0 as u64), v1)
    }

    public entry fun create_staking_pool<T0>(arg0: &0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg1: &mut FarmingData, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbad14d3c4496bbbd4007f501d81500742e6e57663041f250bdc1330610a0c6ec::utils::get_token_name<T0>();
        assert_version(arg1.version);
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v2 = v1 + 2592000;
        let v3 = 0xbad14d3c4496bbbd4007f501d81500742e6e57663041f250bdc1330610a0c6ec::utils::get_token_name<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>>();
        0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::asert_pool_not_completed<T0>(arg0, arg3);
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0)) {
            let v4 = PoolTime{
                lp_type  : v3,
                end_time : v2,
            };
            0x2::dynamic_field::add<0x1::string::String, PoolTime>(&mut arg1.id, v0, v4);
        } else {
            let v5 = 0x2::dynamic_field::borrow_mut<0x1::string::String, PoolTime>(&mut arg1.id, v0);
            assert!(v1 > v5.end_time, 15);
            v5.end_time = v2;
        };
        let v6 = StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>{
            id                    : 0x2::object::new(arg3),
            user_infor            : 0x2::table::new<address, UserInfo>(arg3),
            coin_lp               : 0x2::coin::zero<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>>(arg3),
            reward_coin           : 0x2::coin::zero<T0>(arg3),
            total_user            : 0,
            total_amount          : 0,
            acc_x_per_share       : 0,
            x_per_second          : 0,
            last_reward_timestamp : v1,
            last_upkeep_timestamp : v1,
            end_timestamp         : v2,
            reward_type           : v0,
        };
        0x2::transfer::public_share_object<StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>>(v6);
        let v7 = CreateStakingPoolEvent{
            pid          : 0x2::object::id<StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>>(&v6),
            lp_type      : v3,
            reward_type  : v0,
            created_time : v1,
            end_time     : v2,
            user         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CreateStakingPoolEvent>(v7);
    }

    public entry fun deposit<T0>(arg0: &FarmingData, arg1: &mut StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>, arg2: 0x2::coin::Coin<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>>(&arg2);
        assert_version(arg0.version);
        assert!(arg1.end_timestamp > 0x2::clock::timestamp_ms(arg3) / 1000, 16);
        let v2 = 0x2::object::id<StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>>(arg1);
        update_pool<T0>(arg1, arg3, arg4);
        if (!0x2::table::contains<address, UserInfo>(&arg1.user_infor, v0)) {
            let v3 = UserInfo{
                amount        : 0,
                reward_x_debt : 0,
            };
            0x2::table::add<address, UserInfo>(&mut arg1.user_infor, v0, v3);
            arg1.total_user = arg1.total_user + 1;
        };
        let v4 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg1.user_infor, v0);
        if (v4.amount > 0) {
            let v5 = ((v4.amount * arg1.acc_x_per_share / 1000000000000 - v4.reward_x_debt) as u64);
            let v6 = &mut arg1.reward_coin;
            distributed_reward<T0>(v6, v5, v0, arg4);
        };
        if (v1 == 0) {
            0x2::coin::destroy_zero<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>>(arg2);
        } else {
            0x2::coin::join<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>>(&mut arg1.coin_lp, arg2);
            v4.amount = v4.amount + (v1 as u128);
            arg1.total_amount = arg1.total_amount + (v1 as u128);
        };
        v4.reward_x_debt = v4.amount * arg1.acc_x_per_share / 1000000000000;
        let v7 = DepositEvent{
            user            : v0,
            pid             : v2,
            amount          : v1,
            total_lp_staked : arg1.total_amount,
            lp_type         : 0xbad14d3c4496bbbd4007f501d81500742e6e57663041f250bdc1330610a0c6ec::utils::get_token_name<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>>(),
        };
        0x2::event::emit<DepositEvent>(v7);
    }

    fun distributed_reward<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(arg0);
        if (v0 < arg1) {
            arg1 = v0;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg3), arg2);
    }

    public entry fun emergency_withdraw_reward<T0>(arg0: &mut StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1 || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 0);
        let v1 = 0x2::coin::value<T0>(&arg0.reward_coin);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.reward_coin, v1, arg1), @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1);
        };
    }

    public fun get_user_infor<T0>(arg0: &StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.user_infor, arg1);
        let v1 = GetUserInfor{
            stake_amount : v0.amount,
            reward_debt  : v0.reward_x_debt,
        };
        0x2::event::emit<GetUserInfor>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FarmingData{
            id      : 0x2::object::new(arg0),
            admin   : @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1,
            version : 1,
        };
        0x2::transfer::public_share_object<FarmingData>(v0);
    }

    public entry fun migrate_version(arg0: &mut FarmingData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.admin == v0 || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 0);
        arg0.version = arg1;
    }

    public fun pending_move<T0>(arg0: &StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        let (_, v1) = calc_reward<T0>(arg0, arg1);
        let v2 = 0x2::table::borrow<address, UserInfo>(&arg0.user_infor, arg2);
        ((v2.amount * v1 / 1000000000000 - v2.reward_x_debt) as u64)
    }

    public entry fun set_admin(arg0: &mut FarmingData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 != @0x0, 11);
        assert!(v0 == arg0.admin || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 0);
        arg0.admin = arg1;
    }

    public entry fun set_pool<T0>(arg0: &mut FarmingData, arg1: &mut StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.admin || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 0);
        update_pool<T0>(arg1, arg3, arg4);
        arg1.x_per_second = arg2;
    }

    public entry fun update_pool<T0>(arg0: &mut StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = calc_reward<T0>(arg0, arg1);
        let v2 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (v0 > 0) {
            arg0.acc_x_per_share = v1;
        };
        if (v2 > arg0.last_reward_timestamp) {
            arg0.last_reward_timestamp = v2;
            let v3 = UpdatePoolEvent{
                pid                   : 0x2::object::id<StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>>(arg0),
                last_reward_timestamp : v2,
                lp_supply             : arg0.total_amount,
                acc_x_per_share       : arg0.acc_x_per_share,
            };
            0x2::event::emit<UpdatePoolEvent>(v3);
        };
    }

    public entry fun withdraw<T0>(arg0: &FarmingData, arg1: &mut StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<StakingPool<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>, T0>>(arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert_version(arg0.version);
        update_pool<T0>(arg1, arg3, arg4);
        let v2 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg1.user_infor, v1);
        assert!(v2.amount >= (arg2 as u128), 4);
        let v3 = ((v2.amount * arg1.acc_x_per_share / 1000000000000 - v2.reward_x_debt) as u64);
        assert!(v3 <= 18446744073709551615, 8);
        let v4 = &mut arg1.reward_coin;
        distributed_reward<T0>(v4, v3, v1, arg4);
        if (arg2 > 0) {
            v2.amount = v2.amount - (arg2 as u128);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>>>(0x2::coin::split<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>>(&mut arg1.coin_lp, arg2, arg4), v1);
        };
        v2.reward_x_debt = v2.amount * arg1.acc_x_per_share / 1000000000000;
        arg1.total_amount = arg1.total_amount - (arg2 as u128);
        let v5 = WithdrawEvent{
            user            : v1,
            pid             : v0,
            amount          : arg2,
            total_lp_staked : arg1.total_amount,
            lp_type         : 0xbad14d3c4496bbbd4007f501d81500742e6e57663041f250bdc1330610a0c6ec::utils::get_token_name<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::LSP<0x2::sui::SUI, T0>>(),
        };
        0x2::event::emit<WithdrawEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

