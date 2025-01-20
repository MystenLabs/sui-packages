module 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::investment {
    struct Investment has drop, store {
        id: u64,
        amount: u64,
        lock_time: u64,
        start_release_time: u64,
        period_duration: u64,
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
        arg0 / arg1 * arg1 + arg1
    }

    public fun calculate_rewards(arg0: &Investment, arg1: &ProfitCS, arg2: u64) : (u64, u64, u64, u64, &ProfitConfig) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::borrow<ProfitConfig>(&arg1.configs, 0);
        let v4 = calculate_lock_period(arg0.start_release_time, arg0.period_duration, arg2);
        if (v4 > 0) {
            let (v5, v6) = find_profict_config(arg0, arg1, arg2);
            v3 = v6;
            let v7 = arg0.amount * v6.profit_rate * v4 / 10000;
            v0 = v7;
            v1 = v7 * v6.fee_rate / 10000;
            if (v5 > 0) {
                let v8 = 0x1::vector::borrow<ProfitConfig>(&arg1.configs, v5 - 1);
                v2 = v7 - arg0.amount * v8.profit_rate * v8.max_period / 10000;
            };
        };
        (v0, v1, v2, v4, v3)
    }

    public(friend) fun create_investment(arg0: u64, arg1: u64, arg2: &ProfitCS, arg3: u64) : Investment {
        Investment{
            id                 : arg0,
            amount             : arg1,
            lock_time          : arg3,
            start_release_time : calculate_release_time(arg3, arg2.duration),
            period_duration    : arg2.duration,
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

    public(friend) fun reset_investment_release_time(arg0: &mut Investment, arg1: &ProfitCS, arg2: u64) {
        arg0.start_release_time = calculate_release_time(arg2, arg1.duration) - arg1.duration;
    }

    // decompiled from Move bytecode v6
}

