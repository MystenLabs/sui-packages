module 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards {
    struct CombatPot has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>,
        authorized: 0x1::option::Option<0x1::type_name::TypeName>,
        epoch: u64,
        epoch_started_ms: u64,
        work: u64,
        quota: u64,
        day: u64,
        spent: u64,
    }

    public fun balance(arg0: &CombatPot) : u64 {
        0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg0.balance)
    }

    public(friend) fun authorize<T0: drop>(arg0: &mut CombatPot) {
        arg0.authorized = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_original_ids<T0>());
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : CombatPot {
        CombatPot{
            id               : 0x2::object::new(arg0),
            balance          : 0x2::balance::zero<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(),
            authorized       : 0x1::option::none<0x1::type_name::TypeName>(),
            epoch            : 0x2::tx_context::epoch(arg0),
            epoch_started_ms : 0x2::tx_context::epoch_timestamp_ms(arg0),
            work             : 0,
            quota            : 20000,
            day              : 0,
            spent            : 0,
        }
    }

    public fun daily_budget() : u64 {
        54794520547
    }

    public fun fund(arg0: &mut CombatPot, arg1: 0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>) {
        fund_balance(arg0, 0x2::coin::into_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(arg1));
    }

    public(friend) fun fund_balance(arg0: &mut CombatPot, arg1: 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>) {
        0x2::balance::join<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut arg0.balance, arg1);
    }

    public fun initial_tokens() : u64 {
        100000000000000
    }

    public fun quota(arg0: &CombatPot) : u64 {
        arg0.quota
    }

    fun retarget(arg0: &mut CombatPot, arg1: u64, arg2: u64) {
        if (arg1 == arg0.epoch) {
            return
        };
        arg0.quota = (0x1::u128::min(0x1::u128::max(((arg0.quota as u128) + (arg0.work as u128) * (86400000 as u128) / (0x1::u64::max(arg2 - arg0.epoch_started_ms, 1) as u128)) / 2, (20000 as u128)), 18446744073709551615) as u64);
        arg0.epoch = arg1;
        arg0.epoch_started_ms = arg2;
        arg0.work = 0;
    }

    public(friend) fun share(arg0: CombatPot) {
        0x2::transfer::share_object<CombatPot>(arg0);
    }

    public fun spent(arg0: &CombatPot) : u64 {
        arg0.spent
    }

    public(friend) fun take<T0: drop>(arg0: &mut CombatPot, arg1: T0, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES> {
        if (arg0.authorized != 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_original_ids<T0>())) {
            return 0x2::balance::zero<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>()
        };
        if (arg2 == 0 || arg3 == 0) {
            return 0x2::balance::zero<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>()
        };
        retarget(arg0, 0x2::tx_context::epoch(arg6), 0x2::tx_context::epoch_timestamp_ms(arg6));
        arg0.work = (0x1::u128::min((arg0.work as u128) + (arg2 as u128), 18446744073709551615) as u64);
        let v0 = (0x2::clock::timestamp_ms(arg5) - arg4) / 86400000;
        if (v0 != arg0.day) {
            arg0.day = v0;
            arg0.spent = 0;
        };
        let v1 = 0x1::u64::min(0x1::u64::min((0x1::u128::min((54794520547 as u128) * (arg2 as u128) / (arg0.quota as u128), 18446744073709551615) as u64), 54794520547 - arg0.spent), 0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg0.balance)) / arg3 * arg3;
        arg0.spent = arg0.spent + v1;
        0x2::balance::split<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut arg0.balance, v1)
    }

    public fun work(arg0: &CombatPot) : u64 {
        arg0.work
    }

    // decompiled from Move bytecode v7
}

