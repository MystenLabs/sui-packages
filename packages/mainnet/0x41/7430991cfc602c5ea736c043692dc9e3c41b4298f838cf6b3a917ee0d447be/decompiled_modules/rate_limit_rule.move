module 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::rate_limit_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        read_cooldown_ms: u64,
        write_cooldown_ms: u64,
        delete_cooldown_ms: u64,
    }

    public fun add(arg0: &mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy, arg1: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicyCap, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            read_cooldown_ms   : arg2,
            write_cooldown_ms  : arg3,
            delete_cooldown_ms : arg4,
        };
        0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::add_stackable_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun add_uniform(arg0: &mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy, arg1: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicyCap, arg2: u64) {
        add(arg0, arg1, arg2, arg2, arg2);
    }

    public fun get_cooldowns(arg0: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy) : (u64, u64, u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule<Rule, Config>(v0, arg0);
        (v1.read_cooldown_ms, v1.write_cooldown_ms, v1.delete_cooldown_ms)
    }

    public fun is_configured(arg0: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy) : bool {
        0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::has_rule<Rule>(arg0)
    }

    public fun prove(arg0: &mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessRequest, arg1: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy, arg2: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::memory_vault::MemoryVault, arg3: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::access_type(arg0);
        let v2 = if (v1 == 0) {
            0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule<Rule, Config>(v0, arg1).read_cooldown_ms
        } else if (v1 == 1) {
            0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule<Rule, Config>(v0, arg1).write_cooldown_ms
        } else {
            0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule<Rule, Config>(v0, arg1).delete_cooldown_ms
        };
        assert!(0x2::tx_context::epoch_timestamp_ms(arg3) >= 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::memory_vault::last_access_ts(arg2) + v2, 0);
        let v3 = Rule{dummy_field: false};
        0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::add_receipt<Rule>(v3, arg0);
    }

    public fun remove(arg0: &mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy, arg1: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicyCap) : Config {
        let v0 = Rule{dummy_field: false};
        0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::remove_rule<Rule, Config>(arg0, arg1, v0)
    }

    public fun time_until_allowed(arg0: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy, arg1: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::memory_vault::MemoryVault, arg2: u8, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v2 = if (arg2 == 0) {
            0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule<Rule, Config>(v0, arg0).read_cooldown_ms
        } else if (arg2 == 1) {
            0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule<Rule, Config>(v0, arg0).write_cooldown_ms
        } else {
            0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule<Rule, Config>(v0, arg0).delete_cooldown_ms
        };
        let v3 = 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::memory_vault::last_access_ts(arg1) + v2;
        if (v1 >= v3) {
            0
        } else {
            v3 - v1
        }
    }

    public fun update(arg0: &mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy, arg1: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicyCap, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        v1.read_cooldown_ms = arg2;
        v1.write_cooldown_ms = arg3;
        v1.delete_cooldown_ms = arg4;
    }

    // decompiled from Move bytecode v6
}

