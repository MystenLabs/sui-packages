module 0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl {
    struct ACL has key {
        id: 0x2::object::UID,
        roles: 0x2::table::Table<address, 0x2::vec_set::VecSet<u8>>,
        roles_id_table: 0x2::table::Table<u8, 0x1::string::String>,
        operation_role: 0x2::table::Table<0x1::string::String, u8>,
        role_operation_counts: 0x2::table::Table<u8, u64>,
        deleted_role_ids: 0x2::vec_set::VecSet<u8>,
    }

    struct AclCreatedEvent has copy, drop {
        acl_id: 0x2::object::ID,
    }

    struct RoleGrantedEvent has copy, drop {
        account: address,
        role: u8,
    }

    struct RoleRevokedEvent has copy, drop {
        account: address,
        role: u8,
    }

    struct RoleCreatedEvent has copy, drop {
        role_id: u8,
        role_name: 0x1::string::String,
    }

    struct RoleAssignedToOperationEvent has copy, drop {
        operation: 0x1::string::String,
        role_id: u8,
    }

    struct RoleDeletedEvent has copy, drop {
        role_id: u8,
    }

    struct RoleUnassignedFromOperationEvent has copy, drop {
        operation: 0x1::string::String,
    }

    public fun assert_has_role(arg0: &ACL, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: address, arg3: 0x1::string::String) {
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::package_version::assert_current(arg1);
        assert!(has_role_raw(arg0, arg2, arg3), 100);
    }

    public fun assign_role_to_operation(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut ACL, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x1::string::String, arg4: u8) {
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::package_version::assert_current(arg0);
        assert!(0x2::table::contains<u8, 0x1::string::String>(&arg1.roles_id_table, arg4), 104);
        assert!(!0x2::table::contains<0x1::string::String, u8>(&arg1.operation_role, arg3), 105);
        0x2::table::add<0x1::string::String, u8>(&mut arg1.operation_role, arg3, arg4);
        let v0 = 0x2::table::borrow_mut<u8, u64>(&mut arg1.role_operation_counts, arg4);
        *v0 = *v0 + 1;
        let v1 = RoleAssignedToOperationEvent{
            operation : arg3,
            role_id   : arg4,
        };
        0x2::event::emit<RoleAssignedToOperationEvent>(v1);
    }

    public fun create_role(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut ACL, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u8, arg4: 0x1::string::String) {
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::package_version::assert_current(arg0);
        assert!(!0x2::table::contains<u8, 0x1::string::String>(&arg1.roles_id_table, arg3), 103);
        assert!(!0x2::vec_set::contains<u8>(&arg1.deleted_role_ids, &arg3), 104);
        0x2::table::add<u8, 0x1::string::String>(&mut arg1.roles_id_table, arg3, arg4);
        0x2::table::add<u8, u64>(&mut arg1.role_operation_counts, arg3, 0);
        let v0 = RoleCreatedEvent{
            role_id   : arg3,
            role_name : arg4,
        };
        0x2::event::emit<RoleCreatedEvent>(v0);
    }

    public fun delete_role(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut ACL, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u8) {
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::package_version::assert_current(arg0);
        assert!(0x2::table::contains<u8, 0x1::string::String>(&arg1.roles_id_table, arg3), 104);
        assert!(*0x2::table::borrow<u8, u64>(&arg1.role_operation_counts, arg3) == 0, 107);
        0x2::table::remove<u8, 0x1::string::String>(&mut arg1.roles_id_table, arg3);
        0x2::table::remove<u8, u64>(&mut arg1.role_operation_counts, arg3);
        0x2::vec_set::insert<u8>(&mut arg1.deleted_role_ids, arg3);
        let v0 = RoleDeletedEvent{role_id: arg3};
        0x2::event::emit<RoleDeletedEvent>(v0);
    }

    public fun grant_role(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut ACL, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: address, arg4: u8) {
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::package_version::assert_current(arg0);
        assert!(0x2::table::contains<u8, 0x1::string::String>(&arg1.roles_id_table, arg4), 104);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<u8>>(&arg1.roles, arg3)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<u8>>(&mut arg1.roles, arg3, 0x2::vec_set::empty<u8>());
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<u8>>(&mut arg1.roles, arg3);
        assert!(!0x2::vec_set::contains<u8>(v0, &arg4), 101);
        0x2::vec_set::insert<u8>(v0, arg4);
        let v1 = RoleGrantedEvent{
            account : arg3,
            role    : arg4,
        };
        0x2::event::emit<RoleGrantedEvent>(v1);
    }

    public fun has_role(arg0: &ACL, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: address, arg3: 0x1::string::String) : bool {
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::package_version::assert_current(arg1);
        has_role_raw(arg0, arg2, arg3)
    }

    fun has_role_raw(arg0: &ACL, arg1: address, arg2: 0x1::string::String) : bool {
        if (!0x2::table::contains<0x1::string::String, u8>(&arg0.operation_role, arg2)) {
            return false
        };
        let v0 = *0x2::table::borrow<0x1::string::String, u8>(&arg0.operation_role, arg2);
        if (!0x2::table::contains<u8, 0x1::string::String>(&arg0.roles_id_table, v0)) {
            return false
        };
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<u8>>(&arg0.roles, arg1)) {
            return false
        };
        0x2::vec_set::contains<u8>(0x2::table::borrow<address, 0x2::vec_set::VecSet<u8>>(&arg0.roles, arg1), &v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ACL{
            id                    : 0x2::object::new(arg0),
            roles                 : 0x2::table::new<address, 0x2::vec_set::VecSet<u8>>(arg0),
            roles_id_table        : 0x2::table::new<u8, 0x1::string::String>(arg0),
            operation_role        : 0x2::table::new<0x1::string::String, u8>(arg0),
            role_operation_counts : 0x2::table::new<u8, u64>(arg0),
            deleted_role_ids      : 0x2::vec_set::empty<u8>(),
        };
        let v1 = AclCreatedEvent{acl_id: 0x2::object::id<ACL>(&v0)};
        0x2::event::emit<AclCreatedEvent>(v1);
        0x2::transfer::share_object<ACL>(v0);
    }

    public fun revoke_role(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut ACL, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: address, arg4: u8) {
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::package_version::assert_current(arg0);
        assert!(0x2::table::contains<address, 0x2::vec_set::VecSet<u8>>(&arg1.roles, arg3), 102);
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<u8>>(&mut arg1.roles, arg3);
        assert!(0x2::vec_set::contains<u8>(v0, &arg4), 102);
        0x2::vec_set::remove<u8>(v0, &arg4);
        let v1 = RoleRevokedEvent{
            account : arg3,
            role    : arg4,
        };
        0x2::event::emit<RoleRevokedEvent>(v1);
    }

    public fun unassign_role_from_operation(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut ACL, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x1::string::String) {
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::package_version::assert_current(arg0);
        assert!(0x2::table::contains<0x1::string::String, u8>(&arg1.operation_role, arg3), 106);
        let v0 = 0x2::table::borrow_mut<u8, u64>(&mut arg1.role_operation_counts, 0x2::table::remove<0x1::string::String, u8>(&mut arg1.operation_role, arg3));
        *v0 = *v0 - 1;
        let v1 = RoleUnassignedFromOperationEvent{operation: arg3};
        0x2::event::emit<RoleUnassignedFromOperationEvent>(v1);
    }

    // decompiled from Move bytecode v7
}

