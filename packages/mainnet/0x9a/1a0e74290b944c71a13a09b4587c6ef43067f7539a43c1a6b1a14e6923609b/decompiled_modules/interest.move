module 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::interest {
    struct InterestModel has copy, drop, store {
        base_borrow_rate_per_sec: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
        borrow_rate_on_mid_kink: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
        mid_kink: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
        borrow_rate_on_high_kink: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
        high_kink: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
        max_borrow_rate: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
    }

    public(friend) fun base_borrow_rate(arg0: &InterestModel) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        arg0.base_borrow_rate_per_sec
    }

    public(friend) fun borrow_rate_on_high_kink(arg0: &InterestModel) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        arg0.borrow_rate_on_high_kink
    }

    public(friend) fun borrow_rate_on_mid_kink(arg0: &InterestModel) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        arg0.borrow_rate_on_mid_kink
    }

    public(friend) fun calc_interest(arg0: &InterestModel, arg1: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        let v0 = arg0.borrow_rate_on_mid_kink;
        let v1 = arg0.mid_kink;
        let v2 = arg0.borrow_rate_on_high_kink;
        let v3 = arg0.high_kink;
        let v4 = arg0.base_borrow_rate_per_sec;
        if (0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::ge(v1, arg1)) {
            0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::add(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::mul(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::div(arg1, v1), 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::sub(v0, v4)), v4)
        } else if (0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::ge(v3, arg1)) {
            0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::add(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::mul(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::div(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::sub(arg1, v1), 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::sub(v3, v1)), 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::sub(v2, v0)), v0)
        } else {
            0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::add(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::mul(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::div(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::sub(arg1, v3), 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::sub(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::from_quotient(1, 1), v3)), 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::sub(arg0.max_borrow_rate, v2)), v2)
        }
    }

    public(friend) fun high_kink(arg0: &InterestModel) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        arg0.high_kink
    }

    public(friend) fun max_borrow_rate(arg0: &InterestModel) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        arg0.max_borrow_rate
    }

    public(friend) fun mid_kink(arg0: &InterestModel) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        arg0.mid_kink
    }

    public(friend) fun new(arg0: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal, arg1: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal, arg2: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal, arg3: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal, arg4: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal, arg5: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal) : InterestModel {
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

