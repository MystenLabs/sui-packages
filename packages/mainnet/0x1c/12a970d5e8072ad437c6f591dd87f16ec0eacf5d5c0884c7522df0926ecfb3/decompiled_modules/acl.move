module 0x1c12a970d5e8072ad437c6f591dd87f16ec0eacf5d5c0884c7522df0926ecfb3::acl {
    struct ACL has key {
        id: 0x2::object::UID,
        roles: 0x2::table::Table<address, 0x2::vec_set::VecSet<u8>>,
        role_names: 0x2::table::Table<u8, 0x1::string::String>,
        operation_roles: 0x2::table::Table<0x1::string::String, u8>,
        role_operation_counts: 0x2::table::Table<u8, u64>,
        deleted_role_ids: 0x2::vec_set::VecSet<u8>,
    }

    struct RoleGranted has copy, drop {
        acl_id: 0x2::object::ID,
        account: address,
        role_id: u8,
    }

    struct AclCreated has copy, drop {
        acl_id: 0x2::object::ID,
    }

    struct RoleRevoked has copy, drop {
        acl_id: 0x2::object::ID,
        account: address,
        role_id: u8,
    }

    struct RoleCreated has copy, drop {
        acl_id: 0x2::object::ID,
        role_id: u8,
        role_name: 0x1::string::String,
    }

    struct RoleDeleted has copy, drop {
        acl_id: 0x2::object::ID,
        role_id: u8,
    }

    struct OperationAssigned has copy, drop {
        acl_id: 0x2::object::ID,
        operation: 0x1::string::String,
        role_id: u8,
    }

    struct OperationUnassigned has copy, drop {
        acl_id: 0x2::object::ID,
        operation: 0x1::string::String,
        role_id: u8,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        let v0 = ACL{
            id                    : 0x2::object::new(arg0),
            roles                 : 0x2::table::new<address, 0x2::vec_set::VecSet<u8>>(arg0),
            role_names            : 0x2::table::new<u8, 0x1::string::String>(arg0),
            operation_roles       : 0x2::table::new<0x1::string::String, u8>(arg0),
            role_operation_counts : 0x2::table::new<u8, u64>(arg0),
            deleted_role_ids      : 0x2::vec_set::empty<u8>(),
        };
        let v1 = AclCreated{acl_id: 0x2::object::id<ACL>(&v0)};
        0x2::event::emit<AclCreated>(v1);
        v0
    }

    public fun assert_has_role(arg0: &ACL, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: address, arg3: 0x1::string::String) {
        0x1c12a970d5e8072ad437c6f591dd87f16ec0eacf5d5c0884c7522df0926ecfb3::package_version::assert_current(arg1);
        assert!(has_role(arg0, arg2, arg3), 100);
    }

    public fun assign_role_to_operation(arg0: &mut ACL, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg3: 0x1::string::String, arg4: u8) {
        0x1c12a970d5e8072ad437c6f591dd87f16ec0eacf5d5c0884c7522df0926ecfb3::package_version::assert_current(arg1);
        assert!(0x2::table::contains<u8, 0x1::string::String>(&arg0.role_names, arg4), 104);
        assert!(!0x2::table::contains<0x1::string::String, u8>(&arg0.operation_roles, arg3), 105);
        0x2::table::add<0x1::string::String, u8>(&mut arg0.operation_roles, arg3, arg4);
        let v0 = 0x2::table::borrow_mut<u8, u64>(&mut arg0.role_operation_counts, arg4);
        *v0 = *v0 + 1;
        let v1 = OperationAssigned{
            acl_id    : 0x2::object::id<ACL>(arg0),
            operation : arg3,
            role_id   : arg4,
        };
        0x2::event::emit<OperationAssigned>(v1);
    }

    public fun create_role(arg0: &mut ACL, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg3: u8, arg4: 0x1::string::String) {
        0x1c12a970d5e8072ad437c6f591dd87f16ec0eacf5d5c0884c7522df0926ecfb3::package_version::assert_current(arg1);
        assert!(!0x2::table::contains<u8, 0x1::string::String>(&arg0.role_names, arg3), 103);
        assert!(!0x2::vec_set::contains<u8>(&arg0.deleted_role_ids, &arg3), 104);
        0x2::table::add<u8, 0x1::string::String>(&mut arg0.role_names, arg3, arg4);
        0x2::table::add<u8, u64>(&mut arg0.role_operation_counts, arg3, 0);
        let v0 = RoleCreated{
            acl_id    : 0x2::object::id<ACL>(arg0),
            role_id   : arg3,
            role_name : arg4,
        };
        0x2::event::emit<RoleCreated>(v0);
    }

    public fun delete_role(arg0: &mut ACL, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg3: u8) {
        0x1c12a970d5e8072ad437c6f591dd87f16ec0eacf5d5c0884c7522df0926ecfb3::package_version::assert_current(arg1);
        assert!(0x2::table::contains<u8, 0x1::string::String>(&arg0.role_names, arg3), 104);
        assert!(*0x2::table::borrow<u8, u64>(&arg0.role_operation_counts, arg3) == 0, 107);
        0x2::table::remove<u8, 0x1::string::String>(&mut arg0.role_names, arg3);
        0x2::table::remove<u8, u64>(&mut arg0.role_operation_counts, arg3);
        0x2::vec_set::insert<u8>(&mut arg0.deleted_role_ids, arg3);
        let v0 = RoleDeleted{
            acl_id  : 0x2::object::id<ACL>(arg0),
            role_id : arg3,
        };
        0x2::event::emit<RoleDeleted>(v0);
    }

    public fun grant_role(arg0: &mut ACL, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg3: address, arg4: u8) {
        0x1c12a970d5e8072ad437c6f591dd87f16ec0eacf5d5c0884c7522df0926ecfb3::package_version::assert_current(arg1);
        assert!(0x2::table::contains<u8, 0x1::string::String>(&arg0.role_names, arg4), 104);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<u8>>(&arg0.roles, arg3)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<u8>>(&mut arg0.roles, arg3, 0x2::vec_set::empty<u8>());
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<u8>>(&mut arg0.roles, arg3);
        assert!(!0x2::vec_set::contains<u8>(v0, &arg4), 101);
        0x2::vec_set::insert<u8>(v0, arg4);
        let v1 = RoleGranted{
            acl_id  : 0x2::object::id<ACL>(arg0),
            account : arg3,
            role_id : arg4,
        };
        0x2::event::emit<RoleGranted>(v1);
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: 0x1::string::String) : bool {
        if (!0x2::table::contains<0x1::string::String, u8>(&arg0.operation_roles, arg2)) {
            return false
        };
        let v0 = *0x2::table::borrow<0x1::string::String, u8>(&arg0.operation_roles, arg2);
        if (0x2::table::contains<u8, 0x1::string::String>(&arg0.role_names, v0)) {
            if (0x2::table::contains<address, 0x2::vec_set::VecSet<u8>>(&arg0.roles, arg1)) {
                0x2::vec_set::contains<u8>(0x2::table::borrow<address, 0x2::vec_set::VecSet<u8>>(&arg0.roles, arg1), &v0)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<ACL>(new(arg0));
    }

    public fun operation_assigned(arg0: &ACL, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, u8>(&arg0.operation_roles, arg1)
    }

    public fun revoke_role(arg0: &mut ACL, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg3: address, arg4: u8) {
        0x1c12a970d5e8072ad437c6f591dd87f16ec0eacf5d5c0884c7522df0926ecfb3::package_version::assert_current(arg1);
        assert!(0x2::table::contains<address, 0x2::vec_set::VecSet<u8>>(&arg0.roles, arg3), 102);
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<u8>>(&mut arg0.roles, arg3);
        assert!(0x2::vec_set::contains<u8>(v0, &arg4), 102);
        0x2::vec_set::remove<u8>(v0, &arg4);
        let v1 = RoleRevoked{
            acl_id  : 0x2::object::id<ACL>(arg0),
            account : arg3,
            role_id : arg4,
        };
        0x2::event::emit<RoleRevoked>(v1);
    }

    public fun role_exists(arg0: &ACL, arg1: u8) : bool {
        0x2::table::contains<u8, 0x1::string::String>(&arg0.role_names, arg1)
    }

    public fun role_operation_count(arg0: &ACL, arg1: u8) : u64 {
        assert!(0x2::table::contains<u8, u64>(&arg0.role_operation_counts, arg1), 104);
        *0x2::table::borrow<u8, u64>(&arg0.role_operation_counts, arg1)
    }

    public fun unassign_role_from_operation(arg0: &mut ACL, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg2: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg3: 0x1::string::String) {
        0x1c12a970d5e8072ad437c6f591dd87f16ec0eacf5d5c0884c7522df0926ecfb3::package_version::assert_current(arg1);
        assert!(0x2::table::contains<0x1::string::String, u8>(&arg0.operation_roles, arg3), 106);
        let v0 = 0x2::table::remove<0x1::string::String, u8>(&mut arg0.operation_roles, arg3);
        let v1 = 0x2::table::borrow_mut<u8, u64>(&mut arg0.role_operation_counts, v0);
        *v1 = *v1 - 1;
        let v2 = OperationUnassigned{
            acl_id    : 0x2::object::id<ACL>(arg0),
            operation : arg3,
            role_id   : v0,
        };
        0x2::event::emit<OperationUnassigned>(v2);
    }

    // decompiled from Move bytecode v7
}

