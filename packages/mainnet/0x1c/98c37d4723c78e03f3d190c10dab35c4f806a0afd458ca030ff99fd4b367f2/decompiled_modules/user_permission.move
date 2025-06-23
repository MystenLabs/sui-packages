module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::user_permission {
    struct UserPermission has store, key {
        id: 0x2::object::UID,
        owner: address,
        permissions_list: vector<0x1::string::String>,
    }

    public entry fun add_permissions(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut UserPermission, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::append<0x1::string::String>(&mut arg1.permissions_list, arg2);
    }

    public entry fun add_permissions_by_useradmin(arg0: &mut UserPermission, arg1: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::admin_permission::AdminPermission, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::admin_permission::is_connected_user(arg1, arg0.owner, arg3), 3);
        0x1::vector::append<0x1::string::String>(&mut arg0.permissions_list, arg2);
    }

    public entry fun create_user_permission(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: vector<0x1::string::String>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = UserPermission{
            id               : 0x2::object::new(arg3),
            owner            : arg2,
            permissions_list : arg1,
        };
        0x2::transfer::share_object<UserPermission>(v0);
    }

    public entry fun remove_permission(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut UserPermission, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 0x1::vector::length<0x1::string::String>(&arg1.permissions_list), 2);
        0x1::vector::remove<0x1::string::String>(&mut arg1.permissions_list, arg2);
    }

    public entry fun remove_permission_by_useradmin(arg0: &mut UserPermission, arg1: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::admin_permission::AdminPermission, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::admin_permission::is_connected_user(arg1, arg0.owner, arg3), 3);
        assert!(arg2 < 0x1::vector::length<0x1::string::String>(&arg0.permissions_list), 2);
        0x1::vector::remove<0x1::string::String>(&mut arg0.permissions_list, arg2);
    }

    public entry fun update_permission(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut UserPermission, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 0x1::vector::length<0x1::string::String>(&arg1.permissions_list), 2);
        *0x1::vector::borrow_mut<0x1::string::String>(&mut arg1.permissions_list, arg2) = arg3;
    }

    public entry fun update_permission_by_useradmin(arg0: &mut UserPermission, arg1: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::admin_permission::AdminPermission, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::admin_permission::is_connected_user(arg1, arg0.owner, arg4), 3);
        assert!(arg2 < 0x1::vector::length<0x1::string::String>(&arg0.permissions_list), 2);
        *0x1::vector::borrow_mut<0x1::string::String>(&mut arg0.permissions_list, arg2) = arg3;
    }

    // decompiled from Move bytecode v6
}

