module 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release {
    struct Release has key {
        id: 0x2::object::UID,
        recording_ids: vector<0x2::object::ID>,
    }

    struct ReleaseAdminCap has store, key {
        id: 0x2::object::UID,
        release_id: 0x2::object::ID,
    }

    struct ReleaseTrack has drop {
        recording_id: 0x2::object::ID,
    }

    struct ReleaseAdminCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseCreatedEvent has copy, drop {
        release_id: 0x2::object::ID,
        release_admin_cap_id: 0x2::object::ID,
        recording_ids: vector<0x2::object::ID>,
    }

    public fun new(arg0: vector<ReleaseTrack>, arg1: &mut 0x2::tx_context::TxContext) : (Release, ReleaseAdminCap) {
        assert!(!0x1::vector::is_empty<ReleaseTrack>(&arg0), 1);
        assert!(0x1::vector::length<ReleaseTrack>(&arg0) <= 255, 2);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::reverse<ReleaseTrack>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<ReleaseTrack>(&arg0)) {
            let v2 = 0x1::vector::pop_back<ReleaseTrack>(&mut arg0);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v2.recording_id);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<ReleaseTrack>(arg0);
        let v3 = &v0;
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(v3)) {
            0x1::vector::push_back<u256>(&mut v4, 0x2::address::to_u256(0x2::object::id_to_address(0x1::vector::borrow<0x2::object::ID>(v3, v5))));
            v5 = v5 + 1;
        };
        let v6 = &mut v4;
        let v7 = 0x1::vector::length<u256>(v6);
        if (v7 < 2) {
        } else {
            let v8 = vector[false];
            let v9 = vector[0];
            let v10 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v10, v7);
            while (!0x1::vector::is_empty<bool>(&v8)) {
                let v11 = 0x1::vector::pop_back<u64>(&mut v9);
                let v12 = 0x1::vector::pop_back<u64>(&mut v10);
                let v13 = (v11 + v12) / 2;
                if (0x1::vector::pop_back<bool>(&mut v8)) {
                    let v14 = v11;
                    while (v14 < v13 && v13 < v12) {
                        if (*0x1::vector::borrow<u256>(v6, v14) <= *0x1::vector::borrow<u256>(v6, v13)) {
                            v14 = v14 + 1;
                            continue
                        };
                        while (v13 > v14) {
                            0x1::vector::swap<u256>(v6, v13, v13 - 1);
                            v13 = v13 - 1;
                        };
                        v14 = v14 + 1;
                        v13 = v13 + 1;
                        v13 = v13 + 1;
                    };
                } else {
                    0x1::vector::push_back<bool>(&mut v8, true);
                    0x1::vector::push_back<u64>(&mut v9, v11);
                    0x1::vector::push_back<u64>(&mut v10, v12);
                    if (v13 - v11 > 1) {
                        0x1::vector::push_back<bool>(&mut v8, false);
                        0x1::vector::push_back<u64>(&mut v9, v11);
                        0x1::vector::push_back<u64>(&mut v10, v13);
                    };
                    if (v12 - v13 > 1) {
                        0x1::vector::push_back<bool>(&mut v8, false);
                        0x1::vector::push_back<u64>(&mut v9, v13);
                        0x1::vector::push_back<u64>(&mut v10, v12);
                    };
                };
            };
        };
        let v15 = &v4;
        let v16 = 0;
        let v17;
        while (v16 < 0x1::u64::max(0x1::vector::length<u256>(v15), 1) - 1) {
            if (!(*0x1::vector::borrow<u256>(v15, v16) < *0x1::vector::borrow<u256>(v15, v16 + 1))) {
                v17 = false;
                /* label 40 */
                assert!(v17, 3);
                let v18 = Release{
                    id            : 0x2::object::new(arg1),
                    recording_ids : v0,
                };
                let v19 = ReleaseAdminCapKey{dummy_field: false};
                let v20 = ReleaseAdminCap{
                    id         : 0x2::derived_object::claim<ReleaseAdminCapKey>(&mut v18.id, v19),
                    release_id : 0x2::object::id<Release>(&v18),
                };
                let v21 = ReleaseCreatedEvent{
                    release_id           : 0x2::object::id<Release>(&v18),
                    release_admin_cap_id : 0x2::object::id<ReleaseAdminCap>(&v20),
                    recording_ids        : v18.recording_ids,
                };
                0x2::event::emit<ReleaseCreatedEvent>(v21);
                return (v18, v20)
            };
            v16 = v16 + 1;
        };
        v17 = true;
        /* goto 40 */
    }

    public fun new_release_track<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>) : ReleaseTrack {
        ReleaseTrack{recording_id: 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0)}
    }

    public fun recording_ids(arg0: &Release) : &vector<0x2::object::ID> {
        &arg0.recording_ids
    }

    public fun release_admin_cap_release_id(arg0: &ReleaseAdminCap) : 0x2::object::ID {
        arg0.release_id
    }

    public fun share(arg0: Release) {
        0x2::transfer::share_object<Release>(arg0);
    }

    public fun uid(arg0: &Release) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Release, arg1: &ReleaseAdminCap) : &mut 0x2::object::UID {
        assert!(arg1.release_id == 0x2::object::id<Release>(arg0), 0);
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

