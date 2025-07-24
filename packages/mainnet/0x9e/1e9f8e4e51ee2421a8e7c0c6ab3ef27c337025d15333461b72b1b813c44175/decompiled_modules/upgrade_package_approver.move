module 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver {
    struct UpgradePackageApprover {
        upgrade_cap_id: 0x2::object::ID,
        remaining_witnesses_to_approve: vector<0x1::string::String>,
        old_package_id: 0x2::object::ID,
        new_package_id: 0x1::option::Option<0x2::object::ID>,
        migration_epoch: u64,
    }

    public fun approve_upgrade_package_by_witness<T0: drop>(arg0: &mut UpgradePackageApprover, arg1: T0) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.new_package_id), 1);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()));
        let (v1, v2) = 0x1::vector::index_of<0x1::string::String>(&arg0.remaining_witnesses_to_approve, &v0);
        assert!(v1, 0);
        0x1::vector::remove<0x1::string::String>(&mut arg0.remaining_witnesses_to_approve, v2);
        *0x1::option::borrow<0x2::object::ID>(&arg0.new_package_id)
    }

    public fun assert_all_witnesses_approved(arg0: &UpgradePackageApprover) {
        assert!(0x1::vector::is_empty<0x1::string::String>(&arg0.remaining_witnesses_to_approve), 0);
    }

    public fun commit(arg0: &mut UpgradePackageApprover, arg1: &0x2::package::UpgradeReceipt, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) {
        assert!(arg0.upgrade_cap_id == 0x2::package::receipt_cap(arg1), 2);
        arg0.new_package_id = 0x1::option::some<0x2::object::ID>(0x2::package::receipt_package(arg1));
    }

    public fun create(arg0: 0x2::object::ID, arg1: vector<0x1::string::String>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) : UpgradePackageApprover {
        UpgradePackageApprover{
            upgrade_cap_id                 : arg0,
            remaining_witnesses_to_approve : arg1,
            old_package_id                 : arg2,
            new_package_id                 : 0x1::option::none<0x2::object::ID>(),
            migration_epoch                : arg3,
        }
    }

    public fun destroy(arg0: UpgradePackageApprover, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) {
        let UpgradePackageApprover {
            upgrade_cap_id                 : _,
            remaining_witnesses_to_approve : _,
            old_package_id                 : _,
            new_package_id                 : _,
            migration_epoch                : _,
        } = arg0;
    }

    public fun migration_epoch(arg0: &UpgradePackageApprover) : u64 {
        arg0.migration_epoch
    }

    public fun new_package_id(arg0: &UpgradePackageApprover) : 0x1::option::Option<0x2::object::ID> {
        arg0.new_package_id
    }

    public fun old_package_id(arg0: &UpgradePackageApprover) : 0x2::object::ID {
        arg0.old_package_id
    }

    // decompiled from Move bytecode v6
}

