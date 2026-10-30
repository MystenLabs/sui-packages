module 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events {
    struct Deposited<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        payer: address,
        receiver: address,
        assets: u64,
        shares: u64,
        total_assets: u128,
        total_supply: u64,
    }

    struct Redeemed<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        holder: address,
        recipient: address,
        shares: u64,
        gross_assets: u64,
        net_assets: u64,
        fee: u64,
        total_assets: u128,
        total_supply: u64,
    }

    struct WithdrawalRequested<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        owner_request_id: u64,
        owner: address,
        payout: address,
        finalizer: 0x1::option::Option<address>,
        shares: u64,
        eligible_at_ms: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        total_assets: u128,
        total_supply: u64,
    }

    struct WithdrawalFinalized<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        owner: address,
        payout: address,
        shares: u64,
        assets: u64,
        total_assets: u128,
        total_supply: u64,
    }

    struct WithdrawalExpedited<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        owner: address,
        previous_eligible_at_ms: u64,
        eligible_at_ms: u64,
    }

    struct WithdrawalCancelled<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        owner: address,
        shares: u64,
        total_assets: u128,
        total_supply: u64,
    }

    struct OperatorWithdrew<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        subaccount: address,
        assets: u64,
        deployed_aum: u64,
        total_assets: u128,
        total_supply: u64,
    }

    struct OperatorDeposited<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        assets: u64,
        deployed_aum: u64,
        total_assets: u128,
        total_supply: u64,
    }

    struct AumUpdated<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        previous_deployed_aum: u64,
        new_deployed_aum: u64,
        total_assets: u128,
        total_supply: u64,
    }

    struct ManagementFeeCharged<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        fee: u64,
        charged_at_ms: u64,
        total_assets: u128,
        total_supply: u64,
    }

    struct PerformanceFeeCharged<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        fee: u64,
        high_watermark: u128,
        charged_at_ms: u64,
        total_assets: u128,
        total_supply: u64,
    }

    struct HighWatermarkReset<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        previous_high_watermark: u128,
        high_watermark: u128,
    }

    struct FeesCollected<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        paid: u64,
        remaining: u64,
        total_assets: u128,
        total_supply: u64,
    }

    struct ConfigUpdated<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        action: 0x1::string::String,
    }

    struct Paused<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct Unpaused<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct SubaccountRegistered<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        subaccount: address,
    }

    struct SubaccountDeregistered<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        subaccount: address,
    }

    struct OwnerNominated<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        nominee: address,
        expires_at_ms: u64,
    }

    struct OwnerNominationCancelled<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        nominee: address,
    }

    struct OwnerAccepted<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
    }

    struct QueueAttached<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct QueueDetached<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct PasVaultCreated<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
    }

    struct AllocationUpdated<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        addr: address,
        bps: u64,
    }

    struct DepositedSet<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        addr: address,
        deposited: u64,
    }

    struct SharesSeized<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        from: address,
        to: address,
        shares: u64,
        request_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct VaultCreated<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct ChangeScheduled<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        action: 0x1::string::String,
        value: u64,
        ready_at_ms: u64,
        expires_at_ms: u64,
    }

    struct ChangeExecuted<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        action: 0x1::string::String,
        previous: u64,
        value: u64,
    }

    struct ChangeCancelled<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        action: 0x1::string::String,
        value: u64,
    }

    struct RoleGranted has copy, drop {
        scope_id: 0x2::object::ID,
        role: 0x1::type_name::TypeName,
        addr: address,
    }

    struct RoleRevoked has copy, drop {
        scope_id: 0x2::object::ID,
        role: 0x1::type_name::TypeName,
        addr: address,
    }

    struct MinVersionRaised has copy, drop {
        registry_id: 0x2::object::ID,
        previous_min_version: u64,
        min_version: u64,
    }

    public(friend) fun emit_allocation_updated<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = AllocationUpdated<T0, T1>{
            vault_id : arg0,
            addr     : arg1,
            bps      : arg2,
        };
        0x2::event::emit<AllocationUpdated<T0, T1>>(v0);
    }

    public(friend) fun emit_aum_updated<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128, arg4: u64) {
        let v0 = AumUpdated<T0, T1>{
            vault_id              : arg0,
            previous_deployed_aum : arg1,
            new_deployed_aum      : arg2,
            total_assets          : arg3,
            total_supply          : arg4,
        };
        0x2::event::emit<AumUpdated<T0, T1>>(v0);
    }

    public(friend) fun emit_change_cancelled<T0, T1>(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64) {
        let v0 = ChangeCancelled<T0, T1>{
            vault_id : arg0,
            action   : arg1,
            value    : arg2,
        };
        0x2::event::emit<ChangeCancelled<T0, T1>>(v0);
    }

    public(friend) fun emit_change_executed<T0, T1>(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64) {
        let v0 = ChangeExecuted<T0, T1>{
            vault_id : arg0,
            action   : arg1,
            previous : arg2,
            value    : arg3,
        };
        0x2::event::emit<ChangeExecuted<T0, T1>>(v0);
    }

    public(friend) fun emit_change_scheduled<T0, T1>(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ChangeScheduled<T0, T1>{
            vault_id      : arg0,
            action        : arg1,
            value         : arg2,
            ready_at_ms   : arg3,
            expires_at_ms : arg4,
        };
        0x2::event::emit<ChangeScheduled<T0, T1>>(v0);
    }

    public(friend) fun emit_config_updated<T0, T1>(arg0: 0x2::object::ID, arg1: 0x1::string::String) {
        let v0 = ConfigUpdated<T0, T1>{
            vault_id : arg0,
            action   : arg1,
        };
        0x2::event::emit<ConfigUpdated<T0, T1>>(v0);
    }

    public(friend) fun emit_deposited<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u128, arg6: u64) {
        let v0 = Deposited<T0, T1>{
            vault_id     : arg0,
            payer        : arg1,
            receiver     : arg2,
            assets       : arg3,
            shares       : arg4,
            total_assets : arg5,
            total_supply : arg6,
        };
        0x2::event::emit<Deposited<T0, T1>>(v0);
    }

    public(friend) fun emit_deposited_set<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = DepositedSet<T0, T1>{
            vault_id  : arg0,
            addr      : arg1,
            deposited : arg2,
        };
        0x2::event::emit<DepositedSet<T0, T1>>(v0);
    }

    public(friend) fun emit_fees_collected<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128, arg4: u64) {
        let v0 = FeesCollected<T0, T1>{
            vault_id     : arg0,
            paid         : arg1,
            remaining    : arg2,
            total_assets : arg3,
            total_supply : arg4,
        };
        0x2::event::emit<FeesCollected<T0, T1>>(v0);
    }

    public(friend) fun emit_high_watermark_reset<T0, T1>(arg0: 0x2::object::ID, arg1: u128, arg2: u128) {
        let v0 = HighWatermarkReset<T0, T1>{
            vault_id                : arg0,
            previous_high_watermark : arg1,
            high_watermark          : arg2,
        };
        0x2::event::emit<HighWatermarkReset<T0, T1>>(v0);
    }

    public(friend) fun emit_management_fee_charged<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128, arg4: u64) {
        let v0 = ManagementFeeCharged<T0, T1>{
            vault_id      : arg0,
            fee           : arg1,
            charged_at_ms : arg2,
            total_assets  : arg3,
            total_supply  : arg4,
        };
        0x2::event::emit<ManagementFeeCharged<T0, T1>>(v0);
    }

    public(friend) fun emit_min_version_raised(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = MinVersionRaised{
            registry_id          : arg0,
            previous_min_version : arg1,
            min_version          : arg2,
        };
        0x2::event::emit<MinVersionRaised>(v0);
    }

    public(friend) fun emit_operator_deposited<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128, arg4: u64) {
        let v0 = OperatorDeposited<T0, T1>{
            vault_id     : arg0,
            assets       : arg1,
            deployed_aum : arg2,
            total_assets : arg3,
            total_supply : arg4,
        };
        0x2::event::emit<OperatorDeposited<T0, T1>>(v0);
    }

    public(friend) fun emit_operator_withdrew<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u128, arg5: u64) {
        let v0 = OperatorWithdrew<T0, T1>{
            vault_id     : arg0,
            subaccount   : arg1,
            assets       : arg2,
            deployed_aum : arg3,
            total_assets : arg4,
            total_supply : arg5,
        };
        0x2::event::emit<OperatorWithdrew<T0, T1>>(v0);
    }

    public(friend) fun emit_owner_accepted<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = OwnerAccepted<T0, T1>{
            vault_id       : arg0,
            previous_owner : arg1,
            new_owner      : arg2,
        };
        0x2::event::emit<OwnerAccepted<T0, T1>>(v0);
    }

    public(friend) fun emit_owner_nominated<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = OwnerNominated<T0, T1>{
            vault_id      : arg0,
            nominee       : arg1,
            expires_at_ms : arg2,
        };
        0x2::event::emit<OwnerNominated<T0, T1>>(v0);
    }

    public(friend) fun emit_owner_nomination_cancelled<T0, T1>(arg0: 0x2::object::ID, arg1: address) {
        let v0 = OwnerNominationCancelled<T0, T1>{
            vault_id : arg0,
            nominee  : arg1,
        };
        0x2::event::emit<OwnerNominationCancelled<T0, T1>>(v0);
    }

    public(friend) fun emit_pas_vault_created<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = PasVaultCreated<T0, T1>{
            vault_id  : arg0,
            policy_id : arg1,
        };
        0x2::event::emit<PasVaultCreated<T0, T1>>(v0);
    }

    public(friend) fun emit_paused<T0, T1>(arg0: 0x2::object::ID) {
        let v0 = Paused<T0, T1>{vault_id: arg0};
        0x2::event::emit<Paused<T0, T1>>(v0);
    }

    public(friend) fun emit_performance_fee_charged<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u128, arg3: u64, arg4: u128, arg5: u64) {
        let v0 = PerformanceFeeCharged<T0, T1>{
            vault_id       : arg0,
            fee            : arg1,
            high_watermark : arg2,
            charged_at_ms  : arg3,
            total_assets   : arg4,
            total_supply   : arg5,
        };
        0x2::event::emit<PerformanceFeeCharged<T0, T1>>(v0);
    }

    public(friend) fun emit_queue_attached<T0, T1>(arg0: 0x2::object::ID) {
        let v0 = QueueAttached<T0, T1>{vault_id: arg0};
        0x2::event::emit<QueueAttached<T0, T1>>(v0);
    }

    public(friend) fun emit_queue_detached<T0, T1>(arg0: 0x2::object::ID) {
        let v0 = QueueDetached<T0, T1>{vault_id: arg0};
        0x2::event::emit<QueueDetached<T0, T1>>(v0);
    }

    public(friend) fun emit_redeemed<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u64) {
        let v0 = Redeemed<T0, T1>{
            vault_id     : arg0,
            holder       : arg1,
            recipient    : arg2,
            shares       : arg3,
            gross_assets : arg4,
            net_assets   : arg5,
            fee          : arg6,
            total_assets : arg7,
            total_supply : arg8,
        };
        0x2::event::emit<Redeemed<T0, T1>>(v0);
    }

    public(friend) fun emit_role_granted(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: address) {
        let v0 = RoleGranted{
            scope_id : arg0,
            role     : arg1,
            addr     : arg2,
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public(friend) fun emit_role_revoked(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: address) {
        let v0 = RoleRevoked{
            scope_id : arg0,
            role     : arg1,
            addr     : arg2,
        };
        0x2::event::emit<RoleRevoked>(v0);
    }

    public(friend) fun emit_shares_seized<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: 0x1::option::Option<0x2::object::ID>) {
        let v0 = SharesSeized<T0, T1>{
            vault_id   : arg0,
            from       : arg1,
            to         : arg2,
            shares     : arg3,
            request_id : arg4,
        };
        0x2::event::emit<SharesSeized<T0, T1>>(v0);
    }

    public(friend) fun emit_subaccount_deregistered<T0, T1>(arg0: 0x2::object::ID, arg1: address) {
        let v0 = SubaccountDeregistered<T0, T1>{
            vault_id   : arg0,
            subaccount : arg1,
        };
        0x2::event::emit<SubaccountDeregistered<T0, T1>>(v0);
    }

    public(friend) fun emit_subaccount_registered<T0, T1>(arg0: 0x2::object::ID, arg1: address) {
        let v0 = SubaccountRegistered<T0, T1>{
            vault_id   : arg0,
            subaccount : arg1,
        };
        0x2::event::emit<SubaccountRegistered<T0, T1>>(v0);
    }

    public(friend) fun emit_unpaused<T0, T1>(arg0: 0x2::object::ID) {
        let v0 = Unpaused<T0, T1>{vault_id: arg0};
        0x2::event::emit<Unpaused<T0, T1>>(v0);
    }

    public(friend) fun emit_vault_created<T0, T1>(arg0: 0x2::object::ID, arg1: address) {
        let v0 = VaultCreated<T0, T1>{
            vault_id : arg0,
            owner    : arg1,
        };
        0x2::event::emit<VaultCreated<T0, T1>>(v0);
    }

    public(friend) fun emit_withdrawal_cancelled<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u128, arg5: u64) {
        let v0 = WithdrawalCancelled<T0, T1>{
            vault_id     : arg0,
            request_id   : arg1,
            owner        : arg2,
            shares       : arg3,
            total_assets : arg4,
            total_supply : arg5,
        };
        0x2::event::emit<WithdrawalCancelled<T0, T1>>(v0);
    }

    public(friend) fun emit_withdrawal_expedited<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = WithdrawalExpedited<T0, T1>{
            vault_id                : arg0,
            request_id              : arg1,
            owner                   : arg2,
            previous_eligible_at_ms : arg3,
            eligible_at_ms          : arg4,
        };
        0x2::event::emit<WithdrawalExpedited<T0, T1>>(v0);
    }

    public(friend) fun emit_withdrawal_finalized<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u128, arg7: u64) {
        let v0 = WithdrawalFinalized<T0, T1>{
            vault_id     : arg0,
            request_id   : arg1,
            owner        : arg2,
            payout       : arg3,
            shares       : arg4,
            assets       : arg5,
            total_assets : arg6,
            total_supply : arg7,
        };
        0x2::event::emit<WithdrawalFinalized<T0, T1>>(v0);
    }

    public(friend) fun emit_withdrawal_requested<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: address, arg5: 0x1::option::Option<address>, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: u128, arg10: u64) {
        let v0 = WithdrawalRequested<T0, T1>{
            vault_id         : arg0,
            request_id       : arg1,
            owner_request_id : arg2,
            owner            : arg3,
            payout           : arg4,
            finalizer        : arg5,
            shares           : arg6,
            eligible_at_ms   : arg7,
            expires_at_ms    : arg8,
            total_assets     : arg9,
            total_supply     : arg10,
        };
        0x2::event::emit<WithdrawalRequested<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v7
}

