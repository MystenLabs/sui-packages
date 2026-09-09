module 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::lp_shape_clmm {
    struct LpShape has copy, drop {
        sqrt_pa_x64: u128,
        sqrt_pb_x64: u128,
        l: u128,
    }

    public(friend) fun l(arg0: &LpShape) : u128 {
        arg0.l
    }

    public(friend) fun new(arg0: u128, arg1: u128, arg2: u128) : LpShape {
        assert!(arg0 < arg1, 0);
        LpShape{
            sqrt_pa_x64 : arg0,
            sqrt_pb_x64 : arg1,
            l           : arg2,
        }
    }

    public(friend) fun sqrt_pa_x64(arg0: &LpShape) : u128 {
        arg0.sqrt_pa_x64
    }

    public(friend) fun sqrt_pb_x64(arg0: &LpShape) : u128 {
        arg0.sqrt_pb_x64
    }

    // decompiled from Move bytecode v7
}

