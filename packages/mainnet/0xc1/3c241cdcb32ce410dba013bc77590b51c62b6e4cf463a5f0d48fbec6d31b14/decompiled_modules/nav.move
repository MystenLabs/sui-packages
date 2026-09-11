module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::nav {
    public fun add<T0>(arg0: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::NavTicket, arg2: &0x2::clock::Clock) {
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::nav_version(arg1) == 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 1202);
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::nav_registry(arg1) == 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0), 1203);
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::is_constituent(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::composition(v0), v1), 1200);
        let v2 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::balance_of<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::custody(v0));
        let v3 = if (v2 == 0) {
            0
        } else {
            let v4 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices(v0);
            scale_value(v2, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::decimals_of(v4, v1), 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::get(v4, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy(v0), v1, arg2))
        };
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::nav_add(arg1, v1, v3);
    }

    public fun begin(arg0: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry) : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::NavTicket {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::token_count(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::composition(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner(arg0)));
        assert!(v0 > 0, 1201);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::new_nav(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0), v0)
    }

    entry fun commit_price<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: 0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation::Observation, arg2: &0x2::clock::Clock) {
        let (v0, v1) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices_and_policy_mut(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut(arg0));
        if (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::commit<T0>(v0, v1, arg1, arg2) == 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::outcome_breaker_tripped()) {
            0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::tighten(arg0, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::status_withdraw_only());
        };
    }

    public fun finish(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::NavTicket, arg2: &0x2::clock::Clock) {
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::write_nav(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting_mut(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut(arg0)), 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::consume_nav(arg1, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0)), 0x2::clock::timestamp_ms(arg2));
    }

    fun pow10(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun preview_value<T0>(arg0: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::balance_of<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::custody(v0));
        if (v2 == 0) {
            return 0
        };
        let v3 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices(v0);
        scale_value(v2, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::decimals_of(v3, v1), 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::get(v3, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy(v0), v1, arg1))
    }

    fun scale_value(arg0: u64, arg1: u8, arg2: u64) : u64 {
        (((arg0 as u128) * (arg2 as u128) / (pow10((arg1 as u64)) as u128)) as u64)
    }

    public fun value_of_amount(arg0: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner(arg0);
        let v1 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices(v0);
        scale_value(arg2, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::decimals_of(v1, arg1), 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::get(v1, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy(v0), arg1, arg3))
    }

    // decompiled from Move bytecode v7
}

