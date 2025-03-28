module 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::rebalance_util {
    public(friend) fun calc_f_x64(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg0 < arg1) {
            return 0
        };
        if (arg0 > arg2) {
            return 18446744073709551616
        };
        (((18446744073709551616 as u256) * ((arg0 - arg1) as u256) / (((arg0 - arg1) as u256) + ((arg0 - 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::util::muldiv_u128(arg0, arg0, arg2)) as u256))) as u128)
    }

    public(friend) fun calc_reward_sell_amounts(arg0: u64, arg1: u128, arg2: u256, arg3: u256, arg4: u256) : (u64, u64) {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = v1 * ((arg3 >> 64) as u256);
        let v3 = ((v0 * v2 / ((v2 >> 64) + ((arg4 >> 64) as u256) * (18446744073709551616 - v1) / (arg2 >> 64)) / (18446744073709551616 as u256)) as u64);
        ((v0 as u64) - v3, v3)
    }

    public(friend) fun calc_x_and_y_sell_amounts(arg0: u64, arg1: u64, arg2: u128, arg3: u256) : (u64, u64) {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg2 as u256);
        let v3 = arg3 >> 64;
        let v4 = (18446744073709551616 as u256);
        let v5 = if (v0 > 0 || v1 > 0) {
            (v1 << 128) / (v1 * v4 + v0 * v3)
        } else {
            v2
        };
        if ((v5 as u256) < v2) {
            ((((v2 * (v1 * v4 + v0 * v3) - v1 * v4 * v4) / arg3) as u64), 0)
        } else {
            (0, ((v1 - (v2 * (v1 * v4 + v0 * v3) >> 128)) as u64))
        }
    }

    // decompiled from Move bytecode v6
}

