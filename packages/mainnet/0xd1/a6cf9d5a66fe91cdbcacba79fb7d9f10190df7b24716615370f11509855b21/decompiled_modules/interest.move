module 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::interest {
    struct InterestModel has copy, drop, store {
        base_borrow_rate_per_sec: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        borrow_rate_on_mid_kink: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        mid_kink: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        borrow_rate_on_high_kink: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        high_kink: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        max_borrow_rate: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
    }

    public(friend) fun base_borrow_rate(arg0: &InterestModel) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.base_borrow_rate_per_sec
    }

    public(friend) fun borrow_rate_on_high_kink(arg0: &InterestModel) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.borrow_rate_on_high_kink
    }

    public(friend) fun borrow_rate_on_mid_kink(arg0: &InterestModel) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.borrow_rate_on_mid_kink
    }

    public(friend) fun calc_interest(arg0: &InterestModel, arg1: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        let v0 = arg0.borrow_rate_on_mid_kink;
        let v1 = arg0.mid_kink;
        let v2 = arg0.borrow_rate_on_high_kink;
        let v3 = arg0.high_kink;
        let v4 = arg0.base_borrow_rate_per_sec;
        if (0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::ge(v1, arg1)) {
            0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div(arg1, v1), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::sub(v0, v4)), v4)
        } else if (0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::ge(v3, arg1)) {
            0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::sub(arg1, v1), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::sub(v3, v1)), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::sub(v2, v0)), v0)
        } else {
            0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::sub(arg1, v3), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::sub(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from_quotient(1, 1), v3)), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::sub(arg0.max_borrow_rate, v2)), v2)
        }
    }

    public(friend) fun high_kink(arg0: &InterestModel) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.high_kink
    }

    public(friend) fun max_borrow_rate(arg0: &InterestModel) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.max_borrow_rate
    }

    public(friend) fun mid_kink(arg0: &InterestModel) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.mid_kink
    }

    public(friend) fun new(arg0: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg1: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg2: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg3: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg4: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg5: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) : InterestModel {
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

