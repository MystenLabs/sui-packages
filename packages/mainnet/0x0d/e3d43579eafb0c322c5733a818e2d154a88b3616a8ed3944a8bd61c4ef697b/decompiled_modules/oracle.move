module 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::oracle {
    struct Oracle has key {
        id: 0x2::object::UID,
    }

    struct PriceFeed<phantom T0> has store {
        price_against_sui: u128,
        latest_update_time: u64,
        decimals: u8,
        tolerance_ms: u64,
        rule: 0x1::type_name::TypeName,
    }

    public fun add_price_feed<T0, T1: drop>(arg0: &0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::listing::ListingCap, arg1: &mut Oracle, arg2: u8, arg3: u64) {
        if (price_feed_exists<T0>(arg1)) {
            err_price_feed_already_exists();
        };
        let v0 = PriceFeed<T0>{
            price_against_sui  : 0,
            latest_update_time : 0,
            decimals           : arg2,
            tolerance_ms       : arg3,
            rule               : 0x1::type_name::get<T1>(),
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, PriceFeed<T0>>(&mut arg1.id, 0x1::type_name::get<T0>(), v0);
    }

    fun borrow_price_feed<T0>(arg0: &Oracle) : &PriceFeed<T0> {
        if (!price_feed_exists<T0>(arg0)) {
            err_price_feed_not_exist();
        };
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, PriceFeed<T0>>(&arg0.id, 0x1::type_name::get<T0>())
    }

    fun borrow_price_feed_mut<T0>(arg0: &mut Oracle) : &mut PriceFeed<T0> {
        if (!price_feed_exists<T0>(arg0)) {
            err_price_feed_not_exist();
        };
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, PriceFeed<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    public fun change_rule<T0, T1: drop>(arg0: &0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::listing::ListingCap, arg1: &mut Oracle) {
        if (!price_feed_exists<T0>(arg1)) {
            err_price_feed_not_exist();
        };
        borrow_price_feed_mut<T0>(arg1).rule = 0x1::type_name::get<T1>();
    }

    fun err_invalid_price_rule() {
        abort 3
    }

    fun err_price_feed_already_exists() {
        abort 2
    }

    fun err_price_feed_is_outdated() {
        abort 0
    }

    fun err_price_feed_not_exist() {
        abort 1
    }

    fun handle_decimal_diff(arg0: u64, arg1: u8) : u64 {
        let v0 = 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::config::sui_decimals();
        if (v0 > arg1) {
            0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::math::mul_and_div(arg0, 1, 0x2::math::pow(10, v0 - arg1))
        } else if (v0 < arg1) {
            0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::math::mul_and_div(arg0, 0x2::math::pow(10, v0 - arg1), 1)
        } else {
            arg0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Oracle{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Oracle>(v0);
    }

    public fun price_feed_exists<T0>(arg0: &Oracle) : bool {
        0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, PriceFeed<T0>>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun remove_price_feed<T0>(arg0: &0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::listing::ListingCap, arg1: &mut Oracle) {
        if (!price_feed_exists<T0>(arg1)) {
            err_price_feed_not_exist();
        };
        let PriceFeed {
            price_against_sui  : _,
            latest_update_time : _,
            decimals           : _,
            tolerance_ms       : _,
            rule               : _,
        } = 0x2::dynamic_field::remove<0x1::type_name::TypeName, PriceFeed<T0>>(&mut arg1.id, 0x1::type_name::get<T0>());
    }

    public fun ticket_price<T0>(arg0: &Oracle, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (v0 > arg2) {
            (v0 - arg2) / 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::config::price_period() * 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::config::price_increment()
        } else {
            0
        };
        let v2 = 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::config::initial_price_in_sui() + v1;
        let v3 = v2;
        if (v2 > 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::config::max_price_in_sui()) {
            v3 = 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::config::max_price_in_sui();
        };
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            v3
        } else {
            let v5 = borrow_price_feed<T0>(arg0);
            if (v0 - v5.latest_update_time > v5.tolerance_ms) {
                err_price_feed_is_outdated();
            };
            handle_decimal_diff(0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::math::mul_and_div_u128(v3, 0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::config::precision(), v5.price_against_sui), v5.decimals)
        }
    }

    public fun update_price<T0, T1: drop>(arg0: T1, arg1: &mut Oracle, arg2: &0x2::clock::Clock, arg3: u128) {
        let v0 = borrow_price_feed_mut<T0>(arg1);
        if (v0.rule != 0x1::type_name::get<T1>()) {
            err_invalid_price_rule();
        };
        v0.latest_update_time = 0x2::clock::timestamp_ms(arg2);
        v0.price_against_sui = arg3;
    }

    public fun update_tolerance_ms<T0>(arg0: &0xb1bd3db2664e3d980fa8e6f2a5391cad98bc082f8fec3ed62459b3731983e5e::listing::ListingCap, arg1: &mut Oracle, arg2: u64) {
        if (!price_feed_exists<T0>(arg1)) {
            err_price_feed_not_exist();
        };
        borrow_price_feed_mut<T0>(arg1).tolerance_ms = arg2;
    }

    // decompiled from Move bytecode v6
}

