module 0x1e8f88c1baab969ded715f3c58f640c600fd61eed11d10849c2d77e1f5ec5d9a::release_track_iterator {
    struct ReleaseTrackIterator<phantom T0> {
        release_id: 0x2::object::ID,
        recording_ids: vector<0x2::object::ID>,
        position: u8,
    }

    public fun finish<T0: drop>(arg0: ReleaseTrackIterator<T0>, arg1: T0) {
        let ReleaseTrackIterator {
            release_id    : _,
            recording_ids : v1,
            position      : v2,
        } = arg0;
        let v3 = v1;
        assert!((v2 as u64) == 0x1::vector::length<0x2::object::ID>(&v3), 1);
    }

    public fun new<T0: drop>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: T0) : ReleaseTrackIterator<T0> {
        ReleaseTrackIterator<T0>{
            release_id    : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0),
            recording_ids : *0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::recording_ids(arg0),
            position      : 0,
        }
    }

    public fun next<T0: drop>(arg0: &mut ReleaseTrackIterator<T0>, arg1: T0) : 0x2::object::ID {
        assert!((arg0.position as u64) < 0x1::vector::length<0x2::object::ID>(&arg0.recording_ids), 0);
        arg0.position = arg0.position + 1;
        *0x1::vector::borrow<0x2::object::ID>(&arg0.recording_ids, (arg0.position as u64))
    }

    public fun position<T0>(arg0: &ReleaseTrackIterator<T0>) : u8 {
        arg0.position
    }

    public fun release_id<T0>(arg0: &ReleaseTrackIterator<T0>) : 0x2::object::ID {
        arg0.release_id
    }

    public fun remaining<T0>(arg0: &ReleaseTrackIterator<T0>) : u8 {
        (0x1::vector::length<0x2::object::ID>(&arg0.recording_ids) as u8) - arg0.position
    }

    // decompiled from Move bytecode v7
}

