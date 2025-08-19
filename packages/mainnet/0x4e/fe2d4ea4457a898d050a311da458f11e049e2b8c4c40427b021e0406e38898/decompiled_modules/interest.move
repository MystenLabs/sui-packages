module 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::interest {
    struct InterestModel has copy, drop, store {
        base_borrow_rate_per_sec: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
        borrow_rate_on_mid_kink: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
        mid_kink: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
        borrow_rate_on_high_kink: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
        high_kink: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
        max_borrow_rate: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
    }

    public fun base_borrow_rate(arg0: &InterestModel) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        arg0.base_borrow_rate_per_sec
    }

    public fun borrow_rate_on_high_kink(arg0: &InterestModel) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        arg0.borrow_rate_on_high_kink
    }

    public fun borrow_rate_on_mid_kink(arg0: &InterestModel) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        arg0.borrow_rate_on_mid_kink
    }

    public fun calc_interest(arg0: &InterestModel, arg1: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        let v0 = arg0.borrow_rate_on_mid_kink;
        let v1 = arg0.mid_kink;
        let v2 = arg0.borrow_rate_on_high_kink;
        let v3 = arg0.high_kink;
        let v4 = arg0.base_borrow_rate_per_sec;
        if (0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::ge(v1, arg1)) {
            0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::add(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::div(arg1, v1), 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::sub(v0, v4)), v4)
        } else if (0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::ge(v3, arg1)) {
            0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::add(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::div(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::sub(arg1, v1), 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::sub(v3, v1)), 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::sub(v2, v0)), v0)
        } else {
            0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::add(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::div(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::sub(arg1, v3), 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::sub(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::from_quotient(1, 1), v3)), 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::sub(arg0.max_borrow_rate, v2)), v2)
        }
    }

    public fun high_kink(arg0: &InterestModel) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        arg0.high_kink
    }

    public fun max_borrow_rate(arg0: &InterestModel) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        arg0.max_borrow_rate
    }

    public fun mid_kink(arg0: &InterestModel) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        arg0.mid_kink
    }

    public(friend) fun new(arg0: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg1: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg2: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg3: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg4: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg5: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal) : InterestModel {
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

