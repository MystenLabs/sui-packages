module 0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::admin_control {
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

    struct CapabilityRevokedEvent has copy, drop {
        admin: address,
        user: address,
        capability_type: vector<u8>,
        timestamp: u64,
    }

    public fun issue_all_capabilities(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (VaultConfigAdminCap, RiskAdminCap, FeeAdminCap, RebalanceAdminCap, TreasuryAdminCap, PauseAdminCap, UnpauseAdminCap) {
        let v0 = issue_vault_config_cap(arg0, arg1, arg2);
        let v1 = issue_risk_admin_cap(arg0, arg1, arg2);
        let v2 = issue_fee_admin_cap(arg0, arg1, arg2);
        let v3 = issue_rebalance_admin_cap(arg0, arg1, arg2);
        let v4 = issue_treasury_admin_cap(arg0, arg1, arg2);
        let v5 = issue_pause_admin_cap(arg0, arg1, arg2);
        (v0, v1, v2, v3, v4, v5, issue_unpause_admin_cap(arg0, arg1, arg2))
    }

    public fun issue_fee_admin_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : FeeAdminCap {
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

    public fun issue_pause_admin_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : PauseAdminCap {
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

    public fun issue_rebalance_admin_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : RebalanceAdminCap {
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

    public fun issue_risk_admin_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : RiskAdminCap {
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

    public fun issue_specific_capabilities(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: address, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<VaultConfigAdminCap>, 0x1::option::Option<RiskAdminCap>, 0x1::option::Option<FeeAdminCap>, 0x1::option::Option<RebalanceAdminCap>, 0x1::option::Option<TreasuryAdminCap>, 0x1::option::Option<PauseAdminCap>, 0x1::option::Option<UnpauseAdminCap>) {
        let v0 = 0x1::option::none<VaultConfigAdminCap>();
        let v1 = 0x1::option::none<RiskAdminCap>();
        let v2 = 0x1::option::none<FeeAdminCap>();
        let v3 = 0x1::option::none<RebalanceAdminCap>();
        let v4 = 0x1::option::none<TreasuryAdminCap>();
        let v5 = 0x1::option::none<PauseAdminCap>();
        let v6 = 0x1::option::none<UnpauseAdminCap>();
        if (arg2) {
            let v7 = issue_vault_config_cap(arg0, arg1, arg9);
            0x1::option::fill<VaultConfigAdminCap>(&mut v0, v7);
        };
        if (arg3) {
            let v8 = issue_risk_admin_cap(arg0, arg1, arg9);
            0x1::option::fill<RiskAdminCap>(&mut v1, v8);
        };
        if (arg4) {
            let v9 = issue_fee_admin_cap(arg0, arg1, arg9);
            0x1::option::fill<FeeAdminCap>(&mut v2, v9);
        };
        if (arg5) {
            let v10 = issue_rebalance_admin_cap(arg0, arg1, arg9);
            0x1::option::fill<RebalanceAdminCap>(&mut v3, v10);
        };
        if (arg6) {
            let v11 = issue_treasury_admin_cap(arg0, arg1, arg9);
            0x1::option::fill<TreasuryAdminCap>(&mut v4, v11);
        };
        if (arg7) {
            let v12 = issue_pause_admin_cap(arg0, arg1, arg9);
            0x1::option::fill<PauseAdminCap>(&mut v5, v12);
        };
        if (arg8) {
            0x1::option::fill<UnpauseAdminCap>(&mut v6, issue_unpause_admin_cap(arg0, arg1, arg9));
        };
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public fun issue_treasury_admin_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : TreasuryAdminCap {
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

    public fun issue_unpause_admin_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : UnpauseAdminCap {
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

    public fun issue_vault_config_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : VaultConfigAdminCap {
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

    public fun revoke_fee_admin_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: FeeAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) != arg2, 0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::error::cannot_revoke_self());
        let FeeAdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = CapabilityRevokedEvent{
            admin           : 0x2::tx_context::sender(arg3),
            user            : arg2,
            capability_type : b"FeeAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<CapabilityRevokedEvent>(v1);
    }

    public fun revoke_pause_admin_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: PauseAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) != arg2, 0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::error::cannot_revoke_self());
        let PauseAdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = CapabilityRevokedEvent{
            admin           : 0x2::tx_context::sender(arg3),
            user            : arg2,
            capability_type : b"PauseAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<CapabilityRevokedEvent>(v1);
    }

    public fun revoke_rebalance_admin_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: RebalanceAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) != arg2, 0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::error::cannot_revoke_self());
        let RebalanceAdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = CapabilityRevokedEvent{
            admin           : 0x2::tx_context::sender(arg3),
            user            : arg2,
            capability_type : b"RebalanceAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<CapabilityRevokedEvent>(v1);
    }

    public fun revoke_risk_admin_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: RiskAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) != arg2, 0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::error::cannot_revoke_self());
        let RiskAdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = CapabilityRevokedEvent{
            admin           : 0x2::tx_context::sender(arg3),
            user            : arg2,
            capability_type : b"RiskAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<CapabilityRevokedEvent>(v1);
    }

    public fun revoke_treasury_admin_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: TreasuryAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) != arg2, 0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::error::cannot_revoke_self());
        let TreasuryAdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = CapabilityRevokedEvent{
            admin           : 0x2::tx_context::sender(arg3),
            user            : arg2,
            capability_type : b"TreasuryAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<CapabilityRevokedEvent>(v1);
    }

    public fun revoke_unpause_admin_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: UnpauseAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) != arg2, 0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::error::cannot_revoke_self());
        let UnpauseAdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = CapabilityRevokedEvent{
            admin           : 0x2::tx_context::sender(arg3),
            user            : arg2,
            capability_type : b"UnpauseAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<CapabilityRevokedEvent>(v1);
    }

    public fun revoke_vault_config_cap(arg0: &0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::vault::AdminCap, arg1: VaultConfigAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) != arg2, 0x5ba4a65494c0b709adbad7f8d75b7b2b69a4a72aafcf1cdeab92595878509428::error::cannot_revoke_self());
        let VaultConfigAdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = CapabilityRevokedEvent{
            admin           : 0x2::tx_context::sender(arg3),
            user            : arg2,
            capability_type : b"VaultConfigAdminCap",
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<CapabilityRevokedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

