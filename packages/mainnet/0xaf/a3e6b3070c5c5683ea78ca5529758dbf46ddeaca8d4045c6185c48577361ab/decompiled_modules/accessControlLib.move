module 0xafa3e6b3070c5c5683ea78ca5529758dbf46ddeaca8d4045c6185c48577361ab::accessControlLib {
    struct UserRolesCollection has key {
        id: 0x2::object::UID,
        roles: 0x2::table::Table<vector<u8>, RoleData>,
    }

    struct RoleData has store {
        members: 0x2::vec_map::VecMap<0x2::object::ID, bool>,
        adminRole: vector<u8>,
        properties: 0x2::vec_map::VecMap<u8, vector<u8>>,
    }

    struct DefaultAdminCap has key {
        id: 0x2::object::UID,
        properties: 0x2::vec_map::VecMap<u8, vector<u8>>,
    }

    struct RoleAdminChangedEvent has copy, drop {
        role: vector<u8>,
        previousAdminRole: vector<u8>,
        adminRole: vector<u8>,
    }

    struct RoleGrantedEvent has copy, drop {
        role: vector<u8>,
        userId: 0x2::object::ID,
    }

    struct RoleRevokedEvent has copy, drop {
        role: vector<u8>,
        userId: 0x2::object::ID,
    }

    public fun checkHasRole(arg0: &UserRolesCollection, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID) {
        let v0 = hasRole(arg0, x"02", arg1);
        let v1 = hasRole(arg0, getCommunityRole(x"03", arg3), arg1);
        let v2 = hasRole(arg0, getCommunityRole(x"04", arg3), arg1);
        if (arg2 == 0) {
            return
        } else {
            abort if (arg2 == 2 && !v0) {
                302
            } else if (arg2 == 1 && !hasRole(arg0, x"05", arg1)) {
                303
            } else if (arg2 == 4 && !(v0 || v2)) {
                305
            } else if (arg2 == 5 && !(v0 || v1)) {
                306
            } else if (arg2 == 6 && !v1) {
                307
            } else if (arg2 == 7 && !v2) {
                308
            } else {
                return
            }
        };
    }

    public fun getCommunityRole(arg0: vector<u8>, arg1: 0x2::object::ID) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, 0x2::object::id_to_bytes(&arg1));
        arg0
    }

    public fun getRoleAdmin(arg0: &UserRolesCollection, arg1: vector<u8>) : vector<u8> {
        if (0x2::table::contains<vector<u8>, RoleData>(&arg0.roles, arg1)) {
            0x2::table::borrow<vector<u8>, RoleData>(&arg0.roles, arg1).adminRole
        } else {
            0x1::vector::empty<u8>()
        }
    }

    public fun get_action_role_admin() : u8 {
        2
    }

    public fun get_action_role_admin_or_community_admin() : u8 {
        5
    }

    public fun get_action_role_admin_or_community_moderator() : u8 {
        4
    }

    public fun get_action_role_bot() : u8 {
        1
    }

    public fun get_action_role_community_admin() : u8 {
        6
    }

    public fun get_action_role_community_moderator() : u8 {
        7
    }

    public fun get_action_role_mint_nft() : u8 {
        8
    }

    public fun get_action_role_none() : u8 {
        0
    }

    public fun get_community_admin_role() : vector<u8> {
        x"03"
    }

    public fun get_community_moderator_role() : vector<u8> {
        x"04"
    }

    public fun get_protocol_admin_role() : vector<u8> {
        x"02"
    }

    public entry fun grantProtocolAdminRole(arg0: &DefaultAdminCap, arg1: &mut UserRolesCollection, arg2: 0x2::object::ID) {
        grantRole_(arg1, x"02", arg2);
    }

    public(friend) fun grantRole(arg0: &mut UserRolesCollection, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<u8>) {
        assert!(arg3 != x"02", 301);
        onlyRole(arg0, getRoleAdmin(arg0, arg3), arg1);
        grantRole_(arg0, arg3, arg2);
    }

    fun grantRole_(arg0: &mut UserRolesCollection, arg1: vector<u8>, arg2: 0x2::object::ID) {
        assert!(arg1 != 0x1::vector::empty<u8>(), 309);
        if (!hasRole(arg0, arg1, arg2)) {
            if (!0x2::table::contains<vector<u8>, RoleData>(&arg0.roles, arg1)) {
                let v0 = RoleData{
                    members    : 0x2::vec_map::empty<0x2::object::ID, bool>(),
                    adminRole  : 0x1::vector::empty<u8>(),
                    properties : 0x2::vec_map::empty<u8, vector<u8>>(),
                };
                0x2::table::add<vector<u8>, RoleData>(&mut arg0.roles, arg1, v0);
            };
            let v1 = 0x2::table::borrow_mut<vector<u8>, RoleData>(&mut arg0.roles, arg1);
            let v2 = 0x2::vec_map::get_idx_opt<0x2::object::ID, bool>(&v1.members, &arg2);
            if (0x1::option::is_none<u64>(&v2)) {
                0x2::vec_map::insert<0x2::object::ID, bool>(&mut v1.members, arg2, true);
            } else {
                *0x2::vec_map::get_mut<0x2::object::ID, bool>(&mut v1.members, &arg2) = true;
            };
            let v3 = RoleGrantedEvent{
                role   : arg1,
                userId : arg2,
            };
            0x2::event::emit<RoleGrantedEvent>(v3);
        };
    }

    public fun hasRole(arg0: &UserRolesCollection, arg1: vector<u8>, arg2: 0x2::object::ID) : bool {
        if (0x2::table::contains<vector<u8>, RoleData>(&arg0.roles, arg1)) {
            let v1 = 0x2::table::borrow<vector<u8>, RoleData>(&arg0.roles, arg1);
            let v2 = 0x2::vec_map::get_idx_opt<0x2::object::ID, bool>(&v1.members, &arg2);
            0x1::option::is_none<u64>(&v2) && false || *0x2::vec_map::get<0x2::object::ID, bool>(&v1.members, &arg2)
        } else {
            false
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserRolesCollection{
            id    : 0x2::object::new(arg0),
            roles : 0x2::table::new<vector<u8>, RoleData>(arg0),
        };
        let v1 = &mut v0;
        setRoleAdmin(v1, x"05", x"02");
        0x2::transfer::share_object<UserRolesCollection>(v0);
        let v2 = DefaultAdminCap{
            id         : 0x2::object::new(arg0),
            properties : 0x2::vec_map::empty<u8, vector<u8>>(),
        };
        0x2::transfer::transfer<DefaultAdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun onlyRole(arg0: &UserRolesCollection, arg1: vector<u8>, arg2: 0x2::object::ID) {
        if (!hasRole(arg0, arg1, arg2)) {
            abort 300
        };
    }

    public entry fun revokeProtocolAdminRole(arg0: &DefaultAdminCap, arg1: &mut UserRolesCollection, arg2: 0x2::object::ID) {
        revokeRole_(arg1, x"02", arg2);
    }

    public(friend) fun revokeRole(arg0: &mut UserRolesCollection, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<u8>) {
        assert!(arg3 != x"02", 301);
        onlyRole(arg0, getRoleAdmin(arg0, arg3), arg1);
        revokeRole_(arg0, arg3, arg2);
    }

    fun revokeRole_(arg0: &mut UserRolesCollection, arg1: vector<u8>, arg2: 0x2::object::ID) {
        assert!(arg1 != 0x1::vector::empty<u8>(), 309);
        if (hasRole(arg0, arg1, arg2)) {
            if (!0x2::table::contains<vector<u8>, RoleData>(&arg0.roles, arg1)) {
                return
            };
            let v0 = 0x2::table::borrow_mut<vector<u8>, RoleData>(&mut arg0.roles, arg1);
            let v1 = 0x2::vec_map::get_idx_opt<0x2::object::ID, bool>(&v0.members, &arg2);
            if (0x1::option::is_none<u64>(&v1)) {
                return
            };
            *0x2::vec_map::get_mut<0x2::object::ID, bool>(&mut v0.members, &arg2) = false;
            let v2 = RoleRevokedEvent{
                role   : arg1,
                userId : arg2,
            };
            0x2::event::emit<RoleRevokedEvent>(v2);
        };
    }

    public(friend) fun setCommunityPermission(arg0: &mut UserRolesCollection, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = getCommunityRole(x"03", arg1);
        let v1 = getCommunityRole(x"04", arg1);
        setRoleAdmin(arg0, v1, v0);
        setRoleAdmin(arg0, v0, x"02");
        grantRole_(arg0, v0, arg2);
        grantRole_(arg0, v1, arg2);
    }

    fun setRoleAdmin(arg0: &mut UserRolesCollection, arg1: vector<u8>, arg2: vector<u8>) {
        if (0x2::table::contains<vector<u8>, RoleData>(&arg0.roles, arg1)) {
            0x2::table::borrow_mut<vector<u8>, RoleData>(&mut arg0.roles, arg1).adminRole = arg2;
        } else {
            let v0 = RoleData{
                members    : 0x2::vec_map::empty<0x2::object::ID, bool>(),
                adminRole  : arg2,
                properties : 0x2::vec_map::empty<u8, vector<u8>>(),
            };
            0x2::table::add<vector<u8>, RoleData>(&mut arg0.roles, arg1, v0);
        };
        let v1 = RoleAdminChangedEvent{
            role              : arg1,
            previousAdminRole : getRoleAdmin(arg0, arg1),
            adminRole         : arg2,
        };
        0x2::event::emit<RoleAdminChangedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

