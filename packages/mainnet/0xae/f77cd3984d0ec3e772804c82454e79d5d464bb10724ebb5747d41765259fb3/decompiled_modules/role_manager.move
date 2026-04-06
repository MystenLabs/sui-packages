module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager {
    struct ROLE_MANAGER has drop {
        dummy_field: bool,
    }

    struct RoleManager has key {
        id: 0x2::object::UID,
        super_admin: address,
        roles: 0x2::table::Table<address, vector<0x1::string::String>>,
    }

    struct RoleManagerCreated has copy, drop {
        role_manager_id: 0x2::object::ID,
        super_admin: address,
    }

    struct RoleGranted has copy, drop {
        role_manager_id: 0x2::object::ID,
        account: address,
        role: 0x1::string::String,
    }

    struct RoleRevoked has copy, drop {
        role_manager_id: 0x2::object::ID,
        account: address,
        role: 0x1::string::String,
    }

    struct DeveloperRoleGranted has copy, drop {
        account: address,
        granted_by: address,
    }

    struct DeveloperRoleRevoked has copy, drop {
        account: address,
        revoked_by: address,
    }

    public fun admin_role() : 0x1::string::String {
        0x1::string::utf8(b"admin_role")
    }

    public fun developer_role() : 0x1::string::String {
        0x1::string::utf8(b"developer_role")
    }

    public fun factory_role() : 0x1::string::String {
        0x1::string::utf8(b"factory_role")
    }

    public fun fee_role() : 0x1::string::String {
        0x1::string::utf8(b"fee_role")
    }

    public fun get_account_roles(arg0: &RoleManager, arg1: address) : vector<0x1::string::String> {
        if (!0x2::table::contains<address, vector<0x1::string::String>>(&arg0.roles, arg1)) {
            return 0x1::vector::empty<0x1::string::String>()
        };
        *0x2::table::borrow<address, vector<0x1::string::String>>(&arg0.roles, arg1)
    }

    public fun get_super_admin(arg0: &RoleManager) : address {
        arg0.super_admin
    }

    public fun grant_developer_role(arg0: &mut RoleManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = if (v0 == arg0.super_admin) {
            true
        } else if (has_role(arg0, v0, 0x1::string::utf8(b"admin_role"))) {
            true
        } else {
            has_role(arg0, v0, 0x1::string::utf8(b"user_admin_role"))
        };
        assert!(v1, 1);
        let v2 = 0x1::string::utf8(b"developer_role");
        if (!0x2::table::contains<address, vector<0x1::string::String>>(&arg0.roles, arg1)) {
            0x2::table::add<address, vector<0x1::string::String>>(&mut arg0.roles, arg1, 0x1::vector::empty<0x1::string::String>());
        };
        let v3 = 0x2::table::borrow_mut<address, vector<0x1::string::String>>(&mut arg0.roles, arg1);
        let v4 = 0;
        let v5 = false;
        while (v4 < 0x1::vector::length<0x1::string::String>(v3)) {
            if (*0x1::vector::borrow<0x1::string::String>(v3, v4) == v2) {
                v5 = true;
                break
            };
            v4 = v4 + 1;
        };
        if (!v5) {
            0x1::vector::push_back<0x1::string::String>(v3, v2);
            let v6 = DeveloperRoleGranted{
                account    : arg1,
                granted_by : v0,
            };
            0x2::event::emit<DeveloperRoleGranted>(v6);
        };
    }

    public fun grant_role(arg0: &mut RoleManager, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_role(arg0, 0x2::tx_context::sender(arg3), 0x1::string::utf8(b"admin_role")), 1);
        assert!(is_valid_role(&arg2), 2);
        if (!0x2::table::contains<address, vector<0x1::string::String>>(&arg0.roles, arg1)) {
            0x2::table::add<address, vector<0x1::string::String>>(&mut arg0.roles, arg1, 0x1::vector::empty<0x1::string::String>());
        };
        let v0 = 0x2::table::borrow_mut<address, vector<0x1::string::String>>(&mut arg0.roles, arg1);
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<0x1::string::String>(v0)) {
            if (*0x1::vector::borrow<0x1::string::String>(v0, v1) == arg2) {
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        if (!v2) {
            0x1::vector::push_back<0x1::string::String>(v0, arg2);
            let v3 = RoleGranted{
                role_manager_id : 0x2::object::id<RoleManager>(arg0),
                account         : arg1,
                role            : arg2,
            };
            0x2::event::emit<RoleGranted>(v3);
        };
    }

    public fun has_role(arg0: &RoleManager, arg1: address, arg2: 0x1::string::String) : bool {
        if (!0x2::table::contains<address, vector<0x1::string::String>>(&arg0.roles, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, vector<0x1::string::String>>(&arg0.roles, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(v0)) {
            if (*0x1::vector::borrow<0x1::string::String>(v0, v1) == arg2) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    fun init(arg0: ROLE_MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::table::new<address, vector<0x1::string::String>>(arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"admin_role"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"fee_role"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"factory_role"));
        0x2::table::add<address, vector<0x1::string::String>>(&mut v1, v0, v2);
        let v4 = RoleManager{
            id          : 0x2::object::new(arg1),
            super_admin : v0,
            roles       : v1,
        };
        let v5 = RoleManagerCreated{
            role_manager_id : 0x2::object::id<RoleManager>(&v4),
            super_admin     : v0,
        };
        0x2::event::emit<RoleManagerCreated>(v5);
        0x2::transfer::share_object<RoleManager>(v4);
    }

    fun is_valid_role(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        if (*v0 == b"admin_role") {
            true
        } else if (*v0 == b"factory_role") {
            true
        } else if (*v0 == b"fee_role") {
            true
        } else if (*v0 == b"developer_role") {
            true
        } else {
            *v0 == b"user_admin_role"
        }
    }

    public fun require_role(arg0: &RoleManager, arg1: address, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(has_role(arg0, arg1, arg2), 1);
    }

    public fun revoke_developer_role(arg0: &mut RoleManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = if (v0 == arg0.super_admin) {
            true
        } else if (has_role(arg0, v0, 0x1::string::utf8(b"admin_role"))) {
            true
        } else {
            has_role(arg0, v0, 0x1::string::utf8(b"user_admin_role"))
        };
        assert!(v1, 1);
        if (!0x2::table::contains<address, vector<0x1::string::String>>(&arg0.roles, arg1)) {
            return
        };
        let v2 = 0x2::table::borrow_mut<address, vector<0x1::string::String>>(&mut arg0.roles, arg1);
        let v3 = 0;
        let v4 = false;
        while (v3 < 0x1::vector::length<0x1::string::String>(v2)) {
            if (*0x1::vector::borrow<0x1::string::String>(v2, v3) == 0x1::string::utf8(b"developer_role")) {
                0x1::vector::remove<0x1::string::String>(v2, v3);
                v4 = true;
                break
            };
            v3 = v3 + 1;
        };
        if (v4) {
            let v5 = DeveloperRoleRevoked{
                account    : arg1,
                revoked_by : v0,
            };
            0x2::event::emit<DeveloperRoleRevoked>(v5);
        };
    }

    public fun revoke_role(arg0: &mut RoleManager, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_role(arg0, 0x2::tx_context::sender(arg3), 0x1::string::utf8(b"admin_role")), 1);
        assert!(is_valid_role(&arg2), 2);
        if (!0x2::table::contains<address, vector<0x1::string::String>>(&arg0.roles, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<0x1::string::String>>(&mut arg0.roles, arg1);
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<0x1::string::String>(v0)) {
            if (*0x1::vector::borrow<0x1::string::String>(v0, v1) == arg2) {
                0x1::vector::remove<0x1::string::String>(v0, v1);
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        if (v2) {
            let v3 = RoleRevoked{
                role_manager_id : 0x2::object::id<RoleManager>(arg0),
                account         : arg1,
                role            : arg2,
            };
            0x2::event::emit<RoleRevoked>(v3);
        };
    }

    public fun user_admin_role() : 0x1::string::String {
        0x1::string::utf8(b"user_admin_role")
    }

    // decompiled from Move bytecode v7
}

