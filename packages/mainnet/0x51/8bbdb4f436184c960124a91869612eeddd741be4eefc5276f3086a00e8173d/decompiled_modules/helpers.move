module 0x518bbdb4f436184c960124a91869612eeddd741be4eefc5276f3086a00e8173d::helpers {
    public fun calculate_bid_proximity_multiplier(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 1000
        };
        let v0 = arg1 * 30 / 100;
        let v1 = arg1 - v0;
        if (arg0 >= arg1) {
            1000 + (arg0 - arg1) * 1000 / arg1
        } else if (arg0 >= v1) {
            1000 + (arg0 - v1) * 1000 / 10 / v0
        } else {
            let v3 = (v1 - arg0) * 1000 / arg1;
            let v4 = v3;
            let v5 = 100 * 1000 / 1000;
            if (v3 > v5) {
                v4 = v5;
            };
            1000 - v4
        }
    }

    public fun calculate_chest_points(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        0xafc3b28fc57c1d6d091c27a55e89ac73395002bb46fec7e493d32a3e451bd584::math::mul_div_u128((integer_sqrt(arg0) as u128), ((arg1 * arg2 * arg3) as u128), ((1000 * 1000) as u128))
    }

    public fun calculate_listing_proximity_multiplier(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 1000
        };
        if (arg0 <= arg1) {
            1000 + (arg1 - arg0) * 1000 / arg1
        } else {
            let v1 = (arg0 - arg1) * 1000 / arg1;
            let v2 = v1;
            let v3 = 100 * 1000 / 1000;
            if (v1 > v3) {
                v2 = v3;
            };
            1000 - v2
        }
    }

    public fun calculate_time_multiplier(arg0: u64, arg1: bool) : u64 {
        if (arg1) {
            return 1000
        };
        let v0 = (0xafc3b28fc57c1d6d091c27a55e89ac73395002bb46fec7e493d32a3e451bd584::math::mul_div_u128((arg0 as u128), (1000 as u128), (86400000 as u128)) as u64);
        let v1 = 0x1::string::utf8(b"Effective days:");
        0x1::debug::print<0x1::string::String>(&v1);
        0x1::debug::print<u64>(&v0);
        let v2 = v0 / 30;
        let v3 = 0x1::string::utf8(b"Multiplier:");
        0x1::debug::print<0x1::string::String>(&v3);
        0x1::debug::print<u64>(&v2);
        if (v2 > 1250) {
            1250
        } else {
            v2
        }
    }

    public fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun integer_sqrt(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 < 4) {
            return 1
        };
        let v0 = if (arg0 == 18446744073709551615) {
            arg0 / 2
        } else {
            (arg0 + 1) / 2
        };
        let v1 = v0;
        while (v1 < arg0) {
            let v2 = v1 + arg0 / v1;
            v1 = v2 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

