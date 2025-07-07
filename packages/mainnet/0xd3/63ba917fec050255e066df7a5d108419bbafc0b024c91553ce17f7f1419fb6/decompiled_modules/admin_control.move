module 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::admin_control {
    struct VaultConfigAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RiskAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauseAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct UnpauseAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RebalanceAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasuryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CapabilityIssuedEvent has copy, drop {
        admin: address,
        user: address,
        capability_type: vector<u8>,
        timestamp: u64,
    }

    struct ACL has store, key {
        id: 0x2::object::UID,
        permissions: 0x2::vec_map::VecMap<address, u128>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ACL{
            id          : 0x2::object::new(arg0),
            permissions : 0x2::vec_map::empty<address, u128>(),
        };
        0x2::vec_map::insert<address, u128>(&mut v0.permissions, 0x2::tx_context::sender(arg0), 1 << 127);
        0x2::transfer::share_object<ACL>(v0);
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 128, 0);
        assert!(has_role(arg0, 0x2::tx_context::sender(arg3), 127), 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::error::acl_invalid_permission());
        assert!(!has_role(arg0, arg1, arg2), 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::error::acl_role_already_exists());
        if (0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<address, u128>(&mut arg0.permissions, &arg1);
            *v0 = *v0 | 1 << arg2;
        } else {
            0x2::vec_map::insert<address, u128>(&mut arg0.permissions, arg1, 1 << arg2);
        };
    }

    public fun admin_role() : u8 {
        127
    }

    public fun fee_admin_role() : u8 {
        9
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 0);
        if (0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1) && *0x2::vec_map::get<address, u128>(&arg0.permissions, &arg1) & 1 << 127 > 0) {
            return true
        };
        0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1) && *0x2::vec_map::get<address, u128>(&arg0.permissions, &arg1) & 1 << arg2 > 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new(arg0);
    }

    public fun issue_capabilities_for_user(arg0: &ACL, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<VaultConfigAdminCap>, 0x1::option::Option<RiskAdminCap>, 0x1::option::Option<FeeAdminCap>, 0x1::option::Option<RebalanceAdminCap>, 0x1::option::Option<TreasuryAdminCap>, 0x1::option::Option<PauseAdminCap>, 0x1::option::Option<UnpauseAdminCap>) {
        let v0 = 0x1::option::none<VaultConfigAdminCap>();
        let v1 = 0x1::option::none<RiskAdminCap>();
        let v2 = 0x1::option::none<FeeAdminCap>();
        let v3 = 0x1::option::none<RebalanceAdminCap>();
        let v4 = 0x1::option::none<TreasuryAdminCap>();
        let v5 = 0x1::option::none<PauseAdminCap>();
        let v6 = 0x1::option::none<UnpauseAdminCap>();
        if (has_role(arg0, arg1, 5)) {
            let v7 = issue_vault_config_cap(arg0, arg1, arg2);
            0x1::option::fill<VaultConfigAdminCap>(&mut v0, v7);
        };
        if (has_role(arg0, arg1, 6)) {
            let v8 = issue_risk_admin_cap(arg0, arg1, arg2);
            0x1::option::fill<RiskAdminCap>(&mut v1, v8);
        };
        if (has_role(arg0, arg1, 9)) {
            let v9 = issue_fee_admin_cap(arg0, arg1, arg2);
            0x1::option::fill<FeeAdminCap>(&mut v2, v9);
        };
        if (has_role(arg0, arg1, 10)) {
            let v10 = issue_rebalance_admin_cap(arg0, arg1, arg2);
            0x1::option::fill<RebalanceAdminCap>(&mut v3, v10);
        };
        if (has_role(arg0, arg1, 11)) {
            let v11 = issue_treasury_admin_cap(arg0, arg1, arg2);
            0x1::option::fill<TreasuryAdminCap>(&mut v4, v11);
        };
        if (has_role(arg0, arg1, 7)) {
            let v12 = issue_pause_admin_cap(arg0, arg1, arg2);
            0x1::option::fill<PauseAdminCap>(&mut v5, v12);
        };
        if (has_role(arg0, arg1, 8)) {
            0x1::option::fill<UnpauseAdminCap>(&mut v6, issue_unpause_admin_cap(arg0, arg1, arg2));
        };
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public fun issue_fee_admin_cap(arg0: &ACL, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : FeeAdminCap {
        assert!(has_role(arg0, arg1, 9), 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::error::acl_invalid_permission());
        let v0 = FeeAdminCap{id: 0x2::object::new(arg2)};
        let v1 = CapabilityIssuedEvent{
            admin           : 0x2::tx_context::sender(arg2),
            user            : arg1,
            capability_type : b"FeeAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<CapabilityIssuedEvent>(v1);
        v0
    }

    public fun issue_pause_admin_cap(arg0: &ACL, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : PauseAdminCap {
        assert!(has_role(arg0, arg1, 7), 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::error::acl_invalid_permission());
        let v0 = PauseAdminCap{id: 0x2::object::new(arg2)};
        let v1 = CapabilityIssuedEvent{
            admin           : 0x2::tx_context::sender(arg2),
            user            : arg1,
            capability_type : b"PauseAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<CapabilityIssuedEvent>(v1);
        v0
    }

    public fun issue_rebalance_admin_cap(arg0: &ACL, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : RebalanceAdminCap {
        assert!(has_role(arg0, arg1, 10), 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::error::acl_invalid_permission());
        let v0 = RebalanceAdminCap{id: 0x2::object::new(arg2)};
        let v1 = CapabilityIssuedEvent{
            admin           : 0x2::tx_context::sender(arg2),
            user            : arg1,
            capability_type : b"RebalanceAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<CapabilityIssuedEvent>(v1);
        v0
    }

    public fun issue_risk_admin_cap(arg0: &ACL, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : RiskAdminCap {
        assert!(has_role(arg0, arg1, 6), 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::error::acl_invalid_permission());
        let v0 = RiskAdminCap{id: 0x2::object::new(arg2)};
        let v1 = CapabilityIssuedEvent{
            admin           : 0x2::tx_context::sender(arg2),
            user            : arg1,
            capability_type : b"RiskAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<CapabilityIssuedEvent>(v1);
        v0
    }

    public fun issue_treasury_admin_cap(arg0: &ACL, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : TreasuryAdminCap {
        assert!(has_role(arg0, arg1, 11), 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::error::acl_invalid_permission());
        let v0 = TreasuryAdminCap{id: 0x2::object::new(arg2)};
        let v1 = CapabilityIssuedEvent{
            admin           : 0x2::tx_context::sender(arg2),
            user            : arg1,
            capability_type : b"TreasuryAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<CapabilityIssuedEvent>(v1);
        v0
    }

    public fun issue_unpause_admin_cap(arg0: &ACL, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : UnpauseAdminCap {
        assert!(has_role(arg0, arg1, 8), 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::error::acl_invalid_permission());
        let v0 = UnpauseAdminCap{id: 0x2::object::new(arg2)};
        let v1 = CapabilityIssuedEvent{
            admin           : 0x2::tx_context::sender(arg2),
            user            : arg1,
            capability_type : b"UnpauseAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<CapabilityIssuedEvent>(v1);
        v0
    }

    public fun issue_vault_config_cap(arg0: &ACL, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : VaultConfigAdminCap {
        assert!(has_role(arg0, arg1, 5), 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::error::acl_invalid_permission());
        let v0 = VaultConfigAdminCap{id: 0x2::object::new(arg2)};
        let v1 = CapabilityIssuedEvent{
            admin           : 0x2::tx_context::sender(arg2),
            user            : arg1,
            capability_type : b"VaultConfigAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<CapabilityIssuedEvent>(v1);
        v0
    }

    public fun rebalance_admin_role() : u8 {
        10
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 128, 0);
        assert!(has_role(arg0, 0x2::tx_context::sender(arg3), 127), 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::error::acl_invalid_permission());
        assert!(has_role(arg0, arg1, arg2), 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::error::acl_role_not_exists());
        if (0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<address, u128>(&mut arg0.permissions, &arg1);
            *v0 = *v0 - (1 << arg2);
        };
    }

    public fun risk_admin_role() : u8 {
        6
    }

    public fun set_roles(arg0: &mut ACL, arg1: address, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_role(arg0, 0x2::tx_context::sender(arg3), 127), 0xd363ba917fec050255e066df7a5d108419bbafc0b024c91553ce17f7f1419fb6::error::acl_invalid_permission());
        if (0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1)) {
            *0x2::vec_map::get_mut<address, u128>(&mut arg0.permissions, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<address, u128>(&mut arg0.permissions, arg1, arg2);
        };
    }

    public fun treasury_admin_role() : u8 {
        11
    }

    public fun vault_config_admin_role() : u8 {
        5
    }

    // decompiled from Move bytecode v6
}

