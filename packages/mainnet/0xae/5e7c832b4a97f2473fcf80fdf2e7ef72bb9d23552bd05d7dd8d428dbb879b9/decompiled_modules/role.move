module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::role {
    struct Signer has copy, drop, store {
        roles: vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>,
    }

    struct Role has copy, drop, store {
        name: 0x1::ascii::String,
        signer_ref: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::Reference,
        permission_ref: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::Reference,
    }

    struct RoleBook has store {
        next_id: u64,
        signers: 0x2::table::Table<address, Signer>,
        roles: 0x2::table::Table<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, Role>,
    }

    struct GrantRoleEvent has copy, drop {
        address: address,
        role_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID,
    }

    struct RevokeRoleEvent has copy, drop {
        address: address,
        role_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID,
    }

    struct CreateRoleEvent has copy, drop {
        role_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID,
        name: 0x1::ascii::String,
    }

    struct DeleteRoleEvent has copy, drop {
        role_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID,
        name: 0x1::ascii::String,
    }

    struct RenameRoleEvent has copy, drop {
        role_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID,
        name: 0x1::ascii::String,
    }

    struct CreateSignerEvent has copy, drop {
        address: address,
    }

    fun create_admin_role(arg0: &mut RoleBook) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID {
        let v0 = create_role(arg0, 0x1::ascii::string(b"ADMIN_ROLE"));
        assert!(is_admin_role(v0), 1011);
        v0
    }

    fun create_role(arg0: &mut RoleBook, arg1: 0x1::ascii::String) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID {
        arg0.next_id = arg0.next_id + 1;
        let v0 = &mut arg0.roles;
        create_role_unsafe(v0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::new_role_id(arg0.next_id), arg1)
    }

    fun create_role_unsafe(arg0: &mut 0x2::table::Table<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, Role>, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, arg2: 0x1::ascii::String) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::validate_name(&arg2);
        let v0 = Role{
            name           : arg2,
            signer_ref     : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::new(),
            permission_ref : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::new(),
        };
        0x2::table::add<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, Role>(arg0, arg1, v0);
        let v1 = CreateRoleEvent{
            role_id : arg1,
            name    : arg2,
        };
        0x2::event::emit<CreateRoleEvent>(v1);
        arg1
    }

    fun create_signer(arg0: &mut RoleBook, arg1: address) : Signer {
        let v0 = Signer{roles: 0x1::vector::empty<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>()};
        0x2::table::add<address, Signer>(&mut arg0.signers, arg1, v0);
        let v1 = CreateSignerEvent{address: arg1};
        0x2::event::emit<CreateSignerEvent>(v1);
        v0
    }

    fun create_void_role(arg0: &mut RoleBook) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID {
        let v0 = &mut arg0.roles;
        create_role_unsafe(v0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::new_role_id(18446744073709551615), 0x1::ascii::string(b"VOID_ROLE"))
    }

    fun create_void_signer(arg0: &mut RoleBook) : Signer {
        create_signer(arg0, @0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
    }

    public fun decrease_permission_ref(arg0: &mut RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) {
        let v0 = &mut arg0.roles;
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::decrease(&mut get_role_mut_unsafe(v0, arg1).permission_ref);
    }

    fun delete_role(arg0: &mut RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) {
        assert!(!is_reserved_role(arg1), 1010);
        assert!(exists_role(arg0, arg1), 1000);
        let v0 = 0x2::table::remove<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, Role>(&mut arg0.roles, arg1);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::is_zero(&v0.signer_ref), 1009);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::is_zero(&v0.permission_ref), 1009);
        let v1 = DeleteRoleEvent{
            role_id : arg1,
            name    : v0.name,
        };
        0x2::event::emit<DeleteRoleEvent>(v1);
    }

    fun delete_signer(arg0: &mut RoleBook, arg1: address) : Signer {
        assert!(!is_void_signer(arg1), 1010);
        assert!(exists_signer(arg0, arg1), 1001);
        let v0 = get_signer_mut(arg0, arg1);
        assert!(0x1::vector::is_empty<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>(&v0.roles), 1002);
        0x2::table::remove<address, Signer>(&mut arg0.signers, arg1)
    }

    public(friend) fun execute(arg0: &mut RoleBook, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, arg2: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_admin_operation(arg1), 1007);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_create_role(v0)) {
            execute_create_role(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_create_role(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)), arg2);
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_create_signer(v0)) {
            execute_create_signer(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_create_signer(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_grant_role(v0)) {
            execute_grant_role(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_grant_role(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)), arg2);
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_revoke_role(v0)) {
            execute_revoke_role(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_revoke_role(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)), arg2);
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_delete_role(v0)) {
            execute_delete_role(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_delete_role(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)), arg2);
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_delete_signer(v0)) {
            execute_delete_signer(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_delete_signer(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        } else {
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_op_rename_role(v0), 1008);
            execute_rename_role(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::deserialize_rename_role(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)), arg2);
        };
    }

    fun execute_create_role(arg0: &mut RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::CreateRole, arg2: &mut 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::push_role_id(arg2, create_role(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::create_role_destruct(arg1)));
    }

    fun execute_create_signer(arg0: &mut RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::CreateSigner) {
        create_signer(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::create_signer_destruct(arg1));
    }

    fun execute_delete_role(arg0: &mut RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::DeleteRole, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::delete_role_destruct(arg1);
        delete_role(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::get_role_id(arg2, &v0));
    }

    fun execute_delete_signer(arg0: &mut RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::DeleteSigner) {
        delete_signer(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::delete_signer_destruct(arg1));
    }

    fun execute_grant_role(arg0: &mut RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::GrantRole, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        let (v0, v1) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::grant_role_destruct(arg1);
        let v2 = v0;
        grant_role_to_signer(arg0, v1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::get_role_id(arg2, &v2));
    }

    fun execute_rename_role(arg0: &mut RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::RenameRole, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        let (v0, v1) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::rename_role_destruct(arg1);
        let v2 = v0;
        rename_role(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::get_role_id(arg2, &v2), v1);
    }

    fun execute_revoke_role(arg0: &mut RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::RevokeRole, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        let (v0, v1) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::revoke_role_destruct(arg1);
        let v2 = v0;
        revoke_role_from_signer(arg0, v1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::get_role_id(arg2, &v2));
    }

    public fun exists_role(arg0: &RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) : bool {
        0x2::table::contains<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, Role>(&arg0.roles, arg1)
    }

    public fun exists_signer(arg0: &RoleBook, arg1: address) : bool {
        0x2::table::contains<address, Signer>(&arg0.signers, arg1)
    }

    public fun get_admin_role() : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::new_role_id(0)
    }

    public fun get_role(arg0: &RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) : &Role {
        0x2::table::borrow<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, Role>(&arg0.roles, arg1)
    }

    fun get_role_mut(arg0: &mut RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) : &mut Role {
        assert!(!is_void_role(arg1), 1010);
        let v0 = &mut arg0.roles;
        get_role_mut_unsafe(v0, arg1)
    }

    fun get_role_mut_unsafe(arg0: &mut 0x2::table::Table<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, Role>, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) : &mut Role {
        0x2::table::borrow_mut<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, Role>(arg0, arg1)
    }

    public fun get_signer(arg0: &RoleBook, arg1: address) : &Signer {
        0x2::table::borrow<address, Signer>(&arg0.signers, arg1)
    }

    public fun get_signer_amount_by_role(arg0: &RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) : u64 {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::ref(&get_role(arg0, arg1).signer_ref)
    }

    fun get_signer_mut(arg0: &mut RoleBook, arg1: address) : &mut Signer {
        assert!(!is_void_signer(arg1), 1010);
        let v0 = &mut arg0.signers;
        get_signer_mut_unsafe(v0, arg1)
    }

    fun get_signer_mut_unsafe(arg0: &mut 0x2::table::Table<address, Signer>, arg1: address) : &mut Signer {
        0x2::table::borrow_mut<address, Signer>(arg0, arg1)
    }

    public fun get_void_role() : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::new_role_id(18446744073709551615)
    }

    fun grant_role_to_signer(arg0: &mut RoleBook, arg1: address, arg2: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) {
        assert!(!is_void_signer(arg1) && !is_void_role(arg2), 1010);
        grant_role_to_signer_unsafe(arg0, arg1, arg2);
    }

    fun grant_role_to_signer_unsafe(arg0: &mut RoleBook, arg1: address, arg2: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) {
        assert!(exists_role(arg0, arg2), 1000);
        assert!(exists_signer(arg0, arg1), 1001);
        let v0 = &mut arg0.signers;
        let v1 = get_signer_mut_unsafe(v0, arg1);
        assert!(!has_role(v1, arg2), 1002);
        0x1::vector::push_back<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>(&mut v1.roles, arg2);
        assert!(0x1::vector::length<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>(&v1.roles) <= 128, 1013);
        let v2 = GrantRoleEvent{
            address : arg1,
            role_id : arg2,
        };
        0x2::event::emit<GrantRoleEvent>(v2);
        let v3 = &mut arg0.roles;
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::increase(&mut get_role_mut_unsafe(v3, arg2).signer_ref);
    }

    fun grant_void_role_to_void_signer(arg0: &mut RoleBook) {
        let v0 = get_void_role();
        grant_role_to_signer_unsafe(arg0, @0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff, v0);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::ref(&get_role(arg0, v0).signer_ref) == 1, 1012);
    }

    public fun has_role(arg0: &Signer, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) : bool {
        0x1::vector::contains<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>(&arg0.roles, &arg1)
    }

    public fun increase_permission_ref(arg0: &mut RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) {
        let v0 = &mut arg0.roles;
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::increase(&mut get_role_mut_unsafe(v0, arg1).permission_ref);
    }

    fun init_admin_role(arg0: &mut RoleBook, arg1: address) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID {
        let v0 = create_role(arg0, 0x1::ascii::string(b"ADMIN_ROLE"));
        assert!(is_admin_role(v0), 1011);
        create_signer(arg0, arg1);
        grant_role_to_signer(arg0, arg1, v0);
        v0
    }

    fun init_void_role(arg0: &mut RoleBook) {
        create_void_role(arg0);
        create_void_signer(arg0);
        grant_void_role_to_void_signer(arg0);
    }

    fun is_admin_role(arg0: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) : bool {
        arg0 == 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::new_role_id(0)
    }

    fun is_reserved_role(arg0: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) : bool {
        is_void_role(arg0) || is_admin_role(arg0)
    }

    public fun is_void_role(arg0: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) : bool {
        arg0 == 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::new_role_id(18446744073709551615)
    }

    fun is_void_signer(arg0: address) : bool {
        arg0 == @0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    }

    public fun new_role_book(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : RoleBook {
        let v0 = RoleBook{
            next_id : 0,
            signers : 0x2::table::new<address, Signer>(arg1),
            roles   : 0x2::table::new<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, Role>(arg1),
        };
        let v1 = &mut v0;
        init_void_role(v1);
        let v2 = &mut v0;
        init_admin_role(v2, arg0);
        v0
    }

    fun rename_role(arg0: &mut RoleBook, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID, arg2: 0x1::ascii::String) {
        assert!(!is_reserved_role(arg1), 1010);
        assert!(exists_role(arg0, arg1), 1000);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::validate_name(&arg2);
        get_role_mut(arg0, arg1).name = arg2;
        let v0 = RenameRoleEvent{
            role_id : arg1,
            name    : arg2,
        };
        0x2::event::emit<RenameRoleEvent>(v0);
    }

    fun revoke_role_from_signer(arg0: &mut RoleBook, arg1: address, arg2: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID) {
        assert!(!is_void_role(arg2) && !is_void_signer(arg1), 1010);
        let v0 = get_signer_mut(arg0, arg1);
        assert!(has_role(v0, arg2), 1003);
        let (_, v2) = 0x1::vector::index_of<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>(&v0.roles, &arg2);
        0x1::vector::swap_remove<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>(&mut v0.roles, v2);
        let v3 = RevokeRoleEvent{
            address : arg1,
            role_id : arg2,
        };
        0x2::event::emit<RevokeRoleEvent>(v3);
        let v4 = get_role_mut(arg0, arg2);
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::decrease(&mut v4.signer_ref);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::is_zero(&v4.signer_ref)) {
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference::is_zero(&v4.permission_ref), 1009);
        };
    }

    // decompiled from Move bytecode v6
}

