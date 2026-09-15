module 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::hibernation_rules {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct PendingKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Rules has copy, drop, store {
        ema_tau_ms: u64,
        startup_grace_ms: u64,
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
        new(7 * 86400000, 86400000)
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

    public fun new(arg0: u64, arg1: u64) : Rules {
        assert!(arg0 >= 86400000 && arg0 <= 30 * 86400000, 1);
        assert!(arg1 >= 86400000 && arg1 <= 30 * 86400000, 1);
        Rules{
            ema_tau_ms       : arg0,
            startup_grace_ms : arg1,
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
        cancel(arg0);
        let v0 = PendingKey{dummy_field: false};
        let v1 = Pending{
            rules      : arg1,
            execute_ms : 0x2::clock::timestamp_ms(arg3) + arg2,
        };
        0x2::dynamic_field::add<PendingKey, Pending>(arg0, v0, v1);
    }

    public fun values(arg0: &Rules) : (u64, u64) {
        (arg0.ema_tau_ms, arg0.startup_grace_ms)
    }

    // decompiled from Move bytecode v7
}

