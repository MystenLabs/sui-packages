module 0x123fc385b4d17d0cfe9d9f561dd475b163db6f91fbb7481af5019fe3032baa6c::geyser_staking_contract {
    struct Owner has store, key {
        id: 0x2::object::UID,
        owner_address: address,
    }

    struct StakingInfo has copy, drop, store {
        user_total_stake: u64,
        stake_time: u64,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        user_stake_info: 0x2::vec_map::VecMap<address, StakingInfo>,
        total_staked: 0x2::coin::Coin<0x2::sui::SUI>,
        lock_period: u64,
    }

    struct UpgradeVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct GEYSER_STAKING_CONTRACT has drop {
        dummy_field: bool,
    }

    struct ChangedOwner has copy, drop {
        current_owner: address,
        new_owner: address,
    }

    struct Staked has copy, drop {
        staker: address,
        staker_info: StakingInfo,
        staked_amount: u64,
    }

    struct StakeMore has copy, drop {
        staker: address,
        staker_info: StakingInfo,
        stake_more_amount: u64,
    }

    struct Unstaked has copy, drop {
        staker: address,
        unstaked_amount: u64,
    }

    struct LockPeriod has copy, drop {
        new_lock_period: u64,
    }

    struct WithdrawnFunds has copy, drop {
        rescued_amount: u64,
    }

    public entry fun change_owner(arg0: Owner, arg1: 0x2::package::UpgradeCap, arg2: address, arg3: &UpgradeVersion, arg4: &0x2::tx_context::TxContext) {
        let v0 = arg0.owner_address;
        assert!(0x2::tx_context::sender(arg4) == v0, 7);
        assert!(arg3.version == 0, 1);
        assert!(@0x0 != arg2, 8);
        assert!(arg2 != v0, 9);
        arg0.owner_address = arg2;
        0x2::transfer::public_transfer<Owner>(arg0, arg2);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg1, arg2);
        let v1 = ChangedOwner{
            current_owner : v0,
            new_owner     : arg2,
        };
        0x2::event::emit<ChangedOwner>(v1);
    }

    public entry fun configure_lock_period(arg0: &Owner, arg1: &mut StakingPool, arg2: &UpgradeVersion, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 1);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 7);
        assert!(arg3 != 0, 11);
        arg1.lock_period = arg3;
        let v0 = LockPeriod{new_lock_period: arg3};
        0x2::event::emit<LockPeriod>(v0);
    }

    fun init(arg0: GEYSER_STAKING_CONTRACT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Owner{
            id            : 0x2::object::new(arg1),
            owner_address : v0,
        };
        0x2::transfer::public_transfer<Owner>(v1, v0);
        let v2 = UpgradeVersion{
            id      : 0x2::object::new(arg1),
            version : 0,
        };
        0x2::transfer::share_object<UpgradeVersion>(v2);
        let v3 = StakingPool{
            id              : 0x2::object::new(arg1),
            user_stake_info : 0x2::vec_map::empty<address, StakingInfo>(),
            total_staked    : 0x2::coin::zero<0x2::sui::SUI>(arg1),
            lock_period     : 86400,
        };
        0x2::transfer::share_object<StakingPool>(v3);
    }

    public entry fun rescue_funds_from_pool(arg0: &Owner, arg1: &mut StakingPool, arg2: &UpgradeVersion, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner_address, 7);
        assert!(arg2.version == 0, 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1.total_staked);
        assert!(v1 != 0, 6);
        let v2 = 0x2::coin::split<0x2::sui::SUI>(&mut arg1.total_staked, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0);
        let v3 = WithdrawnFunds{rescued_amount: 0x2::coin::value<0x2::sui::SUI>(&v2)};
        0x2::event::emit<WithdrawnFunds>(v3);
    }

    public entry fun stake(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut StakingPool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &UpgradeVersion, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg4.version == 0, 1);
        assert!(arg2 != 0, 2);
        assert!(arg2 <= 0x2::coin::value<0x2::sui::SUI>(arg0), 3);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(arg0, arg2, arg5);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        if (0x2::vec_map::contains<address, StakingInfo>(&arg1.user_stake_info, &v0)) {
            let v3 = 0x2::vec_map::get_mut<address, StakingInfo>(&mut arg1.user_stake_info, &v0);
            v3.user_total_stake = v3.user_total_stake + v2;
            v3.stake_time = time_in_secs(arg3);
            let v4 = StakeMore{
                staker            : v0,
                staker_info       : *0x2::vec_map::get<address, StakingInfo>(&arg1.user_stake_info, &v0),
                stake_more_amount : arg2,
            };
            0x2::event::emit<StakeMore>(v4);
        } else {
            let v5 = StakingInfo{
                user_total_stake : v2,
                stake_time       : time_in_secs(arg3),
            };
            0x2::vec_map::insert<address, StakingInfo>(&mut arg1.user_stake_info, v0, v5);
            let v6 = Staked{
                staker        : v0,
                staker_info   : *0x2::vec_map::get<address, StakingInfo>(&arg1.user_stake_info, &v0),
                staked_amount : v2,
            };
            0x2::event::emit<Staked>(v6);
        };
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.total_staked, v1);
    }

    public fun time_in_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public entry fun unstake(arg0: &mut StakingPool, arg1: u64, arg2: &0x2::clock::Clock, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg3.version == 0, 1);
        assert!(0x2::vec_map::contains<address, StakingInfo>(&arg0.user_stake_info, &v0), 4);
        assert!(arg1 != 0, 2);
        let v1 = 0x2::vec_map::get_mut<address, StakingInfo>(&mut arg0.user_stake_info, &v0);
        assert!(time_in_secs(arg2) >= v1.stake_time + arg0.lock_period, 5);
        assert!(arg1 <= v1.user_total_stake, 6);
        let v2 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0.total_staked, arg1, arg4);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        assert!(v3 == arg1, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0);
        v1.user_total_stake = v1.user_total_stake - v3;
        if (v1.user_total_stake == 0) {
            let (_, _) = 0x2::vec_map::remove<address, StakingInfo>(&mut arg0.user_stake_info, &v0);
        };
        let v6 = Unstaked{
            staker          : v0,
            unstaked_amount : v3,
        };
        0x2::event::emit<Unstaked>(v6);
    }

    entry fun upgrade_contract_version(arg0: &Owner, arg1: &mut UpgradeVersion, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 7);
        assert!(arg1.version < 0, 1);
        arg1.version = 0;
    }

    // decompiled from Move bytecode v6
}

