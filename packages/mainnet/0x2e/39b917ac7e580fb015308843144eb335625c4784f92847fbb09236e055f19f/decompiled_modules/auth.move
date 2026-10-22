module 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::auth {
    struct AdminRole has drop, store {
        dummy_field: bool,
    }

    struct AuthorizeRole has drop, store {
        dummy_field: bool,
    }

    struct RebalancerRole has drop, store {
        dummy_field: bool,
    }

    struct MigrateRole has drop, store {
        dummy_field: bool,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    struct MarketRoleKey<phantom T0> has copy, drop, store {
        owner: address,
        market: 0x2::object::ID,
    }

    struct DisplayCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultAdmin has key {
        id: 0x2::object::UID,
        admin_count: u64,
        roles: 0x2::bag::Bag,
        timelock_cap: 0x1::option::Option<0x2::object::ID>,
    }

    public(friend) fun add_admin(arg0: &mut VaultAdmin, arg1: address) {
        assert!(arg1 != @0x0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_address_zero_not_allowed());
        let v0 = RoleKey<AdminRole>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<AdminRole>>(&arg0.roles, v0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_role_already_assigned());
        let v1 = RoleKey<AdminRole>{owner: arg1};
        let v2 = AdminRole{dummy_field: false};
        0x2::bag::add<RoleKey<AdminRole>, AdminRole>(&mut arg0.roles, v1, v2);
        arg0.admin_count = arg0.admin_count + 1;
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_add_admin(arg1);
    }

    public fun admin_count(arg0: &VaultAdmin) : u64 {
        arg0.admin_count
    }

    public(friend) fun assert_authority(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg1: &VaultAdmin, arg2: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg3: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::assert_version(arg0);
        assert_only_authority_direct(arg1, arg3);
        assert_ticket(arg1, arg2);
    }

    public fun timelock_cap(arg0: &VaultAdmin) : 0x1::option::Option<0x2::object::ID> {
        arg0.timelock_cap
    }

    public(friend) fun assert_auths(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg1: &VaultAdmin, arg2: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>, arg3: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::assert_version(arg0);
        assert!(get_is_auth(arg1, 0x2::tx_context::sender(arg3)), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_only_auths());
        assert_ticket(arg1, arg2);
    }

    public(friend) fun assert_only_authority_direct(arg0: &VaultAdmin, arg1: &0x2::tx_context::TxContext) {
        assert!(get_is_admin(arg0, 0x2::tx_context::sender(arg1)), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_only_authority());
    }

    public(friend) fun assert_only_migrators(arg0: &VaultAdmin, arg1: &0x2::tx_context::TxContext) {
        assert!(get_is_migrator(arg0, 0x2::tx_context::sender(arg1)), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_only_migrators());
    }

    public(friend) fun assert_only_rebalancer(arg0: &VaultAdmin, arg1: &0x2::tx_context::TxContext, arg2: 0x2::object::ID) {
        assert!(get_is_rebalancer(arg0, 0x2::tx_context::sender(arg1), arg2), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_not_rebalancer());
    }

    public(friend) fun assert_rebalancer(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg1: &VaultAdmin, arg2: &0x2::tx_context::TxContext, arg3: 0x2::object::ID) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::assert_version(arg0);
        assert_only_rebalancer(arg1, arg2, arg3);
    }

    fun assert_ticket(arg0: &VaultAdmin, arg1: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>) {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.timelock_cap)) {
            assert!(0x1::option::is_some<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>(&arg1), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_timelock_ticket_required());
            assert!(0x1::option::some<0x2::object::ID>(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::cap_id(0x1::option::borrow<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket>(&arg1))) == arg0.timelock_cap, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_wrong_timelock_cap());
        };
    }

    public(friend) fun disable_timelock(arg0: &mut VaultAdmin, arg1: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockCap) {
        assert!(arg0.timelock_cap == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockCap>(&arg1)), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_wrong_timelock_cap());
        arg0.timelock_cap = 0x1::option::none<0x2::object::ID>();
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::delete(arg1);
    }

    public(friend) fun enable_timelock(arg0: &mut VaultAdmin, arg1: &mut 0x2::tx_context::TxContext) : 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockCap {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.timelock_cap), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_timelock_already_enabled());
        let v0 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::new(arg1);
        arg0.timelock_cap = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockCap>(&v0));
        v0
    }

    public fun get_is_admin(arg0: &VaultAdmin, arg1: address) : bool {
        let v0 = RoleKey<AdminRole>{owner: arg1};
        0x2::bag::contains<RoleKey<AdminRole>>(&arg0.roles, v0)
    }

    public fun get_is_auth(arg0: &VaultAdmin, arg1: address) : bool {
        let v0 = RoleKey<AuthorizeRole>{owner: arg1};
        0x2::bag::contains<RoleKey<AuthorizeRole>>(&arg0.roles, v0) || get_is_admin(arg0, arg1)
    }

    public fun get_is_migrator(arg0: &VaultAdmin, arg1: address) : bool {
        let v0 = RoleKey<MigrateRole>{owner: arg1};
        0x2::bag::contains<RoleKey<MigrateRole>>(&arg0.roles, v0) || get_is_auth(arg0, arg1)
    }

    public fun get_is_rebalancer(arg0: &VaultAdmin, arg1: address, arg2: 0x2::object::ID) : bool {
        let v0 = MarketRoleKey<RebalancerRole>{
            owner  : arg1,
            market : arg2,
        };
        0x2::bag::contains<MarketRoleKey<RebalancerRole>>(&arg0.roles, v0)
    }

    public(friend) fun grant_auth(arg0: &mut VaultAdmin, arg1: address) {
        assert!(arg1 != @0x0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_address_zero_not_allowed());
        let v0 = RoleKey<AuthorizeRole>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<AuthorizeRole>>(&arg0.roles, v0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_role_already_assigned());
        let v1 = RoleKey<AuthorizeRole>{owner: arg1};
        let v2 = AuthorizeRole{dummy_field: false};
        0x2::bag::add<RoleKey<AuthorizeRole>, AuthorizeRole>(&mut arg0.roles, v1, v2);
    }

    public(friend) fun grant_migrator(arg0: &mut VaultAdmin, arg1: address) {
        assert!(arg1 != @0x0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_address_zero_not_allowed());
        let v0 = RoleKey<MigrateRole>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<MigrateRole>>(&arg0.roles, v0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_role_already_assigned());
        let v1 = RoleKey<MigrateRole>{owner: arg1};
        let v2 = MigrateRole{dummy_field: false};
        0x2::bag::add<RoleKey<MigrateRole>, MigrateRole>(&mut arg0.roles, v1, v2);
    }

    public(friend) fun grant_rebalancer(arg0: &mut VaultAdmin, arg1: address, arg2: 0x2::object::ID) {
        assert!(arg1 != @0x0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_address_zero_not_allowed());
        let v0 = MarketRoleKey<RebalancerRole>{
            owner  : arg1,
            market : arg2,
        };
        assert!(!0x2::bag::contains<MarketRoleKey<RebalancerRole>>(&arg0.roles, v0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_role_already_assigned());
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

    public(friend) fun has_migrator_record(arg0: &VaultAdmin, arg1: address) : bool {
        let v0 = RoleKey<MigrateRole>{owner: arg1};
        0x2::bag::contains<RoleKey<MigrateRole>>(&arg0.roles, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg0);
        let v1 = RoleKey<AdminRole>{owner: 0x2::tx_context::sender(arg0)};
        let v2 = AdminRole{dummy_field: false};
        0x2::bag::add<RoleKey<AdminRole>, AdminRole>(&mut v0, v1, v2);
        let v3 = VaultAdmin{
            id           : 0x2::object::new(arg0),
            admin_count  : 1,
            roles        : v0,
            timelock_cap : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<VaultAdmin>(v3);
    }

    public fun is_timelock_enabled(arg0: &VaultAdmin) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.timelock_cap)
    }

    public(friend) fun remove_admin(arg0: &mut VaultAdmin, arg1: address) {
        let v0 = RoleKey<AdminRole>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<AdminRole>>(&arg0.roles, v0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_role_not_assigned());
        assert!(arg0.admin_count > 1, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_last_admin_not_removable());
        let v1 = RoleKey<AdminRole>{owner: arg1};
        let AdminRole {  } = 0x2::bag::remove<RoleKey<AdminRole>, AdminRole>(&mut arg0.roles, v1);
        arg0.admin_count = arg0.admin_count - 1;
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_remove_admin(arg1);
    }

    public(friend) fun revoke_auth(arg0: &mut VaultAdmin, arg1: address) {
        let v0 = RoleKey<AuthorizeRole>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<AuthorizeRole>>(&arg0.roles, v0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_role_not_assigned());
        let v1 = RoleKey<AuthorizeRole>{owner: arg1};
        let AuthorizeRole {  } = 0x2::bag::remove<RoleKey<AuthorizeRole>, AuthorizeRole>(&mut arg0.roles, v1);
    }

    public(friend) fun revoke_migrator(arg0: &mut VaultAdmin, arg1: address) {
        let v0 = RoleKey<MigrateRole>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<MigrateRole>>(&arg0.roles, v0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_role_not_assigned());
        let v1 = RoleKey<MigrateRole>{owner: arg1};
        let MigrateRole {  } = 0x2::bag::remove<RoleKey<MigrateRole>, MigrateRole>(&mut arg0.roles, v1);
    }

    public(friend) fun revoke_rebalancer(arg0: &mut VaultAdmin, arg1: address, arg2: 0x2::object::ID) {
        let v0 = MarketRoleKey<RebalancerRole>{
            owner  : arg1,
            market : arg2,
        };
        assert!(0x2::bag::contains<MarketRoleKey<RebalancerRole>>(&arg0.roles, v0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_role_not_assigned());
        let v1 = MarketRoleKey<RebalancerRole>{
            owner  : arg1,
            market : arg2,
        };
        let RebalancerRole {  } = 0x2::bag::remove<MarketRoleKey<RebalancerRole>, RebalancerRole>(&mut arg0.roles, v1);
    }

    public(friend) fun store_display_cap<T0>(arg0: &mut VaultAdmin, arg1: 0x2::display_registry::DisplayCap<T0>) {
        let v0 = DisplayCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<DisplayCapKey, 0x2::display_registry::DisplayCap<T0>>(&mut arg0.id, v0, arg1);
    }

    public fun timelock_ticket(arg0: &VaultAdmin, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockCap) : 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockTicket {
        assert!(arg0.timelock_cap == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::TimelockCap>(arg1)), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_admin_wrong_timelock_cap());
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap::new_ticket(arg1)
    }

    // decompiled from Move bytecode v7
}

