module 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control {
    struct VersionField has copy, drop, store {
        dummy_field: bool,
    }

    struct VersionData has store {
        compatible_versions: 0x2::vec_set::VecSet<u64>,
    }

    public(friend) fun assert_object_version_is_compatible_with_package(arg0: &0x2::object::UID) {
        if (!has_version_data(arg0)) {
            return
        };
        let v0 = current_version();
        assert!(0x2::vec_set::contains<u64>(&borrow_data(arg0).compatible_versions, &v0), 0);
    }

    fun borrow_data(arg0: &0x2::object::UID) : &VersionData {
        0x2::dynamic_field::borrow<VersionField, VersionData>(arg0, version_field())
    }

    fun borrow_data_mut(arg0: &mut 0x2::object::UID) : &mut VersionData {
        0x2::dynamic_field::borrow_mut<VersionField, VersionData>(arg0, version_field())
    }

    public fun compatible_versions(arg0: &0x2::object::UID) : vector<u64> {
        if (!has_version_data(arg0)) {
            let v0 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v0, current_version());
            return v0
        };
        *0x2::vec_set::keys<u64>(&borrow_data(arg0).compatible_versions)
    }

    public fun current_version() : u64 {
        1
    }

    public(friend) fun ensure_version_data(arg0: &mut 0x2::object::UID) {
        if (!has_version_data(arg0)) {
            let v0 = VersionData{compatible_versions: 0x2::vec_set::singleton<u64>(current_version())};
            0x2::dynamic_field::add<VersionField, VersionData>(arg0, version_field(), v0);
        };
    }

    fun has_version_data(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<VersionField, VersionData>(arg0, version_field())
    }

    public(friend) fun insert_current_version(arg0: &mut 0x2::object::UID) {
        ensure_version_data(arg0);
        0x2::vec_set::insert<u64>(&mut borrow_data_mut(arg0).compatible_versions, current_version());
    }

    public(friend) fun remove_version(arg0: &mut 0x2::object::UID, arg1: u64) {
        ensure_version_data(arg0);
        0x2::vec_set::remove<u64>(&mut borrow_data_mut(arg0).compatible_versions, &arg1);
    }

    fun version_field() : VersionField {
        VersionField{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

