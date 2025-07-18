module 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::snapshot {
    struct Snapshot has store {
        debt: 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::Debt,
        snapshot_time_ms: u64,
    }

    struct DebtSnapshot has store {
        total_debt: 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::Debt,
        next_snapshot_time_ms: u64,
        snapshot: 0x1::option::Option<Snapshot>,
    }

    public(friend) fun new(arg0: &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::risk_params::RiskParams, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : DebtSnapshot {
        DebtSnapshot{
            total_debt            : 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::new(arg2),
            next_snapshot_time_ms : calc_next_snapshot_time(0x2::clock::timestamp_ms(arg1), 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::risk_params::debt_snapshot_frequency_ms(arg0)),
            snapshot              : 0x1::option::none<Snapshot>(),
        }
    }

    public(friend) fun value<T0>(arg0: &DebtSnapshot) : u64 {
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::value<T0>(&arg0.total_debt)
    }

    public(friend) fun borrow_snapshot(arg0: &DebtSnapshot) : &0x1::option::Option<Snapshot> {
        &arg0.snapshot
    }

    fun calc_next_snapshot_time(arg0: u64, arg1: u64) : u64 {
        arg0 - (arg0 - 0) % arg1 + arg1
    }

    public(friend) fun debt_snapshot_debt_value<T0>(arg0: &DebtSnapshot) : u64 {
        if (0x1::option::is_some<Snapshot>(&arg0.snapshot)) {
            0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::value<T0>(&0x1::option::borrow<Snapshot>(&arg0.snapshot).debt)
        } else {
            0
        }
    }

    public(friend) fun debt_snapshot_into_total_debt_for_liquidation(arg0: DebtSnapshot) : 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::Debt {
        let DebtSnapshot {
            total_debt            : v0,
            next_snapshot_time_ms : _,
            snapshot              : v2,
        } = arg0;
        let v3 = v2;
        if (0x1::option::is_some<Snapshot>(&v3)) {
            destroy_non_empty_snapshot(0x1::option::extract<Snapshot>(&mut v3));
        };
        0x1::option::destroy_none<Snapshot>(v3);
        v0
    }

    public(friend) fun decrease_debt<T0>(arg0: &mut DebtSnapshot, arg1: u64, arg2: &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::risk_params::RiskParams, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::decrease<T0>(&mut arg0.total_debt, arg1);
        if (0x1::option::is_some<Snapshot>(&arg0.snapshot)) {
            let v0 = 0x1::option::borrow_mut<Snapshot>(&mut arg0.snapshot);
            0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::decrease<T0>(&mut v0.debt, 0x1::u64::min(arg1, 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::value<T0>(&v0.debt)));
            if (0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::is_empty(&v0.debt)) {
                destroy_empty_snapshot(0x1::option::extract<Snapshot>(&mut arg0.snapshot));
            };
        };
        if (0x1::option::is_none<Snapshot>(&arg0.snapshot) && 0x2::clock::timestamp_ms(arg3) >= arg0.next_snapshot_time_ms) {
            handle_snapshot(arg0, arg2, arg3, arg4);
        };
    }

    public(friend) fun destroy_empty_debt_snapshot(arg0: DebtSnapshot) {
        let DebtSnapshot {
            total_debt            : v0,
            next_snapshot_time_ms : _,
            snapshot              : v2,
        } = arg0;
        let v3 = v2;
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::destroy_empty(v0);
        if (0x1::option::is_some<Snapshot>(&v3)) {
            destroy_empty_snapshot(0x1::option::extract<Snapshot>(&mut v3));
        };
        0x1::option::destroy_none<Snapshot>(v3);
    }

    fun destroy_empty_snapshot(arg0: Snapshot) {
        let Snapshot {
            debt             : v0,
            snapshot_time_ms : _,
        } = arg0;
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::destroy_empty(v0);
    }

    fun destroy_non_empty_snapshot(arg0: Snapshot) {
        let Snapshot {
            debt             : v0,
            snapshot_time_ms : _,
        } = arg0;
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::destroy(v0);
    }

    fun handle_snapshot(arg0: &mut DebtSnapshot, arg1: &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::risk_params::RiskParams, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<Snapshot>(&arg0.snapshot), 1);
        if (!0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::is_empty(&arg0.total_debt)) {
            let v0 = Snapshot{
                debt             : 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::clone(&arg0.total_debt, arg3),
                snapshot_time_ms : arg0.next_snapshot_time_ms,
            };
            0x1::option::fill<Snapshot>(&mut arg0.snapshot, v0);
        };
        arg0.next_snapshot_time_ms = calc_next_snapshot_time(0x2::clock::timestamp_ms(arg2), 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::risk_params::debt_snapshot_frequency_ms(arg1));
    }

    public(friend) fun increase_debt<T0>(arg0: &mut DebtSnapshot, arg1: u64, arg2: &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::risk_params::RiskParams, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg3) >= arg0.next_snapshot_time_ms) {
            handle_snapshot(arg0, arg2, arg3, arg4);
        };
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::increase<T0>(&mut arg0.total_debt, arg1);
    }

    public(friend) fun make_snapshot(arg0: &mut DebtSnapshot, arg1: &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::risk_params::RiskParams, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.next_snapshot_time_ms, 0);
        handle_snapshot(arg0, arg1, arg2, arg3);
    }

    public(friend) fun next_snapshot_time_ms(arg0: &DebtSnapshot) : u64 {
        arg0.next_snapshot_time_ms
    }

    public(friend) fun total_debt(arg0: &DebtSnapshot) : &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::debt::Debt {
        &arg0.total_debt
    }

    // decompiled from Move bytecode v6
}

