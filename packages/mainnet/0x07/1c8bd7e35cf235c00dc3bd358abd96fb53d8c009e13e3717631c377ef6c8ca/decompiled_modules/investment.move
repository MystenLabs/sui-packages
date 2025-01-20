module 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::investment {
    struct Investment has drop, store {
        id: u64,
        amount: u64,
        lock_time: u64,
        start_release_time: u64,
        period_duration: u64,
        received_period: u64,
    }

    struct ProfitCS has store {
        duration: u64,
        configs: vector<ProfitConfig>,
    }

    struct ProfitConfig has drop, store {
        fee_rate: u64,
        profit_rate: u64,
        min_period: u64,
        max_period: u64,
    }

    public(friend) fun add_profict_config(arg0: &mut ProfitCS, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ProfitConfig{
            fee_rate    : arg1,
            profit_rate : arg2,
            min_period  : arg3,
            max_period  : arg4,
        };
        0x1::vector::push_back<ProfitConfig>(&mut arg0.configs, v0);
    }

    fun calculate_lock_period(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 > arg2) {
            0
        } else {
            (arg2 - arg0) / arg1
        }
    }

    public fun calculate_release_time(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 == 86400000, 0);
        if (arg0 % 86400000 / 3600000 < 16) {
            arg0 / arg1 * arg1
        } else {
            arg0 / arg1 * arg1 + arg1
        }
    }

    public fun calculate_rewards(arg0: &Investment, arg1: &ProfitCS, arg2: u64) : (u64, u64, u64, u64, &ProfitConfig) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::borrow<ProfitConfig>(&arg1.configs, 0);
        let v4 = calculate_lock_period(arg0.start_release_time, arg0.period_duration, arg2);
        assert!(v4 >= arg0.received_period, 2);
        let v5 = v4 - arg0.received_period;
        if (v4 > 0 && v5 > 0) {
            let (v6, v7) = find_profict_config(arg0, arg1, arg2);
            v3 = v7;
            let v8 = arg0.amount * v7.profit_rate * v5 / 10000;
            v0 = v8;
            v1 = v8 * v7.fee_rate / 10000;
            if (v6 > 0) {
                let v9 = 0x1::vector::borrow<ProfitConfig>(&arg1.configs, v6 - 1);
                v2 = v8 - arg0.amount * v9.profit_rate * v9.max_period / 10000;
            };
        };
        (v0, v1, v2, v5, v3)
    }

    public(friend) fun claim_reward(arg0: &mut Investment, arg1: u64) {
        arg0.received_period = arg0.received_period + arg1;
    }

    public(friend) fun create_investment(arg0: u64, arg1: u64, arg2: &ProfitCS, arg3: u64) : Investment {
        Investment{
            id                 : arg0,
            amount             : arg1,
            lock_time          : arg3,
            start_release_time : calculate_release_time(arg3, arg2.duration),
            period_duration    : arg2.duration,
            received_period    : 0,
        }
    }

    public(friend) fun create_profit_cs(arg0: u64) : ProfitCS {
        ProfitCS{
            duration : arg0,
            configs  : 0x1::vector::empty<ProfitConfig>(),
        }
    }

    fun find_profict_config(arg0: &Investment, arg1: &ProfitCS, arg2: u64) : (u64, &ProfitConfig) {
        let v0 = false;
        let v1 = 0x1::vector::borrow<ProfitConfig>(&arg1.configs, 0);
        let v2 = 0x1::vector::length<ProfitConfig>(&arg1.configs);
        while (v2 > 0) {
            let v3 = v2 - 1;
            v2 = v3;
            let v4 = 0x1::vector::borrow<ProfitConfig>(&arg1.configs, v3);
            if (calculate_lock_period(arg0.start_release_time, arg0.period_duration, arg2) >= v4.min_period) {
                v0 = true;
                v1 = v4;
                break
            };
        };
        assert!(v0, 1);
        (v2, v1)
    }

    public(friend) fun investment_id(arg0: &Investment) : u64 {
        arg0.id
    }

    public(friend) fun investment_value(arg0: &Investment) : (u64, u64, u64, u64, u64) {
        (arg0.id, arg0.amount, arg0.lock_time, arg0.start_release_time, arg0.period_duration)
    }

    public(friend) fun profit_config_value(arg0: &ProfitConfig) : (u64, u64, u64, u64) {
        (arg0.fee_rate, arg0.profit_rate, arg0.min_period, arg0.max_period)
    }

    public(friend) fun remove_profict_config(arg0: &mut ProfitCS, arg1: u64) {
        0x1::vector::remove<ProfitConfig>(&mut arg0.configs, arg1);
    }

    // decompiled from Move bytecode v6
}

