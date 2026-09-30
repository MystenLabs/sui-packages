module 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::view {
    struct PriceQuote has copy, drop {
        oracle_id: 0x2::object::ID,
        rate_liquidate: 0x1::option::Option<u128>,
        rate_operate: 0x1::option::Option<u128>,
    }

    fun compute_liquidate(arg0: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::Oracle, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u128 {
        let v0 = 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::main(arg0);
        let (v1, v2) = 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::rate::try_read_rate(&v0, arg1, arg2, arg3);
        let v3 = v1;
        let v4 = 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::guard(arg0);
        if (0x1::option::is_none<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source>(&v4)) {
            assert!(0x1::option::is_some<u128>(&v3), v2);
            return 0x1::option::destroy_some<u128>(v3)
        };
        let v5 = 0x1::option::destroy_some<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source>(v4);
        let (v6, _) = 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::rate::try_read_rate(&v5, arg1, arg2, arg3);
        let v8 = v6;
        if (0x1::option::is_some<u128>(&v3) && 0x1::option::is_some<u128>(&v8)) {
            0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::rate::min(0x1::option::destroy_some<u128>(v3), 0x1::option::destroy_some<u128>(v8))
        } else if (0x1::option::is_some<u128>(&v3)) {
            0x1::option::destroy_some<u128>(v3)
        } else {
            assert!(0x1::option::is_some<u128>(&v8), v2);
            0x1::option::destroy_some<u128>(v8)
        }
    }

    fun compute_operate(arg0: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::Oracle, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u128 {
        let v0 = 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::main(arg0);
        let v1 = 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::guard(arg0);
        if (0x1::option::is_none<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source>(&v1)) {
            return 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::rate::read_rate(&v0, arg1, arg2, false, arg3)
        };
        let v2 = 0x1::option::destroy_some<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source>(v1);
        0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::rate::min(0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::rate::read_rate(&v0, arg1, arg2, false, arg3), 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::rate::read_rate(&v2, arg1, arg2, false, arg3))
    }

    public fun get_both_exchange_rate(arg0: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::Oracle, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : PriceQuote {
        PriceQuote{
            oracle_id      : 0x2::object::id<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::Oracle>(arg0),
            rate_liquidate : 0x1::option::some<u128>(compute_liquidate(arg0, arg1, arg2, arg3)),
            rate_operate   : 0x1::option::some<u128>(compute_operate(arg0, arg1, arg2, arg3)),
        }
    }

    public fun get_exchange_rate_liquidate(arg0: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::Oracle, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : PriceQuote {
        PriceQuote{
            oracle_id      : 0x2::object::id<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::Oracle>(arg0),
            rate_liquidate : 0x1::option::some<u128>(compute_liquidate(arg0, arg1, arg2, arg3)),
            rate_operate   : 0x1::option::none<u128>(),
        }
    }

    public fun get_exchange_rate_operate(arg0: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::Oracle, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : PriceQuote {
        PriceQuote{
            oracle_id      : 0x2::object::id<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::Oracle>(arg0),
            rate_liquidate : 0x1::option::none<u128>(),
            rate_operate   : 0x1::option::some<u128>(compute_operate(arg0, arg1, arg2, arg3)),
        }
    }

    public fun oracle_id(arg0: &PriceQuote) : 0x2::object::ID {
        arg0.oracle_id
    }

    public fun rate_liquidate(arg0: &PriceQuote) : u128 {
        assert!(0x1::option::is_some<u128>(&arg0.rate_liquidate), 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::view_rate_not_in_quote());
        *0x1::option::borrow<u128>(&arg0.rate_liquidate)
    }

    public fun rate_operate(arg0: &PriceQuote) : u128 {
        assert!(0x1::option::is_some<u128>(&arg0.rate_operate), 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::view_rate_not_in_quote());
        *0x1::option::borrow<u128>(&arg0.rate_operate)
    }

    // decompiled from Move bytecode v7
}

