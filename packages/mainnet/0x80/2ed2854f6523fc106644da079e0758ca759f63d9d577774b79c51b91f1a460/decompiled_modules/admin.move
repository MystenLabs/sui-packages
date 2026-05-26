module 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::admin {
    struct PartnerRegistry has key {
        id: 0x2::object::UID,
        partners: 0x2::table::Table<address, PartnerInfo>,
        admins: 0x2::table::Table<address, AdminRole>,
        global_settings: GlobalSettings,
        super_admin: address,
        partner_count: u64,
    }

    struct PartnerInfo has copy, drop, store {
        name: 0x1::string::String,
        contact_info: 0x1::string::String,
        status: u8,
        permissions: PartnerPermissions,
        limits: PartnerLimits,
        created_at: u64,
        last_activity: u64,
        total_markets_created: u64,
        total_volume: u128,
        reputation_score: u64,
    }

    struct PartnerPermissions has copy, drop, store {
        can_create_markets: bool,
        can_create_treasuries: bool,
        can_set_fees: bool,
        can_pause_markets: bool,
        can_update_terms: bool,
        max_fee_rate: u64,
        requires_approval: bool,
    }

    struct PartnerLimits has copy, drop, store {
        max_markets: u64,
        max_treasury_balance: u128,
        max_single_bond_size: u64,
        daily_volume_limit: u128,
        daily_volume_used: u128,
        last_limit_reset: u64,
    }

    struct AdminRole has copy, drop, store {
        can_approve_partners: bool,
        can_suspend_partners: bool,
        can_modify_limits: bool,
        can_access_analytics: bool,
        can_emergency_actions: bool,
        role_level: u8,
    }

    struct GlobalSettings has copy, drop, store {
        platform_fee_rate: u64,
        min_bond_size: u64,
        max_bond_size: u64,
        emergency_pause: bool,
        maintenance_mode: bool,
    }

    struct PartnerRegisteredEvent has copy, drop {
        partner: address,
        name: 0x1::string::String,
        admin: address,
        timestamp: u64,
    }

    struct PartnerStatusChangedEvent has copy, drop {
        partner: address,
        old_status: u8,
        new_status: u8,
        admin: address,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct EmergencyActionEvent has copy, drop {
        action_type: 0x1::string::String,
        target: address,
        admin: address,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    public fun admin_role(arg0: &PartnerRegistry, arg1: address) : (bool, bool, bool, bool, bool, bool, u8) {
        if (!0x2::table::contains<address, AdminRole>(&arg0.admins, arg1)) {
            return (false, false, false, false, false, false, 0)
        };
        let v0 = 0x2::table::borrow<address, AdminRole>(&arg0.admins, arg1);
        (true, v0.can_approve_partners, v0.can_suspend_partners, v0.can_modify_limits, v0.can_access_analytics, v0.can_emergency_actions, v0.role_level)
    }

    public fun emergency_pause_platform(arg0: &mut PartnerRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        validate_admin_permission(arg0, v0, false, false, false, false, true);
        arg0.global_settings.emergency_pause = true;
        let v1 = EmergencyActionEvent{
            action_type : 0x1::string::utf8(b"emergency_pause"),
            target      : 0x2::object::id_address<PartnerRegistry>(arg0),
            admin       : v0,
            reason      : arg1,
            timestamp   : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<EmergencyActionEvent>(v1);
    }

    public fun get_super_admin(arg0: &PartnerRegistry) : address {
        arg0.super_admin
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::table::new<address, AdminRole>(arg0);
        let v2 = AdminRole{
            can_approve_partners  : true,
            can_suspend_partners  : true,
            can_modify_limits     : true,
            can_access_analytics  : true,
            can_emergency_actions : true,
            role_level            : 3,
        };
        0x2::table::add<address, AdminRole>(&mut v1, v0, v2);
        let v3 = GlobalSettings{
            platform_fee_rate : 100,
            min_bond_size     : 1000,
            max_bond_size     : 1000000000,
            emergency_pause   : false,
            maintenance_mode  : false,
        };
        let v4 = PartnerRegistry{
            id              : 0x2::object::new(arg0),
            partners        : 0x2::table::new<address, PartnerInfo>(arg0),
            admins          : v1,
            global_settings : v3,
            super_admin     : v0,
            partner_count   : 0,
        };
        0x2::transfer::share_object<PartnerRegistry>(v4);
    }

    public fun is_partner_authorized(arg0: &PartnerRegistry, arg1: address, arg2: vector<u8>) : bool {
        if (arg0.global_settings.emergency_pause) {
            return false
        };
        if (!0x2::table::contains<address, PartnerInfo>(&arg0.partners, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, PartnerInfo>(&arg0.partners, arg1);
        if (v0.status != 1) {
            return false
        };
        arg2 == b"create_market" && v0.permissions.can_create_markets && v0.total_markets_created < v0.limits.max_markets || arg2 == b"create_treasury" && v0.permissions.can_create_treasuries
    }

    public fun partner_info(arg0: &PartnerRegistry, arg1: address) : (0x1::string::String, 0x1::string::String, u8, u64, u64, u128) {
        assert!(0x2::table::contains<address, PartnerInfo>(&arg0.partners, arg1), 4);
        let v0 = 0x2::table::borrow<address, PartnerInfo>(&arg0.partners, arg1);
        (v0.name, v0.contact_info, v0.status, v0.total_markets_created, v0.reputation_score, v0.total_volume)
    }

    public fun platform_stats(arg0: &PartnerRegistry) : (u64, bool, bool) {
        (arg0.partner_count, arg0.global_settings.emergency_pause, arg0.global_settings.maintenance_mode)
    }

    public fun register_partner(arg0: &mut PartnerRegistry, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        validate_admin_permission(arg0, v0, true, false, false, false, false);
        assert!(!0x2::table::contains<address, PartnerInfo>(&arg0.partners, arg1), 5);
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v2 = PartnerPermissions{
            can_create_markets    : true,
            can_create_treasuries : true,
            can_set_fees          : false,
            can_pause_markets     : true,
            can_update_terms      : false,
            max_fee_rate          : 1000,
            requires_approval     : false,
        };
        let v3 = PartnerLimits{
            max_markets          : arg4,
            max_treasury_balance : 1000000000,
            max_single_bond_size : 10000000,
            daily_volume_limit   : 100000000,
            daily_volume_used    : 0,
            last_limit_reset     : v1,
        };
        let v4 = PartnerInfo{
            name                  : arg2,
            contact_info          : arg3,
            status                : 1,
            permissions           : v2,
            limits                : v3,
            created_at            : v1,
            last_activity         : v1,
            total_markets_created : 0,
            total_volume          : 0,
            reputation_score      : 100,
        };
        0x2::table::add<address, PartnerInfo>(&mut arg0.partners, arg1, v4);
        arg0.partner_count = arg0.partner_count + 1;
        let v5 = PartnerRegisteredEvent{
            partner   : arg1,
            name      : arg2,
            admin     : v0,
            timestamp : v1,
        };
        0x2::event::emit<PartnerRegisteredEvent>(v5);
    }

    public fun set_emergency_pause(arg0: &mut PartnerRegistry, arg1: bool, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        validate_admin_permission(arg0, v0, false, false, false, false, true);
        arg0.global_settings.emergency_pause = arg1;
        let v1 = if (arg1) {
            0x1::string::utf8(b"emergency_pause")
        } else {
            0x1::string::utf8(b"emergency_unpause")
        };
        let v2 = EmergencyActionEvent{
            action_type : v1,
            target      : 0x2::object::id_address<PartnerRegistry>(arg0),
            admin       : v0,
            reason      : 0x1::string::utf8(b"Emergency pause state changed"),
            timestamp   : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<EmergencyActionEvent>(v2);
    }

    public fun set_maintenance_mode(arg0: &mut PartnerRegistry, arg1: bool, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        validate_admin_permission(arg0, v0, false, false, true, false, false);
        arg0.global_settings.maintenance_mode = arg1;
        let v1 = if (arg1) {
            0x1::string::utf8(b"maintenance_on")
        } else {
            0x1::string::utf8(b"maintenance_off")
        };
        let v2 = EmergencyActionEvent{
            action_type : v1,
            target      : 0x2::object::id_address<PartnerRegistry>(arg0),
            admin       : v0,
            reason      : 0x1::string::utf8(b"Maintenance mode changed"),
            timestamp   : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<EmergencyActionEvent>(v2);
    }

    public fun update_partner_status(arg0: &mut PartnerRegistry, arg1: address, arg2: u8, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        validate_admin_permission(arg0, v0, false, true, false, false, false);
        assert!(arg2 <= 3, 7);
        assert!(0x2::table::contains<address, PartnerInfo>(&arg0.partners, arg1), 4);
        let v1 = 0x2::table::borrow_mut<address, PartnerInfo>(&mut arg0.partners, arg1);
        v1.status = arg2;
        let v2 = PartnerStatusChangedEvent{
            partner    : arg1,
            old_status : v1.status,
            new_status : arg2,
            admin      : v0,
            reason     : arg3,
            timestamp  : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<PartnerStatusChangedEvent>(v2);
    }

    fun validate_admin_permission(arg0: &PartnerRegistry, arg1: address, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: bool) {
        assert!(0x2::table::contains<address, AdminRole>(&arg0.admins, arg1), 2);
        let v0 = 0x2::table::borrow<address, AdminRole>(&arg0.admins, arg1);
        if (arg2) {
            assert!(v0.can_approve_partners, 6);
        };
        if (arg3) {
            assert!(v0.can_suspend_partners, 6);
        };
        if (arg4) {
            assert!(v0.can_modify_limits, 6);
        };
        if (arg5) {
            assert!(v0.can_access_analytics, 6);
        };
        if (arg6) {
            assert!(v0.can_emergency_actions, 6);
        };
    }

    public fun validate_partner_action(arg0: &PartnerRegistry, arg1: address, arg2: vector<u8>) {
        assert!(!arg0.global_settings.emergency_pause, 7);
        assert!(0x2::table::contains<address, PartnerInfo>(&arg0.partners, arg1), 4);
        let v0 = 0x2::table::borrow<address, PartnerInfo>(&arg0.partners, arg1);
        assert!(v0.status == 1, 7);
        if (arg2 == b"create_market") {
            assert!(v0.permissions.can_create_markets, 6);
            assert!(v0.total_markets_created < v0.limits.max_markets, 8);
        } else if (arg2 == b"create_treasury") {
            assert!(v0.permissions.can_create_treasuries, 6);
        };
    }

    // decompiled from Move bytecode v7
}

