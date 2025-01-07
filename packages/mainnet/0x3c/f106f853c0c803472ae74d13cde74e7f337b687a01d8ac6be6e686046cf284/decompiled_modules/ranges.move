module 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges {
    struct Ranges has copy, drop, store {
        vec: vector<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range>,
    }

    public fun empty() : Ranges {
        Ranges{vec: 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range>()}
    }

    public fun push_back(arg0: &mut Ranges, arg1: 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range) {
        0x1::vector::push_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range>(&mut arg0.vec, arg1);
    }

    public fun contains(arg0: &Ranges, arg1: u64) : bool {
        let v0 = &arg0.vec;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range>(v0)) {
            if (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::contains(0x1::vector::borrow<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range>(v0, v1), arg1)) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun singleton(arg0: 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range) : Ranges {
        let v0 = 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range>();
        0x1::vector::push_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range>(&mut v0, arg0);
        Ranges{vec: v0}
    }

    public fun borrow_inner(arg0: &Ranges) : &vector<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range> {
        &arg0.vec
    }

    public fun borrow_inner_mut(arg0: &mut Ranges) : &mut vector<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range> {
        &mut arg0.vec
    }

    public fun from_number_vec(arg0: vector<u64>) : Ranges {
        let v0 = 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range>();
        while (!0x1::vector::is_empty<u64>(&arg0)) {
            0x1::vector::push_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range>(&mut v0, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::singleton(0x1::vector::pop_back<u64>(&mut arg0)));
        };
        Ranges{vec: v0}
    }

    public fun from_range_vec(arg0: vector<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range>) : Ranges {
        Ranges{vec: arg0}
    }

    public fun from_single_range(arg0: u64, arg1: u64) : Ranges {
        let v0 = 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range>();
        0x1::vector::push_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::Range>(&mut v0, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::range::new(arg0, arg1));
        Ranges{vec: v0}
    }

    // decompiled from Move bytecode v6
}

