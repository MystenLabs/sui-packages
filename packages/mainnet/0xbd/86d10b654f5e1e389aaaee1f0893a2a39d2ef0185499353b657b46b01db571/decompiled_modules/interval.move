module 0xbd86d10b654f5e1e389aaaee1f0893a2a39d2ef0185499353b657b46b01db571::interval {
    struct Interval has copy, drop, store {
        lo: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18,
        hi: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18,
    }

    public fun add(arg0: Interval, arg1: Interval) : Interval {
        Interval{
            lo : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::add(arg0.lo, arg1.lo),
            hi : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::add(arg0.hi, arg1.hi),
        }
    }

    public fun neg(arg0: Interval) : Interval {
        Interval{
            lo : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::neg(arg0.hi),
            hi : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::neg(arg0.lo),
        }
    }

    public fun sub(arg0: Interval, arg1: Interval) : Interval {
        Interval{
            lo : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::sub(arg0.lo, arg1.hi),
            hi : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::sub(arg0.hi, arg1.lo),
        }
    }

    public fun abs(arg0: Interval) : Interval {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero();
        if (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::ge(arg0.lo, v0)) {
            arg0
        } else if (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(arg0.hi, v0)) {
            neg(arg0)
        } else {
            Interval{lo: v0, hi: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::max(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::neg(arg0.lo), arg0.hi)}
        }
    }

    public fun contains(arg0: Interval, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : bool {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(arg0.lo, arg1) && 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(arg1, arg0.hi)
    }

    public fun contains_zero(arg0: Interval) : bool {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero();
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(arg0.lo, v0) && 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(v0, arg0.hi)
    }

    public fun div(arg0: Interval, arg1: Interval) : Interval {
        assert!(!contains_zero(arg1), 2);
        Interval{
            lo : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::min(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::min(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::div_down(arg0.lo, arg1.hi), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::div_down(arg0.lo, arg1.lo)), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::min(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::div_down(arg0.hi, arg1.hi), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::div_down(arg0.hi, arg1.lo))),
            hi : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::max(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::max(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::div_up(arg0.lo, arg1.hi), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::div_up(arg0.lo, arg1.lo)), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::max(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::div_up(arg0.hi, arg1.hi), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::div_up(arg0.hi, arg1.lo))),
        }
    }

    public fun hull(arg0: Interval, arg1: Interval) : Interval {
        Interval{
            lo : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::min(arg0.lo, arg1.lo),
            hi : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::max(arg0.hi, arg1.hi),
        }
    }

    public fun intersect(arg0: Interval, arg1: Interval) : Interval {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::max(arg0.lo, arg1.lo);
        let v1 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::min(arg0.hi, arg1.hi);
        assert!(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(v0, v1), 3);
        Interval{
            lo : v0,
            hi : v1,
        }
    }

    public fun inv(arg0: Interval) : Interval {
        assert!(!contains_zero(arg0), 2);
        Interval{
            lo : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::inv_down(arg0.hi),
            hi : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::inv_up(arg0.lo),
        }
    }

    public fun is_subset(arg0: Interval, arg1: Interval) : bool {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(arg1.lo, arg0.lo) && 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(arg0.hi, arg1.hi)
    }

    public fun lower(arg0: Interval) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        arg0.lo
    }

    public fun mid(arg0: Interval) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::avg_down(arg0.lo, arg0.hi)
    }

    public fun mul(arg0: Interval, arg1: Interval) : Interval {
        Interval{
            lo : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::min(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::min(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_down(arg0.lo, arg1.lo), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_down(arg0.lo, arg1.hi)), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::min(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_down(arg0.hi, arg1.lo), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_down(arg0.hi, arg1.hi))),
            hi : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::max(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::max(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_up(arg0.lo, arg1.lo), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_up(arg0.lo, arg1.hi)), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::max(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_up(arg0.hi, arg1.lo), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_up(arg0.hi, arg1.hi))),
        }
    }

    public fun new(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : Interval {
        assert!(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(arg0, arg1), 1);
        Interval{
            lo : arg0,
            hi : arg1,
        }
    }

    public fun overlaps(arg0: Interval, arg1: Interval) : bool {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(arg0.lo, arg1.hi) && 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(arg1.lo, arg0.hi)
    }

    public fun point(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : Interval {
        Interval{
            lo : arg0,
            hi : arg0,
        }
    }

    public fun sq(arg0: Interval) : Interval {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero();
        if (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::ge(arg0.lo, v0)) {
            Interval{lo: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_down(arg0.lo, arg0.lo), hi: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_up(arg0.hi, arg0.hi)}
        } else if (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(arg0.hi, v0)) {
            Interval{lo: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_down(arg0.hi, arg0.hi), hi: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_up(arg0.lo, arg0.lo)}
        } else {
            Interval{lo: v0, hi: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::max(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_up(arg0.lo, arg0.lo), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_up(arg0.hi, arg0.hi))}
        }
    }

    public fun upper(arg0: Interval) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        arg0.hi
    }

    public fun width(arg0: Interval) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::sub(arg0.hi, arg0.lo)
    }

    // decompiled from Move bytecode v7
}

