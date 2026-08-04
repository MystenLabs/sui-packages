module 0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_credits {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RecordingCredits has store {
        credits: 0x2::vec_map::VecMap<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>>,
        primary_artist_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        featured_artist_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    fun borrow(arg0: &0x2::object::UID) : &RecordingCredits {
        let v0 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(arg0, v0), 50);
        let v1 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey, RecordingCredits>(arg0, v1)
    }

    fun borrow_mut(arg0: &mut 0x2::object::UID) : &mut RecordingCredits {
        let v0 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(arg0, v0), 50);
        let v1 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ExtensionKey, RecordingCredits>(arg0, v1)
    }

    public fun add_credit<T0, T1>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T0>, arg2: &0x168147621e7b2d55b3ad5e65acc56a63376b339c7b3c42c2b9d48fc80d358dea::party::Party, arg3: 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>) {
        assert!(0x1::vector::length<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>(0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::roles<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>(&arg3)) >= 1, 20);
        assert!(0x1::vector::length<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>(0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::roles<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>(&arg3)) <= 10, 30);
        let v0 = 0x168147621e7b2d55b3ad5e65acc56a63376b339c7b3c42c2b9d48fc80d358dea::party::id(arg2);
        let v1 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid_mut<T0, T1>(arg0, arg1);
        let v2 = borrow_mut_or_init(v1);
        assert!(0x2::vec_map::length<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>>(&v2.credits) < 150, 32);
        assert!(!0x2::vec_map::contains<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>>(&v2.credits, &v0), 40);
        0x2::vec_map::insert<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>>(&mut v2.credits, v0, arg3);
    }

    public fun add_featured_artist<T0, T1>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T0>, arg2: &0x168147621e7b2d55b3ad5e65acc56a63376b339c7b3c42c2b9d48fc80d358dea::party::Party) {
        let v0 = 0x168147621e7b2d55b3ad5e65acc56a63376b339c7b3c42c2b9d48fc80d358dea::party::id(arg2);
        let v1 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid_mut<T0, T1>(arg0, arg1);
        let v2 = borrow_mut(v1);
        assert!(0x2::vec_set::length<0x2::object::ID>(&v2.featured_artist_ids) < 50, 35);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>>(&v2.credits, &v0), 52);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&v2.primary_artist_ids, &v0), 41);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&v2.featured_artist_ids, &v0), 42);
        0x2::vec_set::insert<0x2::object::ID>(&mut v2.featured_artist_ids, v0);
    }

    public fun add_primary_artist<T0, T1>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T0>, arg2: &0x168147621e7b2d55b3ad5e65acc56a63376b339c7b3c42c2b9d48fc80d358dea::party::Party) {
        let v0 = 0x168147621e7b2d55b3ad5e65acc56a63376b339c7b3c42c2b9d48fc80d358dea::party::id(arg2);
        let v1 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid_mut<T0, T1>(arg0, arg1);
        let v2 = borrow_mut(v1);
        assert!(0x2::vec_set::length<0x2::object::ID>(&v2.primary_artist_ids) < 20, 34);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>>(&v2.credits, &v0), 52);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&v2.featured_artist_ids, &v0), 42);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&v2.primary_artist_ids, &v0), 41);
        0x2::vec_set::insert<0x2::object::ID>(&mut v2.primary_artist_ids, v0);
    }

    fun borrow_mut_or_init(arg0: &mut 0x2::object::UID) : &mut RecordingCredits {
        let v0 = ExtensionKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ExtensionKey>(arg0, v0)) {
            let v1 = ExtensionKey{dummy_field: false};
            let v2 = RecordingCredits{
                credits             : 0x2::vec_map::empty<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>>(),
                primary_artist_ids  : 0x2::vec_set::empty<0x2::object::ID>(),
                featured_artist_ids : 0x2::vec_set::empty<0x2::object::ID>(),
            };
            0x2::dynamic_field::add<ExtensionKey, RecordingCredits>(arg0, v1, v2);
        };
        let v3 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ExtensionKey, RecordingCredits>(arg0, v3)
    }

    public fun credits<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>) : &0x2::vec_map::VecMap<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>> {
        &borrow(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid<T0, T1>(arg0)).credits
    }

    public fun featured_artist_ids<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &borrow(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid<T0, T1>(arg0)).featured_artist_ids
    }

    public fun has_credits<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid<T0, T1>(arg0), v0)
    }

    public fun is_featured_artist<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: 0x2::object::ID) : bool {
        has_credits<T0, T1>(arg0) && 0x2::vec_set::contains<0x2::object::ID>(&borrow(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid<T0, T1>(arg0)).featured_artist_ids, &arg1)
    }

    public fun is_primary_artist<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: 0x2::object::ID) : bool {
        has_credits<T0, T1>(arg0) && 0x2::vec_set::contains<0x2::object::ID>(&borrow(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid<T0, T1>(arg0)).primary_artist_ids, &arg1)
    }

    public fun primary_artist_ids<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &borrow(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid<T0, T1>(arg0)).primary_artist_ids
    }

    public fun remove_credit<T0, T1>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T0>, arg2: 0x2::object::ID) {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid_mut<T0, T1>(arg0, arg1);
        let v1 = borrow_mut(v0);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>>(&v1.credits, &arg2), 52);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit::Credit<0xd2f14bd61704c49299f72f9aff76c4b43bd143cf7ca2c6e2b410bbb5090aa3d0::recording_party_role::RecordingPartyRole>>(&mut v1.credits, &arg2);
        if (0x2::vec_set::contains<0x2::object::ID>(&v1.primary_artist_ids, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut v1.primary_artist_ids, &arg2);
        };
        if (0x2::vec_set::contains<0x2::object::ID>(&v1.featured_artist_ids, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut v1.featured_artist_ids, &arg2);
        };
    }

    public fun remove_featured_artist<T0, T1>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T0>, arg2: 0x2::object::ID) {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid_mut<T0, T1>(arg0, arg1);
        let v1 = borrow_mut(v0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&v1.featured_artist_ids, &arg2), 52);
        0x2::vec_set::remove<0x2::object::ID>(&mut v1.featured_artist_ids, &arg2);
    }

    public fun remove_primary_artist<T0, T1>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T0>, arg2: 0x2::object::ID) {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid_mut<T0, T1>(arg0, arg1);
        let v1 = borrow_mut(v0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&v1.primary_artist_ids, &arg2), 52);
        0x2::vec_set::remove<0x2::object::ID>(&mut v1.primary_artist_ids, &arg2);
    }

    // decompiled from Move bytecode v7
}

