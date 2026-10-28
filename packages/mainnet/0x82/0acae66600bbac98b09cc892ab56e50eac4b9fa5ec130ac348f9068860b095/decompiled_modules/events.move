module 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct CreateExchangeEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
    }

    struct CreateMarketEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        kind: u8,
    }

    struct UpdateMarketParamsEventV1 has copy, drop {
        market_id: 0x2::object::ID,
    }

    struct ChangeMarketStatusEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        status: u8,
    }

    struct CreateAccountEventV1 has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
    }

    struct AccountTransferredEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        from: address,
        to: address,
        delegates: vector<address>,
    }

    struct DepositEventV1 has copy, drop {
        account_id: 0x2::object::ID,
        amount: u64,
    }

    struct WithdrawEventV1 has copy, drop {
        account_id: 0x2::object::ID,
        amount: u64,
    }

    struct OrderRequestedEventV1 has copy, drop {
        order_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        requester: address,
        market_id: 0x2::object::ID,
        kind: u8,
        is_long: bool,
        margin: u64,
        leverage: u64,
        position_id: u64,
        acceptable_price_wad: u128,
        min_factor_bps: u64,
        max_fee_bps: u64,
        exec_fee: u64,
        requested_ms: u64,
        fill_deadline_ms: u64,
        cancel_after_ms: u64,
        emergency_after_ms: u64,
        fee_owed: u64,
    }

    struct OrderFinalizedEventV1 has copy, drop {
        order_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        market_id: 0x2::object::ID,
        kind: u8,
        outcome: u8,
        position_id: u64,
        price_wad: u128,
        price_ts_ms: u64,
        refund: u64,
        exec_fee: u64,
        finalized_ms: u64,
        sender: address,
        exec_fee_refunded: u64,
    }

    struct OpenPositionEventV1 has copy, drop {
        builder_id: 0x1::option::Option<u32>,
        position_id: u64,
        account_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        is_long: bool,
        mid_wad: u128,
        conf_wad: u128,
        entry_wad: u128,
        bust_wad: u128,
        margin: u64,
        notional: u64,
        factor_bps: u64,
        winning_exposure: u64,
        win_fee_bps: u64,
        deadband_ppm: u64,
        close_fee_ppm: u64,
    }

    struct ClosePositionEventV1 has copy, drop {
        position_id: u64,
        account_id: 0x2::object::ID,
        gross: u64,
        haircut: u64,
        fee: u64,
        net: u64,
        queued: bool,
        builder_id: 0x1::option::Option<u32>,
        builder_amount: u64,
    }

    struct LiquidatePositionEventV1 has copy, drop {
        position_id: u64,
        account_id: 0x2::object::ID,
        bounty: u64,
        to_lp: u64,
    }

    struct PositionExitEventV1 has copy, drop {
        position_id: u64,
        market_id: 0x2::object::ID,
        kind: u8,
        is_long: bool,
        exit_wad: u128,
        timestamp_ms: u64,
    }

    struct EnqueuePayoutEventV2 has copy, drop {
        exchange_id: 0x2::object::ID,
        claim_id: u64,
        account_id: 0x2::object::ID,
        position_id: u64,
        amount: u64,
        fee: u64,
        on_top: u64,
    }

    struct HarvestPayoutEventV2 has copy, drop {
        exchange_id: 0x2::object::ID,
        claim_id: u64,
        account_id: 0x2::object::ID,
        amount: u64,
    }

    struct GrantDelegateEventV1 has copy, drop {
        account_id: 0x2::object::ID,
        delegate: address,
        expiry_ms: u64,
    }

    struct GrantCloseDelegateEventV1 has copy, drop {
        account_id: 0x2::object::ID,
        delegate: address,
    }

    struct RevokeDelegateEventV1 has copy, drop {
        account_id: 0x2::object::ID,
        delegate: address,
    }

    struct ClaimFeesEventV2 has copy, drop {
        exchange_id: 0x2::object::ID,
        amount: u64,
    }

    struct PauseTradingEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        paused: bool,
    }

    struct AdminActionEventV1 has copy, drop {
        object_id: 0x2::object::ID,
        action: u8,
    }

    struct AdminValueEventV1 has copy, drop {
        object_id: 0x2::object::ID,
        action: u8,
        value: u64,
    }

    struct AdminAddressEventV1 has copy, drop {
        object_id: 0x2::object::ID,
        action: u8,
        addr: address,
    }

    struct AdminIdEventV1 has copy, drop {
        object_id: 0x2::object::ID,
        action: u8,
        target_id: 0x2::object::ID,
    }

    struct BindReferrerEventV1 has copy, drop {
        account_id: 0x2::object::ID,
        referee: address,
        referrer: address,
    }

    struct ReferralPayoutEventV1 has copy, drop {
        referrer: address,
        amount: u64,
        account_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct ReferralSettledEventV1 has copy, drop {
        referrer: address,
        account_id: 0x2::object::ID,
        amount: u64,
    }

    struct BuilderRegisteredEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        builder_id: u32,
        code: vector<u8>,
        payout: address,
        owner: address,
        fee_bps: u16,
        self_serve: bool,
        fee_paid: u64,
    }

    struct BuilderPayoutAccountUpdatedEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        builder_id: u32,
        previous: address,
        new: address,
    }

    struct BuilderPendingSettledEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        payout: address,
        account_id: 0x2::object::ID,
        amount: u64,
    }

    struct BuilderFeeSetEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        builder_id: u32,
        fee_bps: u16,
    }

    struct BuilderStatusEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        builder_id: u32,
        status: u8,
        revoke_open: bool,
    }

    struct BuilderOwnerTransferredEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        builder_id: u32,
        previous: address,
        new: address,
    }

    struct BuilderCodeReservedEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        code: vector<u8>,
        reserved: bool,
    }

    struct BuilderApprovalEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        builder_id: u32,
        max_fee_bps: u16,
        approved: bool,
    }

    struct BuilderConfigUpdatedEventV2 has copy, drop {
        config_id: 0x2::object::ID,
        builders_enabled: bool,
        fee_cap_bps: u64,
        max_fee_bps: u64,
        create_fee: u64,
    }

    struct BuilderOnTopAccruedEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        builder_id: u32,
        payout: address,
        trader_account: 0x2::object::ID,
        position_id: u64,
        profit_base: u64,
        amount: u64,
        account_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct BuilderOnTopRefundedEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        builder_id: 0x1::option::Option<u32>,
        trader_account: 0x2::object::ID,
        position_id: u64,
        profit_base: u64,
        amount: u64,
    }

    struct BuilderPositionSnapEventV1 has copy, drop {
        position_id: u64,
        account_id: 0x2::object::ID,
        builder_id: u32,
        fee_bps: u16,
    }

    struct GameEnabledEventV1 has copy, drop {
        enabled: bool,
    }

    struct TierTableUpdatedEventV1 has copy, drop {
        thresholds: vector<u64>,
    }

    struct TierRenamedEventV1 has copy, drop {
        index: u8,
        name: vector<u8>,
    }

    struct DailyDropUpdatedEventV1 has copy, drop {
        base: u64,
        step: u64,
        max: u64,
        streak_cap: u64,
    }

    struct WinXpUpdatedEventV1 has copy, drop {
        bonus: u64,
        streak_cap: u64,
    }

    struct CrateParamsUpdatedEventV1 has copy, drop {
        xp: u64,
        xp_per_crate: u64,
    }

    struct CrateWeightsUpdatedEventV1 has copy, drop {
        money: u64,
        xp: u64,
        cosmetic: u64,
    }

    struct QuestBoundsUpdatedEventV1 has copy, drop {
        cooldown_ms: u64,
        max_money: u64,
        max_xp_grant: u64,
    }

    struct SeasonRewardCeilingUpdatedEventV1 has copy, drop {
        max_season_reward: u64,
    }

    struct SeasonRolledEventV1 has copy, drop {
        season_id: u64,
        start_ms: u64,
        end_ms: u64,
    }

    struct AchievementRegisteredEventV1 has copy, drop {
        id: u8,
        name: vector<u8>,
        kind: u8,
        param: u64,
        xp: u64,
        mint_amount: u64,
        cosmetic: 0x1::option::Option<u8>,
        active: bool,
    }

    struct AchievementActiveEventV1 has copy, drop {
        id: u8,
        active: bool,
    }

    struct QuestRegisteredEventV1 has copy, drop {
        id: u8,
        name: vector<u8>,
        kind: u8,
        param: u64,
        xp: u64,
        money: u64,
        cosmetic: 0x1::option::Option<u8>,
        active: bool,
        start_ms: u64,
        end_ms: u64,
        season_id: u64,
    }

    struct QuestActiveEventV1 has copy, drop {
        id: u8,
        active: bool,
    }

    struct CosmeticRegisteredEventV1 has copy, drop {
        id: u8,
        name: vector<u8>,
    }

    struct CratePoolUpdatedEventV2 has copy, drop {
        ids: vector<u8>,
        weights: vector<u64>,
    }

    struct ParchmentCapInstalledEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
    }

    struct MintCapsUpdatedEventV1 has copy, drop {
        wallet_cap: u64,
        global_cap: u64,
    }

    struct SeasonRewardGrantedEventV1 has copy, drop {
        who: address,
        season_id: u64,
        amount: u64,
    }

    struct GameKeeperGrantedEventV1 has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct OpenStakingSinkEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        sink_id: 0x2::object::ID,
    }

    struct SetOraclePinsEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        storage_id: 0x2::object::ID,
        feed_info_id: 0x2::object::ID,
        lazer_feed_id: u32,
    }

    struct NoteSessionClosedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct SessionArmedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        price_wad: u128,
        ts_ms: u64,
        watermark: u64,
        remaining: u64,
    }

    struct SessionForceClosedEventV1 has copy, drop {
        position_id: u64,
        market_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        price_wad: u128,
        snapshot_ts_ms: u64,
        liquidated: bool,
        caller: address,
    }

    struct SessionDrainedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        closed_count: u64,
    }

    struct SessionDisarmedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        remaining: u64,
        closed_count: u64,
    }

    struct ForceCloseMinGapEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        min_gap_ms: u64,
    }

    struct HarvestFeesEventV2 has copy, drop {
        exchange_id: 0x2::object::ID,
        claim_id: u64,
        account_id: 0x2::object::ID,
        fee: u64,
        referral_discount: u64,
        referral_paid: u64,
        retained: u64,
    }

    struct StakingReferralFundedEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        amount: u64,
        treasury_after: u64,
    }

    struct LiqGraceUpdatedEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        grace_ms: u64,
    }

    struct SurplusCapUpdatedEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        cap_bps: u64,
    }

    struct SurplusCashFloorUpdatedEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        cash_floor: u64,
    }

    struct LiquidatableFlagEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        position_id: u64,
        account_id: 0x2::object::ID,
        flagged: bool,
        since_ms: u64,
        checked_ms: u64,
    }

    struct LiquidationKindEventV1 has copy, drop {
        position_id: u64,
        market_id: 0x2::object::ID,
        liquidator: address,
        kind: u8,
        mint_basis: u64,
        bounty: u64,
    }

    struct StakerRewardsTaken has copy, drop {
        exchange_id: 0x2::object::ID,
        fee_staker_part: u64,
        skim: u64,
        reserve: u64,
        lp_cash_after: u64,
    }

    struct FeeParamsUpdatedEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        trim_max_share_bps: u64,
        trim_c_ppm: u64,
        loss_fee_bps: u64,
    }

    struct RiskGlobalsUpdatedEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        min_payout_factor_bps: u64,
        sweep_max: u64,
        liq_bounty_cap: u64,
    }

    struct WaterfallParamsUpdatedEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        staker_fee_bps: u64,
        surplus_floor_bps: u64,
        surplus_max_bps: u64,
        surplus_interval_ms: u64,
        surplus_staker_bps: u64,
        surplus_treasury_bps: u64,
        surplus_growth_bps: u64,
    }

    struct RetainedFeeCurveUpdatedEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        min_share_bps: u64,
        max_share_bps: u64,
        low_cov_bps: u64,
        high_cov_bps: u64,
    }

    struct SideCapsUpdatedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        max_long_exposure: u64,
        max_short_exposure: u64,
        stress_bps: u64,
    }

    struct OiCapsUpdatedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        max_long_oi: u64,
        max_short_oi: u64,
    }

    struct FeesRoutedEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        retained: u64,
        to_stakers: u64,
        to_treasury: u64,
        to_pool: u64,
    }

    struct SurplusSweptEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        amount: u64,
        to_stakers: u64,
        to_treasury: u64,
        to_growth: u64,
        lp_cash_after: u64,
        reserve: u128,
        timestamp_ms: u64,
    }

    struct GrowthWithdrawnEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        amount: u64,
    }

    struct PendingBasisEventV1 has copy, drop {
        account_id: 0x2::object::ID,
        added: u64,
        total: u64,
    }

    struct HouseResultEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        minted: u128,
        tail_progress: u64,
    }

    struct PositionReconciledEventV1 has copy, drop {
        account_id: 0x2::object::ID,
        position_id: u64,
    }

    struct CloseFeesEventV2 has copy, drop {
        exchange_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        position_id: u64,
        raw_profit: u64,
        trimmed: u64,
        close_charge: u64,
        win_fee: u64,
        loss_fee: u64,
        referral_discount: u64,
        retained: u64,
    }

    struct LiquidationDetailEventV1 has copy, drop {
        position_id: u64,
        market_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        liquidator: address,
        bounty: u64,
        to_pool: u64,
        loss_fee: u64,
        swept: bool,
    }

    struct AchievementMintFractionUpdatedEventV1 has copy, drop {
        fraction_bps: u64,
    }

    struct PauseCategoryEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        category: u8,
        paused: bool,
        by_admin: bool,
    }

    struct PauseAllEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        paused: bool,
        mask: u64,
        by_admin: bool,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public fun emit_account_transferred_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: address, arg5: vector<address>) {
        let v0 = AccountTransferredEventV1{
            exchange_id : arg1,
            account_id  : arg2,
            from        : arg3,
            to          : arg4,
            delegates   : arg5,
        };
        emit<AccountTransferredEventV1>(v0);
    }

    public fun emit_achievement_active_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u8, arg2: bool) {
        let v0 = AchievementActiveEventV1{
            id     : arg1,
            active : arg2,
        };
        emit<AchievementActiveEventV1>(v0);
    }

    public fun emit_achievement_mint_fraction_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64) {
        let v0 = AchievementMintFractionUpdatedEventV1{fraction_bps: arg1};
        emit<AchievementMintFractionUpdatedEventV1>(v0);
    }

    public fun emit_achievement_registered_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u8, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u8>, arg8: bool) {
        let v0 = AchievementRegisteredEventV1{
            id          : arg1,
            name        : arg2,
            kind        : arg3,
            param       : arg4,
            xp          : arg5,
            mint_amount : arg6,
            cosmetic    : arg7,
            active      : arg8,
        };
        emit<AchievementRegisteredEventV1>(v0);
    }

    public fun emit_admin_action(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u8) {
        let v0 = AdminActionEventV1{
            object_id : arg1,
            action    : arg2,
        };
        emit<AdminActionEventV1>(v0);
    }

    public fun emit_admin_address(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u8, arg3: address) {
        let v0 = AdminAddressEventV1{
            object_id : arg1,
            action    : arg2,
            addr      : arg3,
        };
        emit<AdminAddressEventV1>(v0);
    }

    public fun emit_admin_id(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID) {
        let v0 = AdminIdEventV1{
            object_id : arg1,
            action    : arg2,
            target_id : arg3,
        };
        emit<AdminIdEventV1>(v0);
    }

    public fun emit_admin_value(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u8, arg3: u64) {
        let v0 = AdminValueEventV1{
            object_id : arg1,
            action    : arg2,
            value     : arg3,
        };
        emit<AdminValueEventV1>(v0);
    }

    public fun emit_bind_referrer_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: address, arg3: address) {
        let v0 = BindReferrerEventV1{
            account_id : arg1,
            referee    : arg2,
            referrer   : arg3,
        };
        emit<BindReferrerEventV1>(v0);
    }

    public fun emit_builder_approval_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u32, arg4: u16, arg5: bool) {
        let v0 = BuilderApprovalEventV1{
            exchange_id : arg1,
            account_id  : arg2,
            builder_id  : arg3,
            max_fee_bps : arg4,
            approved    : arg5,
        };
        emit<BuilderApprovalEventV1>(v0);
    }

    public fun emit_builder_code_reserved_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: bool) {
        let v0 = BuilderCodeReservedEventV1{
            exchange_id : arg1,
            code        : arg2,
            reserved    : arg3,
        };
        emit<BuilderCodeReservedEventV1>(v0);
    }

    public(friend) fun emit_builder_config_event(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = BuilderConfigUpdatedEventV2{
            config_id        : arg0,
            builders_enabled : arg1,
            fee_cap_bps      : arg2,
            max_fee_bps      : arg3,
            create_fee       : arg4,
        };
        emit<BuilderConfigUpdatedEventV2>(v0);
    }

    public fun emit_builder_fee_set_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u32, arg3: u16) {
        let v0 = BuilderFeeSetEventV1{
            exchange_id : arg1,
            builder_id  : arg2,
            fee_bps     : arg3,
        };
        emit<BuilderFeeSetEventV1>(v0);
    }

    public(friend) fun emit_builder_on_top_event(arg0: 0x2::object::ID, arg1: u32, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<0x2::object::ID>) {
        let v0 = BuilderOnTopAccruedEventV1{
            exchange_id    : arg0,
            builder_id     : arg1,
            payout         : arg2,
            trader_account : arg3,
            position_id    : arg4,
            profit_base    : arg5,
            amount         : arg6,
            account_id     : arg7,
        };
        emit<BuilderOnTopAccruedEventV1>(v0);
    }

    public(friend) fun emit_builder_on_top_refunded_event(arg0: 0x2::object::ID, arg1: 0x1::option::Option<u32>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = BuilderOnTopRefundedEventV1{
            exchange_id    : arg0,
            builder_id     : arg1,
            trader_account : arg2,
            position_id    : arg3,
            profit_base    : arg4,
            amount         : arg5,
        };
        emit<BuilderOnTopRefundedEventV1>(v0);
    }

    public fun emit_builder_owner_transferred_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u32, arg3: address, arg4: address) {
        let v0 = BuilderOwnerTransferredEventV1{
            exchange_id : arg1,
            builder_id  : arg2,
            previous    : arg3,
            new         : arg4,
        };
        emit<BuilderOwnerTransferredEventV1>(v0);
    }

    public fun emit_builder_payout_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u32, arg3: address, arg4: address) {
        let v0 = BuilderPayoutAccountUpdatedEventV1{
            exchange_id : arg1,
            builder_id  : arg2,
            previous    : arg3,
            new         : arg4,
        };
        emit<BuilderPayoutAccountUpdatedEventV1>(v0);
    }

    public(friend) fun emit_builder_pending_settled_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = BuilderPendingSettledEventV1{
            exchange_id : arg0,
            payout      : arg1,
            account_id  : arg2,
            amount      : arg3,
        };
        emit<BuilderPendingSettledEventV1>(v0);
    }

    public fun emit_builder_position_snap_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: 0x2::object::ID, arg3: u32, arg4: u16) {
        let v0 = BuilderPositionSnapEventV1{
            position_id : arg1,
            account_id  : arg2,
            builder_id  : arg3,
            fee_bps     : arg4,
        };
        emit<BuilderPositionSnapEventV1>(v0);
    }

    public fun emit_builder_registered_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u32, arg3: vector<u8>, arg4: address, arg5: address, arg6: u16, arg7: bool, arg8: u64) {
        let v0 = BuilderRegisteredEventV1{
            exchange_id : arg1,
            builder_id  : arg2,
            code        : arg3,
            payout      : arg4,
            owner       : arg5,
            fee_bps     : arg6,
            self_serve  : arg7,
            fee_paid    : arg8,
        };
        emit<BuilderRegisteredEventV1>(v0);
    }

    public fun emit_builder_status_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u32, arg3: u8, arg4: bool) {
        let v0 = BuilderStatusEventV1{
            exchange_id : arg1,
            builder_id  : arg2,
            status      : arg3,
            revoke_open : arg4,
        };
        emit<BuilderStatusEventV1>(v0);
    }

    public(friend) fun emit_change_market_status_event(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = ChangeMarketStatusEventV1{
            market_id : arg0,
            status    : arg1,
        };
        emit<ChangeMarketStatusEventV1>(v0);
    }

    public(friend) fun emit_claim_fees_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ClaimFeesEventV2{
            exchange_id : arg0,
            amount      : arg1,
        };
        emit<ClaimFeesEventV2>(v0);
    }

    public fun emit_close_fees_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = CloseFeesEventV2{
            exchange_id       : arg1,
            account_id        : arg2,
            position_id       : arg3,
            raw_profit        : arg4,
            trimmed           : arg5,
            close_charge      : arg6,
            win_fee           : arg7,
            loss_fee          : arg8,
            referral_discount : arg9,
            retained          : arg10,
        };
        emit<CloseFeesEventV2>(v0);
    }

    public fun emit_close_position_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::option::Option<u32>, arg9: u64) {
        let v0 = ClosePositionEventV1{
            position_id    : arg1,
            account_id     : arg2,
            gross          : arg3,
            haircut        : arg4,
            fee            : arg5,
            net            : arg6,
            queued         : arg7,
            builder_id     : arg8,
            builder_amount : arg9,
        };
        emit<ClosePositionEventV1>(v0);
    }

    public fun emit_cosmetic_registered_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u8, arg2: vector<u8>) {
        let v0 = CosmeticRegisteredEventV1{
            id   : arg1,
            name : arg2,
        };
        emit<CosmeticRegisteredEventV1>(v0);
    }

    public fun emit_crate_params_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: u64) {
        let v0 = CrateParamsUpdatedEventV1{
            xp           : arg1,
            xp_per_crate : arg2,
        };
        emit<CrateParamsUpdatedEventV1>(v0);
    }

    public fun emit_crate_pool_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: vector<u8>, arg2: vector<u64>) {
        let v0 = CratePoolUpdatedEventV2{
            ids     : arg1,
            weights : arg2,
        };
        emit<CratePoolUpdatedEventV2>(v0);
    }

    public fun emit_crate_weights_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = CrateWeightsUpdatedEventV1{
            money    : arg1,
            xp       : arg2,
            cosmetic : arg3,
        };
        emit<CrateWeightsUpdatedEventV1>(v0);
    }

    public(friend) fun emit_create_account_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = CreateAccountEventV1{
            account_id : arg0,
            owner      : arg1,
        };
        emit<CreateAccountEventV1>(v0);
    }

    public(friend) fun emit_create_exchange_event(arg0: 0x2::object::ID) {
        let v0 = CreateExchangeEventV1{exchange_id: arg0};
        emit<CreateExchangeEventV1>(v0);
    }

    public(friend) fun emit_create_market_event(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = CreateMarketEventV1{
            market_id : arg0,
            kind      : arg1,
        };
        emit<CreateMarketEventV1>(v0);
    }

    public fun emit_daily_drop_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = DailyDropUpdatedEventV1{
            base       : arg1,
            step       : arg2,
            max        : arg3,
            streak_cap : arg4,
        };
        emit<DailyDropUpdatedEventV1>(v0);
    }

    public(friend) fun emit_deposit_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = DepositEventV1{
            account_id : arg0,
            amount     : arg1,
        };
        emit<DepositEventV1>(v0);
    }

    public(friend) fun emit_enqueue_payout_event(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = EnqueuePayoutEventV2{
            exchange_id : arg0,
            claim_id    : arg1,
            account_id  : arg2,
            position_id : arg3,
            amount      : arg4,
            fee         : arg5,
            on_top      : arg6,
        };
        emit<EnqueuePayoutEventV2>(v0);
    }

    public(friend) fun emit_fee_params_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = FeeParamsUpdatedEventV1{
            config_id          : arg0,
            trim_max_share_bps : arg1,
            trim_c_ppm         : arg2,
            loss_fee_bps       : arg3,
        };
        emit<FeeParamsUpdatedEventV1>(v0);
    }

    public(friend) fun emit_fees_routed_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = FeesRoutedEventV1{
            exchange_id : arg0,
            retained    : arg1,
            to_stakers  : arg2,
            to_treasury : arg3,
            to_pool     : arg4,
        };
        emit<FeesRoutedEventV1>(v0);
    }

    public(friend) fun emit_force_close_min_gap_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ForceCloseMinGapEventV1{
            config_id  : arg0,
            min_gap_ms : arg1,
        };
        emit<ForceCloseMinGapEventV1>(v0);
    }

    public fun emit_game_enabled_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: bool) {
        let v0 = GameEnabledEventV1{enabled: arg1};
        emit<GameEnabledEventV1>(v0);
    }

    public(friend) fun emit_game_keeper_granted_event(arg0: 0x2::object::ID) {
        let v0 = GameKeeperGrantedEventV1{cap_id: arg0};
        emit<GameKeeperGrantedEventV1>(v0);
    }

    public(friend) fun emit_grant_close_delegate_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = GrantCloseDelegateEventV1{
            account_id : arg0,
            delegate   : arg1,
        };
        emit<GrantCloseDelegateEventV1>(v0);
    }

    public(friend) fun emit_grant_delegate_event(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = GrantDelegateEventV1{
            account_id : arg0,
            delegate   : arg1,
            expiry_ms  : arg2,
        };
        emit<GrantDelegateEventV1>(v0);
    }

    public(friend) fun emit_growth_withdrawn_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = GrowthWithdrawnEventV1{
            exchange_id : arg0,
            amount      : arg1,
        };
        emit<GrowthWithdrawnEventV1>(v0);
    }

    public(friend) fun emit_harvest_fees_event(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = HarvestFeesEventV2{
            exchange_id       : arg0,
            claim_id          : arg1,
            account_id        : arg2,
            fee               : arg3,
            referral_discount : arg4,
            referral_paid     : arg5,
            retained          : arg6,
        };
        emit<HarvestFeesEventV2>(v0);
    }

    public(friend) fun emit_harvest_payout_event(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = HarvestPayoutEventV2{
            exchange_id : arg0,
            claim_id    : arg1,
            account_id  : arg2,
            amount      : arg3,
        };
        emit<HarvestPayoutEventV2>(v0);
    }

    public(friend) fun emit_house_result_event(arg0: 0x2::object::ID, arg1: u128, arg2: u64) {
        let v0 = HouseResultEventV1{
            exchange_id   : arg0,
            minted        : arg1,
            tail_progress : arg2,
        };
        emit<HouseResultEventV1>(v0);
    }

    public(friend) fun emit_liq_grace_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = LiqGraceUpdatedEventV1{
            config_id : arg0,
            grace_ms  : arg1,
        };
        emit<LiqGraceUpdatedEventV1>(v0);
    }

    public fun emit_liquidatable_flag_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::object::ID, arg4: bool, arg5: u64, arg6: u64) {
        let v0 = LiquidatableFlagEventV1{
            market_id   : arg1,
            position_id : arg2,
            account_id  : arg3,
            flagged     : arg4,
            since_ms    : arg5,
            checked_ms  : arg6,
        };
        emit<LiquidatableFlagEventV1>(v0);
    }

    public fun emit_liquidate_position_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        let v0 = LiquidatePositionEventV1{
            position_id : arg1,
            account_id  : arg2,
            bounty      : arg3,
            to_lp       : arg4,
        };
        emit<LiquidatePositionEventV1>(v0);
    }

    public fun emit_liquidation_detail_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: bool) {
        let v0 = LiquidationDetailEventV1{
            position_id : arg1,
            market_id   : arg2,
            account_id  : arg3,
            liquidator  : arg4,
            bounty      : arg5,
            to_pool     : arg6,
            loss_fee    : arg7,
            swept       : arg8,
        };
        emit<LiquidationDetailEventV1>(v0);
    }

    public fun emit_liquidation_kind_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: 0x2::object::ID, arg3: address, arg4: u8, arg5: u64, arg6: u64) {
        let v0 = LiquidationKindEventV1{
            position_id : arg1,
            market_id   : arg2,
            liquidator  : arg3,
            kind        : arg4,
            mint_basis  : arg5,
            bounty      : arg6,
        };
        emit<LiquidationKindEventV1>(v0);
    }

    public fun emit_mint_caps_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: u64) {
        let v0 = MintCapsUpdatedEventV1{
            wallet_cap : arg1,
            global_cap : arg2,
        };
        emit<MintCapsUpdatedEventV1>(v0);
    }

    public fun emit_note_session_closed_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = NoteSessionClosedEventV1{
            market_id    : arg1,
            timestamp_ms : arg2,
        };
        emit<NoteSessionClosedEventV1>(v0);
    }

    public(friend) fun emit_oi_caps_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = OiCapsUpdatedEventV1{
            market_id    : arg0,
            max_long_oi  : arg1,
            max_short_oi : arg2,
        };
        emit<OiCapsUpdatedEventV1>(v0);
    }

    public fun emit_open_position_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: bool, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: 0x1::option::Option<u32>) {
        let v0 = OpenPositionEventV1{
            builder_id       : arg16,
            position_id      : arg1,
            account_id       : arg2,
            market_id        : arg3,
            is_long          : arg4,
            mid_wad          : arg5,
            conf_wad         : arg6,
            entry_wad        : arg7,
            bust_wad         : arg8,
            margin           : arg9,
            notional         : arg10,
            factor_bps       : arg11,
            winning_exposure : arg12,
            win_fee_bps      : arg13,
            deadband_ppm     : arg14,
            close_fee_ppm    : arg15,
        };
        emit<OpenPositionEventV1>(v0);
    }

    public fun emit_open_staking_sink_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = OpenStakingSinkEventV1{
            config_id : arg1,
            sink_id   : arg2,
        };
        emit<OpenStakingSinkEventV1>(v0);
    }

    public fun emit_order_finalized_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: 0x2::object::ID, arg5: u8, arg6: u8, arg7: u64, arg8: u128, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: u64) {
        let v0 = OrderFinalizedEventV1{
            order_id          : arg1,
            account_id        : arg2,
            owner             : arg3,
            market_id         : arg4,
            kind              : arg5,
            outcome           : arg6,
            position_id       : arg7,
            price_wad         : arg8,
            price_ts_ms       : arg9,
            refund            : arg10,
            exec_fee          : arg11,
            finalized_ms      : arg12,
            sender            : arg13,
            exec_fee_refunded : arg14,
        };
        let v1 = Event<OrderFinalizedEventV1>{pos0: v0};
        0x2::event::emit<Event<OrderFinalizedEventV1>>(v1);
    }

    public fun emit_order_requested_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: address, arg5: 0x2::object::ID, arg6: u8, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64) {
        let v0 = OrderRequestedEventV1{
            order_id             : arg1,
            account_id           : arg2,
            owner                : arg3,
            requester            : arg4,
            market_id            : arg5,
            kind                 : arg6,
            is_long              : arg7,
            margin               : arg8,
            leverage             : arg9,
            position_id          : arg10,
            acceptable_price_wad : arg11,
            min_factor_bps       : arg12,
            max_fee_bps          : arg13,
            exec_fee             : arg14,
            requested_ms         : arg15,
            fill_deadline_ms     : arg16,
            cancel_after_ms      : arg17,
            emergency_after_ms   : arg18,
            fee_owed             : arg19,
        };
        let v1 = Event<OrderRequestedEventV1>{pos0: v0};
        0x2::event::emit<Event<OrderRequestedEventV1>>(v1);
    }

    public(friend) fun emit_parchment_cap_installed_event(arg0: 0x2::object::ID) {
        let v0 = ParchmentCapInstalledEventV1{exchange_id: arg0};
        emit<ParchmentCapInstalledEventV1>(v0);
    }

    public(friend) fun emit_pause_all_event(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: bool) {
        let v0 = PauseAllEventV1{
            config_id : arg0,
            paused    : arg1,
            mask      : arg2,
            by_admin  : arg3,
        };
        emit<PauseAllEventV1>(v0);
    }

    public(friend) fun emit_pause_category_event(arg0: 0x2::object::ID, arg1: u8, arg2: bool, arg3: bool) {
        let v0 = PauseCategoryEventV1{
            config_id : arg0,
            category  : arg1,
            paused    : arg2,
            by_admin  : arg3,
        };
        emit<PauseCategoryEventV1>(v0);
    }

    public(friend) fun emit_pause_trading_event(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = PauseTradingEventV1{
            config_id : arg0,
            paused    : arg1,
        };
        emit<PauseTradingEventV1>(v0);
    }

    public(friend) fun emit_pending_basis_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = PendingBasisEventV1{
            account_id : arg0,
            added      : arg1,
            total      : arg2,
        };
        emit<PendingBasisEventV1>(v0);
    }

    public fun emit_position_exit_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: 0x2::object::ID, arg3: u8, arg4: bool, arg5: u128, arg6: u64) {
        let v0 = PositionExitEventV1{
            position_id  : arg1,
            market_id    : arg2,
            kind         : arg3,
            is_long      : arg4,
            exit_wad     : arg5,
            timestamp_ms : arg6,
        };
        emit<PositionExitEventV1>(v0);
    }

    public fun emit_position_reconciled_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = PositionReconciledEventV1{
            account_id  : arg1,
            position_id : arg2,
        };
        emit<PositionReconciledEventV1>(v0);
    }

    public fun emit_quest_active_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u8, arg2: bool) {
        let v0 = QuestActiveEventV1{
            id     : arg1,
            active : arg2,
        };
        emit<QuestActiveEventV1>(v0);
    }

    public fun emit_quest_bounds_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = QuestBoundsUpdatedEventV1{
            cooldown_ms  : arg1,
            max_money    : arg2,
            max_xp_grant : arg3,
        };
        emit<QuestBoundsUpdatedEventV1>(v0);
    }

    public fun emit_quest_registered_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u8, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u8>, arg8: bool, arg9: u64, arg10: u64, arg11: u64) {
        let v0 = QuestRegisteredEventV1{
            id        : arg1,
            name      : arg2,
            kind      : arg3,
            param     : arg4,
            xp        : arg5,
            money     : arg6,
            cosmetic  : arg7,
            active    : arg8,
            start_ms  : arg9,
            end_ms    : arg10,
            season_id : arg11,
        };
        emit<QuestRegisteredEventV1>(v0);
    }

    public fun emit_referral_payout_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: address, arg2: u64, arg3: 0x1::option::Option<0x2::object::ID>) {
        let v0 = ReferralPayoutEventV1{
            referrer   : arg1,
            amount     : arg2,
            account_id : arg3,
        };
        emit<ReferralPayoutEventV1>(v0);
    }

    public fun emit_referral_settled_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: address, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = ReferralSettledEventV1{
            referrer   : arg1,
            account_id : arg2,
            amount     : arg3,
        };
        emit<ReferralSettledEventV1>(v0);
    }

    public(friend) fun emit_retained_fee_curve_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = RetainedFeeCurveUpdatedEventV1{
            config_id     : arg0,
            min_share_bps : arg1,
            max_share_bps : arg2,
            low_cov_bps   : arg3,
            high_cov_bps  : arg4,
        };
        emit<RetainedFeeCurveUpdatedEventV1>(v0);
    }

    public(friend) fun emit_revoke_delegate_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = RevokeDelegateEventV1{
            account_id : arg0,
            delegate   : arg1,
        };
        emit<RevokeDelegateEventV1>(v0);
    }

    public(friend) fun emit_risk_globals_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = RiskGlobalsUpdatedEventV1{
            config_id             : arg0,
            min_payout_factor_bps : arg1,
            sweep_max             : arg2,
            liq_bounty_cap        : arg3,
        };
        emit<RiskGlobalsUpdatedEventV1>(v0);
    }

    public fun emit_season_ceiling_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64) {
        let v0 = SeasonRewardCeilingUpdatedEventV1{max_season_reward: arg1};
        emit<SeasonRewardCeilingUpdatedEventV1>(v0);
    }

    public fun emit_season_reward_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: address, arg2: u64, arg3: u64) {
        let v0 = SeasonRewardGrantedEventV1{
            who       : arg1,
            season_id : arg2,
            amount    : arg3,
        };
        emit<SeasonRewardGrantedEventV1>(v0);
    }

    public fun emit_season_rolled_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = SeasonRolledEventV1{
            season_id : arg1,
            start_ms  : arg2,
            end_ms    : arg3,
        };
        emit<SeasonRolledEventV1>(v0);
    }

    public fun emit_session_armed_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u128, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SessionArmedEventV1{
            market_id : arg1,
            price_wad : arg2,
            ts_ms     : arg3,
            watermark : arg4,
            remaining : arg5,
        };
        emit<SessionArmedEventV1>(v0);
    }

    public fun emit_session_disarmed_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = SessionDisarmedEventV1{
            market_id    : arg1,
            remaining    : arg2,
            closed_count : arg3,
        };
        emit<SessionDisarmedEventV1>(v0);
    }

    public fun emit_session_drained_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = SessionDrainedEventV1{
            market_id    : arg1,
            closed_count : arg2,
        };
        emit<SessionDrainedEventV1>(v0);
    }

    public fun emit_session_force_closed_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u128, arg5: u64, arg6: bool, arg7: address) {
        let v0 = SessionForceClosedEventV1{
            position_id    : arg1,
            market_id      : arg2,
            account_id     : arg3,
            price_wad      : arg4,
            snapshot_ts_ms : arg5,
            liquidated     : arg6,
            caller         : arg7,
        };
        emit<SessionForceClosedEventV1>(v0);
    }

    public(friend) fun emit_set_oracle_pins_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u32) {
        let v0 = SetOraclePinsEventV1{
            market_id     : arg0,
            storage_id    : arg1,
            feed_info_id  : arg2,
            lazer_feed_id : arg3,
        };
        emit<SetOraclePinsEventV1>(v0);
    }

    public(friend) fun emit_side_caps_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = SideCapsUpdatedEventV1{
            market_id          : arg0,
            max_long_exposure  : arg1,
            max_short_exposure : arg2,
            stress_bps         : arg3,
        };
        emit<SideCapsUpdatedEventV1>(v0);
    }

    public(friend) fun emit_staker_rewards_taken(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = StakerRewardsTaken{
            exchange_id     : arg0,
            fee_staker_part : arg1,
            skim            : arg2,
            reserve         : arg3,
            lp_cash_after   : arg4,
        };
        emit<StakerRewardsTaken>(v0);
    }

    public(friend) fun emit_staking_referral_funded_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = StakingReferralFundedEventV1{
            exchange_id    : arg0,
            amount         : arg1,
            treasury_after : arg2,
        };
        emit<StakingReferralFundedEventV1>(v0);
    }

    public(friend) fun emit_surplus_cap_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = SurplusCapUpdatedEventV1{
            config_id : arg0,
            cap_bps   : arg1,
        };
        emit<SurplusCapUpdatedEventV1>(v0);
    }

    public(friend) fun emit_surplus_cash_floor_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = SurplusCashFloorUpdatedEventV1{
            config_id  : arg0,
            cash_floor : arg1,
        };
        emit<SurplusCashFloorUpdatedEventV1>(v0);
    }

    public(friend) fun emit_surplus_swept_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u64) {
        let v0 = SurplusSweptEventV1{
            exchange_id   : arg0,
            amount        : arg1,
            to_stakers    : arg2,
            to_treasury   : arg3,
            to_growth     : arg4,
            lp_cash_after : arg5,
            reserve       : arg6,
            timestamp_ms  : arg7,
        };
        emit<SurplusSweptEventV1>(v0);
    }

    public fun emit_tier_renamed_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u8, arg2: vector<u8>) {
        let v0 = TierRenamedEventV1{
            index : arg1,
            name  : arg2,
        };
        emit<TierRenamedEventV1>(v0);
    }

    public fun emit_tier_table_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: vector<u64>) {
        let v0 = TierTableUpdatedEventV1{thresholds: arg1};
        emit<TierTableUpdatedEventV1>(v0);
    }

    public(friend) fun emit_update_market_params_event(arg0: 0x2::object::ID) {
        let v0 = UpdateMarketParamsEventV1{market_id: arg0};
        emit<UpdateMarketParamsEventV1>(v0);
    }

    public(friend) fun emit_waterfall_params_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = WaterfallParamsUpdatedEventV1{
            config_id            : arg0,
            staker_fee_bps       : arg1,
            surplus_floor_bps    : arg2,
            surplus_max_bps      : arg3,
            surplus_interval_ms  : arg4,
            surplus_staker_bps   : arg5,
            surplus_treasury_bps : arg6,
            surplus_growth_bps   : arg7,
        };
        emit<WaterfallParamsUpdatedEventV1>(v0);
    }

    public fun emit_win_xp_event(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: u64, arg2: u64) {
        let v0 = WinXpUpdatedEventV1{
            bonus      : arg1,
            streak_cap : arg2,
        };
        emit<WinXpUpdatedEventV1>(v0);
    }

    public(friend) fun emit_withdraw_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = WithdrawEventV1{
            account_id : arg0,
            amount     : arg1,
        };
        emit<WithdrawEventV1>(v0);
    }

    public fun inner<T0: copy + drop>(arg0: Event<T0>) : T0 {
        let Event { pos0: v0 } = arg0;
        v0
    }

    public fun on_top_amount(arg0: &BuilderOnTopAccruedEventV1) : u64 {
        arg0.amount
    }

    public fun on_top_profit_base(arg0: &BuilderOnTopAccruedEventV1) : u64 {
        arg0.profit_base
    }

    public fun on_top_refund_amount(arg0: &BuilderOnTopRefundedEventV1) : u64 {
        arg0.amount
    }

    public fun on_top_refund_profit_base(arg0: &BuilderOnTopRefundedEventV1) : u64 {
        arg0.profit_base
    }

    // decompiled from Move bytecode v7
}

