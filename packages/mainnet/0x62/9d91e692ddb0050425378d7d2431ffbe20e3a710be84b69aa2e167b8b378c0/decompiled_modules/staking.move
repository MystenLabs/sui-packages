module 0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::staking {
    struct StakePool has key {
        id: 0x2::object::UID,
        reward_balance: 0x2::balance::Balance<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>,
        total_staked: u64,
        apy_bps: u64,
        min_hold_ms: u64,
        penalty_bps: u64,
        paused: bool,
    }

    struct StakePosition has store, key {
        id: 0x2::object::UID,
        staked: 0x2::balance::Balance<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>,
        start_ms: u64,
        last_update_ms: u64,
        accrued_unclaimed: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: address,
        apy_bps: u64,
        min_hold_ms: u64,
        penalty_bps: u64,
    }

    struct Staked has copy, drop {
        who: address,
        amount: u64,
        new_total: u64,
    }

    struct Claimed has copy, drop {
        who: address,
        amount: u64,
    }

    struct Unstaked has copy, drop {
        who: address,
        principal: u64,
        reward_paid: u64,
        penalty_forfeited: u64,
    }

    struct RewardsFunded has copy, drop {
        amount: u64,
        new_balance: u64,
    }

    struct ParamsUpdated has copy, drop {
        apy_bps: u64,
        min_hold_ms: u64,
        penalty_bps: u64,
    }

    public fun add_stake(arg0: &mut StakePosition, arg1: 0x2::coin::Coin<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>, arg2: &mut StakePool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.paused, 2);
        let v0 = 0x2::coin::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&arg1);
        assert!(v0 > 0, 1);
        settle(arg0, arg2, arg3);
        0x2::balance::join<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&mut arg0.staked, 0x2::coin::into_balance<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(arg1));
        arg2.total_staked = arg2.total_staked + v0;
        let v1 = Staked{
            who       : 0x2::tx_context::sender(arg4),
            amount    : v0,
            new_total : arg2.total_staked,
        };
        0x2::event::emit<Staked>(v1);
    }

    public fun apy_bps(arg0: &StakePool) : u64 {
        arg0.apy_bps
    }

    public fun claim(arg0: &mut StakePosition, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 2);
        settle(arg0, arg1, arg2);
        let v0 = 0x2::balance::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&arg1.reward_balance);
        let v1 = if (arg0.accrued_unclaimed > v0) {
            v0
        } else {
            arg0.accrued_unclaimed
        };
        if (v1 == 0) {
            return
        };
        arg0.accrued_unclaimed = arg0.accrued_unclaimed - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>>(0x2::coin::from_balance<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(0x2::balance::split<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&mut arg1.reward_balance, v1), arg3), 0x2::tx_context::sender(arg3));
        let v2 = Claimed{
            who    : 0x2::tx_context::sender(arg3),
            amount : v1,
        };
        0x2::event::emit<Claimed>(v2);
    }

    public fun create_pool(arg0: &0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = StakePool{
            id             : 0x2::object::new(arg4),
            reward_balance : 0x2::balance::zero<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(),
            total_staked   : 0,
            apy_bps        : arg1,
            min_hold_ms    : arg2,
            penalty_bps    : arg3,
            paused         : false,
        };
        let v1 = PoolCreated{
            pool_id     : 0x2::object::uid_to_address(&v0.id),
            apy_bps     : arg1,
            min_hold_ms : arg2,
            penalty_bps : arg3,
        };
        0x2::event::emit<PoolCreated>(v1);
        0x2::transfer::share_object<StakePool>(v0);
    }

    public fun fund_rewards(arg0: &0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::AdminCap, arg1: &mut StakePool, arg2: 0x2::coin::Coin<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>) {
        let v0 = 0x2::coin::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&arg2);
        assert!(v0 > 0, 1);
        0x2::balance::join<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&mut arg1.reward_balance, 0x2::coin::into_balance<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(arg2));
        let v1 = RewardsFunded{
            amount      : v0,
            new_balance : 0x2::balance::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&arg1.reward_balance),
        };
        0x2::event::emit<RewardsFunded>(v1);
    }

    public fun is_paused(arg0: &StakePool) : bool {
        arg0.paused
    }

    public fun min_hold_ms(arg0: &StakePool) : u64 {
        arg0.min_hold_ms
    }

    public fun open_position(arg0: 0x2::coin::Coin<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 2);
        let v0 = 0x2::coin::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = StakePosition{
            id                : 0x2::object::new(arg3),
            staked            : 0x2::coin::into_balance<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(arg0),
            start_ms          : v1,
            last_update_ms    : v1,
            accrued_unclaimed : 0,
        };
        arg1.total_staked = arg1.total_staked + v0;
        let v3 = Staked{
            who       : 0x2::tx_context::sender(arg3),
            amount    : v0,
            new_total : arg1.total_staked,
        };
        0x2::event::emit<Staked>(v3);
        0x2::transfer::public_transfer<StakePosition>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun penalty_bps(arg0: &StakePool) : u64 {
        arg0.penalty_bps
    }

    public fun pending_reward(arg0: &StakePosition, arg1: &StakePool, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = if (v0 > arg0.last_update_ms) {
            v0 - arg0.last_update_ms
        } else {
            0
        };
        let v2 = 0x2::balance::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&arg0.staked);
        let v3 = if (v2 > 0) {
            if (arg1.apy_bps > 0) {
                v1 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v4 = if (v3) {
            (((v2 as u128) * (arg1.apy_bps as u128) * (v1 as u128) / (10000 as u128) / (31536000000 as u128)) as u64)
        } else {
            0
        };
        arg0.accrued_unclaimed + v4
    }

    public fun position_start_ms(arg0: &StakePosition) : u64 {
        arg0.start_ms
    }

    public fun reward_balance(arg0: &StakePool) : u64 {
        0x2::balance::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&arg0.reward_balance)
    }

    public fun set_params(arg0: &0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::AdminCap, arg1: &mut StakePool, arg2: u64, arg3: u64, arg4: u64) {
        arg1.apy_bps = arg2;
        arg1.min_hold_ms = arg3;
        arg1.penalty_bps = arg4;
        let v0 = ParamsUpdated{
            apy_bps     : arg2,
            min_hold_ms : arg3,
            penalty_bps : arg4,
        };
        0x2::event::emit<ParamsUpdated>(v0);
    }

    public fun set_paused(arg0: &0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::AdminCap, arg1: &mut StakePool, arg2: bool) {
        arg1.paused = arg2;
    }

    fun settle(arg0: &mut StakePosition, arg1: &StakePool, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 <= arg0.last_update_ms) {
            return
        };
        let v1 = 0x2::balance::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&arg0.staked);
        if (v1 > 0 && arg1.apy_bps > 0) {
            arg0.accrued_unclaimed = arg0.accrued_unclaimed + (((v1 as u128) * (arg1.apy_bps as u128) * ((v0 - arg0.last_update_ms) as u128) / (10000 as u128) / (31536000000 as u128)) as u64);
        };
        arg0.last_update_ms = v0;
    }

    public fun staked_amount(arg0: &StakePosition) : u64 {
        0x2::balance::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&arg0.staked)
    }

    public fun total_staked(arg0: &StakePool) : u64 {
        arg0.total_staked
    }

    public fun unstake(arg0: StakePosition, arg1: &mut StakePool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 2);
        let v0 = &mut arg0;
        settle(v0, arg1, arg2);
        let v1 = 0x2::balance::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&arg0.staked);
        let v2 = arg0.accrued_unclaimed;
        let v3 = v2;
        let v4 = 0;
        if (0x2::clock::timestamp_ms(arg2) - arg0.start_ms < arg1.min_hold_ms) {
            let v5 = v2 * arg1.penalty_bps / 10000;
            v4 = v5;
            v3 = v2 - v5;
        };
        let v6 = 0x2::balance::value<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&arg1.reward_balance);
        let v7 = if (v3 > v6) {
            v6
        } else {
            v3
        };
        let StakePosition {
            id                : v8,
            staked            : v9,
            start_ms          : _,
            last_update_ms    : _,
            accrued_unclaimed : _,
        } = arg0;
        0x2::object::delete(v8);
        arg1.total_staked = arg1.total_staked - v1;
        let v13 = 0x2::coin::from_balance<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(v9, arg3);
        if (v7 > 0) {
            0x2::coin::join<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&mut v13, 0x2::coin::from_balance<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(0x2::balance::split<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>(&mut arg1.reward_balance, v7), arg3));
        };
        let v14 = Unstaked{
            who               : 0x2::tx_context::sender(arg3),
            principal         : v1,
            reward_paid       : v7,
            penalty_forfeited : v4,
        };
        0x2::event::emit<Unstaked>(v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa1964d8d45e2cab45e4e675826ebba62a79e72fb740f519253dffa82d4fca785::nrv::NRV>>(v13, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

