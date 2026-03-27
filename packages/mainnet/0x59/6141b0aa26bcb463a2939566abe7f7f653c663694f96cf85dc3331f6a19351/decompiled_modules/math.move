module 0x596141b0aa26bcb463a2939566abe7f7f653c663694f96cf85dc3331f6a19351::math {
    public fun bps() : u64 {
        10000
    }

    public fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun calculate_percentage(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 0x596141b0aa26bcb463a2939566abe7f7f653c663694f96cf85dc3331f6a19351::errors::e_invalid_bps());
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun calculate_prize_pool(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        arg0 - calculate_fee(arg0, arg1)
    }

    public fun calculate_total_pot(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 0x596141b0aa26bcb463a2939566abe7f7f653c663694f96cf85dc3331f6a19351::errors::e_overflow());
        (v0 as u64)
    }

    public fun calculate_winner_payout(arg0: u64, arg1: u64) : (u64, u64) {
        assert!(arg1 > 0, 0x596141b0aa26bcb463a2939566abe7f7f653c663694f96cf85dc3331f6a19351::errors::e_division_by_zero());
        (arg0 / arg1, arg0 % arg1)
    }

    public fun is_valid_fee_bps(arg0: u64) : bool {
        arg0 <= 1000
    }

    public fun max_fee_bps() : u64 {
        1000
    }

    public fun safe_mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 0x596141b0aa26bcb463a2939566abe7f7f653c663694f96cf85dc3331f6a19351::errors::e_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

