module 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::interest {
    struct InterestModel has copy, drop, store {
        base_borrow_rate_per_sec: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal,
        borrow_rate_on_mid_kink: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal,
        mid_kink: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal,
        borrow_rate_on_high_kink: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal,
        high_kink: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal,
        max_borrow_rate: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal,
    }

    public fun base_borrow_rate(arg0: &InterestModel) : 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal {
        arg0.base_borrow_rate_per_sec
    }

    public fun borrow_rate_on_high_kink(arg0: &InterestModel) : 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal {
        arg0.borrow_rate_on_high_kink
    }

    public fun borrow_rate_on_mid_kink(arg0: &InterestModel) : 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal {
        arg0.borrow_rate_on_mid_kink
    }

    public fun calc_interest(arg0: &InterestModel, arg1: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal) : 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal {
        let v0 = arg0.borrow_rate_on_mid_kink;
        let v1 = arg0.mid_kink;
        let v2 = arg0.borrow_rate_on_high_kink;
        let v3 = arg0.high_kink;
        let v4 = arg0.base_borrow_rate_per_sec;
        if (0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::ge(v1, arg1)) {
            0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::add(0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::mul(0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::div(arg1, v1), 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::sub(v0, v4)), v4)
        } else if (0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::ge(v3, arg1)) {
            0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::add(0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::mul(0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::div(0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::sub(arg1, v1), 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::sub(v3, v1)), 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::sub(v2, v0)), v0)
        } else {
            0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::add(0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::mul(0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::div(0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::sub(arg1, v3), 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::sub(0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::from_quotient(1, 1), v3)), 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::sub(arg0.max_borrow_rate, v2)), v2)
        }
    }

    public fun high_kink(arg0: &InterestModel) : 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal {
        arg0.high_kink
    }

    public fun max_borrow_rate(arg0: &InterestModel) : 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal {
        arg0.max_borrow_rate
    }

    public fun mid_kink(arg0: &InterestModel) : 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal {
        arg0.mid_kink
    }

    public(friend) fun new(arg0: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal, arg1: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal, arg2: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal, arg3: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal, arg4: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal, arg5: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal) : InterestModel {
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

