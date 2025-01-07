module 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::LinearCurve {
    public fun getBuyInfo(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u8, u64, u64, u64, u64, u64) {
        if (arg2 == 0) {
            return (1, 0, 0, 0, 0, 0)
        };
        let v0 = arg2 * (arg0 + arg1) + arg2 * (arg2 - 1) * arg1 / 2;
        let v1 = 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Math::mul_div_u128((v0 as u128), (arg4 as u128), 100000);
        let v2 = 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Math::mul_div_u128((v0 as u128), (arg3 as u128), 100000);
        (0, arg0 + arg1 * arg2, arg1, v0 + v2 + v1, v1, v2)
    }

    public fun getSellInfo(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u8, u64, u64, u64, u64, u64) {
        if (arg2 == 0) {
            return (1, 0, 0, 0, 0, 0)
        };
        let v0 = arg1 * arg2;
        let v1 = if (arg0 < v0) {
            arg2 = arg0 / arg1 + 1;
            0
        } else {
            arg0 - v0
        };
        let v2 = arg2 * arg0 - arg2 * (arg2 - 1) * arg1 / 2;
        let v3 = 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Math::mul_div_u128((v2 as u128), (arg4 as u128), 100000);
        let v4 = 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Math::mul_div_u128((v2 as u128), (arg3 as u128), 100000);
        (0, v1, arg1, v2 - v4 - v3, v3, v4)
    }

    // decompiled from Move bytecode v6
}

