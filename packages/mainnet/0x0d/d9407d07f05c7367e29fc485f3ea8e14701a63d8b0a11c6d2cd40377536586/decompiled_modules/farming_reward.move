module 0xe4daf34d4aa8eb89fe9676c8dbec6a0675c53cb8f98fac9b17357f185e992a31::farming_reward {
    struct RewardPool has store {
        vault: 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::BalanceBag,
        total_stake_shares: u64,
        rewarders: 0x2::vec_map::VecMap<0x2::object::ID, PoolRewarderInfo>,
    }

    struct ClaimRewarderEvent has copy, drop {
        reward_token: 0x1::type_name::TypeName,
        reward_debt: u256,
        reward_harvested: u64,
        total_stake_shares: u64,
        stake_shares: u64,
        claim_amount: u64,
    }

    struct PoolRewarderInfo has store, key {
        id: 0x2::object::UID,
        owner: address,
        reward_token: 0x1::type_name::TypeName,
        emission_per_second: u64,
        total_reward: u64,
        last_reward_time: u64,
        reward_harvested: u64,
        acc_per_share: u256,
        start_time: u64,
        end_time: u64,
        active: bool,
    }

    public(friend) fun add_rewarder<T0: drop>(arg0: 0x1::type_name::TypeName, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut RewardPool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = PoolRewarderInfo{
            id                  : 0x2::object::new(arg6),
            owner               : 0x2::tx_context::sender(arg6),
            reward_token        : arg0,
            emission_per_second : arg2,
            total_reward        : 0x2::coin::value<T0>(&arg1),
            last_reward_time    : 0x2::clock::timestamp_ms(arg5),
            reward_harvested    : 0,
            acc_per_share       : 0,
            start_time          : 0x2::clock::timestamp_ms(arg5),
            end_time            : arg3,
            active              : true,
        };
        if (!0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::contains<T0>(&arg4.vault)) {
            0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::init_balance<T0>(&mut arg4.vault);
        };
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::join<T0>(&mut arg4.vault, 0x2::coin::into_balance<T0>(arg1));
        let v1 = 0x2::object::id<PoolRewarderInfo>(&v0);
        0x2::vec_map::insert<0x2::object::ID, PoolRewarderInfo>(&mut arg4.rewarders, v1, v0);
        v1
    }

    public fun borrow_pool_rewarders(arg0: &RewardPool) : &0x2::vec_map::VecMap<0x2::object::ID, PoolRewarderInfo> {
        &arg0.rewarders
    }

    public fun borrow_pool_vault(arg0: &RewardPool) : &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::BalanceBag {
        &arg0.vault
    }

    public(friend) fun claim_rewarder<T0: drop>(arg0: u64, arg1: &mut RewardPool, arg2: &mut 0x2::vec_map::VecMap<0x2::object::ID, u256>, arg3: &mut 0x2::vec_map::VecMap<0x2::object::ID, u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = &mut arg1.rewarders;
        let v1 = 0x2::vec_map::keys<0x2::object::ID, PoolRewarderInfo>(v0);
        let v2 = 0x2::coin::zero<T0>(arg5);
        while (!0x1::vector::is_empty<0x2::object::ID>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x2::object::ID>(&mut v1);
            let v4 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(v0, &v3);
            let v5 = v4.reward_token;
            if (v5 != 0x1::type_name::get<T0>()) {
                continue
            };
            if (!v4.active) {
                continue
            };
            update_acc_per_share(v4, arg1.total_stake_shares, arg4);
            let v6 = 0x2::object::id<PoolRewarderInfo>(v4);
            let v7 = 0x2::vec_map::try_get<0x2::object::ID, u256>(arg2, &v6);
            let v8 = 0x1::option::get_with_default<u256>(&v7, 0);
            let v9 = 0x2::vec_map::try_get<0x2::object::ID, u64>(arg3, &v6);
            let v10 = 0x1::option::get_with_default<u64>(&v9, 0);
            let v11 = ((((arg0 as u256) * (v4.acc_per_share as u256) - v8) / 18446744073709551615 - (v10 as u256)) as u64);
            if (0x2::vec_map::contains<0x2::object::ID, u64>(arg3, &v6)) {
                let v12 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(arg3, &v6);
                *v12 = *v12 + v11;
            } else {
                0x2::vec_map::insert<0x2::object::ID, u64>(arg3, v6, v11);
            };
            if (v11 > 0) {
                0x2::coin::join<T0>(&mut v2, 0x2::coin::from_balance<T0>(0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::split<T0>(&mut arg1.vault, v11), arg5));
                v4.reward_harvested = v4.reward_harvested + v11;
                let v13 = ClaimRewarderEvent{
                    reward_token       : v5,
                    reward_debt        : v8,
                    reward_harvested   : v10,
                    total_stake_shares : arg1.total_stake_shares,
                    stake_shares       : arg0,
                    claim_amount       : v11,
                };
                0x2::event::emit<ClaimRewarderEvent>(v13);
                continue
            };
        };
        v2
    }

    public(friend) fun emergency_withdraw_rewarder<T0: drop>(arg0: &mut RewardPool, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(&mut arg0.rewarders, &arg1);
        let v1 = v0.total_reward - v0.reward_harvested;
        v0.reward_harvested = v0.total_reward;
        v0.last_reward_time = 0x2::clock::timestamp_ms(arg2);
        v0.end_time = 0x2::clock::timestamp_ms(arg2);
        v0.active = false;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::split<T0>(&mut arg0.vault, v1), arg3), v0.owner);
        v1
    }

    public(friend) fun enable_rewarder(arg0: &mut RewardPool, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(&mut arg0.rewarders, &arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg2), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::acl_invalid_permission());
        assert!(v0.active == false, 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::pool_rewarder_already_active());
        v0.active = true;
    }

    public fun get_pool_rewarder_info(arg0: &PoolRewarderInfo) : (0x1::type_name::TypeName, u64, u64, u256, u64, u64, u64, bool) {
        (arg0.reward_token, arg0.emission_per_second, arg0.total_reward, arg0.acc_per_share, arg0.last_reward_time, arg0.reward_harvested, arg0.end_time, arg0.active)
    }

    public fun get_total_stake_shares(arg0: &RewardPool) : u64 {
        arg0.total_stake_shares
    }

    public fun init_reward_pool(arg0: &mut 0x2::tx_context::TxContext) : RewardPool {
        RewardPool{
            vault              : 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::new(arg0),
            total_stake_shares : 0,
            rewarders          : 0x2::vec_map::empty<0x2::object::ID, PoolRewarderInfo>(),
        }
    }

    public fun is_pool_rewarder_valid(arg0: &PoolRewarderInfo) : bool {
        arg0.active
    }

    public(friend) fun remove_rewarder(arg0: &mut RewardPool, arg1: 0x2::object::ID) {
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, PoolRewarderInfo>(&mut arg0.rewarders, &arg1);
        let v2 = v1;
        assert!(v2.total_reward <= v2.reward_harvested + 1000, 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::reward_not_harvested());
        let PoolRewarderInfo {
            id                  : v3,
            owner               : _,
            reward_token        : _,
            emission_per_second : _,
            total_reward        : _,
            last_reward_time    : _,
            reward_harvested    : _,
            acc_per_share       : _,
            start_time          : _,
            end_time            : _,
            active              : _,
        } = v2;
        0x2::object::delete(v3);
    }

    public(friend) fun remove_stake_shares(arg0: &mut RewardPool, arg1: u64) {
        arg0.total_stake_shares = arg0.total_stake_shares - arg1;
    }

    public(friend) fun stake_rewarder(arg0: &mut RewardPool, arg1: u64, arg2: &mut 0x2::vec_map::VecMap<0x2::object::ID, u256>, arg3: &0x2::clock::Clock) {
        let v0 = &mut arg0.rewarders;
        let v1 = 0x2::vec_map::keys<0x2::object::ID, PoolRewarderInfo>(v0);
        while (!0x1::vector::is_empty<0x2::object::ID>(&v1)) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut v1);
            let v3 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(v0, &v2);
            if (!is_pool_rewarder_valid(v3)) {
                continue
            };
            update_acc_per_share(v3, arg0.total_stake_shares, arg3);
            0x2::vec_map::insert<0x2::object::ID, u256>(arg2, 0x2::object::id<PoolRewarderInfo>(v3), (arg1 as u256) * (v3.acc_per_share as u256));
        };
        arg0.total_stake_shares = arg0.total_stake_shares + arg1;
    }

    public(friend) fun stop_rewarder(arg0: &mut RewardPool, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(&mut arg0.rewarders, &arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg2), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::acl_invalid_permission());
        assert!(v0.active == true, 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::pool_rewarder_not_active());
        v0.active = false;
    }

    public(friend) fun update_acc_per_share(arg0: &mut PoolRewarderInfo, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = v0;
        if (arg0.end_time < v0) {
            v1 = arg0.end_time;
        };
        if (arg1 != 0) {
            arg0.acc_per_share = arg0.acc_per_share + 18446744073709551615 * ((((v1 - arg0.last_reward_time) as u64) / 1000) as u256) * (arg0.emission_per_second as u256) / (arg1 as u256);
        };
        arg0.last_reward_time = v1;
    }

    public(friend) fun update_rewarder<T0: drop>(arg0: &mut RewardPool, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(&mut arg0.rewarders, &arg1);
        assert!(v0.active == true, 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::pool_rewarder_not_active());
        assert!((arg3 - v0.start_time) / 1000 * arg2 - v0.total_reward <= 0x2::coin::value<T0>(&arg4), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::emission_exceeds_total_reward());
        assert!(0x1::type_name::get<T0>() == v0.reward_token, 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::reward_token_type_mismatch());
        assert!(v0.owner == 0x2::tx_context::sender(arg6), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::acl_invalid_permission());
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::balance_bag::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg4));
        v0.total_reward = v0.total_reward + 0x2::coin::value<T0>(&arg4);
    }

    // decompiled from Move bytecode v6
}

