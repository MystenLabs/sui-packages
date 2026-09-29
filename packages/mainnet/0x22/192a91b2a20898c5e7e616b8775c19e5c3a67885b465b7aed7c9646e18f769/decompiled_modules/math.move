module 0x22192a91b2a20898c5e7e616b8775c19e5c3a67885b465b7aed7c9646e18f769::math {
    public(friend) fun bps_of_ceil(arg0: u128, arg1: u64) : u128 {
        ((((arg0 as u256) * (arg1 as u256) + 9999) / 10000) as u128)
    }

    public(friend) fun fixed_scale() : u128 {
        1000000000
    }

    public(friend) fun from_suilend_decimal_ceil(arg0: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : u128 {
        (((0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(arg0) + 1000000000 - 1) / 1000000000) as u128)
    }

    public(friend) fun from_suilend_decimal_floor(arg0: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : u128 {
        ((0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(arg0) / 1000000000) as u128)
    }

    public(friend) fun mul_ceil(arg0: u128, arg1: u128) : u128 {
        ((((arg0 as u256) * (arg1 as u256) + 1000000000 - 1) / 1000000000) as u128)
    }

    public(friend) fun mul_floor(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / 1000000000) as u128)
    }

    fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun to_fixed_amount(arg0: u64, arg1: u8) : u128 {
        assert!(arg1 <= 30, 1);
        (((arg0 as u256) * 1000000000 / pow10(arg1)) as u128)
    }

    // decompiled from Move bytecode v7
}

