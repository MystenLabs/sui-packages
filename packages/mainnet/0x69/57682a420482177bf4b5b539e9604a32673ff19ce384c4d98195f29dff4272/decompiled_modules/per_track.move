module 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track {
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

    public fun filled<T0: copy + drop + store>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: T0) : PerTrack<T0> {
        let v0 = 0x1::vector::empty<T0>();
        let v1 = 0;
        while (v1 < 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::total_tracks(arg0)) {
            0x1::vector::push_back<T0>(&mut v0, arg1);
            v1 = v1 + 1;
        };
        PerTrack<T0>{pos0: v0}
    }

    public fun new<T0: drop + store>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: vector<T0>) : PerTrack<T0> {
        assert!(0x1::vector::length<T0>(&arg1) == 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::total_tracks(arg0), 1);
        PerTrack<T0>{pos0: arg1}
    }

    // decompiled from Move bytecode v7
}

