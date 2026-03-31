module 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::messaging {
    struct MESSAGING has drop {
        dummy_field: bool,
    }

    struct Messaging has drop {
        dummy_field: bool,
    }

    struct MessagingSender has drop {
        dummy_field: bool,
    }

    struct MessagingReader has drop {
        dummy_field: bool,
    }

    struct MessagingDeleter has drop {
        dummy_field: bool,
    }

    struct MessagingEditor has drop {
        dummy_field: bool,
    }

    struct SuiNsAdmin has drop {
        dummy_field: bool,
    }

    struct MetadataAdmin has drop {
        dummy_field: bool,
    }

    struct MessagingNamespace has key {
        id: 0x2::object::UID,
    }

    public fun leave(arg0: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_leaver::GroupLeaver, arg1: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<Messaging>, arg2: &0x2::tx_context::TxContext) {
        assert!(!0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<Messaging, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionsAdmin>(arg1, 0x2::tx_context::sender(arg2)), 3);
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_leaver::leave<Messaging>(arg0, arg1, arg2);
    }

    entry fun archive_group(arg0: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::version::Version, arg1: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<Messaging>, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::version::validate_version(arg0);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::unpause_cap::burn<Messaging>(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::pause<Messaging>(arg1, arg2));
    }

    entry fun create_and_share_group(arg0: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::version::Version, arg1: &mut MessagingNamespace, arg2: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::GroupManager, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<address>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_group(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::vec_set::from_keys<address>(arg6), arg7);
        0x2::transfer::public_share_object<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<Messaging>>(v0);
        0x2::transfer::public_share_object<0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::EncryptionHistory>(v1);
    }

    public fun create_group(arg0: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::version::Version, arg1: &mut MessagingNamespace, arg2: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::GroupManager, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: 0x2::vec_set::VecSet<address>, arg7: &mut 0x2::tx_context::TxContext) : (0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<Messaging>, 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::EncryptionHistory) {
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::version::validate_version(arg0);
        let v0 = Messaging{dummy_field: false};
        let v1 = 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::new_derived<Messaging, 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::PermissionedGroupTag>(v0, &mut arg1.id, 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::permissions_group_tag(arg4), arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = &mut v1;
        grant_all_messaging_permissions(v3, v2, arg7);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<Messaging, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionsAdmin>(&mut v1, 0x2::derived_object::derive_address<0x1::string::String>(0x2::object::id<MessagingNamespace>(arg1), 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_leaver::derivation_key()), arg7);
        let v4 = 0x2::object::id<0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::GroupManager>(arg2);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<Messaging, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ObjectAdmin>(&mut v1, 0x2::object::id_to_address(&v4), arg7);
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::attach_metadata<Messaging>(arg2, &mut v1, 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::new(arg3, arg4, v2));
        let v5 = 0x2::vec_set::into_keys<address>(arg6);
        0x1::vector::reverse<address>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&v5)) {
            let v7 = 0x1::vector::pop_back<address>(&mut v5);
            if (v7 != v2) {
                0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<Messaging, MessagingReader>(&mut v1, v7, arg7);
            };
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<address>(v5);
        (v1, 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::new(&mut arg1.id, arg4, 0x2::object::id<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<Messaging>>(&v1), arg5, arg7))
    }

    fun grant_all_messaging_permissions(arg0: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<Messaging>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<Messaging, MessagingSender>(arg0, arg1, arg2);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<Messaging, MessagingReader>(arg0, arg1, arg2);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<Messaging, MessagingEditor>(arg0, arg1, arg2);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<Messaging, MessagingDeleter>(arg0, arg1, arg2);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<Messaging, 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::EncryptionKeyRotator>(arg0, arg1, arg2);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<Messaging, SuiNsAdmin>(arg0, arg1, arg2);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<Messaging, MetadataAdmin>(arg0, arg1, arg2);
    }

    fun init(arg0: MESSAGING, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MESSAGING>(arg0, arg1);
        let v0 = MessagingNamespace{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<MessagingNamespace>(v0);
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_leaver::share(0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_leaver::new(&mut v0.id));
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::share(0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::new(&mut v0.id));
    }

    public fun insert_group_data(arg0: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::GroupManager, arg1: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<Messaging>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<Messaging, MetadataAdmin>(arg1, 0x2::tx_context::sender(arg4)), 0);
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::insert_data(0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::borrow_metadata_mut<Messaging>(arg0, arg1), arg2, arg3);
    }

    public fun remove_group_data(arg0: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::GroupManager, arg1: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<Messaging>, arg2: &0x1::string::String, arg3: &0x2::tx_context::TxContext) : (0x1::string::String, 0x1::string::String) {
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<Messaging, MetadataAdmin>(arg1, 0x2::tx_context::sender(arg3)), 0);
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::remove_data(0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::borrow_metadata_mut<Messaging>(arg0, arg1), arg2)
    }

    public fun rotate_encryption_key(arg0: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::version::Version, arg1: &mut 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::EncryptionHistory, arg2: &0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<Messaging>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::version::validate_version(arg0);
        assert!(!0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::is_paused<Messaging>(arg2), 1);
        assert!(0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::group_id(arg1) == 0x2::object::id<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<Messaging>>(arg2), 2);
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<Messaging, 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::EncryptionKeyRotator>(arg2, 0x2::tx_context::sender(arg4)), 0);
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history::rotate_key(arg1, arg3);
    }

    public fun set_group_name(arg0: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::GroupManager, arg1: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<Messaging>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<Messaging, MetadataAdmin>(arg1, 0x2::tx_context::sender(arg3)), 0);
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata::set_name(0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::borrow_metadata_mut<Messaging>(arg0, arg1), arg2);
    }

    public fun set_suins_reverse_lookup(arg0: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::GroupManager, arg1: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<Messaging>, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<Messaging, SuiNsAdmin>(arg1, 0x2::tx_context::sender(arg4)), 0);
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::set_reverse_lookup<Messaging>(arg0, arg1, arg2, arg3);
    }

    public fun unset_suins_reverse_lookup(arg0: &0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::GroupManager, arg1: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<Messaging>, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: &0x2::tx_context::TxContext) {
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<Messaging, SuiNsAdmin>(arg1, 0x2::tx_context::sender(arg3)), 0);
        0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_manager::unset_reverse_lookup<Messaging>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

