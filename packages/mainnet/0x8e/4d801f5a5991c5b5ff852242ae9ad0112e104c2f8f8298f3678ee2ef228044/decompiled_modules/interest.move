module 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::interest {
    struct InterestModel has copy, drop, store {
        base_borrow_rate_per_sec: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal,
        borrow_rate_on_mid_kink: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal,
        mid_kink: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal,
        borrow_rate_on_high_kink: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal,
        high_kink: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal,
        max_borrow_rate: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal,
    }

    public(friend) fun base_borrow_rate(arg0: &InterestModel) : 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal {
        arg0.base_borrow_rate_per_sec
    }

    public(friend) fun borrow_rate_on_high_kink(arg0: &InterestModel) : 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal {
        arg0.borrow_rate_on_high_kink
    }

    public(friend) fun borrow_rate_on_mid_kink(arg0: &InterestModel) : 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal {
        arg0.borrow_rate_on_mid_kink
    }

    public(friend) fun calc_interest(arg0: &InterestModel, arg1: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal) : 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal {
        let v0 = arg0.borrow_rate_on_mid_kink;
        let v1 = arg0.mid_kink;
        let v2 = arg0.borrow_rate_on_high_kink;
        let v3 = arg0.high_kink;
        let v4 = arg0.base_borrow_rate_per_sec;
        if (0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::ge(v1, arg1)) {
            0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::add(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::mul(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::div(arg1, v1), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::sub(v0, v4)), v4)
        } else if (0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::ge(v3, arg1)) {
            0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::add(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::mul(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::div(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::sub(arg1, v1), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::sub(v3, v1)), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::sub(v2, v0)), v0)
        } else {
            0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::add(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::mul(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::div(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::sub(arg1, v3), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::sub(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(1, 1), v3)), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::sub(arg0.max_borrow_rate, v2)), v2)
        }
    }

    public(friend) fun high_kink(arg0: &InterestModel) : 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal {
        arg0.high_kink
    }

    public(friend) fun max_borrow_rate(arg0: &InterestModel) : 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal {
        arg0.max_borrow_rate
    }

    public(friend) fun mid_kink(arg0: &InterestModel) : 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal {
        arg0.mid_kink
    }

    public(friend) fun new(arg0: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal, arg1: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal, arg2: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal, arg3: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal, arg4: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal, arg5: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal) : InterestModel {
        InterestModel{
            base_borrow_rate_per_sec : arg0,
            borrow_rate_on_mid_kink  : arg1,
            mid_kink                 : arg2,
            borrow_rate_on_high_kink : arg3,
            high_kink                : arg4,
            max_borrow_rate          : arg5,
        }
    }

    // decompiled from Move bytecode v6
}

