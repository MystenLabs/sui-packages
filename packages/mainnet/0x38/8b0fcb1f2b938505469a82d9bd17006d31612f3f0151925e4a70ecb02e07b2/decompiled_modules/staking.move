module 0x388b0fcb1f2b938505469a82d9bd17006d31612f3f0151925e4a70ecb02e07b2::staking {
    struct StakingConfig has key {
        id: 0x2::object::UID,
        owner: address,
        min_stake: u64,
        max_stake: u64,
        paused: bool,
        percent1: u64,
        percent2: u64,
        percent3: u64,
        period1: u64,
        period2: u64,
        period3: u64,
        fuki_balance: 0x2::balance::Balance<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>,
    }

    struct Stake has store, key {
        id: 0x2::object::UID,
        user: address,
        start_time: u64,
        staking_period: u64,
        unlock_time: u64,
        percent: u64,
        reward: u64,
        locked: bool,
        balance: 0x2::balance::Balance<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct STAKING has drop {
        dummy_field: bool,
    }

    public fun admin_deposit(arg0: &OwnerCap, arg1: 0x2::coin::Coin<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>, arg2: &mut StakingConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>(&mut arg2.fuki_balance, arg1);
    }

    public fun admin_withdraw(arg0: &OwnerCap, arg1: &mut StakingConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>>(0x2::coin::take<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>(&mut arg1.fuki_balance, 0x2::balance::value<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>(&arg1.fuki_balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun change_percent(arg0: &OwnerCap, arg1: &mut StakingConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        arg1.percent1 = arg2;
        arg1.percent2 = arg3;
        arg1.percent3 = arg4;
    }

    public fun change_periods(arg0: &OwnerCap, arg1: &mut StakingConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        arg1.period1 = arg2;
        arg1.period2 = arg3;
        arg1.period3 = arg4;
    }

    public fun deposit(arg0: 0x2::coin::Coin<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>, arg1: &StakingConfig, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 3);
        assert!(arg3 >= 1 && arg3 <= 3, 4);
        let v0 = 0x2::coin::value<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>(&arg0);
        assert!(v0 <= arg1.max_stake, 1);
        assert!(v0 >= arg1.min_stake, 2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0;
        let v3 = 0;
        if (arg3 == 1) {
            v2 = arg1.percent1;
            v3 = arg1.period1;
        };
        if (arg3 == 2) {
            v2 = arg1.percent2;
            v3 = arg1.period2;
        };
        if (arg3 == 3) {
            v2 = arg1.percent3;
            v3 = arg1.period3;
        };
        let v4 = Stake{
            id             : 0x2::object::new(arg4),
            user           : 0x2::tx_context::sender(arg4),
            start_time     : v1,
            staking_period : v3,
            unlock_time    : v1 + v3,
            percent        : v2,
            reward         : v0 * v2 / 100,
            locked         : true,
            balance        : 0x2::coin::into_balance<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>(arg0),
        };
        0x2::transfer::public_transfer<Stake>(v4, 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<STAKING>(arg0, arg1);
        let v0 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = StakingConfig{
            id           : 0x2::object::new(arg1),
            owner        : 0x2::tx_context::sender(arg1),
            min_stake    : 1000000000,
            max_stake    : 100000000000000,
            paused       : false,
            percent1     : 7,
            percent2     : 25,
            percent3     : 60,
            period1      : 2592000000,
            period2      : 5184000000,
            period3      : 7776000000,
            fuki_balance : 0x2::balance::zero<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>(),
        };
        0x2::transfer::share_object<StakingConfig>(v1);
    }

    public fun pause_staking(arg0: &OwnerCap, arg1: &mut StakingConfig, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.paused = !arg1.paused;
    }

    public fun withdraw(arg0: &mut Stake, arg1: &mut StakingConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.unlock_time, 5);
        0x2::balance::join<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>(&mut arg0.balance, 0x2::balance::split<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>(&mut arg1.fuki_balance, arg0.reward));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>>(0x2::coin::take<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>(&mut arg0.balance, 0x2::balance::value<0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki::FUKI>(&arg0.balance), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

