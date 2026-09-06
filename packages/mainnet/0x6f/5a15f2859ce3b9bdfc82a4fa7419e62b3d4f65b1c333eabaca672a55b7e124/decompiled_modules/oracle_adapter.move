module 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::oracle_adapter {
    struct OracleBinUpdate has copy, drop, store {
        bin_id: u32,
        oldest_ms: u64,
    }

    struct FeedReading has copy, drop {
        price_mag: u64,
        conf_mag: u64,
        expo_negative: bool,
        expo_mag: u8,
        ts_ms: u64,
    }

    fun adjust_for_decimals(arg0: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg1: u8, arg2: u8) : 0x1::option::Option<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number> {
        if (arg1 == arg2) {
            return 0x1::option::some<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(arg0)
        };
        let (v0, v1) = if (arg2 > arg1) {
            (arg2 - arg1, false)
        } else {
            (arg1 - arg2, true)
        };
        if (v0 > 18) {
            return 0x1::option::none<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>()
        };
        if (v1) {
            0x1::option::some<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(arg0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::pow10(v0))))
        } else {
            0x1::option::some<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::pow10(v0))))
        }
    }

    public fun bin_id(arg0: &OracleBinUpdate) : u32 {
        arg0.bin_id
    }

    fun checked_bin_id(arg0: bool, arg1: u32) : 0x1::option::Option<u32> {
        if (arg0) {
            let v1 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bin_id_offset();
            if (v1 < arg1) {
                return 0x1::option::none<u32>()
            };
            0x1::option::some<u32>(v1 - arg1)
        } else {
            let v2 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bin_id_offset();
            if (arg1 > 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::bitmap::max_bin_id() - v2) {
                return 0x1::option::none<u32>()
            };
            0x1::option::some<u32>(v2 + arg1)
        }
    }

    fun checked_oracle_conf_pair(arg0: &FeedReading, arg1: &FeedReading, arg2: u16) : bool {
        if (arg2 == 0) {
            return false
        };
        let v0 = (arg2 as u128);
        let v1 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bps_denominator_u128();
        if (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_mul((arg0.conf_mag as u128), v1) > 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_mul((arg0.price_mag as u128), v0)) {
            return false
        };
        if (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_mul((arg1.conf_mag as u128), v1) > 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::checked_mul((arg1.price_mag as u128), v0)) {
            return false
        };
        true
    }

    fun checked_oracle_timestamp_pair(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x1::option::Option<u64> {
        let v0 = if (arg0 < arg1) {
            arg0
        } else {
            arg1
        };
        let v1 = if (arg0 > arg1) {
            arg0
        } else {
            arg1
        };
        if (v1 - v0 > arg4) {
            return 0x1::option::none<u64>()
        };
        if (v1 > arg2 && v1 - arg2 > 10000) {
            return 0x1::option::none<u64>()
        };
        if (v0 < arg2 && arg2 - v0 > arg3) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(v0)
    }

    public fun compute_oracle_bin_id<T0, T1>(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg1: u32, arg2: u32, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: u16, arg6: u64, arg7: u16, arg8: u64, arg9: &0x2::clock::Clock) : 0x1::option::Option<OracleBinUpdate> {
        assert!(arg1 != 0, 656);
        assert!(arg2 != 0, 656);
        let v0 = find_feed(arg0, arg1);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v0)) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        let v1 = find_feed(arg0, arg2);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v1)) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        compute_oracle_bin_id_from_feeds(0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0), 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v1), arg1, arg2, 0x2::coin::get_decimals<T0>(arg3), 0x2::coin::get_decimals<T1>(arg4), arg5, arg6, arg7, arg8, arg9)
    }

    public fun compute_oracle_bin_id_from_feeds(arg0: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg2: u32, arg3: u32, arg4: u8, arg5: u8, arg6: u16, arg7: u64, arg8: u16, arg9: u64, arg10: &0x2::clock::Clock) : 0x1::option::Option<OracleBinUpdate> {
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(&arg0) == arg2, 654);
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(&arg1) == arg3, 654);
        if (!0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::is_valid_bin_step(arg6)) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        if (arg9 == 0 || arg9 > (0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::max_oracle_pair_skew_ms() as u64)) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        let v0 = read_feed(&arg0);
        if (0x1::option::is_none<FeedReading>(&v0)) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        let v1 = read_feed(&arg1);
        if (0x1::option::is_none<FeedReading>(&v1)) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        let v2 = 0x1::option::destroy_some<FeedReading>(v0);
        let v3 = 0x1::option::destroy_some<FeedReading>(v1);
        let v4 = 0x2::clock::timestamp_ms(arg10);
        let v5 = checked_oracle_timestamp_pair(v2.ts_ms, v3.ts_ms, v4, arg7, arg9);
        if (0x1::option::is_none<u64>(&v5)) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        let v6 = 0x1::option::destroy_some<u64>(v5);
        if (!checked_oracle_conf_pair(&v2, &v3, arg8)) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        let v7 = lazer_price_to_number(&v2);
        if (0x1::option::is_none<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&v7)) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        let v8 = lazer_price_to_number(&v3);
        if (0x1::option::is_none<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&v8)) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        if (!q64_conversion_in_range(&v2, &v3, arg4, arg5)) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        let v9 = adjust_for_decimals(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x1::option::destroy_some<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(v7), 0x1::option::destroy_some<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(v8)), arg4, arg5);
        if (0x1::option::is_none<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&v9)) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        let v10 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u128(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x1::option::destroy_some<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(v9), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::q64())));
        if (v10 == 0) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        if (v10 < 1024) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        let (v11, v12) = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::log2(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::from_raw(v10));
        let (_, v14) = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::log2(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::from_fraction(((0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bps_denominator_u16() + arg6) as u64), 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bps_denominator_u64()));
        let v15 = checked_bin_id(v11, 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::to_u32_round(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64::div(v12, v14)));
        if (0x1::option::is_none<u32>(&v15)) {
            return 0x1::option::none<OracleBinUpdate>()
        };
        let v16 = if (v6 > v4) {
            v4
        } else {
            v6
        };
        let v17 = OracleBinUpdate{
            bin_id    : 0x1::option::destroy_some<u32>(v15),
            oldest_ms : v16,
        };
        0x1::option::some<OracleBinUpdate>(v17)
    }

    fun decimal_digits(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = arg0 / 10;
        while (v1 > 0) {
            v0 = v0 + 1;
            v1 = v1 / 10;
        };
        v0
    }

    public fun find_feed(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg1: u32) : 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed> {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::feeds(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v0)) {
            let v2 = *0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v0, v1);
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(&v2) == arg1) {
                return 0x1::option::some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v2)
            };
            v1 = v1 + 1;
        };
        0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>()
    }

    public fun is_valid_feed_id(arg0: u32) : bool {
        arg0 != 0
    }

    fun lazer_opt_positive_magnitude(arg0: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>) : (bool, u64) {
        if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&arg0)) {
            0x1::option::destroy_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(arg0);
            return (false, 0)
        };
        let v0 = 0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(arg0);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v0)) {
            0x1::option::destroy_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(v0);
            return (false, 0)
        };
        let v1 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(v0);
        if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v1)) {
            return (false, 0)
        };
        (true, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v1))
    }

    fun lazer_opt_u64(arg0: 0x1::option::Option<0x1::option::Option<u64>>) : (bool, u64) {
        if (0x1::option::is_none<0x1::option::Option<u64>>(&arg0)) {
            0x1::option::destroy_none<0x1::option::Option<u64>>(arg0);
            return (false, 0)
        };
        let v0 = 0x1::option::destroy_some<0x1::option::Option<u64>>(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            0x1::option::destroy_none<u64>(v0);
            return (false, 0)
        };
        (true, 0x1::option::destroy_some<u64>(v0))
    }

    fun lazer_price_to_number(arg0: &FeedReading) : 0x1::option::Option<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number> {
        if (arg0.price_mag == 0) {
            return 0x1::option::none<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>()
        };
        if (arg0.expo_mag > 18) {
            return 0x1::option::none<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>()
        };
        if (arg0.expo_mag == 0) {
            0x1::option::some<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128((arg0.price_mag as u128)))
        } else if (arg0.expo_negative) {
            0x1::option::some<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128((arg0.price_mag as u128)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::pow10(arg0.expo_mag))))
        } else {
            0x1::option::some<0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128((arg0.price_mag as u128)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::pow10(arg0.expo_mag))))
        }
    }

    public fun oldest_ms(arg0: &OracleBinUpdate) : u64 {
        arg0.oldest_ms
    }

    fun q64_conversion_in_range(arg0: &FeedReading, arg1: &FeedReading, arg2: u8, arg3: u8) : bool {
        let v0 = if (arg0.expo_negative) {
            1000 + decimal_digits(arg0.price_mag) + (arg3 as u64) - decimal_digits(arg1.price_mag) - (arg2 as u64) - (arg0.expo_mag as u64)
        } else {
            1000 + decimal_digits(arg0.price_mag) + (arg3 as u64) - decimal_digits(arg1.price_mag) - (arg2 as u64) + (arg0.expo_mag as u64)
        };
        let v1 = if (arg1.expo_negative) {
            v0 + (arg1.expo_mag as u64)
        } else {
            v0 - (arg1.expo_mag as u64)
        };
        v1 <= 1000 + 18 && v1 + 18 >= 1000
    }

    fun read_feed(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed) : 0x1::option::Option<FeedReading> {
        let (v0, v1) = lazer_opt_positive_magnitude(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(arg0));
        if (!v0 || v1 == 0) {
            return 0x1::option::none<FeedReading>()
        };
        let v2 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(arg0);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v2)) {
            0x1::option::destroy_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(v2);
            return 0x1::option::none<FeedReading>()
        };
        let v3 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(v2);
        let v4 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v3);
        let v5 = if (v4) {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v3)
        } else {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v3)
        };
        if (v5 > (18 as u16)) {
            return 0x1::option::none<FeedReading>()
        };
        let (v6, v7) = lazer_opt_positive_magnitude(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(arg0));
        if (!v6 || v7 == 0) {
            return 0x1::option::none<FeedReading>()
        };
        let (v8, v9) = lazer_opt_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(arg0));
        if (!v8) {
            return 0x1::option::none<FeedReading>()
        };
        let v10 = FeedReading{
            price_mag     : v1,
            conf_mag      : v7,
            expo_negative : v4,
            expo_mag      : (v5 as u8),
            ts_ms         : v9 / 1000,
        };
        0x1::option::some<FeedReading>(v10)
    }

    // decompiled from Move bytecode v7
}

