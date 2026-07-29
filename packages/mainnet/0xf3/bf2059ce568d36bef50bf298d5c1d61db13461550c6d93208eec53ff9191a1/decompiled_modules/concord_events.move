module 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events {
    struct RequestCreated has copy, drop {
        request_id: u64,
        borrower: address,
        principal_token: address,
        principal: u64,
        min_principal_amount: u64,
        collateral_token: address,
        collateral_required: u64,
        interest_rate_schedule: vector<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>,
        duration_secs: u64,
        funding_window_secs: u64,
        collateral_policy: u8,
        liquidation_price: 0x1::option::Option<u64>,
        oracle_feed_id: 0x1::option::Option<0x2::object::ID>,
        liquidation_trigger: u8,
        ltv_bps: u64,
        timestamp_ms: u64,
    }

    struct RequestMatched has copy, drop {
        request_id: u64,
        lender: address,
        timestamp_ms: u64,
    }

    struct BorrowRequestCancelled has copy, drop {
        request_id: u64,
        timestamp_ms: u64,
    }

    struct CancelPenaltyPaid has copy, drop {
        request_id: u64,
        borrower: address,
        amount: u64,
        base: u64,
        timestamp_ms: u64,
    }

    struct CollateralPledged has copy, drop {
        request_id: u64,
        borrower: address,
        token: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct CollateralLocked has copy, drop {
        request_id: u64,
        amount: u64,
    }

    struct CollateralReleased has copy, drop {
        request_id: u64,
        amount: u64,
    }

    struct CollateralSeized has copy, drop {
        request_id: u64,
        amount: u64,
        recipient: address,
    }

    struct LoanMatched has copy, drop {
        request_id: u64,
        loan_id: 0x2::object::ID,
        vault_id: 0x1::option::Option<0x2::object::ID>,
        lender_is_vault: bool,
        borrower: address,
        lender: address,
        principal_amount: u64,
        collateral_amount: u64,
        maturity_ms: u64,
        timestamp_ms: u64,
    }

    struct LoanRepaid has copy, drop {
        request_id: u64,
        principal_amount: u64,
        interest_amount: u64,
        timestamp_ms: u64,
    }

    struct LoanDefaulted has copy, drop {
        request_id: u64,
        collateral_policy: u8,
        timestamp_ms: u64,
    }

    struct LoanLiquidated has copy, drop {
        request_id: u64,
        seized_collateral: u64,
        oracle_price: u64,
        liquidation_price: u64,
        timestamp_ms: u64,
    }

    struct LiquidationSettled has copy, drop {
        request_id: u64,
        liquidator: address,
        principal_amount: u64,
        collateral_amount: u64,
        collateral_recipient: address,
        timestamp_ms: u64,
    }

    struct FactoryVaultCreated has copy, drop {
        request_id: u64,
        vault_id: 0x2::object::ID,
        principal_token: address,
        collateral_token: address,
        share_name: 0x1::string::String,
        share_symbol: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct RouterRequestRouted has copy, drop {
        request_id: u64,
        borrower: address,
        timestamp_ms: u64,
    }

    struct AdminAction has copy, drop {
        object_id: 0x2::object::ID,
        actor: address,
        action: u8,
        timestamp_ms: u64,
    }

    struct ProtocolFee has copy, drop {
        kind: u8,
        amount: u64,
        treasury: address,
        timestamp_ms: u64,
    }

    struct SurplusSwept has copy, drop {
        vault_id: 0x2::object::ID,
        token: address,
        amount: u64,
        recipient: address,
    }

    struct MinPrincipalUpdated has copy, drop {
        request_id: u64,
        new_min: u64,
        timestamp_ms: u64,
    }

    struct MatchWhitelistSet has copy, drop {
        request_id: u64,
        matcher_count: u64,
        timestamp_ms: u64,
    }

    struct UpgradeProposed has copy, drop {
        governance_id: 0x2::object::ID,
        policy: u8,
        digest_len: u64,
        proposed_at_ms: u64,
        executable_after_ms: u64,
    }

    struct UpgradeAuthorized has copy, drop {
        governance_id: 0x2::object::ID,
        policy: u8,
        digest_len: u64,
        timestamp_ms: u64,
    }

    struct UpgradeCommitted has copy, drop {
        governance_id: 0x2::object::ID,
        nonce: u64,
        package_after: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct UpgradeCancelled has copy, drop {
        governance_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct TimelockUpdated has copy, drop {
        governance_id: 0x2::object::ID,
        old_timelock_secs: u64,
        new_timelock_secs: u64,
        timestamp_ms: u64,
    }

    struct TimelockReductionScheduled has copy, drop {
        governance_id: 0x2::object::ID,
        current_timelock_secs: u64,
        pending_timelock_secs: u64,
        effective_at_ms: u64,
        timestamp_ms: u64,
    }

    struct AdminTransferred has copy, drop {
        object_id: 0x2::object::ID,
        old_admin: address,
        new_admin: address,
        timestamp_ms: u64,
    }

    struct AdminProposed has copy, drop {
        object_id: 0x2::object::ID,
        old_admin: address,
        pending_admin: address,
        timestamp_ms: u64,
    }

    struct ProcessorAdded has copy, drop {
        processor: address,
        timestamp_ms: u64,
    }

    struct ProcessorRemoved has copy, drop {
        processor: address,
        timestamp_ms: u64,
    }

    struct LiquidatorAdded has copy, drop {
        liquidator: address,
        timestamp_ms: u64,
    }

    struct LiquidatorRemoved has copy, drop {
        liquidator: address,
        timestamp_ms: u64,
    }

    struct TokenListed has copy, drop {
        token: address,
        timestamp_ms: u64,
    }

    struct TokenUnlisted has copy, drop {
        token: address,
        timestamp_ms: u64,
    }

    struct OracleWhitelisted has copy, drop {
        oracle_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct OracleRemoved has copy, drop {
        oracle_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct BorrowerListed has copy, drop {
        borrower: address,
        timestamp_ms: u64,
    }

    struct BorrowerUnlisted has copy, drop {
        borrower: address,
        timestamp_ms: u64,
    }

    struct LenderListed has copy, drop {
        lender: address,
        timestamp_ms: u64,
    }

    struct LenderUnlisted has copy, drop {
        lender: address,
        timestamp_ms: u64,
    }

    struct BorrowerWhitelistEnabledSet has copy, drop {
        enabled: bool,
        timestamp_ms: u64,
    }

    struct LenderWhitelistEnabledSet has copy, drop {
        enabled: bool,
        timestamp_ms: u64,
    }

    struct ProtocolPaused has copy, drop {
        object_id: 0x2::object::ID,
        actor: address,
        timestamp_ms: u64,
    }

    struct ProtocolUnpaused has copy, drop {
        object_id: 0x2::object::ID,
        actor: address,
        timestamp_ms: u64,
    }

    struct ObjectMigrated has copy, drop {
        object_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
        timestamp_ms: u64,
    }

    struct LenderShareMinted has copy, drop {
        vault_id: 0x2::object::ID,
        share_id: 0x2::object::ID,
        lender: address,
        assets: u64,
        shares: u64,
        timestamp_ms: u64,
    }

    struct LenderShareRedeemed has copy, drop {
        vault_id: 0x2::object::ID,
        share_id: 0x2::object::ID,
        lender: address,
        shares: u64,
        assets: u64,
        timestamp_ms: u64,
    }

    struct VaultModeChanged has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: u64,
        from_mode: u8,
        to_mode: u8,
        timestamp_ms: u64,
    }

    struct CollateralPoolFunded has copy, drop {
        vault_id: 0x2::object::ID,
        request_id: u64,
        collateral_token: address,
        seized_amount: u64,
        timestamp_ms: u64,
    }

    struct LenderCollateralClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        share_id: 0x2::object::ID,
        lender: address,
        shares: u64,
        collateral_token: address,
        collateral_amount: u64,
        timestamp_ms: u64,
    }

    public fun emit_admin_action(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u64) {
        let v0 = AdminAction{
            object_id    : arg0,
            actor        : arg1,
            action       : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<AdminAction>(v0);
    }

    public fun emit_admin_proposed(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = AdminProposed{
            object_id     : arg0,
            old_admin     : arg1,
            pending_admin : arg2,
            timestamp_ms  : arg3,
        };
        0x2::event::emit<AdminProposed>(v0);
    }

    public fun emit_admin_transferred(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = AdminTransferred{
            object_id    : arg0,
            old_admin    : arg1,
            new_admin    : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public fun emit_borrow_request_cancelled(arg0: u64, arg1: u64) {
        let v0 = BorrowRequestCancelled{
            request_id   : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<BorrowRequestCancelled>(v0);
    }

    public fun emit_borrower_listed(arg0: address, arg1: u64) {
        let v0 = BorrowerListed{
            borrower     : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<BorrowerListed>(v0);
    }

    public fun emit_borrower_unlisted(arg0: address, arg1: u64) {
        let v0 = BorrowerUnlisted{
            borrower     : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<BorrowerUnlisted>(v0);
    }

    public fun emit_borrower_whitelist_enabled_set(arg0: bool, arg1: u64) {
        let v0 = BorrowerWhitelistEnabledSet{
            enabled      : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<BorrowerWhitelistEnabledSet>(v0);
    }

    public fun emit_cancel_penalty_paid(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = CancelPenaltyPaid{
            request_id   : arg0,
            borrower     : arg1,
            amount       : arg2,
            base         : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<CancelPenaltyPaid>(v0);
    }

    public fun emit_collateral_locked(arg0: u64, arg1: u64) {
        let v0 = CollateralLocked{
            request_id : arg0,
            amount     : arg1,
        };
        0x2::event::emit<CollateralLocked>(v0);
    }

    public fun emit_collateral_pledged(arg0: u64, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = CollateralPledged{
            request_id   : arg0,
            borrower     : arg1,
            token        : arg2,
            amount       : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<CollateralPledged>(v0);
    }

    public fun emit_collateral_pool_funded(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64, arg4: u64) {
        let v0 = CollateralPoolFunded{
            vault_id         : arg0,
            request_id       : arg1,
            collateral_token : arg2,
            seized_amount    : arg3,
            timestamp_ms     : arg4,
        };
        0x2::event::emit<CollateralPoolFunded>(v0);
    }

    public fun emit_collateral_released(arg0: u64, arg1: u64) {
        let v0 = CollateralReleased{
            request_id : arg0,
            amount     : arg1,
        };
        0x2::event::emit<CollateralReleased>(v0);
    }

    public fun emit_collateral_seized(arg0: u64, arg1: u64, arg2: address) {
        let v0 = CollateralSeized{
            request_id : arg0,
            amount     : arg1,
            recipient  : arg2,
        };
        0x2::event::emit<CollateralSeized>(v0);
    }

    public fun emit_factory_vault_created(arg0: u64, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64) {
        let v0 = FactoryVaultCreated{
            request_id       : arg0,
            vault_id         : arg1,
            principal_token  : arg2,
            collateral_token : arg3,
            share_name       : arg4,
            share_symbol     : arg5,
            timestamp_ms     : arg6,
        };
        0x2::event::emit<FactoryVaultCreated>(v0);
    }

    public fun emit_lender_collateral_claimed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: address, arg5: u64, arg6: u64) {
        let v0 = LenderCollateralClaimed{
            vault_id          : arg0,
            share_id          : arg1,
            lender            : arg2,
            shares            : arg3,
            collateral_token  : arg4,
            collateral_amount : arg5,
            timestamp_ms      : arg6,
        };
        0x2::event::emit<LenderCollateralClaimed>(v0);
    }

    public fun emit_lender_listed(arg0: address, arg1: u64) {
        let v0 = LenderListed{
            lender       : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<LenderListed>(v0);
    }

    public fun emit_lender_share_minted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = LenderShareMinted{
            vault_id     : arg0,
            share_id     : arg1,
            lender       : arg2,
            assets       : arg3,
            shares       : arg4,
            timestamp_ms : arg5,
        };
        0x2::event::emit<LenderShareMinted>(v0);
    }

    public fun emit_lender_share_redeemed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = LenderShareRedeemed{
            vault_id     : arg0,
            share_id     : arg1,
            lender       : arg2,
            shares       : arg3,
            assets       : arg4,
            timestamp_ms : arg5,
        };
        0x2::event::emit<LenderShareRedeemed>(v0);
    }

    public fun emit_lender_unlisted(arg0: address, arg1: u64) {
        let v0 = LenderUnlisted{
            lender       : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<LenderUnlisted>(v0);
    }

    public fun emit_lender_whitelist_enabled_set(arg0: bool, arg1: u64) {
        let v0 = LenderWhitelistEnabledSet{
            enabled      : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<LenderWhitelistEnabledSet>(v0);
    }

    public fun emit_liquidation_settled(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: address, arg5: u64) {
        let v0 = LiquidationSettled{
            request_id           : arg0,
            liquidator           : arg1,
            principal_amount     : arg2,
            collateral_amount    : arg3,
            collateral_recipient : arg4,
            timestamp_ms         : arg5,
        };
        0x2::event::emit<LiquidationSettled>(v0);
    }

    public fun emit_liquidator_added(arg0: address, arg1: u64) {
        let v0 = LiquidatorAdded{
            liquidator   : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<LiquidatorAdded>(v0);
    }

    public fun emit_liquidator_removed(arg0: address, arg1: u64) {
        let v0 = LiquidatorRemoved{
            liquidator   : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<LiquidatorRemoved>(v0);
    }

    public fun emit_loan_defaulted(arg0: u64, arg1: u8, arg2: u64) {
        let v0 = LoanDefaulted{
            request_id        : arg0,
            collateral_policy : arg1,
            timestamp_ms      : arg2,
        };
        0x2::event::emit<LoanDefaulted>(v0);
    }

    public fun emit_loan_liquidated(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = LoanLiquidated{
            request_id        : arg0,
            seized_collateral : arg1,
            oracle_price      : arg2,
            liquidation_price : arg3,
            timestamp_ms      : arg4,
        };
        0x2::event::emit<LoanLiquidated>(v0);
    }

    public fun emit_loan_matched(arg0: u64, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::object::ID>, arg3: bool, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = LoanMatched{
            request_id        : arg0,
            loan_id           : arg1,
            vault_id          : arg2,
            lender_is_vault   : arg3,
            borrower          : arg4,
            lender            : arg5,
            principal_amount  : arg6,
            collateral_amount : arg7,
            maturity_ms       : arg8,
            timestamp_ms      : arg9,
        };
        0x2::event::emit<LoanMatched>(v0);
    }

    public fun emit_loan_repaid(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = LoanRepaid{
            request_id       : arg0,
            principal_amount : arg1,
            interest_amount  : arg2,
            timestamp_ms     : arg3,
        };
        0x2::event::emit<LoanRepaid>(v0);
    }

    public fun emit_match_whitelist_set(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = MatchWhitelistSet{
            request_id    : arg0,
            matcher_count : arg1,
            timestamp_ms  : arg2,
        };
        0x2::event::emit<MatchWhitelistSet>(v0);
    }

    public fun emit_min_principal_updated(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = MinPrincipalUpdated{
            request_id   : arg0,
            new_min      : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<MinPrincipalUpdated>(v0);
    }

    public fun emit_object_migrated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = ObjectMigrated{
            object_id    : arg0,
            from_version : arg1,
            to_version   : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<ObjectMigrated>(v0);
    }

    public fun emit_oracle_removed(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = OracleRemoved{
            oracle_id    : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<OracleRemoved>(v0);
    }

    public fun emit_oracle_whitelisted(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = OracleWhitelisted{
            oracle_id    : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<OracleWhitelisted>(v0);
    }

    public fun emit_processor_added(arg0: address, arg1: u64) {
        let v0 = ProcessorAdded{
            processor    : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<ProcessorAdded>(v0);
    }

    public fun emit_processor_removed(arg0: address, arg1: u64) {
        let v0 = ProcessorRemoved{
            processor    : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<ProcessorRemoved>(v0);
    }

    public fun emit_protocol_fee(arg0: u8, arg1: u64, arg2: address, arg3: u64) {
        let v0 = ProtocolFee{
            kind         : arg0,
            amount       : arg1,
            treasury     : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<ProtocolFee>(v0);
    }

    public fun emit_protocol_paused(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = ProtocolPaused{
            object_id    : arg0,
            actor        : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public fun emit_protocol_unpaused(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = ProtocolUnpaused{
            object_id    : arg0,
            actor        : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<ProtocolUnpaused>(v0);
    }

    public fun emit_request_created(arg0: u64, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: vector<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>, arg8: u64, arg9: u64, arg10: u8, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<0x2::object::ID>, arg13: u8, arg14: u64, arg15: u64) {
        let v0 = RequestCreated{
            request_id             : arg0,
            borrower               : arg1,
            principal_token        : arg2,
            principal              : arg3,
            min_principal_amount   : arg4,
            collateral_token       : arg5,
            collateral_required    : arg6,
            interest_rate_schedule : arg7,
            duration_secs          : arg8,
            funding_window_secs    : arg9,
            collateral_policy      : arg10,
            liquidation_price      : arg11,
            oracle_feed_id         : arg12,
            liquidation_trigger    : arg13,
            ltv_bps                : arg14,
            timestamp_ms           : arg15,
        };
        0x2::event::emit<RequestCreated>(v0);
    }

    public fun emit_request_matched(arg0: u64, arg1: address, arg2: u64) {
        let v0 = RequestMatched{
            request_id   : arg0,
            lender       : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<RequestMatched>(v0);
    }

    public fun emit_router_request_routed(arg0: u64, arg1: address, arg2: u64) {
        let v0 = RouterRequestRouted{
            request_id   : arg0,
            borrower     : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<RouterRequestRouted>(v0);
    }

    public fun emit_surplus_swept(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: address) {
        let v0 = SurplusSwept{
            vault_id  : arg0,
            token     : arg1,
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<SurplusSwept>(v0);
    }

    public fun emit_timelock_reduction_scheduled(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = TimelockReductionScheduled{
            governance_id         : arg0,
            current_timelock_secs : arg1,
            pending_timelock_secs : arg2,
            effective_at_ms       : arg3,
            timestamp_ms          : arg4,
        };
        0x2::event::emit<TimelockReductionScheduled>(v0);
    }

    public fun emit_timelock_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = TimelockUpdated{
            governance_id     : arg0,
            old_timelock_secs : arg1,
            new_timelock_secs : arg2,
            timestamp_ms      : arg3,
        };
        0x2::event::emit<TimelockUpdated>(v0);
    }

    public fun emit_token_listed(arg0: address, arg1: u64) {
        let v0 = TokenListed{
            token        : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<TokenListed>(v0);
    }

    public fun emit_token_unlisted(arg0: address, arg1: u64) {
        let v0 = TokenUnlisted{
            token        : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<TokenUnlisted>(v0);
    }

    public fun emit_upgrade_authorized(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: u64) {
        let v0 = UpgradeAuthorized{
            governance_id : arg0,
            policy        : arg1,
            digest_len    : arg2,
            timestamp_ms  : arg3,
        };
        0x2::event::emit<UpgradeAuthorized>(v0);
    }

    public fun emit_upgrade_cancelled(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpgradeCancelled{
            governance_id : arg0,
            timestamp_ms  : arg1,
        };
        0x2::event::emit<UpgradeCancelled>(v0);
    }

    public fun emit_upgrade_committed(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = UpgradeCommitted{
            governance_id : arg0,
            nonce         : arg1,
            package_after : arg2,
            timestamp_ms  : arg3,
        };
        0x2::event::emit<UpgradeCommitted>(v0);
    }

    public fun emit_upgrade_proposed(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = UpgradeProposed{
            governance_id       : arg0,
            policy              : arg1,
            digest_len          : arg2,
            proposed_at_ms      : arg3,
            executable_after_ms : arg4,
        };
        0x2::event::emit<UpgradeProposed>(v0);
    }

    public fun emit_vault_mode_changed(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: u8, arg4: u64) {
        let v0 = VaultModeChanged{
            vault_id     : arg0,
            request_id   : arg1,
            from_mode    : arg2,
            to_mode      : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<VaultModeChanged>(v0);
    }

    public fun fee_kind_cancel_penalty() : u8 {
        5
    }

    public fun fee_kind_default_collateral() : u8 {
        4
    }

    public fun fee_kind_liq_principal() : u8 {
        3
    }

    public fun fee_kind_repay_interest() : u8 {
        2
    }

    public fun surplus_swept_amount(arg0: &SurplusSwept) : u64 {
        arg0.amount
    }

    public fun surplus_swept_recipient(arg0: &SurplusSwept) : address {
        arg0.recipient
    }

    public fun surplus_swept_token(arg0: &SurplusSwept) : address {
        arg0.token
    }

    public fun surplus_swept_vault_id(arg0: &SurplusSwept) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

