module 0xf796d36fada0fedbc2c1a3b31980fdc9028faea6f3750ec7819d15e991995a0e::rate_limits {
    struct RateLimitState has store, key {
        id: 0x2::object::UID,
        rate_limits: 0x2::object_bag::ObjectBag,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RateLimit<phantom T0> has store, key {
        id: 0x2::object::UID,
        period: u64,
        percentage: u64,
        last_update: u64,
        current_limit: u64,
    }

    fun calculate_limit<T0>(arg0: u64, arg1: &RateLimit<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = arg1.period;
        if (v0 == 0) {
            return 0
        };
        let v1 = arg0 * arg1.percentage / 10000;
        let v2 = (0x2::clock::timestamp_ms(arg2) - arg1.last_update) / 1000;
        let v3 = if (v2 > v0) {
            v0
        } else {
            v2
        };
        let v4 = (arg0 - v1) * v3 / v0;
        if (arg1.current_limit < v4) {
            return v1
        };
        let v5 = arg1.current_limit - v4;
        if (v5 > v1) {
            v5
        } else {
            v1
        }
    }

    public fun get_type_string<T0>() : 0x1::string::String {
        to_hex_string(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RateLimitState{
            id          : 0x2::object::new(arg0),
            rate_limits : 0x2::object_bag::new(arg0),
        };
        0x2::transfer::public_share_object<RateLimitState>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun set_current_limit<T0>(arg0: &mut RateLimit<T0>, arg1: u64, arg2: &AdminCap) {
        arg0.current_limit = arg1;
    }

    entry fun set_last_update<T0>(arg0: &mut RateLimit<T0>, arg1: u64, arg2: &AdminCap) {
        arg0.last_update = arg1;
    }

    entry fun set_percentage<T0>(arg0: &mut RateLimit<T0>, arg1: u64, arg2: &AdminCap) {
        arg0.percentage = arg1;
    }

    entry fun set_period<T0>(arg0: &mut RateLimit<T0>, arg1: u64, arg2: &AdminCap) {
        arg0.period = arg1;
    }

    entry fun set_rate_limit<T0>(arg0: &mut RateLimitState, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &AdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = get_type_string<T0>();
        if (0x2::object_bag::contains<0x1::string::String>(&arg0.rate_limits, v0)) {
            let v1 = 0x2::object_bag::borrow_mut<0x1::string::String, RateLimit<T0>>(&mut arg0.rate_limits, v0);
            v1.current_limit = arg4;
            v1.last_update = arg3;
            v1.percentage = arg2;
            v1.period = arg1;
        };
        let v2 = RateLimit<T0>{
            id            : 0x2::object::new(arg6),
            period        : arg1,
            percentage    : arg2,
            last_update   : arg3,
            current_limit : arg4,
        };
        0x2::object_bag::add<0x1::string::String, RateLimit<T0>>(&mut arg0.rate_limits, v0, v2);
    }

    public fun to_hex_string(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, arg0);
        v0
    }

    public fun verify_withdraw<T0>(arg0: &mut RateLimitState, arg1: &0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
    }

    // decompiled from Move bytecode v6
}

