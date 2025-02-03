module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::permission {
    struct Permission has copy, drop, store {
        name: 0x1::ascii::String,
        proposer: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID,
        approver: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID,
        threshold: u64,
        refs: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::Reference,
    }

    struct PermissionBook has store {
        next_id: u64,
        all: 0x2::table::Table<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, Permission>,
        timelock_config: TimelockConfig,
        admin_policy: 0x2::table::Table<0x1::ascii::String, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>,
        coin_policy: 0x2::table::Table<0x1::ascii::String, CoinPermissions>,
        object_policy: 0x2::table::Table<0x2::object::ID, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>,
    }

    struct CoinPermissions has copy, drop, store {
        stages: vector<StagePermission>,
    }

    struct StagePermission has copy, drop, store {
        stage: u64,
        permission_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID,
    }

    struct TimelockConfig has drop, store {
        timelock_duration: u64,
        execution_duration: u64,
    }

    struct CreatePermissionEvent has copy, drop {
        id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID,
        permission: Permission,
    }

    struct DeletePermissionEvent has copy, drop {
        id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID,
    }

    struct UpdatePermissionEvent has copy, drop {
        id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID,
        permission: Permission,
    }

    struct RecoveryPermissionEvent has copy, drop {
        id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID,
        permission: Permission,
    }

    struct UpdateAdminPolicyEvent has copy, drop {
        policy: 0x1::ascii::String,
        permission_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID,
    }

    struct DeleteAdminPolicyEvent has copy, drop {
        policy: 0x1::ascii::String,
    }

    struct UpdateCoinPolicyEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        stages: vector<u64>,
        permission: vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>,
    }

    struct DeleteCoinPolicyEvent has copy, drop {
        coin_type: 0x1::ascii::String,
    }

    struct UpdateObjectPermissionEvent has copy, drop {
        object_id: 0x2::object::ID,
        permission: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID,
    }

    struct UpdateTimelockConfigEvent has copy, drop {
        timelock_duration: u64,
        execution_duration: u64,
    }

    struct DeleteObjectPermissionEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    fun create_default_permission(arg0: &mut PermissionBook, arg1: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg2: u64, arg3: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, arg4: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID {
        let v0 = create_permission(arg0, arg1, 0x1::ascii::string(b"DEFAULT"), arg2, arg3, arg4);
        assert!(is_default_permission(v0), 1017);
        v0
    }

    fun create_forbidden_permission(arg0: &mut PermissionBook, arg1: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::new_permission_id(18446744073709551615);
        let v1 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::get_void_role();
        let v2 = &mut arg0.all;
        create_permission_unsafe(v2, arg1, v0, 0x1::ascii::string(b"FORBIDDEN"), 18446744073709551615, v1, v1);
        v0
    }

    fun create_permission(arg0: &mut PermissionBook, arg1: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg2: 0x1::ascii::String, arg3: u64, arg4: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, arg5: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::new_permission_id(arg0.next_id);
        arg0.next_id = arg0.next_id + 1;
        let v1 = &mut arg0.all;
        let v2 = create_permission_unsafe(v1, arg1, v0, arg2, arg3, arg4, arg5);
        validate_permission(arg1, &v2);
        v0
    }

    fun create_permission_unsafe(arg0: &mut 0x2::table::Table<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, Permission>, arg1: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg2: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, arg3: 0x1::ascii::String, arg4: u64, arg5: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, arg6: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) : Permission {
        assert!(!0x2::table::contains<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, Permission>(arg0, arg2), 1014);
        let v0 = Permission{
            name      : arg3,
            proposer  : arg5,
            approver  : arg6,
            threshold : arg4,
            refs      : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::new(),
        };
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::increase_permission_ref(arg1, v0.proposer);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::increase_permission_ref(arg1, v0.approver);
        0x2::table::add<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, Permission>(arg0, arg2, v0);
        let v1 = CreatePermissionEvent{
            id         : arg2,
            permission : v0,
        };
        0x2::event::emit<CreatePermissionEvent>(v1);
        v0
    }

    public(friend) fun create_reserved_permission(arg0: &mut PermissionBook, arg1: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook) {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::get_admin_role();
        create_default_permission(arg0, arg1, 1, v0, v0);
        create_forbidden_permission(arg0, arg1);
    }

    fun decrease_coin_permission_ref(arg0: &mut PermissionBook, arg1: &CoinPermissions) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<StagePermission>(&arg1.stages)) {
            decrease_permission_ref(arg0, 0x1::vector::borrow<StagePermission>(&arg1.stages, v0).permission_id);
            v0 = v0 + 1;
        };
    }

    fun decrease_permission_ref(arg0: &mut PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) {
        let v0 = &mut arg0.all;
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::decrease(&mut get_permission_mut_unsafe(v0, arg1).refs);
    }

    fun delete_admin_policy(arg0: &mut PermissionBook, arg1: 0x1::ascii::String) {
        assert!(0x2::table::contains<0x1::ascii::String, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.admin_policy, arg1), 1030);
        let v0 = 0x2::table::remove<0x1::ascii::String, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&mut arg0.admin_policy, arg1);
        decrease_permission_ref(arg0, v0);
        let v1 = DeleteAdminPolicyEvent{policy: arg1};
        0x2::event::emit<DeleteAdminPolicyEvent>(v1);
    }

    fun delete_coin_policy(arg0: &mut PermissionBook, arg1: 0x1::ascii::String) {
        let v0 = 0x2::table::remove<0x1::ascii::String, CoinPermissions>(&mut arg0.coin_policy, arg1);
        decrease_coin_permission_ref(arg0, &v0);
        let v1 = DeleteCoinPolicyEvent{coin_type: arg1};
        0x2::event::emit<DeleteCoinPolicyEvent>(v1);
    }

    fun delete_object_policy(arg0: &mut PermissionBook, arg1: 0x2::object::ID) {
        let v0 = 0x2::table::remove<0x2::object::ID, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&mut arg0.object_policy, arg1);
        decrease_permission_ref(arg0, v0);
        let v1 = DeleteObjectPermissionEvent{object_id: arg1};
        0x2::event::emit<DeleteObjectPermissionEvent>(v1);
    }

    fun delete_permission(arg0: &mut PermissionBook, arg1: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg2: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) {
        assert!(!is_reserved_permission(arg2), 1015);
        let v0 = 0x2::table::borrow_mut<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, Permission>(&mut arg0.all, arg2);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::decrease_permission_ref(arg1, v0.proposer);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::decrease_permission_ref(arg1, v0.approver);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::is_zero(&v0.refs), 1011);
        0x2::table::remove<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, Permission>(&mut arg0.all, arg2);
        let v1 = DeletePermissionEvent{id: arg2};
        0x2::event::emit<DeletePermissionEvent>(v1);
    }

    fun execute_create_permission(arg0: &mut PermissionBook, arg1: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg2: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::CreatePermission, arg3: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        let (v0, v1, v2, v3) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::create_permission_destruct(arg2);
        let v4 = v3;
        let v5 = v2;
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::push_permission_id(arg3, create_permission(arg0, arg1, v0, v1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::get_role_id(arg3, &v5), 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::get_role_id(arg3, &v4)));
    }

    fun execute_delete_admin_policy(arg0: &mut PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::DeleteAdminPolicy) {
        delete_admin_policy(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::delete_admin_policy_destruct(arg1));
    }

    fun execute_delete_coin_policy(arg0: &mut PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::DeleteCoinPolicy) {
        delete_coin_policy(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::delete_coin_policy_destruct(arg1));
    }

    fun execute_delete_object_policy(arg0: &mut PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::DeleteObjectPolicy) {
        delete_object_policy(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::delete_object_policy_destruct(arg1));
    }

    fun execute_delete_permission(arg0: &mut PermissionBook, arg1: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg2: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::DeletePermission, arg3: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::delete_permission_destruct(arg2);
        delete_permission(arg0, arg1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::get_permission_id(arg3, &v0));
    }

    public(friend) fun execute_permission_operation(arg0: &mut PermissionBook, arg1: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, arg3: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_admin_operation(arg2), 1004);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg2);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_create_permission(v0)) {
            execute_create_permission(arg0, arg1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_create_permission(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg2)), arg3);
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_update_permission(v0)) {
            execute_update_permission(arg0, arg1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_update_permission(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg2)), arg3);
        } else {
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_delete_permission(v0), 1006);
            execute_delete_permission(arg0, arg1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_delete_permission(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg2)), arg3);
        };
    }

    fun execute_permission_recovery(arg0: &mut PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::recovery_operation::PermissionRecovery, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::in_timelock_mode(arg2), 1031);
        recover_permission(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::recovery_operation::permission_recovery_destruct(arg1));
    }

    public(friend) fun execute_policy_operation(arg0: &mut PermissionBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, arg2: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_admin_operation(arg1), 1004);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_update_admin_policy(v0)) {
            execute_update_admin_policy(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_update_admin_policy(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)), arg2);
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_update_coin_policy(v0)) {
            execute_update_coin_policy(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_update_coin_policy(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)), arg2);
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_update_object_policy(v0)) {
            execute_update_object_policy(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_update_object_policy(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)), arg2);
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_delete_admin_policy(v0)) {
            execute_delete_admin_policy(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_delete_admin_policy(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_delete_coin_policy(v0)) {
            execute_delete_coin_policy(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_delete_coin_policy(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        } else {
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_delete_object_policy(v0), 1022);
            execute_delete_object_policy(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_delete_object_policy(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        };
    }

    public(friend) fun execute_recovery_operation(arg0: &mut PermissionBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, arg2: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::in_timelock_mode(arg2), 1031);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_recovery_operation(arg1), 1019);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::recovery_operation::is_op_permission_recovery(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1)), 1033);
        execute_permission_recovery(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::recovery_operation::deserialize_permission_recovery(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)), arg2);
    }

    public(friend) fun execute_timelock_config_operation(arg0: &mut PermissionBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, arg2: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_admin_operation(arg1), 1004);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::in_seq_mode(arg2), 1032);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_update_timelock_config(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1)), 1035);
        execute_update_timelock_config(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_update_timelock_config(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
    }

    fun execute_update_admin_policy(arg0: &mut PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::UpdateAdminPolicy, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        let (v0, v1) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::update_admin_policy_destruct(arg1);
        let v2 = v1;
        update_admin_policy(arg0, v0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::get_permission_id(arg2, &v2));
    }

    fun execute_update_coin_policy(arg0: &mut PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::UpdateCoinPolicy, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        let (v0, v1, v2) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::update_coin_policy_destruct(arg1);
        let v3 = v2;
        update_coin_policy(arg0, v0, v1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::get_permission_id_vec(arg2, &v3));
    }

    fun execute_update_object_policy(arg0: &mut PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::UpdateObjectPolicy, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        let (v0, v1) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::update_object_policy_destruct(arg1);
        let v2 = v1;
        update_object_policy(arg0, v0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::get_permission_id(arg2, &v2));
    }

    fun execute_update_permission(arg0: &mut PermissionBook, arg1: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg2: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::UpdatePermission, arg3: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        let (v0, v1, v2, v3, v4) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::update_permission_destruct(arg2);
        let v5 = v4;
        let v6 = v3;
        let v7 = v0;
        update_permission(arg0, arg1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::get_permission_id(arg3, &v7), v1, v2, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::get_role_id(arg3, &v6), 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::get_role_id(arg3, &v5));
    }

    fun execute_update_timelock_config(arg0: &mut PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::UpdateTimelockConfig) {
        let (v0, v1) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::update_timelock_config_destruct(arg1);
        update_timelock_config(arg0, v0, v1);
    }

    fun exists_permission(arg0: &PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) : bool {
        0x2::table::contains<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, Permission>(&arg0.all, arg1)
    }

    fun get_admin_permission(arg0: &PermissionBook, arg1: 0x1::ascii::String) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, &Permission) {
        let v0 = if (0x2::table::contains<0x1::ascii::String, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.admin_policy, arg1)) {
            0x2::table::borrow<0x1::ascii::String, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.admin_policy, arg1)
        } else {
            0x2::table::borrow<0x1::ascii::String, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.admin_policy, 0x1::ascii::string(b"DEFAULT"))
        };
        (*v0, get_permission(arg0, *v0))
    }

    fun get_admin_permission_by_operation(arg0: &PermissionBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, &Permission) {
        get_admin_permission(arg0, get_admin_policy_name_by_operation(arg1))
    }

    fun get_admin_policy_name_by_operation(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation) : 0x1::ascii::String {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg0);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_role_range_operation(v0)) {
            0x1::ascii::string(b"ROLE_ADMIN")
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_permission_range_operation(v0) || 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_policy_range_operation(v0)) {
            0x1::ascii::string(b"PERMISSION_ADMIN")
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_allowlist_range_operation(v0)) {
            0x1::ascii::string(b"ALLOWLIST_ADMIN")
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_spending_limit_range_operation(v0)) {
            0x1::ascii::string(b"SPENDING_LIMIT_ADMIN")
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_meta_info_range_operation(v0)) {
            0x1::ascii::string(b"META_INFO_ADMIN")
        } else {
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_timelock_config_range_opertaion(v0), 1012);
            0x1::ascii::string(b"TIMELOCK_CONFIG")
        }
    }

    fun get_coin_permission(arg0: &PermissionBook, arg1: 0x1::ascii::String, arg2: u64) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, &Permission) {
        let v0 = if (0x2::table::contains<0x1::ascii::String, CoinPermissions>(&arg0.coin_policy, arg1)) {
            0x2::table::borrow<0x1::ascii::String, CoinPermissions>(&arg0.coin_policy, arg1)
        } else {
            0x2::table::borrow<0x1::ascii::String, CoinPermissions>(&arg0.coin_policy, 0x1::ascii::string(b"DEFAULT"))
        };
        let v1 = &v0.stages;
        let v2 = 0;
        while (v2 < 0x1::vector::length<StagePermission>(v1)) {
            let v3 = 0x1::vector::borrow<StagePermission>(v1, v2);
            if (arg2 <= v3.stage) {
                return (v3.permission_id, get_permission(arg0, v3.permission_id))
            };
            v2 = v2 + 1;
        };
        abort 1013
    }

    fun get_coin_permission_by_operation(arg0: &PermissionBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, &Permission) {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1);
        let (v1, v2) = if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::is_coin_transfer(v0)) {
            let (v3, _, v5) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::coin_transfer_destruct(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::deserialize_coin_transfer(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
            (v3, v5)
        } else {
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::is_coin_transfer_to_maven_vault(v0), 1009);
            let (v6, _, _, v9) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::coin_transfer_to_maven_vault_destruct(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::deserialize_coin_transfer_to_maven_vault(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
            (v6, v9)
        };
        get_coin_permission(arg0, v1, v2)
    }

    fun get_object_permission(arg0: &PermissionBook, arg1: 0x2::object::ID) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, &Permission) {
        let v0 = if (0x2::table::contains<0x2::object::ID, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.object_policy, arg1)) {
            0x2::table::borrow<0x2::object::ID, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.object_policy, arg1)
        } else {
            0x2::table::borrow<0x2::object::ID, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.object_policy, 0x2::object::id_from_address(@0x44454641554c54))
        };
        (*v0, get_permission(arg0, *v0))
    }

    fun get_object_permission_by_operation(arg0: &PermissionBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, &Permission) {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1);
        let v1 = if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::is_object_transfer(v0)) {
            let (v2, _) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::object_transfer_destruct(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::deserialize_object_transfer(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
            v2
        } else {
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::is_object_transfer_to_maven_vault(v0), 1010);
            let (v4, _, _) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::object_transfer_to_maven_vault_destruct(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::deserialize_object_transfer_to_maven_vault(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
            v4
        };
        get_object_permission(arg0, v1)
    }

    fun get_permission(arg0: &PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) : &Permission {
        0x2::table::borrow<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, Permission>(&arg0.all, arg1)
    }

    public fun get_permission_by_operation(arg0: &PermissionBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, &Permission) {
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::in_seq_mode(arg2)) {
            get_permission_by_operation_seq_mode(arg0, arg1)
        } else {
            get_permission_by_operation_timelock_mode(arg0, arg1)
        }
    }

    fun get_permission_by_operation_seq_mode(arg0: &PermissionBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, &Permission) {
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_admin_operation(arg1)) {
            get_admin_permission_by_operation(arg0, arg1)
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_coin_operation(arg1)) {
            get_coin_permission_by_operation(arg0, arg1)
        } else {
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_object_operation(arg1), 1005);
            get_object_permission_by_operation(arg0, arg1)
        }
    }

    fun get_permission_by_operation_timelock_mode(arg0: &PermissionBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, &Permission) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::can_be_timelock_operation(arg1), 1005);
        get_timelock_permission_by_operation(arg0, arg1)
    }

    fun get_permission_mut(arg0: &mut PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) : &mut Permission {
        assert!(!is_forbidden_permission(arg1), 1016);
        let v0 = &mut arg0.all;
        get_permission_mut_unsafe(v0, arg1)
    }

    fun get_permission_mut_unsafe(arg0: &mut 0x2::table::Table<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, Permission>, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) : &mut Permission {
        0x2::table::borrow_mut<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, Permission>(arg0, arg1)
    }

    fun get_recovery_permission(arg0: &PermissionBook) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, &Permission) {
        let v0 = 0x1::ascii::string(b"RECOVERY_ADMIN");
        let v1 = if (0x2::table::contains<0x1::ascii::String, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.admin_policy, v0)) {
            0x2::table::borrow<0x1::ascii::String, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.admin_policy, v0)
        } else {
            let v2 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::new_permission_id(18446744073709551615);
            &v2
        };
        (*v1, get_permission(arg0, *v1))
    }

    fun get_timelock_admin_policy_name_by_operation(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation) : 0x1::ascii::String {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg0);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_role_range_operation(v0)) {
            0x1::ascii::string(b"ROLE_ADMIN")
        } else {
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_permission_range_operation(v0) || 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_policy_range_operation(v0), 1012);
            0x1::ascii::string(b"PERMISSION_ADMIN")
        }
    }

    public fun get_timelock_config(arg0: &PermissionBook) : (u64, u64) {
        (arg0.timelock_config.timelock_duration, arg0.timelock_config.execution_duration)
    }

    fun get_timelock_permission_by_operation(arg0: &PermissionBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, &Permission) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::can_be_timelock_operation(arg1), 1023);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_recovery_operation(arg1)) {
            return get_recovery_permission(arg0)
        };
        get_admin_permission(arg0, get_timelock_admin_policy_name_by_operation(arg1))
    }

    public fun has_approve_permission(arg0: &Permission, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::Signer) : bool {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::has_role(arg1, arg0.approver)
    }

    public fun has_enough_weight(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg1: &Permission, arg2: u64) : bool {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::get_signer_amount_by_role(arg0, arg1.approver);
        assert!(v0 > 0, 1036);
        arg2 >= 0x2::math::min(arg1.threshold, v0)
    }

    public fun has_propose_permission(arg0: &Permission, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::Signer) : bool {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::has_role(arg1, arg0.proposer)
    }

    fun increase_coin_permission_ref(arg0: &mut PermissionBook, arg1: &CoinPermissions) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<StagePermission>(&arg1.stages)) {
            increase_permission_ref(arg0, 0x1::vector::borrow<StagePermission>(&arg1.stages, v0).permission_id);
            v0 = v0 + 1;
        };
    }

    fun increase_permission_ref(arg0: &mut PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) {
        let v0 = &mut arg0.all;
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::increase(&mut get_permission_mut_unsafe(v0, arg1).refs);
    }

    public(friend) fun init_default_policy(arg0: &mut PermissionBook) {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::new_permission_id(0);
        update_admin_policy(arg0, 0x1::ascii::string(b"DEFAULT"), v0);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, 18446744073709551615);
        let v2 = 0x1::vector::empty<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>();
        0x1::vector::push_back<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&mut v2, v0);
        update_coin_policy(arg0, 0x1::ascii::string(b"DEFAULT"), v1, v2);
        update_object_policy(arg0, 0x2::object::id_from_address(@0x44454641554c54), v0);
    }

    fun is_default_permission(arg0: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) : bool {
        arg0 == 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::new_permission_id(0)
    }

    fun is_forbidden_permission(arg0: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) : bool {
        arg0 == 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::new_permission_id(18446744073709551615)
    }

    fun is_reserved_permission(arg0: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) : bool {
        is_forbidden_permission(arg0) || is_default_permission(arg0)
    }

    public fun new_permission_book(arg0: &mut 0x2::tx_context::TxContext) : PermissionBook {
        let v0 = TimelockConfig{
            timelock_duration  : 3153600000000,
            execution_duration : 3153600000000,
        };
        PermissionBook{
            next_id         : 0,
            all             : 0x2::table::new<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, Permission>(arg0),
            timelock_config : v0,
            admin_policy    : 0x2::table::new<0x1::ascii::String, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(arg0),
            coin_policy     : 0x2::table::new<0x1::ascii::String, CoinPermissions>(arg0),
            object_policy   : 0x2::table::new<0x2::object::ID, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(arg0),
        }
    }

    fun recover_permission(arg0: &mut PermissionBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) {
        assert!(!is_forbidden_permission(arg1), 1016);
        let v0 = get_permission_mut(arg0, arg1);
        v0.threshold = v0.threshold - 1;
        assert!(v0.threshold > 0, 1007);
        let v1 = RecoveryPermissionEvent{
            id         : arg1,
            permission : *v0,
        };
        0x2::event::emit<RecoveryPermissionEvent>(v1);
    }

    fun to_stage_permissions(arg0: &PermissionBook, arg1: &vector<u64>, arg2: &vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>) : vector<StagePermission> {
        assert!(0x1::vector::length<u64>(arg1) == 0x1::vector::length<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(arg2), 1024);
        assert!(0x1::vector::length<u64>(arg1) <= 32, 1025);
        let v0 = 0x1::vector::empty<StagePermission>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg1)) {
            let v2 = *0x1::vector::borrow<u64>(arg1, v1);
            assert!(v2 > 0, 1003);
            let v3 = *0x1::vector::borrow<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(arg2, v1);
            assert!(exists_permission(arg0, v3), 1000);
            let v4 = StagePermission{
                stage         : v2,
                permission_id : v3,
            };
            0x1::vector::push_back<StagePermission>(&mut v0, v4);
            v1 = v1 + 1;
        };
        v0
    }

    fun update_admin_policy(arg0: &mut PermissionBook, arg1: 0x1::ascii::String, arg2: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) {
        validate_admin_policy_name(arg1);
        assert!(exists_permission(arg0, arg2), 1000);
        assert!(!is_forbidden_permission(arg2), 1029);
        if (0x2::table::contains<0x1::ascii::String, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.admin_policy, arg1)) {
            let v0 = *0x2::table::borrow<0x1::ascii::String, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.admin_policy, arg1);
            decrease_permission_ref(arg0, v0);
        };
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::update_table<0x1::ascii::String, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&mut arg0.admin_policy, arg1, arg2);
        increase_permission_ref(arg0, arg2);
        let v1 = UpdateAdminPolicyEvent{
            policy        : arg1,
            permission_id : arg2,
        };
        0x2::event::emit<UpdateAdminPolicyEvent>(v1);
    }

    fun update_coin_policy(arg0: &mut PermissionBook, arg1: 0x1::ascii::String, arg2: vector<u64>, arg3: vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>) {
        if (!(arg1 == 0x1::ascii::string(b"DEFAULT"))) {
            0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::validate_coin_type(&arg1);
        };
        if (0x2::table::contains<0x1::ascii::String, CoinPermissions>(&arg0.coin_policy, arg1)) {
            let v0 = *0x2::table::borrow<0x1::ascii::String, CoinPermissions>(&arg0.coin_policy, arg1);
            decrease_coin_permission_ref(arg0, &v0);
        };
        let v1 = CoinPermissions{stages: to_stage_permissions(arg0, &arg2, &arg3)};
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::update_table<0x1::ascii::String, CoinPermissions>(&mut arg0.coin_policy, arg1, v1);
        increase_coin_permission_ref(arg0, &v1);
        let v2 = UpdateCoinPolicyEvent{
            coin_type  : arg1,
            stages     : arg2,
            permission : arg3,
        };
        0x2::event::emit<UpdateCoinPolicyEvent>(v2);
    }

    fun update_object_policy(arg0: &mut PermissionBook, arg1: 0x2::object::ID, arg2: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID) {
        assert!(exists_permission(arg0, arg2), 1000);
        if (0x2::table::contains<0x2::object::ID, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.object_policy, arg1)) {
            let v0 = *0x2::table::borrow<0x2::object::ID, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&arg0.object_policy, arg1);
            decrease_permission_ref(arg0, v0);
        };
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::update_table<0x2::object::ID, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>(&mut arg0.object_policy, arg1, arg2);
        increase_permission_ref(arg0, arg2);
        let v1 = UpdateObjectPermissionEvent{
            object_id  : arg1,
            permission : arg2,
        };
        0x2::event::emit<UpdateObjectPermissionEvent>(v1);
    }

    fun update_permission(arg0: &mut PermissionBook, arg1: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg2: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, arg3: 0x1::ascii::String, arg4: u64, arg5: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, arg6: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) {
        assert!(!is_forbidden_permission(arg2), 1016);
        if (is_default_permission(arg2)) {
            assert!(arg3 == 0x1::ascii::string(b"DEFAULT"), 1021);
        };
        let v0 = 0x2::table::borrow_mut<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID, Permission>(&mut arg0.all, arg2);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::decrease_permission_ref(arg1, v0.proposer);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::decrease_permission_ref(arg1, v0.approver);
        v0.name = arg3;
        v0.threshold = arg4;
        v0.proposer = arg5;
        v0.approver = arg6;
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::increase_permission_ref(arg1, v0.proposer);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::increase_permission_ref(arg1, v0.approver);
        validate_permission(arg1, v0);
        let v1 = UpdatePermissionEvent{
            id         : arg2,
            permission : *v0,
        };
        0x2::event::emit<UpdatePermissionEvent>(v1);
    }

    fun update_timelock_config(arg0: &mut PermissionBook, arg1: u64, arg2: u64) {
        assert!(arg1 <= 3153600000000 && arg2 <= 3153600000000, 1027);
        assert!(arg2 >= arg1, 1026);
        arg0.timelock_config.timelock_duration = arg1;
        arg0.timelock_config.execution_duration = arg2;
        let v0 = UpdateTimelockConfigEvent{
            timelock_duration  : arg1,
            execution_duration : arg2,
        };
        0x2::event::emit<UpdateTimelockConfigEvent>(v0);
    }

    fun validate_admin_policy_name(arg0: 0x1::ascii::String) {
        assert!(arg0 == 0x1::ascii::string(b"DEFAULT") || arg0 == 0x1::ascii::string(b"ROLE_ADMIN") || arg0 == 0x1::ascii::string(b"PERMISSION_ADMIN") || arg0 == 0x1::ascii::string(b"ALLOWLIST_ADMIN") || arg0 == 0x1::ascii::string(b"SPENDING_LIMIT_ADMIN") || arg0 == 0x1::ascii::string(b"META_INFO_ADMIN") || arg0 == 0x1::ascii::string(b"TIMELOCK_CONFIG") || arg0 == 0x1::ascii::string(b"RECOVERY_ADMIN"), 1020);
    }

    fun validate_permission(arg0: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::RoleBook, arg1: &Permission) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::exists_role(arg0, arg1.proposer), 1001);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::exists_role(arg0, arg1.approver), 1002);
        assert!(!0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::is_void_role(arg1.proposer), 1018);
        assert!(!0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::is_void_role(arg1.approver), 1018);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::validate_name(&arg1.name);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::get_signer_amount_by_role(arg0, arg1.proposer) > 0, 1028);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role::get_signer_amount_by_role(arg0, arg1.approver);
        assert!(v0 > 0, 1034);
        assert!(arg1.threshold <= 0x2::math::min(v0, 256), 1008);
        assert!(arg1.threshold > 0, 1007);
    }

    // decompiled from Move bytecode v6
}

