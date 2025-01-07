module 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::rebase {
    struct Rebase has store {
        base: u128,
        elastic: u128,
    }

    public fun add_elastic(arg0: &mut Rebase, arg1: u64, arg2: bool) : u64 {
        let v0 = to_base(arg0, arg1, arg2);
        arg0.elastic = arg0.elastic + (arg1 as u128);
        arg0.base = arg0.base + (v0 as u128);
        v0
    }

    public fun base(arg0: &Rebase) : u64 {
        (arg0.base as u64)
    }

    public fun elastic(arg0: &Rebase) : u64 {
        (arg0.elastic as u64)
    }

    public fun increase_elastic(arg0: &mut Rebase, arg1: u64) {
        arg0.elastic = arg0.elastic + (arg1 as u128);
    }

    public fun new() : Rebase {
        Rebase{
            base    : 0,
            elastic : 0,
        }
    }

    public fun sub_base(arg0: &mut Rebase, arg1: u64, arg2: bool) : u64 {
        let v0 = to_elastic(arg0, arg1, arg2);
        arg0.elastic = arg0.elastic - (v0 as u128);
        arg0.base = arg0.base - (arg1 as u128);
        v0
    }

    public fun to_base(arg0: &Rebase, arg1: u64, arg2: bool) : u64 {
        if (arg0.elastic == 0) {
            arg1
        } else {
            let v1 = 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::math::mul_div_u128((arg1 as u128), arg0.base, arg0.elastic);
            let v2 = v1;
            if (arg2 && 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::math::mul_div_u128(v1, arg0.elastic, arg0.base) < (arg1 as u128)) {
                v2 = v1 + 1;
            };
            (v2 as u64)
        }
    }

    public fun to_elastic(arg0: &Rebase, arg1: u64, arg2: bool) : u64 {
        if (arg0.base == 0) {
            arg1
        } else {
            let v1 = 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::math::mul_div_u128((arg1 as u128), arg0.elastic, arg0.base);
            let v2 = v1;
            if (arg2 && 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::math::mul_div_u128(v1, arg0.base, arg0.elastic) < (arg1 as u128)) {
                v2 = v1 + 1;
            };
            (v2 as u64)
        }
    }

    // decompiled from Move bytecode v6
}

