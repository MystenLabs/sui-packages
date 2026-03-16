module 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max {
    struct FMaxState has drop {
        scalar: u128,
        eps: u128,
        t: u128,
        a: u128,
        b: u128,
        u: u128,
        v: u128,
        w: u128,
        x: u128,
        fv: 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128,
        fw: 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128,
        fx: 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128,
        e: 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128,
        d: 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128,
        c: 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128,
    }

    fun abs(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg1 - arg0
        } else {
            arg0 - arg1
        }
    }

    public(friend) fun f_max_calc_initial_u(arg0: &FMaxState) : u64 {
        ((arg0.a + 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::as_u128(arg0.c) * (arg0.b - arg0.a) / arg0.scalar) as u64)
    }

    public(friend) fun f_max_has_converged(arg0: &FMaxState) : bool {
        abs(arg0.x, (arg0.a + arg0.b) / 2) + (arg0.b - arg0.a) / 2 <= 2 * (arg0.eps * arg0.x / arg0.scalar + arg0.t)
    }

    public(friend) fun f_max_init(arg0: &mut FMaxState, arg1: u64, arg2: 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128) {
        let v0 = (arg1 as u128);
        arg0.v = v0;
        arg0.w = v0;
        arg0.x = v0;
        arg0.fv = arg2;
        arg0.fw = arg2;
        arg0.fx = arg2;
    }

    public(friend) fun f_max_next_step_complete(arg0: &mut FMaxState, arg1: 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128) {
        if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::lte(arg0.fx, arg1)) {
            if (arg0.u < arg0.x) {
                arg0.b = arg0.x;
            } else {
                arg0.a = arg0.x;
            };
            arg0.v = arg0.w;
            arg0.fv = arg0.fw;
            arg0.w = arg0.x;
            arg0.fw = arg0.fx;
            arg0.x = arg0.u;
            arg0.fx = arg1;
        } else {
            if (arg0.u < arg0.x) {
                arg0.a = arg0.u;
            } else {
                arg0.b = arg0.u;
            };
            if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::lte(arg0.fw, arg1) || arg0.w == arg0.x) {
                arg0.v = arg0.w;
                arg0.fv = arg0.fw;
                arg0.w = arg0.u;
                arg0.fw = arg1;
            } else {
                let v0 = if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::lte(arg0.fv, arg1)) {
                    true
                } else if (arg0.v == arg0.x) {
                    true
                } else {
                    arg0.v == arg0.w
                };
                if (v0) {
                    arg0.v = arg0.u;
                    arg0.fv = arg1;
                };
            };
        };
    }

    public(friend) fun f_max_next_step_prep_u(arg0: &mut FMaxState) : u64 {
        let v0 = arg0.eps * arg0.x / arg0.scalar + arg0.t;
        let v1 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(arg0.x), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(arg0.v));
        let v2 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(arg0.x), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(arg0.w));
        let v3 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(arg0.fv, arg0.fx);
        let v4 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(arg0.fw, arg0.fx);
        let v5 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(2), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(v2, v3, arg0.scalar), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(v1, v4, arg0.scalar)));
        let (v6, v7) = if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gte(v5, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero())) {
            (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(v1, v1, arg0.scalar), v4, arg0.scalar), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(v2, v2, arg0.scalar), v3, arg0.scalar)), v5)
        } else {
            (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::neg(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(v1, v1, arg0.scalar), v4, arg0.scalar), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(v2, v2, arg0.scalar), v3, arg0.scalar))), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::neg(v5))
        };
        let v8 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(arg0.a), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(arg0.x));
        let v9 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(arg0.b), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(arg0.x));
        let v10 = if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::lte(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::abs(arg0.e), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(v0))) {
            true
        } else if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::lt(v6, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(v7, v8, arg0.scalar))) {
            true
        } else if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gt(v6, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(v7, v9, arg0.scalar))) {
            true
        } else {
            0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gte(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(2), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::abs(v6)), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(v7, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::abs(arg0.e), arg0.scalar))
        };
        let v11 = if (v10) {
            let v12 = if (arg0.x < (arg0.a + arg0.b) / 2) {
                v9
            } else {
                v8
            };
            arg0.e = v12;
            0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::mul_scalar(arg0.c, arg0.e, arg0.scalar)
        } else {
            arg0.e = arg0.d;
            let v13 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::div_scalar(v6, v7, arg0.scalar);
            if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::lt(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(v13, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(arg0.x - arg0.a)), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(2 * v0)) || 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::lt(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(arg0.b - arg0.x), v13), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(2 * v0))) {
                if ((arg0.a + arg0.b) / 2 > arg0.x) {
                    0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(v0)
                } else {
                    0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::neg_from(v0)
                }
            } else {
                v13
            }
        };
        arg0.d = v11;
        let v14 = if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gte(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::abs(arg0.d), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(v0))) {
            0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::as_u128(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::add(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from(arg0.x), arg0.d))
        } else if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gt(arg0.d, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero())) {
            arg0.x + v0
        } else {
            arg0.x - v0
        };
        arg0.u = v14;
        (arg0.u as u64)
    }

    public(friend) fun f_max_result(arg0: &FMaxState) : (u64, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128) {
        ((arg0.x as u64), arg0.fx)
    }

    fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public(friend) fun new_f_max(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : FMaxState {
        let v0 = (arg2 as u128);
        FMaxState{
            scalar : v0,
            eps    : 1,
            t      : (arg3 as u128),
            a      : (arg0 as u128),
            b      : (arg1 as u128),
            u      : 0,
            v      : 0,
            w      : 0,
            x      : 0,
            fv     : 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero(),
            fw     : 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero(),
            fx     : 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero(),
            e      : 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero(),
            d      : 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero(),
            c      : 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from((3 * v0 - sqrt(5 * v0 * v0)) / 2),
        }
    }

    fun sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1;
        let v1 = v0;
        let v2 = arg0;
        if (arg0 >> 32 > 0) {
            v2 = arg0 >> 32;
            v1 = v0 << 16;
        };
        if (v2 >> 16 > 0) {
            v2 = v2 >> 16;
            v1 = v1 << 8;
        };
        if (v2 >> 8 > 0) {
            v2 = v2 >> 8;
            v1 = v1 << 4;
        };
        if (v2 >> 4 > 0) {
            v2 = v2 >> 4;
            v1 = v1 << 2;
        };
        if (v2 >> 2 > 0) {
            v1 = v1 << 1;
        };
        let v3 = v1 + arg0 / v1 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        let v8 = v7 + arg0 / v7 >> 1;
        let v9 = v8 + arg0 / v8 >> 1;
        min(v9, arg0 / v9)
    }

    // decompiled from Move bytecode v6
}

