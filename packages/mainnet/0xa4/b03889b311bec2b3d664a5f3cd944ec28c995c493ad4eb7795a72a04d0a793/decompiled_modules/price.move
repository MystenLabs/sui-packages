module 0xa4b03889b311bec2b3d664a5f3cd944ec28c995c493ad4eb7795a72a04d0a793::price {
    struct Checked<phantom T0> has copy, drop {
        lower: u64,
        expo: u64,
        decimals: u8,
    }

    struct Edges<phantom T0> has copy, drop {
        lower: u64,
        upper: u64,
        expo: u64,
        decimals: u8,
    }

    public fun charged_micros<T0>(arg0: &Edges<T0>, arg1: u64) : u64 {
        value(arg1, arg0.upper, arg0.expo, arg0.decimals)
    }

    public fun check<T0>(arg0: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::ConvertRegistry, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : Checked<T0> {
        let v0 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::enabled_entry<T0>(arg0);
        check_entry<T0>(&v0, arg1, arg2)
    }

    public fun check_edges<T0>(arg0: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::Entry, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : Edges<T0> {
        let v0 = check_entry<T0>(arg0, arg1, arg2);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_unsafe(arg1);
        Edges<T0>{
            lower    : v0.lower,
            upper    : v0.lower + 2 * 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v1),
            expo     : v0.expo,
            decimals : v0.decimals,
        }
    }

    public fun check_entry<T0>(arg0: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::Entry, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : Checked<T0> {
        assert!(0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::kind(arg0) == 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::kind_priced(), 1);
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v0);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v1) == 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::feed_id(arg0), 2);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_no_older_than(arg1, arg2, 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::max_age_s(arg0));
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v2);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v2);
        assert!(!0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v3) && 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v4), 3);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v3);
        let v6 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v2);
        assert!(v5 > 0 && v6 < v5, 3);
        assert!((v6 as u128) * 10000 <= (v5 as u128) * (0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::tolerance_bps(arg0) as u128), 4);
        let v7 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v4);
        assert!(v7 <= 18, 3);
        Checked<T0>{
            lower    : v5 - v6,
            expo     : v7,
            decimals : 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::decimals(arg0),
        }
    }

    public fun edges_lower<T0>(arg0: &Edges<T0>) : u64 {
        arg0.lower
    }

    public fun edges_upper<T0>(arg0: &Edges<T0>) : u64 {
        arg0.upper
    }

    public fun expo<T0>(arg0: &Checked<T0>) : u64 {
        arg0.expo
    }

    public fun lower<T0>(arg0: &Checked<T0>) : u64 {
        arg0.lower
    }

    public fun micros<T0>(arg0: &Checked<T0>, arg1: u64) : u64 {
        let v0 = (arg1 as u128) * (arg0.lower as u128) * 1000000 / pow10((arg0.decimals as u64)) * pow10(arg0.expo);
        assert!(v0 <= 18446744073709551615, 3);
        (v0 as u64)
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

    public fun returned_micros<T0>(arg0: &Edges<T0>, arg1: u64) : u64 {
        value(arg1, arg0.lower, arg0.expo, arg0.decimals)
    }

    fun value(arg0: u64, arg1: u64, arg2: u64, arg3: u8) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) * 1000000 / pow10((arg3 as u64)) * pow10(arg2);
        assert!(v0 <= 18446744073709551615, 3);
        (v0 as u64)
    }

    // decompiled from Move bytecode v7
}

