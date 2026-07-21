module 0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::policy {
    struct Policy has copy, drop, store {
        allowed_tokens: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        allowed_pools: 0x2::vec_set::VecSet<address>,
        max_slippage_bps: u16,
        max_position_usd_e6: u64,
        min_interval_ms: u64,
        max_leverage_bps: u16,
        paused: bool,
    }

    public fun empty() : Policy {
        Policy{
            allowed_tokens      : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            allowed_pools       : 0x2::vec_set::empty<address>(),
            max_slippage_bps    : 0,
            max_position_usd_e6 : 0,
            min_interval_ms     : 0,
            max_leverage_bps    : 0,
            paused              : false,
        }
    }

    public fun assert_interval(arg0: &Policy, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1 + arg0.min_interval_ms, 3);
    }

    public fun assert_not_paused(arg0: &Policy) {
        assert!(!arg0.paused, 5);
    }

    public fun assert_position_size(arg0: &Policy, arg1: u64) {
        assert!(arg1 <= arg0.max_position_usd_e6, 4);
    }

    public fun assert_token<T0>(arg0: &Policy) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_tokens, &v0), 0);
    }

    public fun is_paused(arg0: &Policy) : bool {
        arg0.paused
    }

    public fun max_position_usd_e6(arg0: &Policy) : u64 {
        arg0.max_position_usd_e6
    }

    public fun max_slippage_bps(arg0: &Policy) : u16 {
        arg0.max_slippage_bps
    }

    public fun min_interval_ms(arg0: &Policy) : u64 {
        arg0.min_interval_ms
    }

    public fun new(arg0: 0x2::vec_set::VecSet<0x1::type_name::TypeName>, arg1: 0x2::vec_set::VecSet<address>, arg2: u16, arg3: u64, arg4: u64, arg5: u16) : Policy {
        assert!(arg2 <= 10000, 6);
        Policy{
            allowed_tokens      : arg0,
            allowed_pools       : arg1,
            max_slippage_bps    : arg2,
            max_position_usd_e6 : arg3,
            min_interval_ms     : arg4,
            max_leverage_bps    : arg5,
            paused              : false,
        }
    }

    public fun set_limits(arg0: &mut Policy, arg1: u16, arg2: u64, arg3: u64) {
        assert!(arg1 <= 10000, 6);
        arg0.max_slippage_bps = arg1;
        arg0.max_position_usd_e6 = arg2;
        arg0.min_interval_ms = arg3;
    }

    public fun set_paused(arg0: &mut Policy, arg1: bool) {
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v7
}

