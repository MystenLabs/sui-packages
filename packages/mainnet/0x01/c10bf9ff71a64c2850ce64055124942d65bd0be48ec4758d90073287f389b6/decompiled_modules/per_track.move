module 0x1c10bf9ff71a64c2850ce64055124942d65bd0be48ec4758d90073287f389b6::per_track {
    struct PerTrack<T0: drop + store> has drop, store {
        pos0: vector<T0>,
    }

    public fun length<T0: drop + store>(arg0: &PerTrack<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.pos0)
    }

    public fun borrow<T0: drop + store>(arg0: &PerTrack<T0>, arg1: u64) : &T0 {
        assert!(arg1 < 0x1::vector::length<T0>(&arg0.pos0), 0);
        0x1::vector::borrow<T0>(&arg0.pos0, arg1)
    }

    public fun borrow_mut<T0: drop + store>(arg0: &mut PerTrack<T0>, arg1: u64) : &mut T0 {
        assert!(arg1 < 0x1::vector::length<T0>(&arg0.pos0), 0);
        0x1::vector::borrow_mut<T0>(&mut arg0.pos0, arg1)
    }

    public fun filled<T0: copy + drop + store>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: T0) : PerTrack<T0> {
        let v0 = 0x1::vector::empty<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::Track>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::tracks(arg0))) {
            0x1::vector::push_back<T0>(&mut v0, arg1);
            v1 = v1 + 1;
        };
        PerTrack<T0>{pos0: v0}
    }

    public fun new<T0: drop + store>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: vector<T0>) : PerTrack<T0> {
        assert!(0x1::vector::length<T0>(&arg1) == 0x1::vector::length<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::Track>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::tracks(arg0)), 1);
        PerTrack<T0>{pos0: arg1}
    }

    // decompiled from Move bytecode v7
}

