module 0x9ac684bb54bf68ce2d52f80a35c18f6b19030a47fbe448c3be632b958db63c4d::stoken_events {
    struct VaultInitialized has copy, drop {
        vault_id: 0x2::object::ID,
        underlying_type: 0x1::ascii::String,
        admin: address,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        shares_minted: u64,
        fee_shares: u64,
        price: u64,
        timestamp_ms: u64,
    }

    struct WithdrawalRequestCreated has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        request_id: u64,
        shares: u64,
        fee_shares: u64,
        amount_due: u64,
        min_amount_out: u64,
        price: u64,
        timestamp_ms: u64,
    }

    struct WithdrawalFulfilled has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        request_id: u64,
        amount_paid: u64,
        shares_burned: u64,
        timestamp_ms: u64,
    }

    struct WithdrawalCancelled has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        request_id: u64,
        shares_returned: u64,
        is_early_cancel: bool,
        penalty_shares: u64,
        timestamp_ms: u64,
    }

    struct PriceUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
        timestamp_ms: u64,
    }

    struct PricePendingEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
        deviation_bps: u64,
        timestamp_ms: u64,
    }

    struct PriceAccepted has copy, drop {
        vault_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
        timestamp_ms: u64,
    }

    struct DepositsProcessed has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        timestamp_ms: u64,
    }

    struct FundsReturned has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        timestamp_ms: u64,
    }

    struct ManagementFeeAccrued has copy, drop {
        vault_id: 0x2::object::ID,
        fee_shares: u64,
        time_elapsed: u64,
        timestamp_ms: u64,
    }

    struct VaultPausedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        caller: address,
        timestamp_ms: u64,
    }

    struct VaultUnpausedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        caller: address,
        timestamp_ms: u64,
    }

    struct RolesChangePending has copy, drop {
        vault_id: 0x2::object::ID,
        effective_time: u64,
        timestamp_ms: u64,
    }

    struct RolesUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct FeesChangePending has copy, drop {
        vault_id: 0x2::object::ID,
        effective_time: u64,
        timestamp_ms: u64,
    }

    struct FeesUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct LimitsChangePending has copy, drop {
        vault_id: 0x2::object::ID,
        effective_time: u64,
        timestamp_ms: u64,
    }

    struct LimitsUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct FactoryVaultCreated has copy, drop {
        factory_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        vault_index: u64,
        timestamp_ms: u64,
    }

    struct ProxyInitialized has copy, drop {
        proxy_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct ProxyFundsForwarded has copy, drop {
        proxy_id: 0x2::object::ID,
        target: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct ProxyFundsReturned has copy, drop {
        proxy_id: 0x2::object::ID,
        amount: u64,
        timestamp_ms: u64,
    }

    struct ProxyPausedEvent has copy, drop {
        proxy_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct ProxyUnpausedEvent has copy, drop {
        proxy_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct ProxyManagerChangePending has copy, drop {
        proxy_id: 0x2::object::ID,
        new_manager: address,
        effective_time: u64,
        timestamp_ms: u64,
    }

    struct ProxyManagerUpdated has copy, drop {
        proxy_id: 0x2::object::ID,
        manager: address,
        timestamp_ms: u64,
    }

    struct ProxyProcessorChangePending has copy, drop {
        proxy_id: 0x2::object::ID,
        new_processor: address,
        effective_time: u64,
        timestamp_ms: u64,
    }

    struct ProxyProcessorUpdated has copy, drop {
        proxy_id: 0x2::object::ID,
        processor: address,
        timestamp_ms: u64,
    }

    struct ProxyLimitsChangePending has copy, drop {
        proxy_id: 0x2::object::ID,
        effective_time: u64,
        timestamp_ms: u64,
    }

    struct ProxyLimitsUpdated has copy, drop {
        proxy_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct ProxyTargetUpdated has copy, drop {
        proxy_id: 0x2::object::ID,
        target: address,
        active: bool,
        timestamp_ms: u64,
    }

    public fun emit_deposit(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = DepositEvent{
            vault_id      : arg0,
            depositor     : arg1,
            amount        : arg2,
            shares_minted : arg3,
            fee_shares    : arg4,
            price         : arg5,
            timestamp_ms  : arg6,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun emit_deposits_processed(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = DepositsProcessed{
            vault_id     : arg0,
            amount       : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<DepositsProcessed>(v0);
    }

    public fun emit_factory_vault_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = FactoryVaultCreated{
            factory_id   : arg0,
            vault_id     : arg1,
            vault_index  : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<FactoryVaultCreated>(v0);
    }

    public fun emit_fees_change_pending(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = FeesChangePending{
            vault_id       : arg0,
            effective_time : arg1,
            timestamp_ms   : arg2,
        };
        0x2::event::emit<FeesChangePending>(v0);
    }

    public fun emit_fees_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = FeesUpdatedEvent{
            vault_id     : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<FeesUpdatedEvent>(v0);
    }

    public fun emit_funds_returned(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = FundsReturned{
            vault_id     : arg0,
            amount       : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<FundsReturned>(v0);
    }

    public fun emit_limits_change_pending(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = LimitsChangePending{
            vault_id       : arg0,
            effective_time : arg1,
            timestamp_ms   : arg2,
        };
        0x2::event::emit<LimitsChangePending>(v0);
    }

    public fun emit_limits_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = LimitsUpdatedEvent{
            vault_id     : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<LimitsUpdatedEvent>(v0);
    }

    public fun emit_management_fee_accrued(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = ManagementFeeAccrued{
            vault_id     : arg0,
            fee_shares   : arg1,
            time_elapsed : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<ManagementFeeAccrued>(v0);
    }

    public fun emit_price_accepted(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = PriceAccepted{
            vault_id     : arg0,
            old_price    : arg1,
            new_price    : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<PriceAccepted>(v0);
    }

    public fun emit_price_pending(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PricePendingEvent{
            vault_id      : arg0,
            old_price     : arg1,
            new_price     : arg2,
            deviation_bps : arg3,
            timestamp_ms  : arg4,
        };
        0x2::event::emit<PricePendingEvent>(v0);
    }

    public fun emit_price_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = PriceUpdated{
            vault_id     : arg0,
            old_price    : arg1,
            new_price    : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public fun emit_proxy_funds_forwarded(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = ProxyFundsForwarded{
            proxy_id     : arg0,
            target       : arg1,
            amount       : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<ProxyFundsForwarded>(v0);
    }

    public fun emit_proxy_funds_returned(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = ProxyFundsReturned{
            proxy_id     : arg0,
            amount       : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<ProxyFundsReturned>(v0);
    }

    public fun emit_proxy_initialized(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = ProxyInitialized{
            proxy_id     : arg0,
            vault_id     : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<ProxyInitialized>(v0);
    }

    public fun emit_proxy_limits_change_pending(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = ProxyLimitsChangePending{
            proxy_id       : arg0,
            effective_time : arg1,
            timestamp_ms   : arg2,
        };
        0x2::event::emit<ProxyLimitsChangePending>(v0);
    }

    public fun emit_proxy_limits_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ProxyLimitsUpdated{
            proxy_id     : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<ProxyLimitsUpdated>(v0);
    }

    public fun emit_proxy_manager_change_pending(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = ProxyManagerChangePending{
            proxy_id       : arg0,
            new_manager    : arg1,
            effective_time : arg2,
            timestamp_ms   : arg3,
        };
        0x2::event::emit<ProxyManagerChangePending>(v0);
    }

    public fun emit_proxy_manager_updated(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = ProxyManagerUpdated{
            proxy_id     : arg0,
            manager      : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<ProxyManagerUpdated>(v0);
    }

    public fun emit_proxy_paused(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ProxyPausedEvent{
            proxy_id     : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<ProxyPausedEvent>(v0);
    }

    public fun emit_proxy_processor_change_pending(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = ProxyProcessorChangePending{
            proxy_id       : arg0,
            new_processor  : arg1,
            effective_time : arg2,
            timestamp_ms   : arg3,
        };
        0x2::event::emit<ProxyProcessorChangePending>(v0);
    }

    public fun emit_proxy_processor_updated(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = ProxyProcessorUpdated{
            proxy_id     : arg0,
            processor    : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<ProxyProcessorUpdated>(v0);
    }

    public fun emit_proxy_target_updated(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u64) {
        let v0 = ProxyTargetUpdated{
            proxy_id     : arg0,
            target       : arg1,
            active       : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<ProxyTargetUpdated>(v0);
    }

    public fun emit_proxy_unpaused(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ProxyUnpausedEvent{
            proxy_id     : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<ProxyUnpausedEvent>(v0);
    }

    public fun emit_roles_change_pending(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = RolesChangePending{
            vault_id       : arg0,
            effective_time : arg1,
            timestamp_ms   : arg2,
        };
        0x2::event::emit<RolesChangePending>(v0);
    }

    public fun emit_roles_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = RolesUpdated{
            vault_id     : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<RolesUpdated>(v0);
    }

    public fun emit_vault_initialized(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: address) {
        let v0 = VaultInitialized{
            vault_id        : arg0,
            underlying_type : arg1,
            admin           : arg2,
        };
        0x2::event::emit<VaultInitialized>(v0);
    }

    public fun emit_vault_paused(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = VaultPausedEvent{
            vault_id     : arg0,
            caller       : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<VaultPausedEvent>(v0);
    }

    public fun emit_vault_unpaused(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = VaultUnpausedEvent{
            vault_id     : arg0,
            caller       : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<VaultUnpausedEvent>(v0);
    }

    public fun emit_withdrawal_cancelled(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64) {
        let v0 = WithdrawalCancelled{
            vault_id        : arg0,
            user            : arg1,
            request_id      : arg2,
            shares_returned : arg3,
            is_early_cancel : arg4,
            penalty_shares  : arg5,
            timestamp_ms    : arg6,
        };
        0x2::event::emit<WithdrawalCancelled>(v0);
    }

    public fun emit_withdrawal_fulfilled(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = WithdrawalFulfilled{
            vault_id      : arg0,
            user          : arg1,
            request_id    : arg2,
            amount_paid   : arg3,
            shares_burned : arg4,
            timestamp_ms  : arg5,
        };
        0x2::event::emit<WithdrawalFulfilled>(v0);
    }

    public fun emit_withdrawal_request_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = WithdrawalRequestCreated{
            vault_id       : arg0,
            user           : arg1,
            request_id     : arg2,
            shares         : arg3,
            fee_shares     : arg4,
            amount_due     : arg5,
            min_amount_out : arg6,
            price          : arg7,
            timestamp_ms   : arg8,
        };
        0x2::event::emit<WithdrawalRequestCreated>(v0);
    }

    // decompiled from Move bytecode v7
}

