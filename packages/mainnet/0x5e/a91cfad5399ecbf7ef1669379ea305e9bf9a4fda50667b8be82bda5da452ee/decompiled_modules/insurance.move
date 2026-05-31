module 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::insurance {
    struct AdminCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
    }

    struct Fund<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T1>,
        total_inflow: u64,
        total_outflow: u64,
        threshold: u64,
        last_used_at_ms: u64,
    }

    struct InsuranceFundCreated has copy, drop {
        fund_id: 0x2::object::ID,
        threshold: u64,
    }

    struct InsuranceFundInflow has copy, drop {
        fund_id: 0x2::object::ID,
        amount: u64,
        total_inflow: u64,
        balance_after: u64,
    }

    struct InsuranceFundOutflow has copy, drop {
        fund_id: 0x2::object::ID,
        requested: u64,
        covered: u64,
        total_outflow: u64,
        balance_after: u64,
    }

    struct InsuranceBelowThreshold has copy, drop {
        fund_id: 0x2::object::ID,
        balance: u64,
        threshold: u64,
    }

    public fun balance<T0, T1>(arg0: &Fund<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance)
    }

    public fun id<T0, T1>(arg0: &Fund<T0, T1>) : 0x2::object::ID {
        0x2::object::id<Fund<T0, T1>>(arg0)
    }

    public fun cover<T0: drop, T1>(arg0: T0, arg1: &mut Fund<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x2::balance::value<T1>(&arg1.balance);
        let v1 = if (v0 < arg2) {
            v0
        } else {
            arg2
        };
        arg1.total_outflow = arg1.total_outflow + v1;
        arg1.last_used_at_ms = arg3;
        let v2 = 0x2::balance::value<T1>(&arg1.balance);
        let v3 = InsuranceFundOutflow{
            fund_id       : 0x2::object::id<Fund<T0, T1>>(arg1),
            requested     : arg2,
            covered       : v1,
            total_outflow : arg1.total_outflow,
            balance_after : v2,
        };
        0x2::event::emit<InsuranceFundOutflow>(v3);
        if (v2 < arg1.threshold) {
            let v4 = InsuranceBelowThreshold{
                fund_id   : 0x2::object::id<Fund<T0, T1>>(arg1),
                balance   : v2,
                threshold : arg1.threshold,
            };
            0x2::event::emit<InsuranceBelowThreshold>(v4);
        };
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance, v1), arg4), v1)
    }

    public fun deposit<T0: drop, T1>(arg0: T0, arg1: &mut Fund<T0, T1>, arg2: 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        0x2::balance::join<T1>(&mut arg1.balance, arg2);
        arg1.total_inflow = arg1.total_inflow + v0;
        let v1 = InsuranceFundInflow{
            fund_id       : 0x2::object::id<Fund<T0, T1>>(arg1),
            amount        : v0,
            total_inflow  : arg1.total_inflow,
            balance_after : 0x2::balance::value<T1>(&arg1.balance),
        };
        0x2::event::emit<InsuranceFundInflow>(v1);
    }

    public fun initialize<T0: drop, T1>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (AdminCap<T0, T1>, Fund<T0, T1>) {
        let v0 = AdminCap<T0, T1>{id: 0x2::object::new(arg2)};
        let v1 = Fund<T0, T1>{
            id              : 0x2::object::new(arg2),
            balance         : 0x2::balance::zero<T1>(),
            total_inflow    : 0,
            total_outflow   : 0,
            threshold       : arg1,
            last_used_at_ms : 0,
        };
        let v2 = InsuranceFundCreated{
            fund_id   : 0x2::object::id<Fund<T0, T1>>(&v1),
            threshold : arg1,
        };
        0x2::event::emit<InsuranceFundCreated>(v2);
        (v0, v1)
    }

    public fun is_below_threshold<T0, T1>(arg0: &Fund<T0, T1>) : bool {
        0x2::balance::value<T1>(&arg0.balance) < arg0.threshold
    }

    public fun last_used_at_ms<T0, T1>(arg0: &Fund<T0, T1>) : u64 {
        arg0.last_used_at_ms
    }

    public fun set_threshold<T0, T1>(arg0: &AdminCap<T0, T1>, arg1: &mut Fund<T0, T1>, arg2: u64) {
        arg1.threshold = arg2;
    }

    public fun share<T0, T1>(arg0: Fund<T0, T1>) {
        0x2::transfer::share_object<Fund<T0, T1>>(arg0);
    }

    public fun threshold<T0, T1>(arg0: &Fund<T0, T1>) : u64 {
        arg0.threshold
    }

    public fun total_inflow<T0, T1>(arg0: &Fund<T0, T1>) : u64 {
        arg0.total_inflow
    }

    public fun total_outflow<T0, T1>(arg0: &Fund<T0, T1>) : u64 {
        arg0.total_outflow
    }

    // decompiled from Move bytecode v7
}

