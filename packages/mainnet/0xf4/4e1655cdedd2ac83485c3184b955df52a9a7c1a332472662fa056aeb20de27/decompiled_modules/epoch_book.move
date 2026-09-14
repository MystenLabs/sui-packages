module 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::epoch_book {
    struct WeightRecord has copy, drop, store {
        lots: vector<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Lot>,
        amount: u64,
        lock: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::Lock,
    }

    struct Frame has copy, drop, store {
        position: 0x2::object::ID,
        root: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::Root,
        weight: u128,
    }

    struct Epoch<phantom T0> has store {
        graph: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::Graph<T0>,
        frames: 0x2::table::Table<u64, Frame>,
        summary: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::Summary,
        schedule: 0x1::option::Option<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::Schedule>,
        count: u64,
        collected: u64,
        allocated: u64,
        allocated_total: u64,
        pot: u64,
        timestamp_ms: u64,
        expires_ms: u64,
        abandoned: 0x1::option::Option<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Snapshot<WeightRecord>>,
        cleanup_cursor: u64,
    }

    struct Book<phantom T0> has store {
        pool: 0x2::object::ID,
        positions: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Registry<WeightRecord>,
        epoch: 0x1::option::Option<Epoch<T0>>,
        rollover: 0x2::balance::Balance<T0>,
        retired: 0x2::table::Table<u64, Epoch<T0>>,
        first_retired: u64,
        next_retired: u64,
    }

    public fun length<T0>(arg0: &Book<T0>) : u64 {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::length<WeightRecord>(&arg0.positions)
    }

    public(friend) fun join<T0, T1>(arg0: &mut Book<T1>, arg1: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg3: &0x2::clock::Clock) {
        sync_lock<T0, T1>(arg0, arg1);
        let v0 = &mut arg2;
        sync_lock<T0, T1>(arg0, v0);
        check<T0, T1>(arg0, arg1);
        check<T0, T1>(arg0, &arg2);
        expire_if_due<T1>(arg0, arg3);
        let v1 = 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1);
        let v2 = 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&arg2);
        capture_position<T1>(arg0, v1, arg3);
        capture_removal<T1>(arg0, v2, arg3);
        if (active<T1>(arg0, arg3)) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::join<T1>(&mut 0x1::option::borrow_mut<Epoch<T1>>(&mut arg0.epoch).graph, v1, v2, arg3);
        };
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::remove<WeightRecord>(&mut arg0.positions, v2);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::join<T0>(arg1, arg2);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::replace<WeightRecord>(&mut arg0.positions, v1, record<T0>(arg1));
    }

    public(friend) fun split<T0, T1>(arg0: &mut Book<T1>, arg1: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0> {
        sync_lock<T0, T1>(arg0, arg1);
        check<T0, T1>(arg0, arg1);
        expire_if_due<T1>(arg0, arg3);
        let v0 = 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1);
        capture_position<T1>(arg0, v0, arg3);
        let v1 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::split<T0>(arg1, arg2, arg4);
        if (active<T1>(arg0, arg3)) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::split<T1>(&mut 0x1::option::borrow_mut<Epoch<T1>>(&mut arg0.epoch).graph, v0, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&v1), arg2, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(arg1), arg3);
        };
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::replace<WeightRecord>(&mut arg0.positions, v0, record<T0>(arg1));
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::insert<WeightRecord>(&mut arg0.positions, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(&v1), record<T0>(&v1));
        v1
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : Book<T0> {
        Book<T0>{
            pool          : arg0,
            positions     : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::new<WeightRecord>(arg1),
            epoch         : 0x1::option::none<Epoch<T0>>(),
            rollover      : 0x2::balance::zero<T0>(),
            retired       : 0x2::table::new<u64, Epoch<T0>>(arg1),
            first_retired : 0,
            next_retired  : 0,
        }
    }

    public fun active<T0>(arg0: &Book<T0>, arg1: &0x2::clock::Clock) : bool {
        0x1::option::is_some<Epoch<T0>>(&arg0.epoch) && 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::active<T0>(&0x1::option::borrow<Epoch<T0>>(&arg0.epoch).graph, arg1)
    }

    public(friend) fun advance<T0>(arg0: &mut Book<T0>, arg1: u64, arg2: &0x2::clock::Clock) : vector<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::Delivery<T0>> {
        assert!(active<T0>(arg0, arg2), 2);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::advance<T0>(&mut 0x1::option::borrow_mut<Epoch<T0>>(&mut arg0.epoch).graph, arg1, arg2)
    }

    public(friend) fun claim<T0, T1>(arg0: &mut Book<T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        check<T0, T1>(arg0, arg1);
        expire_if_due<T1>(arg0, arg2);
        if (!active<T1>(arg0, arg2)) {
            return 0x2::balance::zero<T1>()
        };
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::claim<T1>(&mut 0x1::option::borrow_mut<Epoch<T1>>(&mut arg0.epoch).graph, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1), arg2)
    }

    public fun claimable<T0, T1>(arg0: &Book<T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: &0x2::clock::Clock) : u64 {
        check<T0, T1>(arg0, arg1);
        if (!active<T1>(arg0, arg2)) {
            return 0
        };
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::claimable<T1>(&0x1::option::borrow<Epoch<T1>>(&arg0.epoch).graph, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1), arg2)
    }

    public(friend) fun cleanup<T0>(arg0: &mut Book<T0>, arg1: u64) {
        assert!(arg1 > 0 && arg1 <= 64, 3);
        if (arg0.first_retired == arg0.next_retired) {
            return
        };
        let v0 = 0x2::table::borrow_mut<u64, Epoch<T0>>(&mut arg0.retired, arg0.first_retired);
        if (0x1::option::is_some<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Snapshot<WeightRecord>>(&v0.abandoned)) {
            if (0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::cleanup_snapshot<WeightRecord>(0x1::option::borrow_mut<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Snapshot<WeightRecord>>(&mut v0.abandoned), arg1)) {
                0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::destroy_snapshot<WeightRecord>(0x1::option::extract<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Snapshot<WeightRecord>>(&mut v0.abandoned));
            };
            return
        };
        if (v0.cleanup_cursor < v0.count) {
            let v1 = 0;
            while (v1 < arg1 && v0.cleanup_cursor < v0.count) {
                if (0x2::table::contains<u64, Frame>(&v0.frames, v0.cleanup_cursor)) {
                    0x2::table::remove<u64, Frame>(&mut v0.frames, v0.cleanup_cursor);
                };
                v0.cleanup_cursor = v0.cleanup_cursor + 1;
                v1 = v1 + 1;
            };
            return
        };
        if (!0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::cleaned<T0>(&v0.graph)) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::cleanup<T0>(&mut v0.graph, arg1);
            return
        };
        let Epoch {
            graph           : v2,
            frames          : v3,
            summary         : _,
            schedule        : _,
            count           : _,
            collected       : _,
            allocated       : _,
            allocated_total : _,
            pot             : _,
            timestamp_ms    : _,
            expires_ms      : _,
            abandoned       : v13,
            cleanup_cursor  : _,
        } = 0x2::table::remove<u64, Epoch<T0>>(&mut arg0.retired, arg0.first_retired);
        0x2::balance::join<T0>(&mut arg0.rollover, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::close<T0>(v2));
        0x2::table::destroy_empty<u64, Frame>(v3);
        0x1::option::destroy_none<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Snapshot<WeightRecord>>(v13);
        arg0.first_retired = arg0.first_retired + 1;
    }

    public(friend) fun exit<T0, T1>(arg0: &mut Book<T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1);
        expire_if_due<T1>(arg0, arg3);
        let v0 = 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1);
        capture_removal<T1>(arg0, v0, arg3);
        if (active<T1>(arg0, arg3)) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::exit<T1>(&mut 0x1::option::borrow_mut<Epoch<T1>>(&mut arg0.epoch).graph, v0, 0x2::tx_context::sender(arg4), arg2, arg3);
        };
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::remove<WeightRecord>(&mut arg0.positions, v0);
    }

    public(friend) fun expire<T0>(arg0: &mut Book<T0>, arg1: &0x2::clock::Clock) {
        if (0x1::option::is_none<Epoch<T0>>(&arg0.epoch)) {
            return
        };
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x1::option::borrow<Epoch<T0>>(&arg0.epoch).expires_ms, 2);
        let v0 = 0x1::option::extract<Epoch<T0>>(&mut arg0.epoch);
        0x2::balance::join<T0>(&mut arg0.rollover, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::expire<T0>(&mut v0.graph, arg1));
        let v1 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::detach<WeightRecord>(&mut arg0.positions);
        if (0x1::option::is_some<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Snapshot<WeightRecord>>(&v1)) {
            0x1::option::fill<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Snapshot<WeightRecord>>(&mut v0.abandoned, 0x1::option::destroy_some<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Snapshot<WeightRecord>>(v1));
        } else {
            0x1::option::destroy_none<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Snapshot<WeightRecord>>(v1);
        };
        0x2::table::add<u64, Epoch<T0>>(&mut arg0.retired, arg0.next_retired, v0);
        arg0.next_retired = arg0.next_retired + 1;
    }

    fun weight(arg0: &WeightRecord, arg1: u64) : u128 {
        let v0 = 0;
        let v1 = &arg0.lots;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Lot>(v1)) {
            let v3 = 0x1::vector::borrow<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Lot>(v1, v2);
            v0 = v0 + 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividends::weight(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lot_amount(v3), arg1 - 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lot_entry(v3), 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::multiplier(&arg0.lock, arg1));
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun allocate<T0>(arg0: &mut Book<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(active<T0>(arg0, arg2), 2);
        assert!(arg1 > 0 && arg1 <= 64, 3);
        let v0 = 0x1::option::borrow_mut<Epoch<T0>>(&mut arg0.epoch);
        assert!(0x1::option::is_some<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::Schedule>(&v0.schedule), 2);
        let v1 = 0;
        while (v1 < arg1 && v0.allocated < v0.count) {
            let Frame {
                position : _,
                root     : v3,
                weight   : v4,
            } = 0x2::table::remove<u64, Frame>(&mut v0.frames, v0.allocated);
            let v5 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::payout(0x1::option::borrow<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::Schedule>(&v0.schedule), v4);
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::submit<T0>(&mut v0.graph, v3, v5, arg2);
            v0.allocated = v0.allocated + 1;
            v0.allocated_total = v0.allocated_total + v5;
            v1 = v1 + 1;
        };
    }

    public(friend) fun begin<T0>(arg0: &mut Book<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        expire_if_due<T0>(arg0, arg3);
        assert!(0x1::option::is_none<Epoch<T0>>(&arg0.epoch) && arg2 > 0, 2);
        0x2::balance::join<T0>(&mut arg1, 0x2::balance::split<T0>(&mut arg0.rollover, 0x2::balance::value<T0>(&arg0.rollover)));
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = v1 + arg2;
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::begin<WeightRecord>(&mut arg0.positions, v1, arg4);
        let v3 = Epoch<T0>{
            graph           : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::new<T0>(arg1, v2, arg3, arg4),
            frames          : 0x2::table::new<u64, Frame>(arg4),
            summary         : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::new(),
            schedule        : 0x1::option::none<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::Schedule>(),
            count           : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::length<WeightRecord>(&arg0.positions),
            collected       : 0,
            allocated       : 0,
            allocated_total : 0,
            pot             : v0,
            timestamp_ms    : v1,
            expires_ms      : v2,
            abandoned       : 0x1::option::none<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Snapshot<WeightRecord>>(),
            cleanup_cursor  : 0,
        };
        0x1::option::fill<Epoch<T0>>(&mut arg0.epoch, v3);
        v0
    }

    fun capture<T0>(arg0: &mut Book<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        if (!active<T0>(arg0, arg2) || 0x1::option::is_some<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::Schedule>(&0x1::option::borrow<Epoch<T0>>(&arg0.epoch).schedule)) {
            return
        };
        let v0 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::peek_original<WeightRecord>(&arg0.positions, arg1);
        if (0x1::option::is_some<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Entry<WeightRecord>>(&v0)) {
            let v1 = 0x1::option::borrow_mut<Epoch<T0>>(&mut arg0.epoch);
            frame<T0>(v1, arg1, 0x1::option::destroy_some<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Entry<WeightRecord>>(v0), arg2);
        };
    }

    fun capture_position<T0>(arg0: &mut Book<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::slot<WeightRecord>(&arg0.positions, arg1);
        capture<T0>(arg0, v0, arg2);
    }

    fun capture_removal<T0>(arg0: &mut Book<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        capture_position<T0>(arg0, arg1, arg2);
        let v0 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::length<WeightRecord>(&arg0.positions) - 1;
        capture<T0>(arg0, v0, arg2);
    }

    fun check<T0, T1>(arg0: &Book<T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>) {
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(arg1) == arg0.pool, 1);
        let v0 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::get<WeightRecord>(&arg0.positions, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1));
        let v1 = record<T0>(arg1);
        let v2 = if (v0.lots == v1.lots) {
            if (v0.amount == v1.amount) {
                v0.lock == v1.lock || v0.lock == 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::flexible()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 1);
    }

    public(friend) fun collect<T0>(arg0: &mut Book<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(active<T0>(arg0, arg2), 2);
        assert!(arg1 > 0 && arg1 <= 64, 3);
        let v0 = 0x1::option::borrow_mut<Epoch<T0>>(&mut arg0.epoch);
        if (0x1::option::is_some<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::Schedule>(&v0.schedule)) {
            return
        };
        let v1 = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::take<WeightRecord>(&mut arg0.positions, arg1);
        0x1::vector::reverse<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Entry<WeightRecord>>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Entry<WeightRecord>>(&v1)) {
            let v3 = v0.collected;
            frame<T0>(v0, v3, 0x1::vector::pop_back<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Entry<WeightRecord>>(&mut v1), arg2);
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::observe(&mut v0.summary, 0x2::table::borrow<u64, Frame>(&v0.frames, v0.collected).weight);
            v0.collected = v0.collected + 1;
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Entry<WeightRecord>>(v1);
        if (v0.collected == v0.count) {
            0x1::option::fill<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::Schedule>(&mut v0.schedule, 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::dividend_summary::finish(&v0.summary, v0.pot));
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::seal<T0>(&mut v0.graph, arg2);
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::finish<WeightRecord>(&mut arg0.positions);
        };
    }

    public fun effective_lock<T0>(arg0: &Book<T0>, arg1: 0x2::object::ID) : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::Lock {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::get<WeightRecord>(&arg0.positions, arg1).lock
    }

    fun expire_if_due<T0>(arg0: &mut Book<T0>, arg1: &0x2::clock::Clock) {
        if (0x1::option::is_some<Epoch<T0>>(&arg0.epoch) && 0x2::clock::timestamp_ms(arg1) >= 0x1::option::borrow<Epoch<T0>>(&arg0.epoch).expires_ms) {
            expire<T0>(arg0, arg1);
        };
    }

    fun frame<T0>(arg0: &mut Epoch<T0>, arg1: u64, arg2: 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::Entry<WeightRecord>, arg3: &0x2::clock::Clock) {
        let (v0, v1) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::unpack<WeightRecord>(arg2);
        let v2 = v1;
        if (0x2::table::contains<u64, Frame>(&arg0.frames, arg1)) {
            let v3 = 0x2::table::borrow<u64, Frame>(&arg0.frames, arg1);
            assert!(v3.position == v0 && v3.weight == weight(&v2, arg0.timestamp_ms), 1);
        } else {
            let v4 = Frame{
                position : v0,
                root     : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::deferred_dividends::add_root<T0>(&mut arg0.graph, v0, arg3),
                weight   : weight(&v2, arg0.timestamp_ms),
            };
            0x2::table::add<u64, Frame>(&mut arg0.frames, arg1, v4);
        };
    }

    public(friend) fun insert<T0, T1>(arg0: &mut Book<T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: &0x2::clock::Clock) {
        assert!(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::pool_id<T0>(arg1) == arg0.pool, 1);
        expire_if_due<T1>(arg0, arg2);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::insert<WeightRecord>(&mut arg0.positions, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1), record<T0>(arg1));
    }

    public fun position_at<T0>(arg0: &Book<T0>, arg1: u64) : 0x2::object::ID {
        let (v0, _) = 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::unpack<WeightRecord>(0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::at<WeightRecord>(&arg0.positions, arg1));
        v0
    }

    public fun pot<T0>(arg0: &Book<T0>) : u64 {
        0x1::option::borrow<Epoch<T0>>(&arg0.epoch).pot
    }

    public fun progress<T0>(arg0: &Book<T0>) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0x1::option::borrow<Epoch<T0>>(&arg0.epoch);
        (v0.timestamp_ms, v0.expires_ms, v0.count, v0.collected, v0.allocated, v0.allocated_total)
    }

    fun record<T0>(arg0: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>) : WeightRecord {
        WeightRecord{
            lots   : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lots<T0>(arg0),
            amount : 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::amount<T0>(arg0),
            lock   : *0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::lock<T0>(arg0),
        }
    }

    public fun retired_count<T0>(arg0: &Book<T0>) : u64 {
        0x2::table::length<u64, Epoch<T0>>(&arg0.retired)
    }

    public fun rollover<T0>(arg0: &Book<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rollover)
    }

    public(friend) fun sync_lock<T0, T1>(arg0: &Book<T1>, arg1: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>) {
        check<T0, T1>(arg0, arg1);
        if (0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::get<WeightRecord>(&arg0.positions, 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1)).lock == 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::flexible()) {
            0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::clear_lock<T0>(arg1);
        };
    }

    public(friend) fun unlock_position<T0>(arg0: &mut Book<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        expire_if_due<T0>(arg0, arg2);
        capture_position<T0>(arg0, arg1, arg2);
        let v0 = *0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::get<WeightRecord>(&arg0.positions, arg1);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::locks::clear(&mut v0.lock);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::replace<WeightRecord>(&mut arg0.positions, arg1, v0);
    }

    public(friend) fun upgrade<T0, T1>(arg0: &mut Book<T1>, arg1: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>, arg2: u8, arg3: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Params, arg4: &0x2::clock::Clock) {
        sync_lock<T0, T1>(arg0, arg1);
        check<T0, T1>(arg0, arg1);
        expire_if_due<T1>(arg0, arg4);
        let v0 = 0x2::object::id<0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::Position<T0>>(arg1);
        capture_position<T1>(arg0, v0, arg4);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::position::upgrade<T0>(arg1, arg2, 0x2::clock::timestamp_ms(arg4), arg3);
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::snapshot_registry::replace<WeightRecord>(&mut arg0.positions, v0, record<T0>(arg1));
    }

    // decompiled from Move bytecode v7
}

