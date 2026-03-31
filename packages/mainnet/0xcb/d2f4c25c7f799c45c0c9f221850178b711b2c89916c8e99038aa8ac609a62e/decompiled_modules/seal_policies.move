module 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::seal_policies {
    entry fun seal_approve_reader(arg0: vector<u8>, arg1: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::version::Version, arg2: &0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::messaging::Messaging>, arg3: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::EncryptionHistory, arg4: &0x2::tx_context::TxContext) {
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::version::validate_version(arg1);
        validate_identity(arg2, arg3, arg0);
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::messaging::Messaging, 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::messaging::MessagingReader>(arg2, 0x2::tx_context::sender(arg4)), 1);
    }

    public fun validate_identity(arg0: &0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::messaging::Messaging>, arg1: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::EncryptionHistory, arg2: vector<u8>) {
        assert!(0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::group_id(arg1) == 0x2::object::id<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::messaging::Messaging>>(arg0), 3);
        assert!(0x1::vector::length<u8>(&arg2) == 40, 0);
        let v0 = 0x2::bcs::new(arg2);
        let v1 = 0x2::object::id<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::messaging::Messaging>>(arg0);
        assert!(0x2::object::id_to_address(&v1) == 0x2::bcs::peel_address(&mut v0), 0);
        assert!(0x2::bcs::peel_u64(&mut v0) <= 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::current_key_version(arg1), 2);
    }

    // decompiled from Move bytecode v6
}

