module 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::interest {
    struct InterestModel has copy, drop, store {
        base_borrow_rate_per_sec: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal,
        borrow_rate_on_mid_kink: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal,
        mid_kink: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal,
        borrow_rate_on_high_kink: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal,
        high_kink: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal,
        max_borrow_rate: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal,
    }

    public(friend) fun base_borrow_rate(arg0: &InterestModel) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        arg0.base_borrow_rate_per_sec
    }

    public(friend) fun borrow_rate_on_high_kink(arg0: &InterestModel) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        arg0.borrow_rate_on_high_kink
    }

    public(friend) fun borrow_rate_on_mid_kink(arg0: &InterestModel) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        arg0.borrow_rate_on_mid_kink
    }

    public(friend) fun calc_interest(arg0: &InterestModel, arg1: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        let v0 = arg0.borrow_rate_on_mid_kink;
        let v1 = arg0.mid_kink;
        let v2 = arg0.borrow_rate_on_high_kink;
        let v3 = arg0.high_kink;
        let v4 = arg0.base_borrow_rate_per_sec;
        if (0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::ge(v1, arg1)) {
            0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::add(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::mul(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::div(arg1, v1), 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::sub(v0, v4)), v4)
        } else if (0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::ge(v3, arg1)) {
            0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::add(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::mul(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::div(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::sub(arg1, v1), 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::sub(v3, v1)), 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::sub(v2, v0)), v0)
        } else {
            0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::add(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::mul(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::div(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::sub(arg1, v3), 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::sub(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::from_quotient(1, 1), v3)), 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::sub(arg0.max_borrow_rate, v2)), v2)
        }
    }

    public(friend) fun high_kink(arg0: &InterestModel) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        arg0.high_kink
    }

    public(friend) fun max_borrow_rate(arg0: &InterestModel) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        arg0.max_borrow_rate
    }

    public(friend) fun mid_kink(arg0: &InterestModel) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        arg0.mid_kink
    }

    public(friend) fun new(arg0: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal, arg1: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal, arg2: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal, arg3: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal, arg4: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal, arg5: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal) : InterestModel {
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

