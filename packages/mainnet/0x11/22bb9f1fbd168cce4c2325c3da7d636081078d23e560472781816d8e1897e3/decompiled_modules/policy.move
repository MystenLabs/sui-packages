module 0x1122bb9f1fbd168cce4c2325c3da7d636081078d23e560472781816d8e1897e3::policy {
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

    public fun assert_pool(arg0: &Policy, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.allowed_pools, &arg1), 1);
    }

    public fun assert_position_size(arg0: &Policy, arg1: u64) {
        assert!(arg1 <= arg0.max_position_usd_e6, 4);
    }

    public fun assert_slippage(arg0: &Policy, arg1: u16) {
        assert!(arg1 <= arg0.max_slippage_bps, 2);
    }

    public fun assert_token<T0>(arg0: &Policy) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_tokens, &v0), 0);
    }

    public fun is_paused(arg0: &Policy) : bool {
        arg0.paused
    }

    public fun max_leverage_bps(arg0: &Policy) : u16 {
        arg0.max_leverage_bps
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

    public fun min_return_e6(arg0: &Policy, arg1: u64) : u64 {
        (((arg1 as u128) * ((10000 - (arg0.max_slippage_bps as u64)) as u128) / (10000 as u128)) as u64)
    }

    public fun new(arg0: 0x2::vec_set::VecSet<0x1::type_name::TypeName>, arg1: 0x2::vec_set::VecSet<address>, arg2: u16, arg3: u64, arg4: u64, arg5: u16) : Policy {
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

    public fun set_paused(arg0: &mut Policy, arg1: bool) {
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v7
}

