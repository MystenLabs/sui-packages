module 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::ExponentialCurve {
    public fun getBuyInfo(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u8, u64, u64, u64, u64, u64) {
        if (arg2 == 0) {
            return (1, 0, 0, 0, 0, 0)
        };
        let v0 = (arg1 as u128) + 100000;
        if (v0 == 100000) {
            return (1, 0, 0, 0, 0, 0)
        };
        let v1 = (arg0 as u128);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < arg2) {
            let v6 = (v1 as u128) * v0 / 100000;
            v1 = v6;
            v2 = v2 + v6;
            v3 = v3 + 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Math::mul_div_u128(v6, (arg4 as u128), 100000);
            v4 = v4 + 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Math::mul_div_u128(v6, (arg3 as u128), 100000);
            v5 = v5 + 1;
        };
        let v7 = v2 + ((v3 + v4) as u128);
        if (v7 > 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Math::max_u64()) {
            return (1, 0, 0, 0, 0, 0)
        };
        (0, (v1 as u64), arg1, (v7 as u64), (v3 as u64), (v4 as u64))
    }

    public fun getSellInfo(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u8, u64, u64, u64, u64, u64) {
        if (arg2 == 0) {
            return (1, 0, 0, 0, 0, 0)
        };
        let v0 = if (arg1 < (100000 as u64)) {
            100000 - (arg1 as u128)
        } else {
            (arg1 as u128) + 100000
        };
        if (v0 == 100000) {
            return (1, 0, 0, 0, 0, 0)
        };
        let v1 = (arg0 as u128);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < arg2) {
            if (arg1 < (100000 as u64)) {
                let v6 = v1 * v0;
                v1 = v6 / 100000;
            } else {
                let v7 = v1 * 100000;
                v1 = v7 / v0;
            };
            v2 = v2 + (v1 as u128);
            v3 = v3 + 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Math::mul_div_u128((v1 as u128), (arg4 as u128), 100000);
            v4 = v4 + 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Math::mul_div_u128((v1 as u128), (arg3 as u128), 100000);
            v5 = v5 + 1;
        };
        let v8 = v2 - (v4 as u128) - (v3 as u128);
        if (v8 > 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Math::max_u64()) {
            return (1, 0, 0, 0, 0, 0)
        };
        (0, (v1 as u64), arg1, (v8 as u64), (v3 as u64), (v4 as u64))
    }

    // decompiled from Move bytecode v6
}

