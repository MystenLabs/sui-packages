module 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::access {
    struct AccessPolicy has copy, drop, store {
        kind: u8,
        delegated: vector<address>,
        unlock_ms: u64,
    }

    public fun assert_access(arg0: &AccessPolicy, arg1: address, arg2: address, arg3: u64) {
        assert!(check_access(arg0, arg1, arg2, arg3), 200);
    }

    public fun check_access(arg0: &AccessPolicy, arg1: address, arg2: address, arg3: u64) : bool {
        arg0.kind == 0 && arg1 == arg2 || arg0.kind == 1 && (arg1 == arg2 || 0x1::vector::contains<address>(&arg0.delegated, &arg1)) || arg0.kind == 2 || arg0.kind == 3 && arg3 >= arg0.unlock_ms
    }

    public fun delegated(arg0: &AccessPolicy) : &vector<address> {
        &arg0.delegated
    }

    public fun from_args(arg0: u8, arg1: vector<address>, arg2: u64) : AccessPolicy {
        if (arg0 == 1) {
            new_delegated(arg1)
        } else if (arg0 == 2) {
            new_public()
        } else if (arg0 == 3) {
            new_time_lock(arg2)
        } else {
            new_sole_owner()
        }
    }

    public fun kind(arg0: &AccessPolicy) : u8 {
        arg0.kind
    }

    public fun new_delegated(arg0: vector<address>) : AccessPolicy {
        assert!(0x1::vector::length<address>(&arg0) <= 16, 201);
        AccessPolicy{
            kind      : 1,
            delegated : arg0,
            unlock_ms : 0,
        }
    }

    public fun new_public() : AccessPolicy {
        AccessPolicy{
            kind      : 2,
            delegated : vector[],
            unlock_ms : 0,
        }
    }

    public fun new_sole_owner() : AccessPolicy {
        AccessPolicy{
            kind      : 0,
            delegated : vector[],
            unlock_ms : 0,
        }
    }

    public fun new_time_lock(arg0: u64) : AccessPolicy {
        AccessPolicy{
            kind      : 3,
            delegated : vector[],
            unlock_ms : arg0,
        }
    }

    public fun unlock_ms(arg0: &AccessPolicy) : u64 {
        arg0.unlock_ms
    }

    // decompiled from Move bytecode v7
}

