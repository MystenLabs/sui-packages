module 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::redstone_core {
    fun price_data(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg1: 0x2::object::ID, arg2: vector<u8>) : &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::PriceData {
        assert!(0x2::object::id<0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter>(arg0) == arg1, 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::redstone_core_wrong_adapter());
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::price_data(arg0, arg2)
    }

    fun publish_time_ms(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::PriceData) : u64 {
        let v0 = 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::timestamp(arg0);
        let v1 = 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::write_timestamp(arg0);
        if (v0 < v1) {
            v0
        } else {
            v1
        }
    }

    public(friend) fun read_source(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: bool, arg4: &0x2::clock::Clock) : 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Price {
        let v0 = price_data(arg0, arg1, arg2);
        let v1 = reading_error(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::price(v0), publish_time_ms(v0), arg3, arg4);
        if (0x1::option::is_some<u64>(&v1)) {
            abort 0x1::option::destroy_some<u64>(v1)
        };
        to_price(v0)
    }

    fun reading_error(arg0: u256, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : 0x1::option::Option<u64> {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (v0 < arg1) {
            return 0x1::option::some<u64>(0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::redstone_core_price_too_old())
        };
        let v1 = if (arg2) {
            0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::constants::max_age_liquidate()
        } else {
            0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::constants::max_age_operate()
        };
        if (v0 - arg1 > v1 * 1000) {
            return 0x1::option::some<u64>(0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::redstone_core_price_too_old())
        };
        if (arg0 == 0) {
            return 0x1::option::some<u64>(0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::redstone_core_price_not_valid())
        };
        if (arg0 > 18446744073709551615) {
            return 0x1::option::some<u64>(0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::redstone_core_price_overflow())
        };
        0x1::option::none<u64>()
    }

    fun to_price(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::PriceData) : 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Price {
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::new_price((0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::price(arg0) as u128), 0x1::option::some<u32>((0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::constants::redstone_decimals() as u32)))
    }

    public(friend) fun try_read_source(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &0x2::clock::Clock) : (0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Price>, bool, u64) {
        let v0 = price_data(arg0, arg1, arg2);
        let v1 = reading_error(0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::price(v0), publish_time_ms(v0), true, arg3);
        if (0x1::option::is_some<u64>(&v1)) {
            return (0x1::option::none<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Price>(), false, 0x1::option::destroy_some<u64>(v1))
        };
        (0x1::option::some<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Price>(to_price(v0)), 0x2::clock::timestamp_ms(arg3) - publish_time_ms(v0) <= 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::constants::max_age_operate() * 1000, 0)
    }

    // decompiled from Move bytecode v7
}

