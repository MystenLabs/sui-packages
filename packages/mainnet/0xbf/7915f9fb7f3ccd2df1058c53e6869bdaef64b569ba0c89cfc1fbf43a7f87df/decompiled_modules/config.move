module 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        paused: bool,
        acl: 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::acl::ACL,
        min_sig_expiry_seconds: u16,
        max_sig_expiry_seconds: u16,
        default_fee_bps: u16,
    }

    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct ConfigInitializedEvent has copy, drop {
        config_id: 0x2::object::ID,
        deployer: address,
        initial_roles: u128,
    }

    struct CommonParamSetEvent has copy, drop {
        key: u8,
        value: u64,
    }

    struct GlobalPausedEvent has copy, drop {
        paused: bool,
    }

    struct SetRolesEvent has copy, drop {
        member: address,
        roles: u128,
    }

    struct SuperAdminAclRoleAddedEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct SuperAdminAclRoleRemovedEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct SuperAdminAclMemberRemovedEvent has copy, drop {
        member: address,
    }

    public(friend) fun acl_ref(arg0: &GlobalConfig) : &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::acl::ACL {
        &arg0.acl
    }

    public(friend) fun assert_fee_collector(arg0: &GlobalConfig, arg1: address) {
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::acl::has_role(&arg0.acl, arg1, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::acl_fee_collector()), 10);
    }

    public(friend) fun assert_fee_manager(arg0: &GlobalConfig, arg1: address) {
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::acl::has_role(&arg0.acl, arg1, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::acl_fee_manager()), 9);
    }

    public(friend) fun assert_mm_registrar(arg0: &GlobalConfig, arg1: address) {
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::acl::has_role(&arg0.acl, arg1, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::acl_mm_registrar()), 4);
    }

    public(friend) fun assert_not_paused(arg0: &GlobalConfig) {
        assert!(!arg0.paused, 1);
    }

    public(friend) fun assert_param_manager(arg0: &GlobalConfig, arg1: address) {
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::acl::has_role(&arg0.acl, arg1, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::acl_param_manager()), 2);
    }

    public(friend) fun assert_pauser(arg0: &GlobalConfig, arg1: address) {
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::acl::has_role(&arg0.acl, arg1, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::acl_pauser()), 3);
    }

    public fun default_fee_bps(arg0: &GlobalConfig) : u16 {
        arg0.default_fee_bps
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::acl::new(arg1);
        let v2 = 1 << 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::acl_param_manager() | 1 << 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::acl_pauser() | 1 << 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::acl_mm_registrar();
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::acl::set_roles(&mut v1, v0, v2);
        let v3 = GlobalConfig{
            id                     : 0x2::object::new(arg1),
            paused                 : false,
            acl                    : v1,
            min_sig_expiry_seconds : 15,
            max_sig_expiry_seconds : 120,
            default_fee_bps        : 10,
        };
        let v4 = ConfigInitializedEvent{
            config_id     : 0x2::object::id<GlobalConfig>(&v3),
            deployer      : v0,
            initial_roles : v2,
        };
        0x2::event::emit<ConfigInitializedEvent>(v4);
        let v5 = SetRolesEvent{
            member : v0,
            roles  : v2,
        };
        0x2::event::emit<SetRolesEvent>(v5);
        0x2::transfer::share_object<GlobalConfig>(v3);
    }

    public fun max_sig_expiry_seconds(arg0: &GlobalConfig) : u16 {
        arg0.max_sig_expiry_seconds
    }

    public fun min_sig_expiry_seconds(arg0: &GlobalConfig) : u16 {
        arg0.min_sig_expiry_seconds
    }

    public fun paused(arg0: &GlobalConfig) : bool {
        arg0.paused
    }

    public fun set_common_param(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &mut GlobalConfig, arg2: u8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        assert_param_manager(arg1, 0x2::tx_context::sender(arg4));
        if (arg2 == 0) {
            assert!(arg3 <= (600 as u64), 6);
            let v0 = (arg3 as u16);
            assert!(v0 >= 5, 7);
            assert!(v0 <= arg1.max_sig_expiry_seconds, 8);
            arg1.min_sig_expiry_seconds = v0;
        } else {
            assert!(arg2 == 1, 5);
            assert!(arg3 <= (600 as u64), 6);
            let v1 = (arg3 as u16);
            assert!(v1 >= arg1.min_sig_expiry_seconds, 8);
            arg1.max_sig_expiry_seconds = v1;
        };
        let v2 = CommonParamSetEvent{
            key   : arg2,
            value : arg3,
        };
        0x2::event::emit<CommonParamSetEvent>(v2);
    }

    public(friend) fun set_default_fee_bps(arg0: &mut GlobalConfig, arg1: u16) {
        arg0.default_fee_bps = arg1;
    }

    public fun set_paused_global_true(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &mut GlobalConfig, arg2: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        assert_pauser(arg1, 0x2::tx_context::sender(arg2));
        arg1.paused = true;
        let v0 = GlobalPausedEvent{paused: true};
        0x2::event::emit<GlobalPausedEvent>(v0);
    }

    public fun super_admin_acl_add_role(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::admin_cap::SuperAdminCap, arg2: &mut GlobalConfig, arg3: address, arg4: u8) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::acl::add_role(&mut arg2.acl, arg3, arg4);
        let v0 = SuperAdminAclRoleAddedEvent{
            member : arg3,
            role   : arg4,
        };
        0x2::event::emit<SuperAdminAclRoleAddedEvent>(v0);
    }

    public fun super_admin_acl_remove_member(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::admin_cap::SuperAdminCap, arg2: &mut GlobalConfig, arg3: address) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::acl::remove_member(&mut arg2.acl, arg3);
        let v0 = SuperAdminAclMemberRemovedEvent{member: arg3};
        0x2::event::emit<SuperAdminAclMemberRemovedEvent>(v0);
    }

    public fun super_admin_acl_remove_role(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::admin_cap::SuperAdminCap, arg2: &mut GlobalConfig, arg3: address, arg4: u8) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::acl::remove_role(&mut arg2.acl, arg3, arg4);
        let v0 = SuperAdminAclRoleRemovedEvent{
            member : arg3,
            role   : arg4,
        };
        0x2::event::emit<SuperAdminAclRoleRemovedEvent>(v0);
    }

    public(friend) fun uid(arg0: &GlobalConfig) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut GlobalConfig) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun unpause_global(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::admin_cap::SuperAdminCap, arg2: &mut GlobalConfig) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        arg2.paused = false;
        let v0 = GlobalPausedEvent{paused: false};
        0x2::event::emit<GlobalPausedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

