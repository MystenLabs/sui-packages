module 0xe3c0f6ffa83768efbd09afd3d2f3c34bcc4cb36eaa011a7f484a8071b3642686::admin_whitelist {
    struct AdminConfig has key {
        id: 0x2::object::UID,
        admins: 0x2::table::Table<address, AdminPermission>,
        super_admin: address,
    }

    struct AdminPermission has copy, drop, store {
        permissions: u8,
        feature_permissions: vector<FeaturePermission>,
    }

    struct FeaturePermission has copy, drop, store {
        feature_name: vector<u8>,
        permissions: u8,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminAdded has copy, drop {
        admin_address: address,
        permissions: u8,
    }

    struct AdminRemoved has copy, drop {
        admin_address: address,
    }

    struct AdminPermissionUpdated has copy, drop {
        admin_address: address,
        new_permissions: u8,
    }

    public fun add_admin(arg0: &mut AdminConfig, arg1: address, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.super_admin, 1);
        let v0 = AdminPermission{
            permissions         : arg2,
            feature_permissions : 0x1::vector::empty<FeaturePermission>(),
        };
        0x2::table::add<address, AdminPermission>(&mut arg0.admins, arg1, v0);
        let v1 = AdminAdded{
            admin_address : arg1,
            permissions   : arg2,
        };
        0x2::event::emit<AdminAdded>(v1);
    }

    public fun add_feature_permission(arg0: &mut AdminConfig, arg1: address, arg2: vector<u8>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.super_admin, 1);
        assert!(0x2::table::contains<address, AdminPermission>(&arg0.admins, arg1), 2);
        let v0 = FeaturePermission{
            feature_name : arg2,
            permissions  : arg3,
        };
        0x1::vector::push_back<FeaturePermission>(&mut 0x2::table::borrow_mut<address, AdminPermission>(&mut arg0.admins, arg1).feature_permissions, v0);
    }

    public fun get_admin_permissions(arg0: &AdminConfig, arg1: address) : u8 {
        if (!0x2::table::contains<address, AdminPermission>(&arg0.admins, arg1)) {
            return 0
        };
        0x2::table::borrow<address, AdminPermission>(&arg0.admins, arg1).permissions
    }

    public fun has_feature_permission(arg0: &AdminConfig, arg1: address, arg2: vector<u8>, arg3: u8) : bool {
        if (!0x2::table::contains<address, AdminPermission>(&arg0.admins, arg1)) {
            return false
        };
        let v0 = &0x2::table::borrow<address, AdminPermission>(&arg0.admins, arg1).feature_permissions;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FeaturePermission>(v0)) {
            let v2 = 0x1::vector::borrow<FeaturePermission>(v0, v1);
            if (v2.feature_name == arg2) {
                return v2.permissions & arg3 == arg3
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun has_permission(arg0: &AdminConfig, arg1: address, arg2: u8) : bool {
        if (!0x2::table::contains<address, AdminPermission>(&arg0.admins, arg1)) {
            return false
        };
        0x2::table::borrow<address, AdminPermission>(&arg0.admins, arg1).permissions & arg2 == arg2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminConfig{
            id          : 0x2::object::new(arg0),
            admins      : 0x2::table::new<address, AdminPermission>(arg0),
            super_admin : v0,
        };
        let v2 = AdminPermission{
            permissions         : 15,
            feature_permissions : 0x1::vector::empty<FeaturePermission>(),
        };
        0x2::table::add<address, AdminPermission>(&mut v1.admins, v0, v2);
        0x2::transfer::share_object<AdminConfig>(v1);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v3, v0);
    }

    public fun is_super_admin(arg0: &AdminConfig, arg1: address) : bool {
        arg1 == arg0.super_admin
    }

    public fun permission_delete() : u8 {
        8
    }

    public fun permission_insert() : u8 {
        2
    }

    public fun permission_update() : u8 {
        4
    }

    public fun permission_view() : u8 {
        1
    }

    public fun remove_admin(arg0: &mut AdminConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.super_admin, 1);
        assert!(arg1 != arg0.super_admin, 1);
        0x2::table::remove<address, AdminPermission>(&mut arg0.admins, arg1);
        let v0 = AdminRemoved{admin_address: arg1};
        0x2::event::emit<AdminRemoved>(v0);
    }

    public fun remove_feature_permission(arg0: &mut AdminConfig, arg1: address, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.super_admin, 1);
        assert!(0x2::table::contains<address, AdminPermission>(&arg0.admins, arg1), 2);
        let v0 = &mut 0x2::table::borrow_mut<address, AdminPermission>(&mut arg0.admins, arg1).feature_permissions;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FeaturePermission>(v0)) {
            if (0x1::vector::borrow<FeaturePermission>(v0, v1).feature_name == arg2) {
                0x1::vector::remove<FeaturePermission>(v0, v1);
                return
            };
            v1 = v1 + 1;
        };
    }

    public fun update_admin_permissions(arg0: &mut AdminConfig, arg1: address, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.super_admin, 1);
        assert!(0x2::table::contains<address, AdminPermission>(&arg0.admins, arg1), 2);
        0x2::table::borrow_mut<address, AdminPermission>(&mut arg0.admins, arg1).permissions = arg2;
        let v0 = AdminPermissionUpdated{
            admin_address   : arg1,
            new_permissions : arg2,
        };
        0x2::event::emit<AdminPermissionUpdated>(v0);
    }

    public fun update_feature_permission(arg0: &mut AdminConfig, arg1: address, arg2: vector<u8>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.super_admin, 1);
        assert!(0x2::table::contains<address, AdminPermission>(&arg0.admins, arg1), 2);
        let v0 = &mut 0x2::table::borrow_mut<address, AdminPermission>(&mut arg0.admins, arg1).feature_permissions;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FeaturePermission>(v0)) {
            let v2 = 0x1::vector::borrow_mut<FeaturePermission>(v0, v1);
            if (v2.feature_name == arg2) {
                v2.permissions = arg3;
                return
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

