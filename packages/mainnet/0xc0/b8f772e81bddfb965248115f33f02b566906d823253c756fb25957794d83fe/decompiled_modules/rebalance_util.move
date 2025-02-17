module 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::rebalance_util {
    public(friend) fun calc_f_x64(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg0 < arg1) {
            return 0
        };
        if (arg0 > arg2) {
            return 18446744073709551616
        };
        (((18446744073709551616 as u256) * ((arg0 - arg1) as u256) / (((arg0 - arg1) as u256) + ((arg0 - 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::util::muldiv_u128(arg0, arg0, arg2)) as u256))) as u128)
    }

    public(friend) fun calc_reward_sell_amounts(arg0: u64, arg1: u128, arg2: u256, arg3: u256) : (u64, u64) {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = ((arg2 >> 64) as u256);
        let v3 = ((arg3 >> 64) as u256);
        let v4 = (18446744073709551616 as u256);
        let v5 = if (v2 > v3) {
            v3 + v1 * (v2 - v3) / v4
        } else {
            v3 - v1 * (v3 - v2) / v4
        };
        let v6 = ((v0 * v1 * v2 / v5 / v4) as u64);
        ((v0 as u64) - v6, v6)
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

