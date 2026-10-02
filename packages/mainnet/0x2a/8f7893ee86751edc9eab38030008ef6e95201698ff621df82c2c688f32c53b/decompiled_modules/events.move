module 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events {
    struct ProtocolCreated has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        timelock_id: 0x2::object::ID,
        order_domain_package_id: address,
        matcher_key_epoch: u64,
        max_session_key_lifetime_ms: u64,
        max_session_order_notional_e6: u64,
    }

    struct AccountCreated has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
    }

    struct Deposited has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        amount_e6: u64,
        new_collateral_e6: u64,
    }

    struct Withdrawn has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        amount_e6: u64,
        new_collateral_e6: u64,
    }

    struct SessionKeyRegistered has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        key_id: vector<u8>,
        public_key: vector<u8>,
        valid_until_ms: u64,
        max_notional_per_order_e6: u64,
        label_hash: vector<u8>,
    }

    struct SessionKeyRevoked has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        key_id: vector<u8>,
    }

    struct OrderCancelled has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        account_epoch: u64,
        key_id: vector<u8>,
        nonce: u64,
        order_hash: vector<u8>,
    }

    struct NonceFloorRaised has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        key_id: vector<u8>,
        new_floor: u64,
    }

    struct OrderEpochBumped has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        new_epoch: u64,
    }

    struct OrderStatePruned has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        account_epoch: u64,
        key_id: vector<u8>,
        nonce: u64,
    }

    struct MarketCreated has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        market_key: vector<u8>,
        question: vector<u8>,
        rules_hash: vector<u8>,
        metadata_uri: vector<u8>,
        collateral_type: vector<u8>,
        open_time_ms: u64,
        match_cutoff_ms: u64,
        settlement_deadline_ms: u64,
        price_tick_e6: u64,
        min_price_e6: u64,
        max_price_e6: u64,
        quantity_step_e6: u64,
        min_quantity_e6: u64,
        max_order_quantity_e6: u64,
        max_open_interest_e6: u64,
        max_account_position_per_outcome_e6: u64,
        taker_fee_bps: u64,
        fee_recipient: address,
        oracle_feed_id: vector<u8>,
        oracle_comparison: u8,
        oracle_threshold_mantissa: u64,
        oracle_threshold_negative: bool,
        oracle_threshold_exponent: u8,
        oracle_target_timestamp_ms: u64,
        oracle_publish_window_ms: u64,
        oracle_max_confidence_ratio_bps: u64,
        oracle_resolve_deadline_ms: u64,
        oracle_kind: u8,
    }

    struct MarketPaused has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        paused: bool,
    }

    struct MarketCancelled has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
    }

    struct PositionSplit has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        amount_e6: u64,
        vault_after_e6: u64,
        yes_issued_after_e6: u64,
        no_issued_after_e6: u64,
    }

    struct PositionMerged has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        amount_e6: u64,
        vault_after_e6: u64,
        yes_issued_after_e6: u64,
        no_issued_after_e6: u64,
    }

    struct PositionRedeemed has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        outcome: u8,
        amount_e6: u64,
        payout_e6: u64,
        vault_after_e6: u64,
    }

    struct MatcherKeyRotated has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        old_epoch: u64,
        new_epoch: u64,
        old_key_id: vector<u8>,
        new_key_id: vector<u8>,
        enabled: bool,
    }

    struct MatcherEpochInvalidated has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        old_epoch: u64,
        new_epoch: u64,
        old_key_id: vector<u8>,
    }

    struct PackageUpgradeScheduled has copy, drop {
        schema_version: u8,
        vault_id: 0x2::object::ID,
        original_package_id: 0x2::object::ID,
        action_hash: vector<u8>,
        eta_ms: u64,
    }

    struct PackageUpgradeCancelled has copy, drop {
        schema_version: u8,
        vault_id: 0x2::object::ID,
        action_hash: vector<u8>,
    }

    struct PackageUpgradeAuthorized has copy, drop {
        schema_version: u8,
        vault_id: 0x2::object::ID,
        action_hash: vector<u8>,
    }

    struct PackageUpgradeCommitted has copy, drop {
        schema_version: u8,
        vault_id: 0x2::object::ID,
        original_package_id: 0x2::object::ID,
    }

    struct TimelockActionScheduled has copy, drop {
        schema_version: u8,
        timelock_id: 0x2::object::ID,
        action_hash: vector<u8>,
        eta_ms: u64,
    }

    struct TimelockActionCancelled has copy, drop {
        schema_version: u8,
        timelock_id: 0x2::object::ID,
        action_hash: vector<u8>,
    }

    struct TimelockActionExecuted has copy, drop {
        schema_version: u8,
        timelock_id: 0x2::object::ID,
        action_hash: vector<u8>,
    }

    struct TradeLeg has copy, drop {
        account_id: 0x2::object::ID,
        order_hash: vector<u8>,
        outcome: u8,
        side: u8,
        order_state_before_hash: vector<u8>,
        total_filled_before_e6: u64,
        total_filled_after_e6: u64,
        execution_price_e6: u64,
        quote_delta_e6: u64,
    }

    struct TradeSettled has copy, drop {
        schema_version: u8,
        match_id: vector<u8>,
        matcher_key_epoch: u64,
        settlement_kind: u8,
        market_id: 0x2::object::ID,
        maker: TradeLeg,
        taker: TradeLeg,
        quantity_e6: u64,
        fee_payer_role: u8,
        fee_e6: u64,
        timestamp_ms: u64,
        collateral_delta_kind: u8,
        collateral_delta_e6: u64,
        yes_supply_delta_kind: u8,
        yes_supply_delta_e6: u64,
        no_supply_delta_kind: u8,
        no_supply_delta_e6: u64,
    }

    struct MarketResolved has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        status: u8,
        payout_yes_e6: u64,
        payout_no_e6: u64,
        price_mantissa: u64,
        price_negative: bool,
        price_exponent: u8,
        publish_time_ms: u64,
    }

    struct MarketInvalidated has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
    }

    struct PositionRedeemedEvt has copy, drop {
        schema_version: u8,
    }

    struct PauseFlagSet has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        flag: u64,
        value: bool,
        emergency: bool,
    }

    struct QuotaLocked has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        amount_e6: u64,
        locked_after_e6: u64,
    }

    struct QuotaDecreaseRequested has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        amount_e6: u64,
        unlock_at_ms: u64,
        locked_after_e6: u64,
    }

    struct QuotaDecreaseExecuted has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        amount_e6: u64,
    }

    struct QuotaDecreaseCancelled has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        amount_e6: u64,
    }

    struct QuotaDrawnBySettlement has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        from_locked_e6: u64,
        from_pending_e6: u64,
        from_collateral_e6: u64,
    }

    struct LendingPoolCreated has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        base_rate_bps: u64,
        slope1_bps: u64,
        slope2_bps: u64,
        kink_utilization_bps: u64,
        reserve_factor_bps: u64,
        borrow_cap_e6: u64,
    }

    struct LendingSupplied has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        supplier: address,
        amount_e6: u64,
        shares: u128,
        total_supply_shares: u128,
    }

    struct LendingWithdrawn has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        supplier: address,
        amount_e6: u64,
        shares: u128,
        total_supply_shares: u128,
    }

    struct LendingBorrowed has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount_e6: u64,
        scaled_delta: u128,
        borrow_index_e18: u128,
        total_scaled_debt: u128,
    }

    struct LendingRepaid has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount_e6: u64,
        scaled_delta: u128,
        borrow_index_e18: u128,
        total_scaled_debt: u128,
    }

    struct LendingPoolPauseSet has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        paused: bool,
    }

    struct MarkPriceCreated has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        mark_id: 0x2::object::ID,
        price_e6: u64,
        max_step_e6: u64,
        min_update_interval_ms: u64,
        staleness_ms: u64,
    }

    struct MarkPriceUpdated has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        mark_id: 0x2::object::ID,
        prev_price_e6: u64,
        price_e6: u64,
        updated_ms: u64,
    }

    struct MarginConfigCreated has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        initial_margin_bps: u64,
        maintenance_margin_bps: u64,
        liquidation_penalty_bps: u64,
        close_factor_bps: u64,
        min_debt_e6: u64,
        max_debt_per_position_e6: u64,
        ramp_window_ms: u64,
    }

    struct MarkRegistered has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        mark_id: 0x2::object::ID,
    }

    struct MarginPositionOpened has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        trading_account_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    struct MarginPositionClosed has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
    }

    struct MarginBorrowed has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_e6: u64,
        debt_scaled_after: u128,
    }

    struct MarginRepaid has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_e6: u64,
        debt_scaled_after: u128,
    }

    struct MarginCollateralWithdrawn has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_e6: u64,
    }

    struct LendingDebtWrittenDown has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        value_e6: u64,
        scaled_delta: u128,
        total_scaled_debt: u128,
    }

    struct InsuranceFundCreated has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        fund_id: 0x2::object::ID,
    }

    struct InsuranceFunded has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        fund_id: 0x2::object::ID,
        amount_e6: u64,
        balance_e6: u64,
    }

    struct InsuranceCovered has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        fund_id: 0x2::object::ID,
        amount_e6: u64,
        balance_e6: u64,
    }

    struct LiquidationExecuted has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        liquidator: address,
        repaid_e6: u64,
        seized_usdc_e6: u64,
        seized_yes_e6: u64,
        seized_no_e6: u64,
        fund_fee_e6: u64,
        mark_price_e6: u64,
    }

    struct MarginBadDebt has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        shortfall_e6: u64,
        covered_e6: u64,
        socialized_e6: u64,
    }

    struct MarginUnwound has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        redeemed_payout_e6: u64,
        repaid_e6: u64,
        covered_e6: u64,
        socialized_e6: u64,
    }

    struct ResolutionProposed has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        resolver_id: 0x2::object::ID,
        outcome: u8,
        proposer: address,
        bond_e6: u64,
        proposed_at_ms: u64,
        challenge_window_ms: u64,
    }

    struct ResolutionChallenged has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        resolver_id: 0x2::object::ID,
        challenger: address,
        bond_e6: u64,
    }

    struct ResolutionFinalized has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        resolver_id: 0x2::object::ID,
        outcome: u8,
        arbitrated: bool,
        winner: address,
        protocol_cut_e6: u64,
    }

    struct GroupCreated has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        group_id: 0x2::object::ID,
        title: vector<u8>,
    }

    struct GroupMemberAdded has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        group_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        member_count: u64,
    }

    struct GroupSealed has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        group_id: 0x2::object::ID,
        member_count: u64,
    }

    struct GroupWinnerDeclared has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        group_id: 0x2::object::ID,
        winner_market_id: 0x2::object::ID,
    }

    struct GroupResultApplied has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        group_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        is_winner: bool,
        vault_transferred_e6: u64,
    }

    struct GroupConverted has copy, drop {
        schema_version: u8,
        protocol_id: 0x2::object::ID,
        group_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        source_market_id: 0x2::object::ID,
        amount_e6: u64,
    }

    public(friend) fun emit_account_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = AccountCreated{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            account_id     : arg1,
            owner          : arg2,
        };
        0x2::event::emit<AccountCreated>(v0);
    }

    public(friend) fun emit_deposited(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = Deposited{
            schema_version    : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id       : arg0,
            account_id        : arg1,
            owner             : arg2,
            amount_e6         : arg3,
            new_collateral_e6 : arg4,
        };
        0x2::event::emit<Deposited>(v0);
    }

    public(friend) fun emit_group_converted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64) {
        let v0 = GroupConverted{
            schema_version   : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id      : arg0,
            group_id         : arg1,
            account_id       : arg2,
            source_market_id : arg3,
            amount_e6        : arg4,
        };
        0x2::event::emit<GroupConverted>(v0);
    }

    public(friend) fun emit_group_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>) {
        let v0 = GroupCreated{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            group_id       : arg1,
            title          : arg2,
        };
        0x2::event::emit<GroupCreated>(v0);
    }

    public(friend) fun emit_group_member_added(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = GroupMemberAdded{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            group_id       : arg1,
            market_id      : arg2,
            member_count   : arg3,
        };
        0x2::event::emit<GroupMemberAdded>(v0);
    }

    public(friend) fun emit_group_result_applied(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: bool, arg4: u64) {
        let v0 = GroupResultApplied{
            schema_version       : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id          : arg0,
            group_id             : arg1,
            market_id            : arg2,
            is_winner            : arg3,
            vault_transferred_e6 : arg4,
        };
        0x2::event::emit<GroupResultApplied>(v0);
    }

    public(friend) fun emit_group_sealed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = GroupSealed{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            group_id       : arg1,
            member_count   : arg2,
        };
        0x2::event::emit<GroupSealed>(v0);
    }

    public(friend) fun emit_group_winner_declared(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = GroupWinnerDeclared{
            schema_version   : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id      : arg0,
            group_id         : arg1,
            winner_market_id : arg2,
        };
        0x2::event::emit<GroupWinnerDeclared>(v0);
    }

    public(friend) fun emit_insurance_covered(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = InsuranceCovered{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            fund_id        : arg1,
            amount_e6      : arg2,
            balance_e6     : arg3,
        };
        0x2::event::emit<InsuranceCovered>(v0);
    }

    public(friend) fun emit_insurance_fund_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = InsuranceFundCreated{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            fund_id        : arg1,
        };
        0x2::event::emit<InsuranceFundCreated>(v0);
    }

    public(friend) fun emit_insurance_funded(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = InsuranceFunded{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            fund_id        : arg1,
            amount_e6      : arg2,
            balance_e6     : arg3,
        };
        0x2::event::emit<InsuranceFunded>(v0);
    }

    public(friend) fun emit_lending_borrowed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u128, arg4: u128, arg5: u128) {
        let v0 = LendingBorrowed{
            schema_version    : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id       : arg0,
            pool_id           : arg1,
            amount_e6         : arg2,
            scaled_delta      : arg3,
            borrow_index_e18  : arg4,
            total_scaled_debt : arg5,
        };
        0x2::event::emit<LendingBorrowed>(v0);
    }

    public(friend) fun emit_lending_debt_written_down(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u128, arg4: u128) {
        let v0 = LendingDebtWrittenDown{
            schema_version    : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id       : arg0,
            pool_id           : arg1,
            value_e6          : arg2,
            scaled_delta      : arg3,
            total_scaled_debt : arg4,
        };
        0x2::event::emit<LendingDebtWrittenDown>(v0);
    }

    public(friend) fun emit_lending_pool_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = LendingPoolCreated{
            schema_version       : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id          : arg0,
            pool_id              : arg1,
            base_rate_bps        : arg2,
            slope1_bps           : arg3,
            slope2_bps           : arg4,
            kink_utilization_bps : arg5,
            reserve_factor_bps   : arg6,
            borrow_cap_e6        : arg7,
        };
        0x2::event::emit<LendingPoolCreated>(v0);
    }

    public(friend) fun emit_lending_pool_pause_set(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool) {
        let v0 = LendingPoolPauseSet{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            pool_id        : arg1,
            paused         : arg2,
        };
        0x2::event::emit<LendingPoolPauseSet>(v0);
    }

    public(friend) fun emit_lending_repaid(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u128, arg4: u128, arg5: u128) {
        let v0 = LendingRepaid{
            schema_version    : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id       : arg0,
            pool_id           : arg1,
            amount_e6         : arg2,
            scaled_delta      : arg3,
            borrow_index_e18  : arg4,
            total_scaled_debt : arg5,
        };
        0x2::event::emit<LendingRepaid>(v0);
    }

    public(friend) fun emit_lending_supplied(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u128, arg5: u128) {
        let v0 = LendingSupplied{
            schema_version      : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id         : arg0,
            pool_id             : arg1,
            supplier            : arg2,
            amount_e6           : arg3,
            shares              : arg4,
            total_supply_shares : arg5,
        };
        0x2::event::emit<LendingSupplied>(v0);
    }

    public(friend) fun emit_lending_withdrawn(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u128, arg5: u128) {
        let v0 = LendingWithdrawn{
            schema_version      : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id         : arg0,
            pool_id             : arg1,
            supplier            : arg2,
            amount_e6           : arg3,
            shares              : arg4,
            total_supply_shares : arg5,
        };
        0x2::event::emit<LendingWithdrawn>(v0);
    }

    public(friend) fun emit_liquidation_executed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = LiquidationExecuted{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            position_id    : arg1,
            market_id      : arg2,
            liquidator     : arg3,
            repaid_e6      : arg4,
            seized_usdc_e6 : arg5,
            seized_yes_e6  : arg6,
            seized_no_e6   : arg7,
            fund_fee_e6    : arg8,
            mark_price_e6  : arg9,
        };
        0x2::event::emit<LiquidationExecuted>(v0);
    }

    public(friend) fun emit_margin_bad_debt(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = MarginBadDebt{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            position_id    : arg1,
            market_id      : arg2,
            shortfall_e6   : arg3,
            covered_e6     : arg4,
            socialized_e6  : arg5,
        };
        0x2::event::emit<MarginBadDebt>(v0);
    }

    public(friend) fun emit_margin_borrowed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u128) {
        let v0 = MarginBorrowed{
            schema_version    : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id       : arg0,
            position_id       : arg1,
            amount_e6         : arg2,
            debt_scaled_after : arg3,
        };
        0x2::event::emit<MarginBorrowed>(v0);
    }

    public(friend) fun emit_margin_collateral_withdrawn(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = MarginCollateralWithdrawn{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            position_id    : arg1,
            amount_e6      : arg2,
        };
        0x2::event::emit<MarginCollateralWithdrawn>(v0);
    }

    public(friend) fun emit_margin_config_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = MarginConfigCreated{
            schema_version           : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id              : arg0,
            config_id                : arg1,
            initial_margin_bps       : arg2,
            maintenance_margin_bps   : arg3,
            liquidation_penalty_bps  : arg4,
            close_factor_bps         : arg5,
            min_debt_e6              : arg6,
            max_debt_per_position_e6 : arg7,
            ramp_window_ms           : arg8,
        };
        0x2::event::emit<MarginConfigCreated>(v0);
    }

    public(friend) fun emit_margin_position_closed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = MarginPositionClosed{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            position_id    : arg1,
            owner          : arg2,
        };
        0x2::event::emit<MarginPositionClosed>(v0);
    }

    public(friend) fun emit_margin_position_opened(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID) {
        let v0 = MarginPositionOpened{
            schema_version     : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id        : arg0,
            position_id        : arg1,
            owner              : arg2,
            trading_account_id : arg3,
            market_id          : arg4,
            pool_id            : arg5,
        };
        0x2::event::emit<MarginPositionOpened>(v0);
    }

    public(friend) fun emit_margin_repaid(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u128) {
        let v0 = MarginRepaid{
            schema_version    : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id       : arg0,
            position_id       : arg1,
            amount_e6         : arg2,
            debt_scaled_after : arg3,
        };
        0x2::event::emit<MarginRepaid>(v0);
    }

    public(friend) fun emit_margin_unwound(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = MarginUnwound{
            schema_version     : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id        : arg0,
            position_id        : arg1,
            market_id          : arg2,
            redeemed_payout_e6 : arg3,
            repaid_e6          : arg4,
            covered_e6         : arg5,
            socialized_e6      : arg6,
        };
        0x2::event::emit<MarginUnwound>(v0);
    }

    public(friend) fun emit_mark_price_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = MarkPriceCreated{
            schema_version         : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id            : arg0,
            market_id              : arg1,
            mark_id                : arg2,
            price_e6               : arg3,
            max_step_e6            : arg4,
            min_update_interval_ms : arg5,
            staleness_ms           : arg6,
        };
        0x2::event::emit<MarkPriceCreated>(v0);
    }

    public(friend) fun emit_mark_price_updated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = MarkPriceUpdated{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            market_id      : arg1,
            mark_id        : arg2,
            prev_price_e6  : arg3,
            price_e6       : arg4,
            updated_ms     : arg5,
        };
        0x2::event::emit<MarkPriceUpdated>(v0);
    }

    public(friend) fun emit_mark_registered(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = MarkRegistered{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            market_id      : arg1,
            mark_id        : arg2,
        };
        0x2::event::emit<MarkRegistered>(v0);
    }

    public(friend) fun emit_market_cancelled(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = MarketCancelled{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            market_id      : arg1,
        };
        0x2::event::emit<MarketCancelled>(v0);
    }

    public(friend) fun emit_market_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: address, arg20: vector<u8>, arg21: u8, arg22: u64, arg23: bool, arg24: u8, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u8) {
        let v0 = MarketCreated{
            schema_version                      : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id                         : arg0,
            market_id                           : arg1,
            market_key                          : arg2,
            question                            : arg3,
            rules_hash                          : arg4,
            metadata_uri                        : arg5,
            collateral_type                     : arg6,
            open_time_ms                        : arg7,
            match_cutoff_ms                     : arg8,
            settlement_deadline_ms              : arg9,
            price_tick_e6                       : arg10,
            min_price_e6                        : arg11,
            max_price_e6                        : arg12,
            quantity_step_e6                    : arg13,
            min_quantity_e6                     : arg14,
            max_order_quantity_e6               : arg15,
            max_open_interest_e6                : arg16,
            max_account_position_per_outcome_e6 : arg17,
            taker_fee_bps                       : arg18,
            fee_recipient                       : arg19,
            oracle_feed_id                      : arg20,
            oracle_comparison                   : arg21,
            oracle_threshold_mantissa           : arg22,
            oracle_threshold_negative           : arg23,
            oracle_threshold_exponent           : arg24,
            oracle_target_timestamp_ms          : arg25,
            oracle_publish_window_ms            : arg26,
            oracle_max_confidence_ratio_bps     : arg27,
            oracle_resolve_deadline_ms          : arg28,
            oracle_kind                         : arg29,
        };
        0x2::event::emit<MarketCreated>(v0);
    }

    public(friend) fun emit_market_invalidated(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = MarketInvalidated{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            market_id      : arg1,
        };
        0x2::event::emit<MarketInvalidated>(v0);
    }

    public(friend) fun emit_market_paused(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool) {
        let v0 = MarketPaused{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            market_id      : arg1,
            paused         : arg2,
        };
        0x2::event::emit<MarketPaused>(v0);
    }

    public(friend) fun emit_market_resolved(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u8, arg8: u64) {
        let v0 = MarketResolved{
            schema_version  : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id     : arg0,
            market_id       : arg1,
            status          : arg2,
            payout_yes_e6   : arg3,
            payout_no_e6    : arg4,
            price_mantissa  : arg5,
            price_negative  : arg6,
            price_exponent  : arg7,
            publish_time_ms : arg8,
        };
        0x2::event::emit<MarketResolved>(v0);
    }

    public(friend) fun emit_matcher_epoch_invalidated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: vector<u8>) {
        let v0 = MatcherEpochInvalidated{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            old_epoch      : arg1,
            new_epoch      : arg2,
            old_key_id     : arg3,
        };
        0x2::event::emit<MatcherEpochInvalidated>(v0);
    }

    public(friend) fun emit_matcher_key_rotated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: bool) {
        let v0 = MatcherKeyRotated{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            old_epoch      : arg1,
            new_epoch      : arg2,
            old_key_id     : arg3,
            new_key_id     : arg4,
            enabled        : arg5,
        };
        0x2::event::emit<MatcherKeyRotated>(v0);
    }

    public(friend) fun emit_nonce_floor_raised(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u64) {
        let v0 = NonceFloorRaised{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            account_id     : arg1,
            key_id         : arg2,
            new_floor      : arg3,
        };
        0x2::event::emit<NonceFloorRaised>(v0);
    }

    public(friend) fun emit_order_cancelled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) {
        let v0 = OrderCancelled{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            account_id     : arg1,
            account_epoch  : arg2,
            key_id         : arg3,
            nonce          : arg4,
            order_hash     : arg5,
        };
        0x2::event::emit<OrderCancelled>(v0);
    }

    public(friend) fun emit_order_epoch_bumped(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = OrderEpochBumped{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            account_id     : arg1,
            new_epoch      : arg2,
        };
        0x2::event::emit<OrderEpochBumped>(v0);
    }

    public(friend) fun emit_order_state_pruned(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>, arg4: u64) {
        let v0 = OrderStatePruned{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            account_id     : arg1,
            account_epoch  : arg2,
            key_id         : arg3,
            nonce          : arg4,
        };
        0x2::event::emit<OrderStatePruned>(v0);
    }

    public(friend) fun emit_package_upgrade_authorized(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = PackageUpgradeAuthorized{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            vault_id       : arg0,
            action_hash    : arg1,
        };
        0x2::event::emit<PackageUpgradeAuthorized>(v0);
    }

    public(friend) fun emit_package_upgrade_cancelled(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = PackageUpgradeCancelled{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            vault_id       : arg0,
            action_hash    : arg1,
        };
        0x2::event::emit<PackageUpgradeCancelled>(v0);
    }

    public(friend) fun emit_package_upgrade_committed(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = PackageUpgradeCommitted{
            schema_version      : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            vault_id            : arg0,
            original_package_id : arg1,
        };
        0x2::event::emit<PackageUpgradeCommitted>(v0);
    }

    public(friend) fun emit_package_upgrade_scheduled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u64) {
        let v0 = PackageUpgradeScheduled{
            schema_version      : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            vault_id            : arg0,
            original_package_id : arg1,
            action_hash         : arg2,
            eta_ms              : arg3,
        };
        0x2::event::emit<PackageUpgradeScheduled>(v0);
    }

    public(friend) fun emit_pause_flag_set(arg0: 0x2::object::ID, arg1: u64, arg2: bool, arg3: bool) {
        let v0 = PauseFlagSet{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            flag           : arg1,
            value          : arg2,
            emergency      : arg3,
        };
        0x2::event::emit<PauseFlagSet>(v0);
    }

    public(friend) fun emit_position_merged(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = PositionMerged{
            schema_version      : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id         : arg0,
            market_id           : arg1,
            account_id          : arg2,
            amount_e6           : arg3,
            vault_after_e6      : arg4,
            yes_issued_after_e6 : arg5,
            no_issued_after_e6  : arg6,
        };
        0x2::event::emit<PositionMerged>(v0);
    }

    public(friend) fun emit_position_redeemed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u8, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = PositionRedeemed{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            market_id      : arg1,
            account_id     : arg2,
            outcome        : arg3,
            amount_e6      : arg4,
            payout_e6      : arg5,
            vault_after_e6 : arg6,
        };
        0x2::event::emit<PositionRedeemed>(v0);
    }

    public(friend) fun emit_position_split(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = PositionSplit{
            schema_version      : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id         : arg0,
            market_id           : arg1,
            account_id          : arg2,
            amount_e6           : arg3,
            vault_after_e6      : arg4,
            yes_issued_after_e6 : arg5,
            no_issued_after_e6  : arg6,
        };
        0x2::event::emit<PositionSplit>(v0);
    }

    public(friend) fun emit_protocol_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = ProtocolCreated{
            schema_version                : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id                   : arg0,
            registry_id                   : arg1,
            timelock_id                   : arg2,
            order_domain_package_id       : arg3,
            matcher_key_epoch             : arg4,
            max_session_key_lifetime_ms   : arg5,
            max_session_order_notional_e6 : arg6,
        };
        0x2::event::emit<ProtocolCreated>(v0);
    }

    public(friend) fun emit_quota_decrease_cancelled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = QuotaDecreaseCancelled{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            account_id     : arg1,
            owner          : arg2,
            amount_e6      : arg3,
        };
        0x2::event::emit<QuotaDecreaseCancelled>(v0);
    }

    public(friend) fun emit_quota_decrease_executed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = QuotaDecreaseExecuted{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            account_id     : arg1,
            owner          : arg2,
            amount_e6      : arg3,
        };
        0x2::event::emit<QuotaDecreaseExecuted>(v0);
    }

    public(friend) fun emit_quota_decrease_requested(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = QuotaDecreaseRequested{
            schema_version  : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id     : arg0,
            account_id      : arg1,
            owner           : arg2,
            amount_e6       : arg3,
            unlock_at_ms    : arg4,
            locked_after_e6 : arg5,
        };
        0x2::event::emit<QuotaDecreaseRequested>(v0);
    }

    public(friend) fun emit_quota_drawn_by_settlement(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = QuotaDrawnBySettlement{
            schema_version     : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id        : arg0,
            account_id         : arg1,
            owner              : arg2,
            from_locked_e6     : arg3,
            from_pending_e6    : arg4,
            from_collateral_e6 : arg5,
        };
        0x2::event::emit<QuotaDrawnBySettlement>(v0);
    }

    public(friend) fun emit_quota_locked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = QuotaLocked{
            schema_version  : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id     : arg0,
            account_id      : arg1,
            owner           : arg2,
            amount_e6       : arg3,
            locked_after_e6 : arg4,
        };
        0x2::event::emit<QuotaLocked>(v0);
    }

    public(friend) fun emit_resolution_challenged(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: u64) {
        let v0 = ResolutionChallenged{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            market_id      : arg1,
            resolver_id    : arg2,
            challenger     : arg3,
            bond_e6        : arg4,
        };
        0x2::event::emit<ResolutionChallenged>(v0);
    }

    public(friend) fun emit_resolution_finalized(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u8, arg4: bool, arg5: address, arg6: u64) {
        let v0 = ResolutionFinalized{
            schema_version  : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id     : arg0,
            market_id       : arg1,
            resolver_id     : arg2,
            outcome         : arg3,
            arbitrated      : arg4,
            winner          : arg5,
            protocol_cut_e6 : arg6,
        };
        0x2::event::emit<ResolutionFinalized>(v0);
    }

    public(friend) fun emit_resolution_proposed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u8, arg4: address, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = ResolutionProposed{
            schema_version      : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id         : arg0,
            market_id           : arg1,
            resolver_id         : arg2,
            outcome             : arg3,
            proposer            : arg4,
            bond_e6             : arg5,
            proposed_at_ms      : arg6,
            challenge_window_ms : arg7,
        };
        0x2::event::emit<ResolutionProposed>(v0);
    }

    public(friend) fun emit_session_key_registered(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: vector<u8>) {
        let v0 = SessionKeyRegistered{
            schema_version            : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id               : arg0,
            account_id                : arg1,
            key_id                    : arg2,
            public_key                : arg3,
            valid_until_ms            : arg4,
            max_notional_per_order_e6 : arg5,
            label_hash                : arg6,
        };
        0x2::event::emit<SessionKeyRegistered>(v0);
    }

    public(friend) fun emit_session_key_revoked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>) {
        let v0 = SessionKeyRevoked{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id    : arg0,
            account_id     : arg1,
            key_id         : arg2,
        };
        0x2::event::emit<SessionKeyRevoked>(v0);
    }

    public(friend) fun emit_timelock_action_cancelled(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = TimelockActionCancelled{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            timelock_id    : arg0,
            action_hash    : arg1,
        };
        0x2::event::emit<TimelockActionCancelled>(v0);
    }

    public(friend) fun emit_timelock_action_executed(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = TimelockActionExecuted{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            timelock_id    : arg0,
            action_hash    : arg1,
        };
        0x2::event::emit<TimelockActionExecuted>(v0);
    }

    public(friend) fun emit_timelock_action_scheduled(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = TimelockActionScheduled{
            schema_version : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            timelock_id    : arg0,
            action_hash    : arg1,
            eta_ms         : arg2,
        };
        0x2::event::emit<TimelockActionScheduled>(v0);
    }

    public(friend) fun emit_trade_settled(arg0: vector<u8>, arg1: u64, arg2: u8, arg3: 0x2::object::ID, arg4: TradeLeg, arg5: TradeLeg, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: u64) {
        let v0 = TradeSettled{
            schema_version        : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            match_id              : arg0,
            matcher_key_epoch     : arg1,
            settlement_kind       : arg2,
            market_id             : arg3,
            maker                 : arg4,
            taker                 : arg5,
            quantity_e6           : arg6,
            fee_payer_role        : 1,
            fee_e6                : arg7,
            timestamp_ms          : arg8,
            collateral_delta_kind : arg9,
            collateral_delta_e6   : arg10,
            yes_supply_delta_kind : arg9,
            yes_supply_delta_e6   : arg10,
            no_supply_delta_kind  : arg9,
            no_supply_delta_e6    : arg10,
        };
        0x2::event::emit<TradeSettled>(v0);
    }

    public(friend) fun emit_withdrawn(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = Withdrawn{
            schema_version    : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::event_schema_version(),
            protocol_id       : arg0,
            account_id        : arg1,
            owner             : arg2,
            amount_e6         : arg3,
            new_collateral_e6 : arg4,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    public(friend) fun new_trade_leg(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u8, arg3: u8, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : TradeLeg {
        TradeLeg{
            account_id              : arg0,
            order_hash              : arg1,
            outcome                 : arg2,
            side                    : arg3,
            order_state_before_hash : arg4,
            total_filled_before_e6  : arg5,
            total_filled_after_e6   : arg6,
            execution_price_e6      : arg7,
            quote_delta_e6          : arg8,
        }
    }

    // decompiled from Move bytecode v7
}

