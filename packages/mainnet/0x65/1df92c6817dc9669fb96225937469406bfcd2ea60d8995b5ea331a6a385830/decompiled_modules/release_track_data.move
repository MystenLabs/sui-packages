module 0x651df92c6817dc9669fb96225937469406bfcd2ea60d8995b5ea331a6a385830::release_track_data {
    struct ReleaseTrackData<T0: drop + store> has drop, store {
        pos0: vector<T0>,
    }

    public fun length<T0: drop + store>(arg0: &ReleaseTrackData<T0>) : u8 {
        (0x1::vector::length<T0>(&arg0.pos0) as u8)
    }

    public fun borrow<T0: drop + store>(arg0: &ReleaseTrackData<T0>, arg1: u8) : &T0 {
        assert!((arg1 as u64) < 0x1::vector::length<T0>(&arg0.pos0), 0);
        0x1::vector::borrow<T0>(&arg0.pos0, (arg1 as u64))
    }

    public fun borrow_mut<T0: drop + store>(arg0: &mut ReleaseTrackData<T0>, arg1: u8) : &mut T0 {
        assert!((arg1 as u64) < 0x1::vector::length<T0>(&arg0.pos0), 0);
        0x1::vector::borrow_mut<T0>(&mut arg0.pos0, (arg1 as u64))
    }

    public fun filled<T0: copy + drop + store>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: T0) : ReleaseTrackData<T0> {
        let v0 = 0x1::vector::empty<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::recording_ids(arg0))) {
            0x1::vector::push_back<T0>(&mut v0, arg1);
            v1 = v1 + 1;
        };
        ReleaseTrackData<T0>{pos0: v0}
    }

    public fun new<T0: drop + store>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: vector<T0>) : ReleaseTrackData<T0> {
        assert!(0x1::vector::length<T0>(&arg1) == 0x1::vector::length<0x2::object::ID>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::recording_ids(arg0)), 1);
        ReleaseTrackData<T0>{pos0: arg1}
    }

    // decompiled from Move bytecode v7
}

