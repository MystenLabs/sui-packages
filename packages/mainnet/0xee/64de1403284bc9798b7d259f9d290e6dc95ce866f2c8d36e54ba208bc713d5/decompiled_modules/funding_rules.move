module 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::funding_rules {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct PendingKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Rules has copy, drop, store {
        reserve_days: u64,
        alarm_days: u64,
        history_ms: u64,
        max_gap_bps: u64,
        grace_ms: u64,
    }

    struct Pending has drop, store {
        rules: Rules,
        execute_ms: u64,
    }

    public(friend) fun cancel(arg0: &mut 0x2::object::UID) {
        let v0 = PendingKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PendingKey>(arg0, v0)) {
            let v1 = PendingKey{dummy_field: false};
            0x2::dynamic_field::remove<PendingKey, Pending>(arg0, v1);
        };
    }

    public fun defaults() : Rules {
        new(180, 90, 28800000, 2000, 60000)
    }

    public(friend) fun execute(arg0: &mut 0x2::object::UID, arg1: &0x2::clock::Clock) {
        let v0 = PendingKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<PendingKey>(arg0, v0), 2);
        let v1 = PendingKey{dummy_field: false};
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x2::dynamic_field::borrow<PendingKey, Pending>(arg0, v1).execute_ms, 2);
        let v2 = PendingKey{dummy_field: false};
        let Pending {
            rules      : v3,
            execute_ms : _,
        } = 0x2::dynamic_field::remove<PendingKey, Pending>(arg0, v2);
        let v5 = Key{dummy_field: false};
        if (0x2::dynamic_field::exists<Key>(arg0, v5)) {
            let v6 = Key{dummy_field: false};
            0x2::dynamic_field::remove<Key, Rules>(arg0, v6);
        };
        let v7 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, Rules>(arg0, v7, v3);
    }

    public(friend) fun get(arg0: &0x2::object::UID) : Rules {
        let v0 = Key{dummy_field: false};
        if (0x2::dynamic_field::exists<Key>(arg0, v0)) {
            let v2 = Key{dummy_field: false};
            *0x2::dynamic_field::borrow<Key, Rules>(arg0, v2)
        } else {
            defaults()
        }
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : Rules {
        let v0 = if (arg0 >= 1) {
            if (arg0 <= 365) {
                if (arg1 > 0) {
                    arg1 <= arg0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = if (arg2 >= 3600000) {
            if (arg2 <= 604800000) {
                if (arg3 <= 5000) {
                    arg4 <= 300000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        Rules{
            reserve_days : arg0,
            alarm_days   : arg1,
            history_ms   : arg2,
            max_gap_bps  : arg3,
            grace_ms     : arg4,
        }
    }

    public(friend) fun pending(arg0: &0x2::object::UID) : (bool, Rules, u64) {
        let v0 = PendingKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PendingKey>(arg0, v0)) {
            return (false, get(arg0), 0)
        };
        let v1 = PendingKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<PendingKey, Pending>(arg0, v1);
        (true, v2.rules, v2.execute_ms)
    }

    public(friend) fun propose(arg0: &mut 0x2::object::UID, arg1: Rules, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = PendingKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PendingKey>(arg0, v0)) {
            let v1 = PendingKey{dummy_field: false};
            0x2::dynamic_field::remove<PendingKey, Pending>(arg0, v1);
        };
        let v2 = PendingKey{dummy_field: false};
        let v3 = Pending{
            rules      : arg1,
            execute_ms : 0x2::clock::timestamp_ms(arg3) + arg2,
        };
        0x2::dynamic_field::add<PendingKey, Pending>(arg0, v2, v3);
    }

    public fun values(arg0: &Rules) : (u64, u64, u64, u64, u64) {
        (arg0.reserve_days, arg0.alarm_days, arg0.history_ms, arg0.max_gap_bps, arg0.grace_ms)
    }

    // decompiled from Move bytecode v7
}

