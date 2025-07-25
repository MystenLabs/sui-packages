module 0xc88437011e7b102b51d599f16e11d96e06c147a10fa46aa786803d960c1d949f::artfi_liquid_staking {
    struct ArtfiStaking<phantom T0> has key {
        id: 0x2::object::UID,
        rewardrate: u64,
        sender: address,
        amount: 0x2::balance::Balance<T0>,
        duration: u64,
        start_time: u64,
        claim_interval: u64,
        total_staked: u64,
        max_stake: u64,
        total_capacity: u64,
        minimum_stake: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        obj_id: 0x2::object::ID,
    }

    struct ArtfiReward<phantom T0> has store, key {
        id: 0x2::object::UID,
        staker: address,
        amount: 0x2::balance::Balance<T0>,
        withdraw_amount: u64,
        start_time: u64,
        last_claim_time: u64,
    }

    struct DeployerRegistry has key {
        id: 0x2::object::UID,
        deployer: address,
    }

    public entry fun add_rewards<T0>(arg0: &mut ArtfiStaking<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.sender, 8);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 1);
        0x2::balance::join<T0>(&mut arg0.amount, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun create_staking<T0>(arg0: u64, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(arg2 > 0, 1);
        assert!(arg0 > 0 && arg0 <= 10000, 2);
        assert!(arg3 > 0, 3);
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 0);
        let v1 = 0x2::object::new(arg9);
        let v2 = ArtfiStaking<T0>{
            id             : v1,
            rewardrate     : arg0,
            sender         : v0,
            amount         : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg2, arg9)),
            duration       : arg3,
            start_time     : 0x2::clock::timestamp_ms(arg8),
            claim_interval : arg4,
            total_staked   : 0,
            max_stake      : arg5,
            total_capacity : arg6,
            minimum_stake  : arg7,
        };
        0x2::transfer::share_object<ArtfiStaking<T0>>(v2);
        let v3 = AdminCap{
            id     : 0x2::object::new(arg9),
            obj_id : 0x2::object::uid_to_inner(&v1),
        };
        0x2::transfer::public_transfer<AdminCap>(v3, v0);
    }

    public entry fun deployer_withdraw_with_registry<T0>(arg0: &mut ArtfiStaking<T0>, arg1: &DeployerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.deployer, 8);
        let v1 = if (arg2 == 0) {
            0x2::balance::value<T0>(&arg0.amount)
        } else {
            assert!(arg2 <= 0x2::balance::value<T0>(&arg0.amount), 0);
            arg2
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.amount, v1, arg3), v0);
        };
    }

    public entry fun get_regwards<T0>(arg0: &mut ArtfiStaking<T0>, arg1: &DeployerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.deployer, 8);
        let v1 = if (arg2 == 0) {
            0x2::balance::value<T0>(&arg0.amount)
        } else {
            assert!(arg2 <= 0x2::balance::value<T0>(&arg0.amount), 0);
            arg2
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.amount, v1, arg3), v0);
        };
    }

    public entry fun get_rewards<T0>(arg0: &mut ArtfiStaking<T0>, arg1: &DeployerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.deployer, 8);
        let v1 = if (arg2 == 0) {
            0x2::balance::value<T0>(&arg0.amount)
        } else {
            assert!(arg2 <= 0x2::balance::value<T0>(&arg0.amount), 0);
            arg2
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.amount, v1, arg3), v0);
        };
    }

    public entry fun init_deployer_registry(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerRegistry{
            id       : 0x2::object::new(arg1),
            deployer : arg0,
        };
        0x2::transfer::share_object<DeployerRegistry>(v0);
    }

    public entry fun receive_reward<T0>(arg0: &mut ArtfiStaking<T0>, arg1: ArtfiReward<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.staker, 6);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg1.last_claim_time + arg0.claim_interval, 7);
        assert!(v1 <= arg0.start_time + arg0.duration, 11);
        let v2 = (((0x2::balance::value<T0>(&arg1.amount) as u128) * (arg0.rewardrate as u128) * ((v1 - arg1.start_time) as u128) * 10000 / (arg0.duration as u128) / 100000000) as u64) - arg1.withdraw_amount;
        assert!(v2 >= 0, 0);
        assert!(0x2::balance::value<T0>(&arg0.amount) >= v2, 0);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.amount, v2, arg3), v0);
            arg1.withdraw_amount = arg1.withdraw_amount + v2;
        };
        arg1.last_claim_time = v1;
        0x2::transfer::public_transfer<ArtfiReward<T0>>(arg1, v0);
    }

    public entry fun stake_token<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut ArtfiStaking<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1 > 0, 1);
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
        assert!(arg1 >= arg2.minimum_stake, 12);
        assert!(arg2.total_staked + arg1 <= arg2.total_capacity, 9);
        assert!(arg1 <= arg2.max_stake, 10);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = ArtfiReward<T0>{
            id              : 0x2::object::new(arg4),
            staker          : v0,
            amount          : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg1, arg4)),
            withdraw_amount : 0,
            start_time      : v1,
            last_claim_time : v1,
        };
        0x2::transfer::public_transfer<ArtfiReward<T0>>(v2, v0);
        arg2.total_staked = arg2.total_staked + arg1;
    }

    public entry fun unstake_fund<T0>(arg0: &mut ArtfiStaking<T0>, arg1: ArtfiReward<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.staker, 6);
        let v1 = 0x2::balance::value<T0>(&arg1.amount);
        let v2 = (((v1 as u128) * (arg0.rewardrate as u128) * ((0x2::clock::timestamp_ms(arg2) - arg1.start_time) as u128) * 10000 / (arg0.duration as u128) / 100000000) as u64) - arg1.withdraw_amount;
        assert!(v2 >= 0, 0);
        assert!(0x2::balance::value<T0>(&arg0.amount) >= v2, 0);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.amount, v2, arg3), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.amount, v1, arg3), v0);
        arg0.total_staked = arg0.total_staked - v1;
        let ArtfiReward {
            id              : v3,
            staker          : _,
            amount          : v5,
            withdraw_amount : _,
            start_time      : _,
            last_claim_time : _,
        } = arg1;
        0x2::object::delete(v3);
        0x2::balance::destroy_zero<T0>(v5);
    }

    public entry fun withdraw_excess_rewards<T0>(arg0: &mut ArtfiStaking<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.sender, 8);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start_time + arg0.duration, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.amount, 0x2::balance::value<T0>(&arg0.amount), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

