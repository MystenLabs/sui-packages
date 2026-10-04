module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::rebalance_state {
    struct RebalanceState has store {
        last_rebalance_ms: u64,
        cycle: u64,
        legs: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        in_flight: bool,
    }

    struct CycleOpened has copy, drop {
        cycle: u64,
        timestamp_ms: u64,
        open_crank: bool,
    }

    struct CycleClosed has copy, drop {
        cycle: u64,
        timestamp_ms: u64,
        skipped: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : RebalanceState {
        RebalanceState{
            last_rebalance_ms : 0,
            cycle             : 0,
            legs              : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
            in_flight         : false,
        }
    }

    public(friend) fun assert_due(arg0: &RebalanceState, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: &0x2::clock::Clock) {
        assert!(is_due(arg0, arg1, arg2), 900);
    }

    public(friend) fun assert_leg_open(arg0: &RebalanceState, arg1: 0x1::type_name::TypeName) {
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.legs, arg1)) {
            assert!(*0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.legs, arg1) != arg0.cycle, 901);
        };
    }

    public(friend) fun close_cycle(arg0: &mut RebalanceState, arg1: &0x2::clock::Clock, arg2: bool) {
        assert!(arg0.in_flight, 903);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.in_flight = false;
        arg0.last_rebalance_ms = v0;
        let v1 = CycleClosed{
            cycle        : arg0.cycle,
            timestamp_ms : v0,
            skipped      : arg2,
        };
        0x2::event::emit<CycleClosed>(v1);
    }

    public(friend) fun cycle(arg0: &RebalanceState) : u64 {
        arg0.cycle
    }

    public(friend) fun in_flight(arg0: &RebalanceState) : bool {
        arg0.in_flight
    }

    public(friend) fun is_due(arg0: &RebalanceState, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg2) >= arg0.last_rebalance_ms + 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::rebalance_interval_ms(arg1)
    }

    public(friend) fun is_open_crank(arg0: &RebalanceState, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg2) >= arg0.last_rebalance_ms + 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::rebalance_interval_ms(arg1) + 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::open_crank_grace_ms(arg1)
    }

    public(friend) fun last_rebalance_ms(arg0: &RebalanceState) : u64 {
        arg0.last_rebalance_ms
    }

    public(friend) fun leg_done_this_cycle(arg0: &RebalanceState, arg1: 0x1::type_name::TypeName) : bool {
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.legs, arg1)) {
            return false
        };
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.legs, arg1) == arg0.cycle
    }

    public(friend) fun mark_leg_done(arg0: &mut RebalanceState, arg1: 0x1::type_name::TypeName) {
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.legs, arg1)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.legs, arg1) = arg0.cycle;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.legs, arg1, arg0.cycle);
        };
    }

    public(friend) fun open_cycle(arg0: &mut RebalanceState, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: &0x2::clock::Clock, arg3: bool) {
        assert!(!arg0.in_flight, 902);
        assert_due(arg0, arg1, arg2);
        arg0.cycle = arg0.cycle + 1;
        arg0.in_flight = true;
        let v0 = CycleOpened{
            cycle        : arg0.cycle,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            open_crank   : arg3,
        };
        0x2::event::emit<CycleOpened>(v0);
    }

    // decompiled from Move bytecode v7
}

