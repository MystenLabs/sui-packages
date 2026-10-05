module 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::combat_rewards {
    struct CombatPot<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        authorized: 0x1::type_name::TypeName,
        started_ms: u64,
        epoch: u64,
        epoch_started_ms: u64,
        work: u64,
        quota: u64,
        day: u64,
        spent: u64,
    }

    public fun balance<T0>(arg0: &CombatPot<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun create<T0, T1: drop>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : CombatPot<T0> {
        assert!(0x2::balance::value<T0>(&arg0) == 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::amounts::combat_tokens(), 0);
        CombatPot<T0>{
            id               : 0x2::object::new(arg2),
            balance          : arg0,
            authorized       : 0x1::type_name::with_original_ids<T1>(),
            started_ms       : 0x2::clock::timestamp_ms(arg1),
            epoch            : 0x2::tx_context::epoch(arg2),
            epoch_started_ms : 0x2::tx_context::epoch_timestamp_ms(arg2),
            work             : 0,
            quota            : 20000,
            day              : 0,
            spent            : 0,
        }
    }

    public fun daily_budget() : u64 {
        0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::amounts::combat_tokens() / 1825
    }

    public fun fund<T0>(arg0: &mut CombatPot<T0>, arg1: 0x2::coin::Coin<T0>) {
        fund_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun fund_balance<T0>(arg0: &mut CombatPot<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun initial_tokens() : u64 {
        0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::amounts::combat_tokens()
    }

    public fun quota<T0>(arg0: &CombatPot<T0>) : u64 {
        arg0.quota
    }

    fun retarget<T0>(arg0: &mut CombatPot<T0>, arg1: u64, arg2: u64) {
        if (arg1 == arg0.epoch) {
            return
        };
        arg0.quota = (0x1::u128::min(0x1::u128::max(((arg0.quota as u128) + (arg0.work as u128) * (86400000 as u128) / (0x1::u64::max(arg2 - arg0.epoch_started_ms, 1) as u128)) / 2, (20000 as u128)), 18446744073709551615) as u64);
        arg0.epoch = arg1;
        arg0.epoch_started_ms = arg2;
        arg0.work = 0;
    }

    public(friend) fun share<T0>(arg0: CombatPot<T0>) {
        0x2::transfer::share_object<CombatPot<T0>>(arg0);
    }

    public fun spent<T0>(arg0: &CombatPot<T0>) : u64 {
        arg0.spent
    }

    public fun take<T0, T1: drop>(arg0: &mut CombatPot<T0>, arg1: T1, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.authorized == 0x1::type_name::with_original_ids<T1>(), 1);
        if (arg2 == 0 || arg3 == 0) {
            return 0x2::balance::zero<T0>()
        };
        retarget<T0>(arg0, 0x2::tx_context::epoch(arg5), 0x2::tx_context::epoch_timestamp_ms(arg5));
        arg0.work = (0x1::u128::min((arg0.work as u128) + (arg2 as u128), 18446744073709551615) as u64);
        let v0 = (0x2::clock::timestamp_ms(arg4) - arg0.started_ms) / 86400000;
        if (v0 != arg0.day) {
            arg0.day = v0;
            arg0.spent = 0;
        };
        let v1 = 0x1::u64::min(0x1::u64::min((0x1::u128::min((daily_budget() as u128) * (arg2 as u128) / (arg0.quota as u128), 18446744073709551615) as u64), daily_budget() - arg0.spent), 0x2::balance::value<T0>(&arg0.balance)) / arg3 * arg3;
        arg0.spent = arg0.spent + v1;
        0x2::balance::split<T0>(&mut arg0.balance, v1)
    }

    public fun work<T0>(arg0: &CombatPot<T0>) : u64 {
        arg0.work
    }

    // decompiled from Move bytecode v7
}

