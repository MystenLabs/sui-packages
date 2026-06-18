module 0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl {
    struct ACL has key {
        id: 0x2::object::UID,
        roles: 0x2::table::Table<address, 0x2::vec_set::VecSet<u8>>,
        roles_id_table: 0x2::table::Table<u8, 0x1::string::String>,
        operation_role: 0x2::table::Table<0x1::string::String, u8>,
        role_operation_counts: 0x2::table::Table<u8, u64>,
        deleted_role_ids: 0x2::vec_set::VecSet<u8>,
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

    public fun assert_has_role(arg0: &ACL, arg1: address, arg2: 0x1::string::String) {
        assert!(has_role(arg0, arg1, arg2), 100);
    }

    public fun assign_role_to_operation(arg0: &mut ACL, arg1: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg2: 0x1::string::String, arg3: u8) {
        assert!(0x2::table::contains<u8, 0x1::string::String>(&arg0.roles_id_table, arg3), 104);
        assert!(!0x2::table::contains<0x1::string::String, u8>(&arg0.operation_role, arg2), 105);
        0x2::table::add<0x1::string::String, u8>(&mut arg0.operation_role, arg2, arg3);
        let v0 = 0x2::table::borrow_mut<u8, u64>(&mut arg0.role_operation_counts, arg3);
        *v0 = *v0 + 1;
        let v1 = RoleAssignedToOperationEvent{
            operation : arg2,
            role_id   : arg3,
        };
        0x2::event::emit<RoleAssignedToOperationEvent>(v1);
    }

    public fun create_role(arg0: &mut ACL, arg1: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg2: u8, arg3: 0x1::string::String) {
        assert!(!0x2::table::contains<u8, 0x1::string::String>(&arg0.roles_id_table, arg2), 103);
        assert!(!0x2::vec_set::contains<u8>(&arg0.deleted_role_ids, &arg2), 104);
        0x2::table::add<u8, 0x1::string::String>(&mut arg0.roles_id_table, arg2, arg3);
        0x2::table::add<u8, u64>(&mut arg0.role_operation_counts, arg2, 0);
        let v0 = RoleCreatedEvent{
            role_id   : arg2,
            role_name : arg3,
        };
        0x2::event::emit<RoleCreatedEvent>(v0);
    }

    public fun delete_role(arg0: &mut ACL, arg1: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg2: u8) {
        assert!(0x2::table::contains<u8, 0x1::string::String>(&arg0.roles_id_table, arg2), 104);
        assert!(*0x2::table::borrow<u8, u64>(&arg0.role_operation_counts, arg2) == 0, 107);
        0x2::table::remove<u8, 0x1::string::String>(&mut arg0.roles_id_table, arg2);
        0x2::table::remove<u8, u64>(&mut arg0.role_operation_counts, arg2);
        0x2::vec_set::insert<u8>(&mut arg0.deleted_role_ids, arg2);
        let v0 = RoleDeletedEvent{role_id: arg2};
        0x2::event::emit<RoleDeletedEvent>(v0);
    }

    public fun grant_role(arg0: &mut ACL, arg1: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg2: address, arg3: u8) {
        assert!(0x2::table::contains<u8, 0x1::string::String>(&arg0.roles_id_table, arg3), 104);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<u8>>(&arg0.roles, arg2)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<u8>>(&mut arg0.roles, arg2, 0x2::vec_set::empty<u8>());
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<u8>>(&mut arg0.roles, arg2);
        assert!(!0x2::vec_set::contains<u8>(v0, &arg3), 101);
        0x2::vec_set::insert<u8>(v0, arg3);
        let v1 = RoleGrantedEvent{
            account : arg2,
            role    : arg3,
        };
        0x2::event::emit<RoleGrantedEvent>(v1);
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: 0x1::string::String) : bool {
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
        0x2::transfer::share_object<ACL>(v0);
    }

    public fun revoke_role(arg0: &mut ACL, arg1: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg2: address, arg3: u8) {
        assert!(0x2::table::contains<address, 0x2::vec_set::VecSet<u8>>(&arg0.roles, arg2), 102);
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<u8>>(&mut arg0.roles, arg2);
        assert!(0x2::vec_set::contains<u8>(v0, &arg3), 102);
        0x2::vec_set::remove<u8>(v0, &arg3);
        let v1 = RoleRevokedEvent{
            account : arg2,
            role    : arg3,
        };
        0x2::event::emit<RoleRevokedEvent>(v1);
    }

    public fun unassign_role_from_operation(arg0: &mut ACL, arg1: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg2: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, u8>(&arg0.operation_role, arg2), 106);
        let v0 = 0x2::table::borrow_mut<u8, u64>(&mut arg0.role_operation_counts, 0x2::table::remove<0x1::string::String, u8>(&mut arg0.operation_role, arg2));
        *v0 = *v0 - 1;
        let v1 = RoleUnassignedFromOperationEvent{operation: arg2};
        0x2::event::emit<RoleUnassignedFromOperationEvent>(v1);
    }

    // decompiled from Move bytecode v7
}

