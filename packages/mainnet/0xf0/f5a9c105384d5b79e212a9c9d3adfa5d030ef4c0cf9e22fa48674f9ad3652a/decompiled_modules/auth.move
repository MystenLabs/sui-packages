module 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::auth {
    struct AdminRole has drop, store {
        dummy_field: bool,
    }

    struct AuthorizeRole has drop, store {
        dummy_field: bool,
    }

    struct RebalancerRole has drop, store {
        dummy_field: bool,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    struct MarketRoleKey<phantom T0> has copy, drop, store {
        owner: address,
        market: 0x2::object::ID,
    }

    struct VaultAdmin has key {
        id: 0x2::object::UID,
        admin_count: u64,
        roles: 0x2::bag::Bag,
    }

    public(friend) fun add_admin(arg0: &mut VaultAdmin, arg1: address) {
        assert!(arg1 != @0x0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_address_zero_not_allowed());
        let v0 = RoleKey<AdminRole>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<AdminRole>>(&arg0.roles, v0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_role_already_assigned());
        let v1 = RoleKey<AdminRole>{owner: arg1};
        let v2 = AdminRole{dummy_field: false};
        0x2::bag::add<RoleKey<AdminRole>, AdminRole>(&mut arg0.roles, v1, v2);
        arg0.admin_count = arg0.admin_count + 1;
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_add_admin(arg1);
    }

    public fun admin_count(arg0: &VaultAdmin) : u64 {
        arg0.admin_count
    }

    public(friend) fun assert_authority(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg1: &VaultAdmin, arg2: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::assert_version(arg0);
        assert_only_authority(arg1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun assert_auths(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg1: &VaultAdmin, arg2: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::assert_version(arg0);
        assert_only_auths(arg1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun assert_only_authority(arg0: &VaultAdmin, arg1: address) {
        assert!(get_is_admin(arg0, arg1), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_only_authority());
    }

    public(friend) fun assert_only_auths(arg0: &VaultAdmin, arg1: address) {
        assert!(get_is_auth(arg0, arg1), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_only_auths());
    }

    public(friend) fun assert_only_rebalancer(arg0: &VaultAdmin, arg1: address, arg2: 0x2::object::ID) {
        assert!(get_is_rebalancer(arg0, arg1, arg2), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_not_rebalancer());
    }

    public(friend) fun assert_rebalancer(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg1: &VaultAdmin, arg2: address, arg3: 0x2::object::ID) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::assert_version(arg0);
        assert_only_rebalancer(arg1, arg2, arg3);
    }

    public fun get_is_admin(arg0: &VaultAdmin, arg1: address) : bool {
        let v0 = RoleKey<AdminRole>{owner: arg1};
        0x2::bag::contains<RoleKey<AdminRole>>(&arg0.roles, v0)
    }

    public fun get_is_auth(arg0: &VaultAdmin, arg1: address) : bool {
        let v0 = RoleKey<AuthorizeRole>{owner: arg1};
        0x2::bag::contains<RoleKey<AuthorizeRole>>(&arg0.roles, v0) || get_is_admin(arg0, arg1)
    }

    public fun get_is_rebalancer(arg0: &VaultAdmin, arg1: address, arg2: 0x2::object::ID) : bool {
        let v0 = MarketRoleKey<RebalancerRole>{
            owner  : arg1,
            market : arg2,
        };
        0x2::bag::contains<MarketRoleKey<RebalancerRole>>(&arg0.roles, v0)
    }

    public(friend) fun grant_auth(arg0: &mut VaultAdmin, arg1: address) {
        assert!(arg1 != @0x0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_address_zero_not_allowed());
        let v0 = RoleKey<AuthorizeRole>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<AuthorizeRole>>(&arg0.roles, v0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_role_already_assigned());
        let v1 = RoleKey<AuthorizeRole>{owner: arg1};
        let v2 = AuthorizeRole{dummy_field: false};
        0x2::bag::add<RoleKey<AuthorizeRole>, AuthorizeRole>(&mut arg0.roles, v1, v2);
    }

    public(friend) fun grant_rebalancer(arg0: &mut VaultAdmin, arg1: address, arg2: 0x2::object::ID) {
        assert!(arg1 != @0x0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_address_zero_not_allowed());
        let v0 = MarketRoleKey<RebalancerRole>{
            owner  : arg1,
            market : arg2,
        };
        assert!(!0x2::bag::contains<MarketRoleKey<RebalancerRole>>(&arg0.roles, v0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_role_already_assigned());
        let v1 = MarketRoleKey<RebalancerRole>{
            owner  : arg1,
            market : arg2,
        };
        let v2 = RebalancerRole{dummy_field: false};
        0x2::bag::add<MarketRoleKey<RebalancerRole>, RebalancerRole>(&mut arg0.roles, v1, v2);
    }

    public(friend) fun has_auth_record(arg0: &VaultAdmin, arg1: address) : bool {
        let v0 = RoleKey<AuthorizeRole>{owner: arg1};
        0x2::bag::contains<RoleKey<AuthorizeRole>>(&arg0.roles, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg0);
        let v1 = RoleKey<AdminRole>{owner: 0x2::tx_context::sender(arg0)};
        let v2 = AdminRole{dummy_field: false};
        0x2::bag::add<RoleKey<AdminRole>, AdminRole>(&mut v0, v1, v2);
        let v3 = VaultAdmin{
            id          : 0x2::object::new(arg0),
            admin_count : 1,
            roles       : v0,
        };
        0x2::transfer::share_object<VaultAdmin>(v3);
    }

    public(friend) fun remove_admin(arg0: &mut VaultAdmin, arg1: address) {
        let v0 = RoleKey<AdminRole>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<AdminRole>>(&arg0.roles, v0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_role_not_assigned());
        assert!(arg0.admin_count > 1, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_last_admin_not_removable());
        let v1 = RoleKey<AdminRole>{owner: arg1};
        let AdminRole {  } = 0x2::bag::remove<RoleKey<AdminRole>, AdminRole>(&mut arg0.roles, v1);
        arg0.admin_count = arg0.admin_count - 1;
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_remove_admin(arg1);
    }

    public(friend) fun revoke_auth(arg0: &mut VaultAdmin, arg1: address) {
        let v0 = RoleKey<AuthorizeRole>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<AuthorizeRole>>(&arg0.roles, v0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_role_not_assigned());
        let v1 = RoleKey<AuthorizeRole>{owner: arg1};
        let AuthorizeRole {  } = 0x2::bag::remove<RoleKey<AuthorizeRole>, AuthorizeRole>(&mut arg0.roles, v1);
    }

    public(friend) fun revoke_rebalancer(arg0: &mut VaultAdmin, arg1: address, arg2: 0x2::object::ID) {
        let v0 = MarketRoleKey<RebalancerRole>{
            owner  : arg1,
            market : arg2,
        };
        assert!(0x2::bag::contains<MarketRoleKey<RebalancerRole>>(&arg0.roles, v0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_admin_role_not_assigned());
        let v1 = MarketRoleKey<RebalancerRole>{
            owner  : arg1,
            market : arg2,
        };
        let RebalancerRole {  } = 0x2::bag::remove<MarketRoleKey<RebalancerRole>, RebalancerRole>(&mut arg0.roles, v1);
    }

    // decompiled from Move bytecode v7
}

