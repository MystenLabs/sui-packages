module 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager {
    struct GroupManager has key {
        id: 0x2::object::UID,
    }

    public(friend) fun attach_metadata<T0: drop>(arg0: &GroupManager, arg1: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>, arg2: 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::Metadata) {
        0x2::dynamic_field::add<0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::MetadataKey, 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::Metadata>(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::object_uid_mut<T0>(arg1, &arg0.id), 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::key(), arg2);
    }

    public(friend) fun borrow_metadata<T0: drop>(arg0: &GroupManager, arg1: &0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>) : &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::Metadata {
        0x2::dynamic_field::borrow<0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::MetadataKey, 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::Metadata>(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::object_uid<T0>(arg1, &arg0.id), 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::key())
    }

    public(friend) fun borrow_metadata_mut<T0: drop>(arg0: &GroupManager, arg1: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>) : &mut 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::Metadata {
        0x2::dynamic_field::borrow_mut<0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::MetadataKey, 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::Metadata>(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::object_uid_mut<T0>(arg1, &arg0.id), 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::key())
    }

    public(friend) fun derivation_key() : 0x1::string::String {
        0x1::string::utf8(b"group_manager")
    }

    public(friend) fun new(arg0: &mut 0x2::object::UID) : GroupManager {
        GroupManager{id: 0x2::derived_object::claim<0x1::string::String>(arg0, 0x1::string::utf8(b"group_manager"))}
    }

    public(friend) fun remove_metadata<T0: drop>(arg0: &GroupManager, arg1: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>) : 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::Metadata {
        0x2::dynamic_field::remove<0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::MetadataKey, 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::Metadata>(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::object_uid_mut<T0>(arg1, &arg0.id), 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::key())
    }

    public(friend) fun set_reverse_lookup<T0: drop>(arg0: &GroupManager, arg1: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: 0x1::string::String) {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::controller::set_object_reverse_lookup(arg2, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::object_uid_mut<T0>(arg1, &arg0.id), arg3);
    }

    public(friend) fun share(arg0: GroupManager) {
        0x2::transfer::share_object<GroupManager>(arg0);
    }

    public(friend) fun unset_reverse_lookup<T0: drop>(arg0: &GroupManager, arg1: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS) {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::controller::unset_object_reverse_lookup(arg2, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::object_uid_mut<T0>(arg1, &arg0.id));
    }

    // decompiled from Move bytecode v6
}

