module 0x210583b3e0a97aa0da941ad2c73b4ad82580e6097fcbbb699f279045db33d996::piecewise {
    struct Section has copy, drop, store {
        end: u64,
        end_val: u64,
    }

    struct Piecewise has copy, drop, store {
        start: u64,
        start_val: u64,
        sections: vector<Section>,
    }

    public fun create(arg0: u64, arg1: u64, arg2: vector<Section>) : Piecewise {
        assert!(0x1::vector::length<Section>(&arg2) > 0, 0);
        Piecewise{
            start     : arg0,
            start_val : arg1,
            sections  : arg2,
        }
    }

    public fun range(arg0: &Piecewise) : (u64, u64) {
        let v0 = *0x1::vector::borrow<Section>(&arg0.sections, 0x1::vector::length<Section>(&arg0.sections) - 1);
        (arg0.start, v0.end)
    }

    public fun section(arg0: u64, arg1: u64) : Section {
        Section{
            end     : arg0,
            end_val : arg1,
        }
    }

    public fun value_at(arg0: &Piecewise, arg1: u64) : u64 {
        assert!(arg1 >= arg0.start, 1);
        let v0 = *0x1::vector::borrow<Section>(&arg0.sections, 0x1::vector::length<Section>(&arg0.sections) - 1);
        assert!(arg1 <= v0.end, 1);
        if (arg1 == arg0.start) {
            return arg0.start_val
        };
        let v1 = arg0.start;
        let v2 = arg0.start_val;
        let v3 = *0x1::vector::borrow<Section>(&arg0.sections, 0);
        let v4 = 0;
        while (arg1 > v3.end) {
            v1 = v3.end;
            v2 = v3.end_val;
            v3 = *0x1::vector::borrow<Section>(&arg0.sections, v4 + 1);
            v4 = v4 + 1;
        };
        if (arg1 == v3.end) {
            return v3.end_val
        };
        if (v2 == v3.end_val) {
            return v2
        };
        if (v2 < v3.end_val) {
            v2 + 0x210583b3e0a97aa0da941ad2c73b4ad82580e6097fcbbb699f279045db33d996::util::muldiv(0x210583b3e0a97aa0da941ad2c73b4ad82580e6097fcbbb699f279045db33d996::util::abs_diff(v3.end_val, v2), arg1 - v1, 0x210583b3e0a97aa0da941ad2c73b4ad82580e6097fcbbb699f279045db33d996::util::abs_diff(v3.end, v1))
        } else {
            v2 - 0x210583b3e0a97aa0da941ad2c73b4ad82580e6097fcbbb699f279045db33d996::util::muldiv(0x210583b3e0a97aa0da941ad2c73b4ad82580e6097fcbbb699f279045db33d996::util::abs_diff(v3.end_val, v2), arg1 - v1, 0x210583b3e0a97aa0da941ad2c73b4ad82580e6097fcbbb699f279045db33d996::util::abs_diff(v3.end, v1))
        }
    }

    // decompiled from Move bytecode v6
}

