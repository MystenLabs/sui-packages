module 0x662e339ad17c4442bbfa78e9335b344a32bdbb642bfe950c317d99a1b054d592::calculator {
    public fun caculate_utilization(arg0: &mut 0x662e339ad17c4442bbfa78e9335b344a32bdbb642bfe950c317d99a1b054d592::storage::Storage, arg1: u8, arg2: u256) : u256 {
        let (v0, v1) = 0x662e339ad17c4442bbfa78e9335b344a32bdbb642bfe950c317d99a1b054d592::storage::get_total_supply(arg0, arg1);
        let (_, v3) = 0x662e339ad17c4442bbfa78e9335b344a32bdbb642bfe950c317d99a1b054d592::storage::get_index(arg0, arg1);
        if (0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray_mul(v1, v3) + arg2 == 0) {
            0
        } else {
            0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray_div(v1, v0)
        }
    }

    public fun calculate_amount(arg0: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg1: u256, arg2: u8) : u256 {
        let (v0, v1) = 0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::get_token_price(arg0, arg2);
        arg1 * (0x2::math::pow(10, v1) as u256) / v0
    }

    public fun calculate_borrow_rate(arg0: &mut 0x662e339ad17c4442bbfa78e9335b344a32bdbb642bfe950c317d99a1b054d592::storage::Storage, arg1: u8, arg2: u256) : u256 {
        let (v0, v1, v2, _, v4) = 0x662e339ad17c4442bbfa78e9335b344a32bdbb642bfe950c317d99a1b054d592::storage::get_borrow_rate_factors(arg0, arg1);
        let v5 = caculate_utilization(arg0, arg1, arg2);
        if (v5 < v4) {
            v0 + 0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray_mul(v5, v1)
        } else {
            v0 + 0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray_mul(v5, v1) + 0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray_mul(v5 - v4, v2)
        }
    }

    public fun calculate_compounded_interest(arg0: u64, arg1: u64, arg2: u256) : u256 {
        let v0 = ((arg0 - arg1) as u256);
        if (v0 == 0) {
            return 0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray()
        };
        let v1 = v0 - 1;
        let v2 = 0;
        if (v0 > 2) {
            v2 = v0 - 2;
        };
        let v3 = arg2 / 31536000;
        let v4 = 0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray_mul(v3, v3);
        0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray() + v3 * v0 + v0 * v1 * v4 / 2 + v0 * v1 * v2 * 0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray_mul(v4, v3) / 6
    }

    public fun calculate_linear_interest(arg0: u64, arg1: u64, arg2: u256) : u256 {
        0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray() + arg2 * ((arg0 - arg1) as u256) / 31536000
    }

    public fun calculate_supply_rate(arg0: &mut 0x662e339ad17c4442bbfa78e9335b344a32bdbb642bfe950c317d99a1b054d592::storage::Storage, arg1: u8, arg2: u256, arg3: u256) : u256 {
        let (_, _, _, v3, _) = 0x662e339ad17c4442bbfa78e9335b344a32bdbb642bfe950c317d99a1b054d592::storage::get_borrow_rate_factors(arg0, arg1);
        0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray_mul(0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray_mul(arg2, caculate_utilization(arg0, arg1, arg3)), 0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray() - v3)
    }

    public fun calculate_value(arg0: &0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::PriceOracle, arg1: u256, arg2: u8) : u256 {
        let (v0, v1) = 0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle::get_token_price(arg0, arg2);
        arg1 * v0 / (0x2::math::pow(10, v1) as u256)
    }

    // decompiled from Move bytecode v6
}

