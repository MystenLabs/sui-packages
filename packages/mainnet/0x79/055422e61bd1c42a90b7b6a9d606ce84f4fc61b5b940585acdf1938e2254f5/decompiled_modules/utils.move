module 0x79055422e61bd1c42a90b7b6a9d606ce84f4fc61b5b940585acdf1938e2254f5::utils {
    public fun currentTime(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun estPoint(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64) : u64 {
        let v0 = 0;
        if (arg1 > 0) {
            v0 = (currentTime(arg0) - arg1) * arg2;
        };
        v0
    }

    public fun estimateUpgradeFee(arg0: u64) : u64 {
        if (arg0 == 2) {
            1 * 1000000000
        } else if (arg0 == 3) {
            3 * 1000000000
        } else if (arg0 == 4) {
            5 * 1000000000
        } else if (arg0 == 5) {
            10 * 1000000000
        } else if (arg0 == 6) {
            30 * 1000000000
        } else if (arg0 == 7) {
            100 * 1000000000
        } else if (arg0 == 8) {
            300 * 1000000000
        } else if (arg0 == 9) {
            1000 * 1000000000
        } else if (arg0 == 10) {
            5000 * 1000000000
        } else {
            5000 * 1000000000
        }
    }

    public fun estimate_commission_ref(arg0: u64) : u64 {
        if (arg0 == 1) {
            5 * 0x2::math::pow(10, 7)
        } else if (arg0 == 2) {
            100000000
        } else if (arg0 == 3) {
            150000000
        } else if (arg0 == 4) {
            200000000
        } else if (arg0 == 5) {
            250000000
        } else if (arg0 == 6) {
            300000000
        } else if (arg0 == 7) {
            350000000
        } else if (arg0 == 8) {
            500000000
        } else if (arg0 == 9) {
            800000000
        } else if (arg0 == 10) {
            1000000000
        } else {
            50000000
        }
    }

    // decompiled from Move bytecode v6
}

