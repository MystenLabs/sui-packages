module 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::rate {
    public(friend) fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun read(arg0: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: bool, arg4: &0x2::clock::Clock) : 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Price {
        let v0 = 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::source_type(arg0);
        let v1 = 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::redstone_adapter_id(&v0);
        if (0x1::option::is_some<0x2::object::ID>(&v1)) {
            0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::redstone_core::read_source(arg1, 0x1::option::destroy_some<0x2::object::ID>(v1), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::feed_id(arg0), arg3, arg4)
        } else {
            0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::pyth_core::read_source(arg2, 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::feed_id(arg0), arg3, arg4)
        }
    }

    public(friend) fun read_rate(arg0: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: bool, arg4: &0x2::clock::Clock) : u128 {
        let v0 = read(arg0, arg1, arg2, arg3, arg4);
        let v1 = scale_and_invert(&v0, 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::invert(arg0));
        assert!(v1 > 0, 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::rate_scaled_to_zero());
        v1
    }

    fun scale_and_invert(arg0: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Price, arg1: bool) : u128 {
        let (v0, v1, v2) = 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::get(arg0);
        let v3 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(v0, v1, v2);
        let v4 = v3;
        if (v3 > 0 && arg1) {
            let v5 = if (v3 > 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::constants::max_invertible_rate()) {
                0
            } else {
                0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::constants::rate_factor(), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::constants::rate_factor(), v3)
            };
            v4 = v5;
        };
        v4
    }

    fun try_read(arg0: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Price>, bool, u64) {
        let v0 = 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::source_type(arg0);
        let v1 = 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::redstone_adapter_id(&v0);
        if (0x1::option::is_some<0x2::object::ID>(&v1)) {
            0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::redstone_core::try_read_source(arg1, 0x1::option::destroy_some<0x2::object::ID>(v1), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::feed_id(arg0), arg3)
        } else {
            0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::pyth_core::try_read_source(arg2, 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::feed_id(arg0), arg3)
        }
    }

    public(friend) fun try_read_rate(arg0: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source, arg1: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (0x1::option::Option<u128>, bool, u64) {
        let (v0, v1, v2) = try_read(arg0, arg1, arg2, arg3);
        let v3 = v0;
        if (0x1::option::is_none<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Price>(&v3)) {
            return (0x1::option::none<u128>(), false, v2)
        };
        let v4 = scale_and_invert(0x1::option::borrow<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Price>(&v3), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::invert(arg0));
        if (v4 == 0) {
            return (0x1::option::none<u128>(), false, 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::rate_scaled_to_zero())
        };
        (0x1::option::some<u128>(v4), v1, 0)
    }

    // decompiled from Move bytecode v7
}

