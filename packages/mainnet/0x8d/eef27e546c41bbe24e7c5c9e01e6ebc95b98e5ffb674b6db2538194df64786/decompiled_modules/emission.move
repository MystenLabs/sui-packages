module 0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::emission {
    struct EmissionSchedule has key {
        id: 0x2::object::UID,
        pool: u64,
        issued: u64,
        multipliers: vector<u64>,
        tranche_size: u64,
    }

    struct ScheduleCreated has copy, drop {
        pool: u64,
        tranches: u64,
        multipliers: vector<u64>,
    }

    struct Released has copy, drop {
        amount: u64,
        issued_total: u64,
    }

    struct Issued has copy, drop {
        base: u64,
        boosted: u64,
        effective_x100: u64,
        issued_total: u64,
        remaining: u64,
    }

    public(friend) fun consume(arg0: &mut EmissionSchedule, arg1: u64) : u64 {
        assert!(arg1 > 0, 1);
        assert!(arg0.issued < arg0.pool, 0);
        let v0 = 0x1::vector::length<u64>(&arg0.multipliers) - 1;
        let v1 = 0;
        let v2 = 0;
        loop {
            let v3 = if (arg1 > 0) {
                if (arg0.issued < arg0.pool) {
                    v2 <= 16
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                let v4 = arg0.issued / arg0.tranche_size;
                let v5 = v4;
                if (v4 > v0) {
                    v5 = v0;
                };
                let v6 = *0x1::vector::borrow<u64>(&arg0.multipliers, v5);
                let v7 = (v5 + 1) * arg0.tranche_size;
                let v8 = v7;
                if (v5 == v0 || v7 > arg0.pool) {
                    v8 = arg0.pool;
                };
                let v9 = v8 - arg0.issued;
                let v10 = arg1 * v6;
                let v11 = if (v10 <= v9) {
                    v10
                } else {
                    v9
                };
                v1 = v1 + v11;
                arg0.issued = arg0.issued + v11;
                let v12 = (v11 + v6 - 1) / v6;
                let v13 = if (v12 >= arg1) {
                    0
                } else {
                    arg1 - v12
                };
                arg1 = v13;
                v2 = v2 + 1;
            } else {
                break
            };
        };
        assert!(v1 > 0, 0);
        let v14 = Issued{
            base           : arg1,
            boosted        : v1,
            effective_x100 : v1 * 100 / arg1,
            issued_total   : arg0.issued,
            remaining      : arg0.pool - arg0.issued,
        };
        0x2::event::emit<Issued>(v14);
        v1
    }

    public fun create(arg0: &0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::AdminCap, arg1: u64, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 > 0 && arg1 > 0, 2);
        assert!(v0 <= 16, 2);
        let v1 = 0;
        while (v1 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg2, v1) > 0, 2);
            if (v1 > 0) {
                assert!(*0x1::vector::borrow<u64>(&arg2, v1) <= *0x1::vector::borrow<u64>(&arg2, v1 - 1), 2);
            };
            v1 = v1 + 1;
        };
        let v2 = ScheduleCreated{
            pool        : arg1,
            tranches    : v0,
            multipliers : arg2,
        };
        0x2::event::emit<ScheduleCreated>(v2);
        let v3 = EmissionSchedule{
            id           : 0x2::object::new(arg3),
            pool         : arg1,
            issued       : 0,
            multipliers  : arg2,
            tranche_size : arg1 / v0,
        };
        0x2::transfer::share_object<EmissionSchedule>(v3);
    }

    public fun current_multiplier(arg0: &EmissionSchedule) : u64 {
        if (arg0.issued >= arg0.pool) {
            return 0
        };
        let v0 = 0x1::vector::length<u64>(&arg0.multipliers) - 1;
        let v1 = arg0.issued / arg0.tranche_size;
        let v2 = v1;
        if (v1 > v0) {
            v2 = v0;
        };
        *0x1::vector::borrow<u64>(&arg0.multipliers, v2)
    }

    public fun current_tranche(arg0: &EmissionSchedule) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0.multipliers) - 1;
        let v1 = arg0.issued / arg0.tranche_size;
        if (v1 > v0) {
            v0
        } else {
            v1
        }
    }

    public fun is_exhausted(arg0: &EmissionSchedule) : bool {
        arg0.issued >= arg0.pool
    }

    public fun issued(arg0: &EmissionSchedule) : u64 {
        arg0.issued
    }

    public fun multipliers(arg0: &EmissionSchedule) : vector<u64> {
        arg0.multipliers
    }

    public fun pool(arg0: &EmissionSchedule) : u64 {
        arg0.pool
    }

    public fun preview(arg0: &EmissionSchedule, arg1: u64) : u64 {
        if (arg1 == 0 || arg0.issued >= arg0.pool) {
            return 0
        };
        simulate(arg0, arg1)
    }

    public(friend) fun release(arg0: &mut EmissionSchedule, arg1: u64) {
        assert!(arg1 <= arg0.issued, 3);
        arg0.issued = arg0.issued - arg1;
        let v0 = Released{
            amount       : arg1,
            issued_total : arg0.issued,
        };
        0x2::event::emit<Released>(v0);
    }

    public fun remaining(arg0: &EmissionSchedule) : u64 {
        arg0.pool - arg0.issued
    }

    public fun remaining_in_tranche(arg0: &EmissionSchedule) : u64 {
        if (arg0.issued >= arg0.pool) {
            return 0
        };
        let v0 = current_tranche(arg0);
        let v1 = (v0 + 1) * arg0.tranche_size;
        let v2 = v1;
        if (v0 == 0x1::vector::length<u64>(&arg0.multipliers) - 1 || v1 > arg0.pool) {
            v2 = arg0.pool;
        };
        v2 - arg0.issued
    }

    public(friend) fun reserve(arg0: &mut EmissionSchedule, arg1: u64) : u64 {
        assert!(arg1 > 0, 1);
        assert!(arg0.issued < arg0.pool, 0);
        let v0 = simulate(arg0, arg1);
        assert!(v0 > 0, 0);
        arg0.issued = arg0.issued + v0;
        let v1 = Issued{
            base           : arg1,
            boosted        : v0,
            effective_x100 : v0 * 100 / arg1,
            issued_total   : arg0.issued,
            remaining      : arg0.pool - arg0.issued,
        };
        0x2::event::emit<Issued>(v1);
        v0
    }

    fun simulate(arg0: &EmissionSchedule, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0.multipliers) - 1;
        let v1 = 0;
        let v2 = arg0.issued;
        let v3 = 0;
        loop {
            let v4 = if (arg1 > 0) {
                if (v2 < arg0.pool) {
                    v3 <= 16
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                let v5 = v2 / arg0.tranche_size;
                let v6 = v5;
                if (v5 > v0) {
                    v6 = v0;
                };
                let v7 = *0x1::vector::borrow<u64>(&arg0.multipliers, v6);
                let v8 = (v6 + 1) * arg0.tranche_size;
                let v9 = v8;
                if (v6 == v0 || v8 > arg0.pool) {
                    v9 = arg0.pool;
                };
                let v10 = v9 - v2;
                let v11 = arg1 * v7;
                let v12 = if (v11 <= v10) {
                    v11
                } else {
                    v10
                };
                v1 = v1 + v12;
                v2 = v2 + v12;
                let v13 = (v12 + v7 - 1) / v7;
                let v14 = if (v13 >= arg1) {
                    0
                } else {
                    arg1 - v13
                };
                arg1 = v14;
                v3 = v3 + 1;
            } else {
                break
            };
        };
        v1
    }

    public fun tranche_size(arg0: &EmissionSchedule) : u64 {
        arg0.tranche_size
    }

    // decompiled from Move bytecode v7
}

