module 0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::access_control {
    struct AccessConfig has key {
        id: 0x2::object::UID,
        default_admin: address,
        proposed_default_admin: 0x1::option::Option<AdminChange>,
        admins: vector<address>,
        emergency_controller_role_admin: address,
        emergency_controllers: vector<address>,
        liquidator_role_admin: address,
        liquidators: vector<address>,
        treasury: address,
        paused: bool,
        version: u64,
    }

    struct DefaultAdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminChange has copy, drop, store {
        proposed_admin: address,
        accepted: bool,
    }

    struct DefaultRoleAdminTransferred has copy, drop {
        cap_id: 0x1::option::Option<address>,
        from: address,
        to: address,
    }

    struct ProposedDefaultAdminChange has copy, drop {
        new_admin: address,
        old_admin: address,
    }

    struct RoleAdminTransferred has copy, drop {
        role: 0x1::string::String,
        new_admin: address,
        old_admin: address,
    }

    struct EmergencyControllerSet has copy, drop {
        emergency_controller: address,
        add: bool,
    }

    struct LiquidatorSet has copy, drop {
        liquidator: address,
        add: bool,
    }

    struct AdminRoleSet has copy, drop {
        admin: address,
        add: bool,
    }

    struct TreasurySet has copy, drop {
        old_treasury: address,
        new_treasury: address,
    }

    struct PauseSet has copy, drop {
        paused: bool,
    }

    public entry fun accept_default_admin(arg0: &mut AccessConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow_mut<AdminChange>(&mut arg0.proposed_default_admin);
        assert!(0x2::tx_context::sender(arg1) == v0.proposed_admin, 2);
        v0.accepted = true;
    }

    public fun assert_admin_role(arg0: address, arg1: &AccessConfig) {
        assert!(0x1::vector::contains<address>(&arg1.admins, &arg0), 2);
    }

    public fun assert_emergency_controller(arg0: address, arg1: &AccessConfig) {
        let v0 = get_emergency_controller(arg1);
        assert!(0x1::vector::contains<address>(&v0, &arg0), 2);
    }

    public fun assert_emergency_controller_role_admin(arg0: address, arg1: &AccessConfig) {
        assert!(arg1.emergency_controller_role_admin == arg0, 2);
    }

    public fun assert_liquidator(arg0: address, arg1: &AccessConfig) {
        let v0 = get_liquidators(arg1);
        assert!(0x1::vector::contains<address>(&v0, &arg0), 2);
    }

    public fun assert_liquidator_role_admin(arg0: address, arg1: &AccessConfig) {
        assert!(arg1.liquidator_role_admin == arg0, 2);
    }

    public fun assert_not_paused(arg0: &AccessConfig) {
        assert!(!is_paused(arg0), 0);
        check_version(arg0.version);
    }

    public fun assert_treasury(arg0: address, arg1: &AccessConfig) {
        assert!(arg1.treasury == arg0, 2);
    }

    fun check_version(arg0: u64) {
        assert!(arg0 == 0, 6);
    }

    public entry fun execute_default_admin_change_proposal(arg0: &mut AccessConfig, arg1: DefaultAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow_mut<AdminChange>(&mut arg0.proposed_default_admin);
        let v1 = v0.proposed_admin;
        assert!(v0.accepted == true, 4);
        arg0.proposed_default_admin = 0x1::option::none<AdminChange>();
        arg0.default_admin = v1;
        0x2::transfer::transfer<DefaultAdminCap>(arg1, v1);
        let v2 = DefaultRoleAdminTransferred{
            cap_id : 0x1::option::some<address>(0x2::object::uid_to_address(&arg1.id)),
            from   : 0x2::tx_context::sender(arg2),
            to     : v1,
        };
        0x2::event::emit<DefaultRoleAdminTransferred>(v2);
    }

    public fun get_admin_role(arg0: &AccessConfig) : vector<address> {
        arg0.admins
    }

    public fun get_emergency_controller(arg0: &AccessConfig) : vector<address> {
        arg0.emergency_controllers
    }

    public fun get_emergency_controller_role_admin(arg0: &AccessConfig) : address {
        arg0.emergency_controller_role_admin
    }

    public fun get_liquidator_role_admin(arg0: &AccessConfig) : address {
        arg0.liquidator_role_admin
    }

    public fun get_liquidators(arg0: &AccessConfig) : vector<address> {
        arg0.liquidators
    }

    public fun get_treasury(arg0: &AccessConfig) : address {
        arg0.treasury
    }

    public fun has_emergency_controller(arg0: &AccessConfig) : bool {
        let v0 = get_emergency_controller(arg0);
        0x1::vector::length<address>(&v0) != 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DefaultAdminCap{id: 0x2::object::new(arg0)};
        let v1 = DefaultRoleAdminTransferred{
            cap_id : 0x1::option::some<address>(0x2::object::uid_to_address(&v0.id)),
            from   : @0x0,
            to     : @0x742d4c30cbefdd742042095840f394f681512e835d9de10761ecb636cb6403e8,
        };
        0x2::event::emit<DefaultRoleAdminTransferred>(v1);
        let v2 = RoleAdminTransferred{
            role      : 0x1::string::utf8(b"emergency_controller_role_admin"),
            new_admin : @0x742d4c30cbefdd742042095840f394f681512e835d9de10761ecb636cb6403e8,
            old_admin : @0x0,
        };
        0x2::event::emit<RoleAdminTransferred>(v2);
        let v3 = RoleAdminTransferred{
            role      : 0x1::string::utf8(b"liquidator_role_admin"),
            new_admin : @0x742d4c30cbefdd742042095840f394f681512e835d9de10761ecb636cb6403e8,
            old_admin : @0x0,
        };
        0x2::event::emit<RoleAdminTransferred>(v3);
        0x2::transfer::transfer<DefaultAdminCap>(v0, @0x742d4c30cbefdd742042095840f394f681512e835d9de10761ecb636cb6403e8);
        let v4 = AccessConfig{
            id                              : 0x2::object::new(arg0),
            default_admin                   : @0x742d4c30cbefdd742042095840f394f681512e835d9de10761ecb636cb6403e8,
            proposed_default_admin          : 0x1::option::none<AdminChange>(),
            admins                          : vector[@0x742d4c30cbefdd742042095840f394f681512e835d9de10761ecb636cb6403e8],
            emergency_controller_role_admin : @0x742d4c30cbefdd742042095840f394f681512e835d9de10761ecb636cb6403e8,
            emergency_controllers           : vector[@0x742d4c30cbefdd742042095840f394f681512e835d9de10761ecb636cb6403e8],
            liquidator_role_admin           : @0x742d4c30cbefdd742042095840f394f681512e835d9de10761ecb636cb6403e8,
            liquidators                     : vector[@0x742d4c30cbefdd742042095840f394f681512e835d9de10761ecb636cb6403e8],
            treasury                        : @0x8b4332306b36ae2893141037a4463070e3f5eb6208c841771532b02517e5f79f,
            paused                          : false,
            version                         : 0,
        };
        0x2::transfer::share_object<AccessConfig>(v4);
    }

    public fun is_paused(arg0: &AccessConfig) : bool {
        arg0.paused
    }

    entry fun migrate(arg0: &mut AccessConfig, arg1: &DefaultAdminCap) {
        assert!(arg0.version < 0, 5);
        arg0.version = 0;
    }

    public entry fun propose_new_default_admin(arg0: &DefaultAdminCap, arg1: &mut AccessConfig, arg2: address) {
        assert!(arg2 != @0x0, 3);
        let v0 = AdminChange{
            proposed_admin : arg2,
            accepted       : false,
        };
        arg1.proposed_default_admin = 0x1::option::some<AdminChange>(v0);
        let v1 = ProposedDefaultAdminChange{
            new_admin : arg2,
            old_admin : arg1.default_admin,
        };
        0x2::event::emit<ProposedDefaultAdminChange>(v1);
    }

    public entry fun retract_change_admin_proposal(arg0: &DefaultAdminCap, arg1: &mut AccessConfig) {
        arg1.proposed_default_admin = 0x1::option::none<AdminChange>();
    }

    public entry fun set_admin_role(arg0: &mut AccessConfig, arg1: &DefaultAdminCap, arg2: address, arg3: bool) {
        assert!(arg2 != @0x0, 3);
        if (arg3) {
            assert!(!0x1::vector::contains<address>(&arg0.admins, &arg2), 1);
            0x1::vector::push_back<address>(&mut arg0.admins, arg2);
        } else {
            let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg2);
            assert!(v0, 1);
            0x1::vector::remove<address>(&mut arg0.admins, v1);
        };
        let v2 = AdminRoleSet{
            admin : arg2,
            add   : arg3,
        };
        0x2::event::emit<AdminRoleSet>(v2);
    }

    public entry fun set_emergency_controller(arg0: &mut AccessConfig, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_emergency_controller_role_admin(0x2::tx_context::sender(arg3), arg0);
        assert!(arg1 != @0x0, 3);
        if (arg2) {
            assert!(!0x1::vector::contains<address>(&arg0.emergency_controllers, &arg1), 1);
            0x1::vector::push_back<address>(&mut arg0.emergency_controllers, arg1);
        } else {
            let (v0, v1) = 0x1::vector::index_of<address>(&arg0.emergency_controllers, &arg1);
            assert!(v0, 1);
            0x1::vector::remove<address>(&mut arg0.emergency_controllers, v1);
        };
        let v2 = EmergencyControllerSet{
            emergency_controller : arg1,
            add                  : arg2,
        };
        0x2::event::emit<EmergencyControllerSet>(v2);
    }

    public entry fun set_emergency_controller_admin(arg0: &mut AccessConfig, arg1: address, arg2: &DefaultAdminCap) {
        assert!(arg1 != @0x0, 3);
        assert!(arg0.emergency_controller_role_admin != arg1, 1);
        arg0.emergency_controller_role_admin = arg1;
        let v0 = RoleAdminTransferred{
            role      : 0x1::string::utf8(b"emergency_controller_admin"),
            new_admin : arg1,
            old_admin : arg0.emergency_controller_role_admin,
        };
        0x2::event::emit<RoleAdminTransferred>(v0);
    }

    public entry fun set_liquidator(arg0: &mut AccessConfig, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_liquidator_role_admin(0x2::tx_context::sender(arg3), arg0);
        assert!(arg1 != @0x0, 3);
        if (arg2) {
            assert!(!0x1::vector::contains<address>(&arg0.liquidators, &arg1), 1);
            0x1::vector::push_back<address>(&mut arg0.liquidators, arg1);
        } else {
            let (v0, v1) = 0x1::vector::index_of<address>(&arg0.liquidators, &arg1);
            assert!(v0, 1);
            0x1::vector::remove<address>(&mut arg0.liquidators, v1);
        };
        let v2 = LiquidatorSet{
            liquidator : arg1,
            add        : arg2,
        };
        0x2::event::emit<LiquidatorSet>(v2);
    }

    public entry fun set_liquidator_admin(arg0: &mut AccessConfig, arg1: address, arg2: &DefaultAdminCap) {
        assert!(arg1 != @0x0, 3);
        assert!(arg0.liquidator_role_admin != arg1, 1);
        arg0.liquidator_role_admin = arg1;
        let v0 = RoleAdminTransferred{
            role      : 0x1::string::utf8(b"liquidator_admin"),
            new_admin : arg1,
            old_admin : arg0.liquidator_role_admin,
        };
        0x2::event::emit<RoleAdminTransferred>(v0);
    }

    public entry fun set_pause(arg0: &mut AccessConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_emergency_controller(0x2::tx_context::sender(arg2), arg0);
        assert!(is_paused(arg0) != arg1, 1);
        arg0.paused = arg1;
        let v0 = PauseSet{paused: arg1};
        0x2::event::emit<PauseSet>(v0);
    }

    public entry fun set_treasury(arg0: &DefaultAdminCap, arg1: &mut AccessConfig, arg2: address) {
        assert!(arg2 != @0x0, 3);
        assert!(arg2 != arg1.treasury, 1);
        arg1.treasury = arg2;
        let v0 = TreasurySet{
            old_treasury : arg1.treasury,
            new_treasury : arg2,
        };
        0x2::event::emit<TreasurySet>(v0);
    }

    // decompiled from Move bytecode v6
}

