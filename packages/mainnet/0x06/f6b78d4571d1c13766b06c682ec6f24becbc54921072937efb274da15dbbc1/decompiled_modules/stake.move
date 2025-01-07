module 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::stake {
    struct STAKE has drop {
        dummy_field: bool,
    }

    struct Admincap has store, key {
        id: 0x2::object::UID,
    }

    struct StakePool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        apy: u128,
        paused: bool,
        unlock_times: u64,
        stake_coins: 0x2::coin::Coin<T0>,
        reward_coins: 0x2::coin::Coin<T1>,
        stakes: 0x2::table::Table<address, UserStake>,
    }

    struct UserStake has store {
        spt_staked: u128,
        withdraw_stake: u128,
        reward_remaining: u128,
        lastest_updated_time: u64,
        unlock_times: u64,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: address,
        unlock_times: u64,
        apy: u128,
    }

    struct StakeEvent has copy, drop, store {
        pool_id: address,
        user_address: address,
        amount: u128,
        apy: u128,
        user_spt_staked: u128,
        user_reward_remaining: u128,
        user_lastest_updated_time: u64,
    }

    struct UpdateApyEvent has copy, drop, store {
        poo_id: address,
        user_address: address,
        apy: u128,
        user_spt_staked: u128,
        user_withdraw_stake: u128,
        user_reward_remaining: u128,
        user_lastest_updated_time: u64,
        user_unlock_time: u64,
    }

    struct DepositRewardEvent has copy, drop, store {
        pool_id: address,
        amount: u128,
        total_reward: u128,
    }

    struct WithdarawRewardEvent has copy, drop, store {
        pool_id: address,
        total_reward: u128,
    }

    struct UnStakeEvent has copy, drop, store {
        pool_id: address,
        user_address: address,
        amount: u128,
        user_spt_staked: u128,
        user_withdraw_stake: u128,
        user_reward_remaining: u128,
        user_lastest_updated_time: u64,
        user_unlock_time: u64,
    }

    struct WithdrawSptEvent has copy, drop, store {
        pool_id: address,
        user_address: address,
        user_spt_staked: u128,
        user_withdraw_staked: u128,
        user_reward_remaining: u128,
        user_lastest_updated_time: u64,
        user_unlock_time: u64,
    }

    struct ClaimRewardsEvent has copy, drop, store {
        pool_id: address,
        user_address: address,
        amount: u128,
        total_staked: u128,
        total_reward: u128,
        user_spt_staked: u128,
        user_withdraw_stake: u128,
        user_reward_remaining: u128,
        user_lastest_updated_time: u64,
        user_unlock_time: u64,
    }

    struct StopEmergencyEvent has copy, drop, store {
        pool_id: address,
        total_staked: u128,
        paused: bool,
    }

    struct StakeRewardsEvent has copy, drop, store {
        pool_id: address,
        user_address: address,
        amount: u128,
        total_staked: u128,
        user_spt_staked: u128,
        user_reward_remaining: u128,
        user_lastest_updated_time: u64,
    }

    public fun stake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::checkVersion(arg3, 1);
        assert!(!arg0.paused, 8008);
        let v0 = (0x2::coin::value<T0>(&arg1) as u128);
        assert!(v0 > 0, 8002);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = arg0.apy;
        if (!0x2::table::contains<address, UserStake>(&arg0.stakes, v1)) {
            let v3 = UserStake{
                spt_staked           : v0,
                withdraw_stake       : 0,
                reward_remaining     : 0,
                lastest_updated_time : 0x2::clock::timestamp_ms(arg2),
                unlock_times         : 0,
            };
            0x2::table::add<address, UserStake>(&mut arg0.stakes, v1, v3);
        } else {
            let v4 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v1);
            update_reward_remaining(v2, 0x2::clock::timestamp_ms(arg2), v4);
            v4.spt_staked = v4.spt_staked + v0;
        };
        let v5 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v1);
        0x2::coin::join<T0>(&mut arg0.stake_coins, arg1);
        let v6 = StakeEvent{
            pool_id                   : 0x2::object::uid_to_address(&arg0.id),
            user_address              : v1,
            amount                    : v0,
            apy                       : v2,
            user_spt_staked           : v5.spt_staked,
            user_reward_remaining     : v5.reward_remaining,
            user_lastest_updated_time : v5.lastest_updated_time,
        };
        0x2::event::emit<StakeEvent>(v6);
    }

    public fun change_admin(arg0: Admincap, arg1: address, arg2: &mut 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::Version) {
        0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::checkVersion(arg2, 1);
        0x2::transfer::public_transfer<Admincap>(arg0, arg1);
    }

    public entry fun claimRewards<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::checkVersion(arg2, 1);
        assert!(!arg0.paused, 8008);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, v0), 8004);
        let v1 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v0);
        update_reward_remaining(arg0.apy, 0x2::clock::timestamp_ms(arg1), v1);
        let v2 = v1.reward_remaining;
        assert!(v2 > 0 && v2 <= (0x2::coin::value<T1>(&arg0.reward_coins) as u128), 8007);
        v1.reward_remaining = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.reward_coins, (v2 as u64), arg3), v0);
        let v3 = ClaimRewardsEvent{
            pool_id                   : 0x2::object::uid_to_address(&arg0.id),
            user_address              : v0,
            amount                    : v2,
            total_staked              : (0x2::coin::value<T0>(&arg0.stake_coins) as u128),
            total_reward              : (0x2::coin::value<T1>(&arg0.reward_coins) as u128),
            user_spt_staked           : v1.spt_staked,
            user_withdraw_stake       : v1.withdraw_stake,
            user_reward_remaining     : v1.reward_remaining,
            user_lastest_updated_time : v1.lastest_updated_time,
            user_unlock_time          : v1.unlock_times,
        };
        0x2::event::emit<ClaimRewardsEvent>(v3);
    }

    public entry fun createPool<T0, T1>(arg0: &Admincap, arg1: u64, arg2: u128, arg3: &mut 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::checkVersion(arg3, 1);
        assert!(arg2 > 0, 8001);
        let v0 = StakePool<T0, T1>{
            id           : 0x2::object::new(arg4),
            apy          : arg2,
            paused       : false,
            unlock_times : arg1,
            stake_coins  : 0x2::coin::zero<T0>(arg4),
            reward_coins : 0x2::coin::zero<T1>(arg4),
            stakes       : 0x2::table::new<address, UserStake>(arg4),
        };
        let v1 = CreatePoolEvent{
            pool_id      : 0x2::object::id_address<StakePool<T0, T1>>(&v0),
            unlock_times : arg1,
            apy          : arg2,
        };
        0x2::event::emit<CreatePoolEvent>(v1);
        0x2::transfer::share_object<StakePool<T0, T1>>(v0);
    }

    public entry fun depositRewardCoins<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: &mut 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::Version, arg3: 0x2::coin::Coin<T1>) {
        0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::checkVersion(arg2, 1);
        let v0 = (0x2::coin::value<T1>(&arg3) as u128);
        assert!(v0 > 0, 8002);
        0x2::coin::join<T1>(&mut arg1.reward_coins, arg3);
        let v1 = DepositRewardEvent{
            pool_id      : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            amount       : v0,
            total_reward : (0x2::coin::value<T1>(&arg1.reward_coins) as u128),
        };
        0x2::event::emit<DepositRewardEvent>(v1);
    }

    fun init(arg0: STAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Admincap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<Admincap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun pause<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun stakeRewards<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::checkVersion(arg2, 1);
        assert!(!arg0.paused, 8008);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserStake>(&mut arg0.stakes, v0), 8003);
        let v1 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v0);
        update_reward_remaining(arg0.apy, 0x2::clock::timestamp_ms(arg1), v1);
        let v2 = v1.reward_remaining;
        assert!(v2 > 0, 8003);
        v1.spt_staked = v1.spt_staked + v2;
        v1.reward_remaining = 0;
        let v3 = StakeRewardsEvent{
            pool_id                   : 0x2::object::uid_to_address(&arg0.id),
            user_address              : v0,
            amount                    : v2,
            total_staked              : (0x2::coin::value<T0>(&mut arg0.stake_coins) as u128),
            user_spt_staked           : v1.spt_staked,
            user_reward_remaining     : v1.reward_remaining,
            user_lastest_updated_time : v1.lastest_updated_time,
        };
        0x2::event::emit<StakeRewardsEvent>(v3);
    }

    public entry fun stopEmergency<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: vector<address>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::checkVersion(arg5, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, UserStake>(&mut arg1.stakes, v1)) {
                let v2 = 0x2::table::borrow_mut<address, UserStake>(&mut arg1.stakes, v1);
                update_reward_remaining(arg1.apy, 0x2::clock::timestamp_ms(arg4), v2);
                let v3 = v2.spt_staked;
                assert!(v3 > 0 && v3 <= (0x2::coin::value<T0>(&arg1.stake_coins) as u128), 8003);
                v2.spt_staked = 0;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.stake_coins, (v3 as u64), arg6), v1);
            };
            v0 = v0 + 1;
        };
        arg1.paused = arg3;
        let v4 = StopEmergencyEvent{
            pool_id      : 0x2::object::uid_to_address(&arg1.id),
            total_staked : (0x2::coin::value<T0>(&arg1.stake_coins) as u128),
            paused       : arg3,
        };
        0x2::event::emit<StopEmergencyEvent>(v4);
    }

    public fun unstake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: u128, arg2: &0x2::clock::Clock, arg3: &mut 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::checkVersion(arg3, 1);
        assert!(!arg0.paused, 8008);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, v1), 8004);
        let v2 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v1);
        update_reward_remaining(arg0.apy, v0, v2);
        let v3 = v2.spt_staked;
        assert!(arg1 > 0, 8002);
        assert!(v3 > 0 && v3 >= arg1, 8003);
        v2.spt_staked = v2.spt_staked - arg1;
        v2.withdraw_stake = v2.withdraw_stake + arg1;
        v2.unlock_times = v0 + arg0.unlock_times;
        let v4 = v2.reward_remaining;
        assert!(v4 > 0 && (0x2::coin::value<T1>(&arg0.reward_coins) as u128) >= v4, 8003);
        v2.reward_remaining = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.reward_coins, (v4 as u64), arg4), v1);
        let v5 = UnStakeEvent{
            pool_id                   : 0x2::object::uid_to_address(&arg0.id),
            user_address              : v1,
            amount                    : v3,
            user_spt_staked           : v2.spt_staked,
            user_withdraw_stake       : v2.withdraw_stake,
            user_reward_remaining     : v2.reward_remaining,
            user_lastest_updated_time : v2.lastest_updated_time,
            user_unlock_time          : v2.unlock_times,
        };
        0x2::event::emit<UnStakeEvent>(v5);
    }

    public entry fun updateApy<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: vector<address>, arg3: u128, arg4: &mut 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::Version, arg5: &0x2::clock::Clock) {
        0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::checkVersion(arg4, 1);
        assert!(arg3 > 0, 8001);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, UserStake>(&arg1.stakes, v1)) {
                let v2 = 0x2::table::borrow_mut<address, UserStake>(&mut arg1.stakes, v1);
                update_reward_remaining(arg1.apy, 0x2::clock::timestamp_ms(arg5), v2);
                let v3 = UpdateApyEvent{
                    poo_id                    : 0x2::object::uid_to_address(&arg1.id),
                    user_address              : v1,
                    apy                       : arg3,
                    user_spt_staked           : v2.spt_staked,
                    user_withdraw_stake       : v2.withdraw_stake,
                    user_reward_remaining     : v2.reward_remaining,
                    user_lastest_updated_time : v2.lastest_updated_time,
                    user_unlock_time          : v2.unlock_times,
                };
                0x2::event::emit<UpdateApyEvent>(v3);
            };
            v0 = v0 + 1;
        };
        arg1.apy = arg3;
    }

    public entry fun updateApyV2<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: vector<address>, arg3: u128, arg4: u128, arg5: &mut 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::Version, arg6: &0x2::clock::Clock) {
        0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::checkVersion(arg5, 1);
        assert!(arg3 > 0, 8001);
        arg1.apy = arg3;
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, UserStake>(&arg1.stakes, v1)) {
                let v2 = 0x2::table::borrow_mut<address, UserStake>(&mut arg1.stakes, v1);
                update_reward_remaining(arg4, 0x2::clock::timestamp_ms(arg6), v2);
                let v3 = UpdateApyEvent{
                    poo_id                    : 0x2::object::uid_to_address(&arg1.id),
                    user_address              : v1,
                    apy                       : arg3,
                    user_spt_staked           : v2.spt_staked,
                    user_withdraw_stake       : v2.withdraw_stake,
                    user_reward_remaining     : v2.reward_remaining,
                    user_lastest_updated_time : v2.lastest_updated_time,
                    user_unlock_time          : v2.unlock_times,
                };
                0x2::event::emit<UpdateApyEvent>(v3);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun updateUnlockTime<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: u64, arg3: &mut 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::Version) {
        0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::checkVersion(arg3, 1);
        assert!(arg2 > 0, 8001);
        arg1.unlock_times = arg2;
    }

    fun update_reward_remaining(arg0: u128, arg1: u64, arg2: &mut UserStake) {
        assert!(arg0 > 0, 8001);
        arg2.reward_remaining = arg2.reward_remaining + ((arg1 - arg2.lastest_updated_time) as u128) * arg2.spt_staked * arg0 / ((31536000000 * 10000) as u128);
        arg2.lastest_updated_time = arg1;
    }

    public entry fun withdrawRewardCoins<T0, T1>(arg0: &Admincap, arg1: &mut StakePool<T0, T1>, arg2: &mut 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::checkVersion(arg2, 1);
        let v0 = (0x2::coin::value<T1>(&arg1.reward_coins) as u128);
        assert!(v0 > 0, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1.reward_coins, (v0 as u64), arg3), 0x2::tx_context::sender(arg3));
        let v1 = WithdarawRewardEvent{
            pool_id      : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            total_reward : v0,
        };
        0x2::event::emit<WithdarawRewardEvent>(v1);
    }

    public entry fun withdrawSpt<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x6f6b78d4571d1c13766b06c682ec6f24becbc54921072937efb274da15dbbc1::version::checkVersion(arg2, 1);
        assert!(!arg0.paused, 8008);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserStake>(&mut arg0.stakes, v0), 8003);
        let v1 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v0);
        assert!(0x2::clock::timestamp_ms(arg1) >= v1.unlock_times, 8006);
        assert!(v1.withdraw_stake > 0 && v1.withdraw_stake <= (0x2::coin::value<T0>(&arg0.stake_coins) as u128), 8005);
        v1.withdraw_stake = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.stake_coins, (v1.withdraw_stake as u64), arg3), v0);
        let v2 = WithdrawSptEvent{
            pool_id                   : 0x2::object::uid_to_address(&arg0.id),
            user_address              : v0,
            user_spt_staked           : v1.spt_staked,
            user_withdraw_staked      : v1.withdraw_stake,
            user_reward_remaining     : v1.reward_remaining,
            user_lastest_updated_time : v1.lastest_updated_time,
            user_unlock_time          : v1.unlock_times,
        };
        0x2::event::emit<WithdrawSptEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

