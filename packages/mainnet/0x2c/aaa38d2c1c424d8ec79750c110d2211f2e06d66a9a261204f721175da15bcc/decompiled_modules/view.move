module 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view {
    struct PriceQuote has copy, drop {
        oracle_id: 0x2::object::ID,
        rate_liquidate: 0x1::option::Option<u128>,
        rate_operate: 0x1::option::Option<u128>,
    }

    fun assert_not_outdated(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry) {
        assert!(0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::version(arg0) <= 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::constants::version(), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::errors::oracle_wrong_version());
    }

    fun compute_liquidate(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::Oracle, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u128 {
        let v0 = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::main(arg0);
        let (v1, v2, v3) = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::rate::try_read_rate(&v0, arg1, arg2, arg3);
        let v4 = v1;
        let v5 = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::guard(arg0);
        if (0x1::option::is_none<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>(&v5)) {
            assert!(0x1::option::is_some<u128>(&v4), v3);
            return 0x1::option::destroy_some<u128>(v4)
        };
        let v6 = 0x1::option::destroy_some<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>(v5);
        let (v7, v8, _) = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::rate::try_read_rate(&v6, arg1, arg2, arg3);
        let v10 = v7;
        if (0x1::option::is_some<u128>(&v4) && 0x1::option::is_some<u128>(&v10)) {
            if (v2 == v8) {
                0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::rate::min(0x1::option::destroy_some<u128>(v4), 0x1::option::destroy_some<u128>(v10))
            } else if (v2) {
                0x1::option::destroy_some<u128>(v4)
            } else {
                0x1::option::destroy_some<u128>(v10)
            }
        } else if (0x1::option::is_some<u128>(&v4)) {
            0x1::option::destroy_some<u128>(v4)
        } else {
            assert!(0x1::option::is_some<u128>(&v10), v3);
            0x1::option::destroy_some<u128>(v10)
        }
    }

    fun compute_operate(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::Oracle, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u128 {
        let v0 = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::main(arg0);
        let v1 = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::guard(arg0);
        if (0x1::option::is_none<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>(&v1)) {
            return 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::rate::read_rate(&v0, arg1, arg2, false, arg3)
        };
        let v2 = 0x1::option::destroy_some<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>(v1);
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::rate::min(0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::rate::read_rate(&v0, arg1, arg2, false, arg3), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::rate::read_rate(&v2, arg1, arg2, false, arg3))
    }

    public fun get_both_exchange_rate(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg1: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::Oracle, arg2: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : PriceQuote {
        assert_not_outdated(arg0);
        PriceQuote{
            oracle_id      : 0x2::object::id<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::Oracle>(arg1),
            rate_liquidate : 0x1::option::some<u128>(compute_liquidate(arg1, arg2, arg3, arg4)),
            rate_operate   : 0x1::option::some<u128>(compute_operate(arg1, arg2, arg3, arg4)),
        }
    }

    public fun get_exchange_rate_liquidate(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg1: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::Oracle, arg2: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : PriceQuote {
        assert_not_outdated(arg0);
        PriceQuote{
            oracle_id      : 0x2::object::id<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::Oracle>(arg1),
            rate_liquidate : 0x1::option::some<u128>(compute_liquidate(arg1, arg2, arg3, arg4)),
            rate_operate   : 0x1::option::none<u128>(),
        }
    }

    public fun get_exchange_rate_operate(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg1: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::Oracle, arg2: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : PriceQuote {
        assert_not_outdated(arg0);
        PriceQuote{
            oracle_id      : 0x2::object::id<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::Oracle>(arg1),
            rate_liquidate : 0x1::option::none<u128>(),
            rate_operate   : 0x1::option::some<u128>(compute_operate(arg1, arg2, arg3, arg4)),
        }
    }

    public fun oracle_id(arg0: &PriceQuote) : 0x2::object::ID {
        arg0.oracle_id
    }

    public fun rate_liquidate(arg0: &PriceQuote) : u128 {
        assert!(0x1::option::is_some<u128>(&arg0.rate_liquidate), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::errors::view_rate_not_in_quote());
        *0x1::option::borrow<u128>(&arg0.rate_liquidate)
    }

    public fun rate_operate(arg0: &PriceQuote) : u128 {
        assert!(0x1::option::is_some<u128>(&arg0.rate_operate), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::errors::view_rate_not_in_quote());
        *0x1::option::borrow<u128>(&arg0.rate_operate)
    }

    // decompiled from Move bytecode v7
}

