module 0x6b0dfb647f381f4c2369ea53dde8ce43bf12821dfa245cc1144cbd8b9e8554c3::per_track {
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

    public fun filled<T0: copy + drop + store>(arg0: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::release::Release, arg1: T0) : PerTrack<T0> {
        let v0 = 0x1::vector::empty<T0>();
        let v1 = 0;
        while (v1 < 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::release::total_tracks(arg0)) {
            0x1::vector::push_back<T0>(&mut v0, arg1);
            v1 = v1 + 1;
        };
        PerTrack<T0>{pos0: v0}
    }

    public fun new<T0: drop + store>(arg0: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::release::Release, arg1: vector<T0>) : PerTrack<T0> {
        assert!(0x1::vector::length<T0>(&arg1) == 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::release::total_tracks(arg0), 1);
        PerTrack<T0>{pos0: arg1}
    }

    // decompiled from Move bytecode v7
}

