module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle {
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

    public fun add_price_feed<T0, T1: drop>(arg0: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::ListingCap, arg1: &mut Oracle, arg2: u8, arg3: u64) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, PriceFeed<T0>>(&arg1.id, v0), 2);
        let v1 = PriceFeed<T0>{
            price_against_sui  : 0,
            latest_update_time : 0,
            decimals           : arg2,
            tolerance_ms       : arg3,
            rule               : 0x1::type_name::get<T1>(),
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, PriceFeed<T0>>(&mut arg1.id, v0, v1);
    }

    fun borrow_price_feed<T0>(arg0: &Oracle) : &PriceFeed<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, PriceFeed<T0>>(&arg0.id, v0), 1);
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, PriceFeed<T0>>(&arg0.id, v0)
    }

    fun borrow_price_feed_mut<T0>(arg0: &mut Oracle) : &mut PriceFeed<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, PriceFeed<T0>>(&arg0.id, v0), 1);
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, PriceFeed<T0>>(&mut arg0.id, v0)
    }

    public fun change_rule<T0, T1: drop>(arg0: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::ListingCap, arg1: &mut Oracle) {
        borrow_price_feed_mut<T0>(arg1).rule = 0x1::type_name::get<T1>();
    }

    fun handle_decimal_diff(arg0: u64, arg1: u8) : u64 {
        let v0 = sui_decimals();
        if (v0 > arg1) {
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(arg0, 1, 0x2::math::pow(10, v0 - arg1))
        } else if (v0 < arg1) {
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(arg0, 0x2::math::pow(10, v0 - arg1), 1)
        } else {
            arg0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Oracle{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Oracle>(v0);
    }

    public fun precision() : u128 {
        1000000000000000000
    }

    public fun precision_decimals() : u8 {
        18
    }

    public fun red_envelop_price<T0>(arg0: &Oracle, arg1: &0x2::clock::Clock) : u64 {
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            red_envelop_price_in_sui()
        } else {
            let v1 = borrow_price_feed<T0>(arg0);
            assert!(0x2::clock::timestamp_ms(arg1) - v1.latest_update_time <= v1.tolerance_ms, 0);
            handle_decimal_diff(0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div_u128(red_envelop_price_in_sui(), precision(), v1.price_against_sui), v1.decimals)
        }
    }

    public fun red_envelop_price_in_sui() : u64 {
        10000000000
    }

    public fun remove_price_feed<T0>(arg0: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::ListingCap, arg1: &mut Oracle) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, PriceFeed<T0>>(&arg1.id, v0), 2);
        let PriceFeed {
            price_against_sui  : _,
            latest_update_time : _,
            decimals           : _,
            tolerance_ms       : _,
            rule               : _,
        } = 0x2::dynamic_field::remove<0x1::type_name::TypeName, PriceFeed<T0>>(&mut arg1.id, v0);
    }

    public fun sui_decimals() : u8 {
        9
    }

    public fun update_price<T0, T1: drop>(arg0: T1, arg1: &mut Oracle, arg2: &0x2::clock::Clock, arg3: u128) {
        let v0 = borrow_price_feed_mut<T0>(arg1);
        assert!(v0.rule == 0x1::type_name::get<T1>(), 3);
        v0.latest_update_time = 0x2::clock::timestamp_ms(arg2);
        v0.price_against_sui = arg3;
    }

    public fun update_tolerance_ms<T0>(arg0: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::ListingCap, arg1: &mut Oracle, arg2: u64) {
        borrow_price_feed_mut<T0>(arg1).tolerance_ms = arg2;
    }

    // decompiled from Move bytecode v6
}

