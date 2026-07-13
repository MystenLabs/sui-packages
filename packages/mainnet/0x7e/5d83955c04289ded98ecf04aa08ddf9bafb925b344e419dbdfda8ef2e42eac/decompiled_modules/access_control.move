module 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::access_control {
    struct AccessControl has key {
        id: 0x2::object::UID,
        version: u64,
        admin_roles: 0x2::table::Table<address, bool>,
        token_roles: 0x2::table::Table<address, bool>,
        pause_roles: 0x2::table::Table<address, bool>,
        unpause_roles: 0x2::table::Table<address, bool>,
        operate_roles: 0x2::table::Table<address, bool>,
    }

    struct SuperAdminCap has key {
        id: 0x2::object::UID,
    }

    struct PendingTransfer has key {
        id: 0x2::object::UID,
        recipient: address,
    }

    public fun approve_super_admin_transfer(arg0: SuperAdminCap, arg1: PendingTransfer, arg2: address) {
        let PendingTransfer {
            id        : v0,
            recipient : v1,
        } = arg1;
        assert!(v1 == arg2, 4004);
        0x2::object::delete(v0);
        0x2::transfer::transfer<SuperAdminCap>(arg0, v1);
    }

    public(friend) fun assert_admin_role(arg0: &AccessControl, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.admin_roles, arg1), 4001);
    }

    public(friend) fun assert_operate_role(arg0: &AccessControl, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.operate_roles, arg1), 4001);
    }

    public(friend) fun assert_pause_role(arg0: &AccessControl, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.pause_roles, arg1), 4001);
    }

    public(friend) fun assert_token_role(arg0: &AccessControl, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.token_roles, arg1), 4001);
    }

    public(friend) fun assert_unpause_role(arg0: &AccessControl, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.unpause_roles, arg1), 4001);
    }

    fun assert_version(arg0: &AccessControl) {
        assert!(arg0.version == 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current(), 4005);
    }

    public fun cancel_super_admin_request(arg0: PendingTransfer, arg1: &0x2::tx_context::TxContext) {
        let PendingTransfer {
            id        : v0,
            recipient : v1,
        } = arg0;
        assert!(v1 == 0x2::tx_context::sender(arg1), 4001);
        0x2::object::delete(v0);
    }

    public fun grant_admin_role(arg0: &SuperAdminCap, arg1: &mut AccessControl, arg2: address) {
        assert_version(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg1.admin_roles, arg2), 4002);
        0x2::table::add<address, bool>(&mut arg1.admin_roles, arg2, true);
    }

    public fun grant_operate_role(arg0: &SuperAdminCap, arg1: &mut AccessControl, arg2: address) {
        assert_version(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg1.operate_roles, arg2), 4002);
        0x2::table::add<address, bool>(&mut arg1.operate_roles, arg2, true);
    }

    public fun grant_pause_role(arg0: &SuperAdminCap, arg1: &mut AccessControl, arg2: address) {
        assert_version(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg1.pause_roles, arg2), 4002);
        0x2::table::add<address, bool>(&mut arg1.pause_roles, arg2, true);
    }

    public fun grant_token_role(arg0: &SuperAdminCap, arg1: &mut AccessControl, arg2: address) {
        assert_version(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg1.token_roles, arg2), 4002);
        0x2::table::add<address, bool>(&mut arg1.token_roles, arg2, true);
    }

    public fun grant_unpause_role(arg0: &SuperAdminCap, arg1: &mut AccessControl, arg2: address) {
        assert_version(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg1.unpause_roles, arg2), 4002);
        0x2::table::add<address, bool>(&mut arg1.unpause_roles, arg2, true);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SuperAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AccessControl{
            id            : 0x2::object::new(arg0),
            version       : 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current(),
            admin_roles   : 0x2::table::new<address, bool>(arg0),
            token_roles   : 0x2::table::new<address, bool>(arg0),
            pause_roles   : 0x2::table::new<address, bool>(arg0),
            unpause_roles : 0x2::table::new<address, bool>(arg0),
            operate_roles : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<AccessControl>(v1);
    }

    public(friend) fun migrate(arg0: &mut AccessControl) {
        if (arg0.version < 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current()) {
            arg0.version = 0x7e5d83955c04289ded98ecf04aa08ddf9bafb925b344e419dbdfda8ef2e42eac::version::current();
        };
    }

    public fun reject_super_admin_request(arg0: &SuperAdminCap, arg1: PendingTransfer) {
        let PendingTransfer {
            id        : v0,
            recipient : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun request_super_admin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PendingTransfer{
            id        : 0x2::object::new(arg0),
            recipient : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<PendingTransfer>(v0);
    }

    public fun revoke_admin_role(arg0: &SuperAdminCap, arg1: &mut AccessControl, arg2: address) {
        assert_version(arg1);
        assert!(0x2::table::contains<address, bool>(&arg1.admin_roles, arg2), 4003);
        0x2::table::remove<address, bool>(&mut arg1.admin_roles, arg2);
    }

    public fun revoke_operate_role(arg0: &SuperAdminCap, arg1: &mut AccessControl, arg2: address) {
        assert_version(arg1);
        assert!(0x2::table::contains<address, bool>(&arg1.operate_roles, arg2), 4003);
        0x2::table::remove<address, bool>(&mut arg1.operate_roles, arg2);
    }

    public fun revoke_pause_role(arg0: &SuperAdminCap, arg1: &mut AccessControl, arg2: address) {
        assert_version(arg1);
        assert!(0x2::table::contains<address, bool>(&arg1.pause_roles, arg2), 4003);
        0x2::table::remove<address, bool>(&mut arg1.pause_roles, arg2);
    }

    public fun revoke_token_role(arg0: &SuperAdminCap, arg1: &mut AccessControl, arg2: address) {
        assert_version(arg1);
        assert!(0x2::table::contains<address, bool>(&arg1.token_roles, arg2), 4003);
        0x2::table::remove<address, bool>(&mut arg1.token_roles, arg2);
    }

    public fun revoke_unpause_role(arg0: &SuperAdminCap, arg1: &mut AccessControl, arg2: address) {
        assert_version(arg1);
        assert!(0x2::table::contains<address, bool>(&arg1.unpause_roles, arg2), 4003);
        0x2::table::remove<address, bool>(&mut arg1.unpause_roles, arg2);
    }

    // decompiled from Move bytecode v7
}

