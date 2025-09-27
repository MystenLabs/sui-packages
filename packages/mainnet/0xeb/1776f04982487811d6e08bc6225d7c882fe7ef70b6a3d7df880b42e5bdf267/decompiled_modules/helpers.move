module 0xeb1776f04982487811d6e08bc6225d7c882fe7ef70b6a3d7df880b42e5bdf267::helpers {
    public fun bid_proximity_multiplier(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 1000
        };
        let v0 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((arg0 as u256), (1000 as u256), (arg1 as u256)) as u64);
        if (v0 >= 1000) {
            let v1 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256(((v0 - 1000) as u256), (1000 as u256), (1000 as u256)) as u64);
            let v2 = v1;
            if (v1 > 700) {
                v2 = 700;
            };
            return 1000 + v2
        };
        if (v0 >= 800) {
            let v3 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256(((1000 - v0) as u256), (250 as u256), ((1000 - 800) as u256)) as u64);
            let v4 = if (1000 > v3) {
                1000 - v3
            } else {
                0
            };
            return if (v4 < 100) {
                100
            } else {
                v4
            }
        };
        if (v0 >= 500) {
            let v6 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256(((800 - v0) as u256), (1000 as u256), ((800 - 500) as u256)) as u64);
            return (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256(((1000 - 300) as u256), ((1000 - (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((v6 as u256), (v6 as u256), (1000 as u256)) as u64)) as u256), (1000 as u256)) as u64)
        };
        0
    }

    public fun listing_proximity_multiplier(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 1000
        };
        let v0 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((arg0 as u256), (1000 as u256), (arg1 as u256)) as u64);
        if (v0 <= 1000) {
            let v1 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256(((1000 - v0) as u256), (1000 as u256), (1000 as u256)) as u64);
            let v2 = v1;
            if (v1 > 500) {
                v2 = 500;
            };
            return 1000 + v2
        };
        if (v0 <= 1500) {
            let v3 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256(((v0 - 1000) as u256), (300 as u256), ((1500 - 1000) as u256)) as u64);
            let v4 = if (1000 > v3) {
                1000 - v3
            } else {
                0
            };
            return if (v4 < 100) {
                100
            } else {
                v4
            }
        };
        if (v0 < 3000) {
            let v6 = (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256(((v0 - 1500) as u256), (1000 as u256), ((3000 - 1500) as u256)) as u64);
            return (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256(((1000 - 300) as u256), ((1000 - (0xc7f41f8852439daefb6ace539e999258e72ab6f3e97f7b08924d20f7e4ea7dc6::math::mul_div_u256((v6 as u256), (v6 as u256), (1000 as u256)) as u64)) as u256), (1000 as u256)) as u64)
        };
        0
    }

    // decompiled from Move bytecode v6
}

