module 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::rate {
    public(friend) fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun read(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: bool, arg4: &0x2::clock::Clock) : 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Price {
        let v0 = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::source_type(arg0);
        let v1 = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::redstone_adapter_id(&v0);
        if (0x1::option::is_some<0x2::object::ID>(&v1)) {
            0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::redstone_core::read_source(arg1, 0x1::option::destroy_some<0x2::object::ID>(v1), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::feed_id(arg0), arg3, arg4)
        } else {
            0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::pyth_core::read_source(arg2, 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::feed_id(arg0), arg3, arg4)
        }
    }

    public(friend) fun read_rate(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: bool, arg4: &0x2::clock::Clock) : u128 {
        let v0 = read(arg0, arg1, arg2, arg3, arg4);
        let v1 = scale_and_invert(&v0, 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::invert(arg0));
        assert!(v1 > 0, 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::errors::rate_scaled_to_zero());
        v1
    }

    fun scale_and_invert(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Price, arg1: bool) : u128 {
        let (v0, v1, v2) = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::get(arg0);
        let v3 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(v0, v1, v2);
        let v4 = v3;
        if (v3 > 0 && arg1) {
            let v5 = if (v3 > 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::constants::max_invertible_rate()) {
                0
            } else {
                0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::constants::rate_factor(), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::constants::rate_factor(), v3)
            };
            v4 = v5;
        };
        v4
    }

    fun try_read(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Price>, bool, u64) {
        let v0 = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::source_type(arg0);
        let v1 = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::redstone_adapter_id(&v0);
        if (0x1::option::is_some<0x2::object::ID>(&v1)) {
            0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::redstone_core::try_read_source(arg1, 0x1::option::destroy_some<0x2::object::ID>(v1), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::feed_id(arg0), arg3)
        } else {
            0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::pyth_core::try_read_source(arg2, 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::feed_id(arg0), arg3)
        }
    }

    public(friend) fun try_read_rate(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (0x1::option::Option<u128>, bool, u64) {
        let (v0, v1, v2) = try_read(arg0, arg1, arg2, arg3);
        let v3 = v0;
        if (0x1::option::is_none<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Price>(&v3)) {
            return (0x1::option::none<u128>(), false, v2)
        };
        let v4 = scale_and_invert(0x1::option::borrow<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Price>(&v3), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::invert(arg0));
        if (v4 == 0) {
            return (0x1::option::none<u128>(), false, 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::errors::rate_scaled_to_zero())
        };
        (0x1::option::some<u128>(v4), v1, 0)
    }

    // decompiled from Move bytecode v7
}

