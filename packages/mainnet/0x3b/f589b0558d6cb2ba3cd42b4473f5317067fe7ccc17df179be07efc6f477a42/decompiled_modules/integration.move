module 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::integration {
    public entry fun accept_invite_and_update_registry(arg0: 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::DatabaseInvite, arg1: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database, arg2: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::DatabaseRegistry, arg3: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::InviteRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _, v4, _, _, _) = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::get_invite_details(&arg0);
        let (v8, v9, v10, v11) = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::get_permission_details(v4);
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::accept_invite(arg0, arg3, arg4);
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::grant_access(arg1, 0x2::tx_context::sender(arg4), v8, v9, v10, v11, arg4);
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::add_accessible_database(arg2, 0x2::object::id<0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::DatabaseInvite>(&arg0), arg4);
    }

    public entry fun accept_invite_for_secure_database(arg0: 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::DatabaseInvite, arg1: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database, arg2: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::DatabaseRegistry, arg3: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::InviteRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _, v4, _, _, _) = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::get_invite_details(&arg0);
        let (v8, v9, v10, v11) = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::get_permission_details(v4);
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::accept_invite(arg0, arg3, arg4);
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::grant_access(arg1, 0x2::tx_context::sender(arg4), v8, v9, v10, v11, arg4);
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::add_accessible_database(arg2, 0x2::object::id<0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database>(arg1), arg4);
    }

    public entry fun approve_request_and_update_registries(arg0: 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::AccessRequest, arg1: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database, arg2: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::DatabaseRegistry, arg3: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::InviteRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::object::id<0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::AccessRequest>(&arg0);
        let (v0, _, v2, _, v4, _, _) = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::get_request_details(&arg0);
        let (v7, v8, v9, v10) = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::get_permission_details(v4);
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::approve_request(arg0, arg3, arg4);
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::grant_access(arg1, v2, v7, v8, v9, v10, arg4);
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::add_accessible_database(arg2, v0, arg4);
    }

    public fun check_user_permission(arg0: &0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database, arg1: address, arg2: u8, arg3: &0x2::tx_context::TxContext) : bool {
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::check_permission(arg0, arg1, arg2, arg3)
    }

    public entry fun create_database_with_registry(arg0: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::GlobalRegistry, arg1: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::DatabaseRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::add_owned_database(arg1, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::create_database_and_get_id(arg0, arg2, arg3), arg3);
    }

    public entry fun create_secure_database_with_registry(arg0: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::GlobalRegistry, arg1: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::DatabaseRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::add_owned_database(arg1, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::create_database_and_get_id(arg0, arg2, arg3), arg3);
    }

    public fun ensure_user_registry(arg0: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::GlobalRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::get_or_create_registry(arg0, arg1)
    }

    public fun get_user_databases(arg0: &0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::DatabaseRegistry) : (&vector<0x2::object::ID>, &vector<0x2::object::ID>) {
        (0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::get_owned_databases(arg0), 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::get_accessible_databases(arg0))
    }

    public fun get_user_permission_level(arg0: &0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database, arg1: address) : (bool, bool, bool) {
        if (0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::get_owner(arg0) == arg1) {
            return (true, true, true)
        };
        let v0 = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::view_permissions(arg0, arg1);
        if (0x1::option::is_some<0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&v0)) {
            let (v4, v5, v6, _) = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::get_permission_details(0x1::option::borrow<0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&v0));
            (v4, v5, v6)
        } else {
            (false, false, false)
        }
    }

    public entry fun grant_access_and_update_registry(arg0: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database, arg1: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::DatabaseRegistry, arg2: address, arg3: bool, arg4: bool, arg5: bool, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::grant_access(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::add_accessible_database(arg1, 0x2::object::id<0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database>(arg0), arg7);
    }

    public entry fun request_database_access(arg0: &0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database, arg1: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::InviteRegistry, arg2: bool, arg3: bool, arg4: bool, arg5: 0x1::option::Option<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::request_access(arg1, 0x2::object::id<0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database>(arg0), 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::get_name(arg0), 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::get_owner(arg0), arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun revoke_access_and_update_registry(arg0: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database, arg1: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::DatabaseRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::revoke_access(arg0, arg2, arg3);
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::remove_accessible_database(arg1, 0x2::object::id<0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database>(arg0), arg3);
    }

    public entry fun send_database_invite(arg0: &0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database, arg1: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::InviteRegistry, arg2: address, arg3: bool, arg4: bool, arg5: bool, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) {
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::send_invite(arg1, 0x2::object::id<0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database>(arg0), 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::get_name(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun setup_database_with_initial_access(arg0: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::GlobalRegistry, arg1: 0x1::string::String, arg2: vector<address>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::create_database(arg0, arg1, arg4);
    }

    public entry fun store_encrypted_database_content(arg0: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::has_seal_policy(arg0), 0);
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::store_encrypted_content(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun user_has_database_access(arg0: &0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::Database, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        if (0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::get_owner(arg0) == arg1) {
            return true
        };
        let v0 = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database::view_permissions(arg0, arg1);
        0x1::option::is_some<0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&v0)
    }

    // decompiled from Move bytecode v6
}

