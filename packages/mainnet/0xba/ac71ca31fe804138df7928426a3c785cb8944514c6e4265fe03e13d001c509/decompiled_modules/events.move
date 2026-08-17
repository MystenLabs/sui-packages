module 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events {
    struct ProtocolInitialized has copy, drop {
        config_id: 0x2::object::ID,
        admin: address,
        version: u64,
    }

    struct ProtocolStatusChanged has copy, drop {
        config_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
    }

    struct ProtocolVersionUpdated has copy, drop {
        config_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    struct ProtocolCapRevoked has copy, drop {
        config_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        kind: u8,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        quote_type: 0x1::type_name::TypeName,
        creator: address,
    }

    struct VaultPaused has copy, drop {
        vault_id: 0x2::object::ID,
        paused: bool,
    }

    struct ShareCapMinted has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        flag: u64,
    }

    struct ShareCapRevoked has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        shares_minted: u64,
        via_cap: bool,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        receiver: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        shares_burned: u64,
        performance_fee: u64,
    }

    struct ShareTransferred has copy, drop {
        vault_id: 0x2::object::ID,
        share_id: 0x2::object::ID,
        from: address,
        to: address,
        royalty: u64,
    }

    struct ManagementFeeAccrued has copy, drop {
        vault_id: 0x2::object::ID,
        shares_minted: u64,
        new_total_shares: u64,
        elapsed_seconds: u64,
    }

    struct PerformanceFeeCollected has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct BuyFeeApplied has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        fee_amount: u64,
        period_used: u64,
        period_cap: u64,
    }

    struct RiskRejection has copy, drop {
        vault_id: 0x2::object::ID,
        reason: u8,
        value: u64,
    }

    struct StrategyTradeIntent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_cap_id: 0x2::object::ID,
        nonce: u64,
        dex: u8,
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        amount_in: u64,
        min_amount_out: u64,
    }

    struct VenueConfigured has copy, drop {
        vault_id: 0x2::object::ID,
        venue: u8,
        kind: u8,
        enabled: bool,
        max_deployed_quote: u64,
        max_notional_per_cycle: u64,
        max_slippage_bps: u64,
    }

    struct PulseChanged has copy, drop {
        config_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        clearance: u8,
        before_mask: u32,
        after_mask: u32,
        halting: bool,
    }

    struct GuardianMinted has copy, drop {
        config_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        clearance: u8,
        products: u32,
    }

    struct GuardianRetired has copy, drop {
        config_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct OracleSourceConfigured has copy, drop {
        aggregator_id: 0x2::object::ID,
        source: u8,
        enabled: bool,
        max_age_ms: u64,
        weight: u64,
    }

    struct OracleAggregated has copy, drop {
        aggregator_id: 0x2::object::ID,
        price: u64,
        scale: u64,
        sources_used: u8,
        source_mask: u32,
        spread_bps: u64,
        oldest_ts_ms: u64,
        observed_at_ms: u64,
    }

    struct OracleSampleRejected has copy, drop {
        aggregator_id: 0x2::object::ID,
        source: u8,
        price: u64,
        reason: u8,
    }

    struct VenueBookFrozen has copy, drop {
        vault_id: 0x2::object::ID,
        book_id: 0x2::object::ID,
        frozen: bool,
    }

    struct StrategyPolicyGranted has copy, drop {
        vault_id: 0x2::object::ID,
        book_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        venue_kind_mask: u32,
        max_notional_per_cycle: u64,
        max_notional_per_period: u64,
        period_ms: u64,
        max_slippage_bps: u64,
        expires_at_ms: u64,
        max_executions: u64,
    }

    struct StrategyPolicyUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        paused: bool,
        max_notional_per_cycle: u64,
        max_notional_per_period: u64,
        max_executions: u64,
    }

    struct StrategyPolicyRevoked has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        executions: u64,
    }

    struct PriceFeedCreated has copy, drop {
        vault_id: 0x2::object::ID,
        feed_id: 0x2::object::ID,
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        scale: u64,
    }

    struct PriceGuardsUpdated has copy, drop {
        feed_id: 0x2::object::ID,
        max_age_ms: u64,
        max_future_skew_ms: u64,
        max_deviation_bps: u64,
        min_price: u64,
        max_price: u64,
    }

    struct PriceFeedPaused has copy, drop {
        feed_id: 0x2::object::ID,
        paused: bool,
    }

    struct PriceApplied has copy, drop {
        vault_id: 0x2::object::ID,
        feed_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        sequence: u64,
        price: u64,
        scale: u64,
        source_ts_ms: u64,
        applied_ms: u64,
        deviation_bps: u64,
        observations: u64,
    }

    struct PriceReceiptDiscarded has copy, drop {
        vault_id: 0x2::object::ID,
        feed_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        sequence: u64,
        price: u64,
        reason: u8,
    }

    struct MK has copy, drop {
        k: 0x2::object::ID,
        n: u64,
        z: u64,
    }

    struct MF has copy, drop {
        b: 0x2::object::ID,
        a: u64,
        d: u8,
    }

    struct FlashOpened has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        sequence: u64,
        notional_quote: u64,
        min_profit_quote: u64,
        ref_price: u64,
        deadline_ms: u64,
    }

    struct FlashAllowanceSet has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        max_flash_notional: u64,
        min_flash_profit_bps: u64,
    }

    struct FlashSettled has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        sequence: u64,
        notional_quote: u64,
        min_profit_quote: u64,
        profit_quote: u64,
    }

    struct BoostOpened has copy, drop {
        vault_id: 0x2::object::ID,
        venue: u8,
        cap_id: 0x2::object::ID,
        sequence: u64,
        asset: 0x1::type_name::TypeName,
        asset_amount: u64,
        principal_quote: u64,
        min_return_quote: u64,
        ref_price: u64,
        deadline_ms: u64,
    }

    struct BoostSettled has copy, drop {
        vault_id: 0x2::object::ID,
        venue: u8,
        cap_id: 0x2::object::ID,
        sequence: u64,
        asset: 0x1::type_name::TypeName,
        asset_amount: u64,
        principal_quote: u64,
        realized_quote: u64,
        profit_quote: u64,
        loss_quote: u64,
    }

    public fun emit_boost_opened(arg0: 0x2::object::ID, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = BoostOpened{
            vault_id         : arg0,
            venue            : arg1,
            cap_id           : arg2,
            sequence         : arg3,
            asset            : arg4,
            asset_amount     : arg5,
            principal_quote  : arg6,
            min_return_quote : arg7,
            ref_price        : arg8,
            deadline_ms      : arg9,
        };
        0x2::event::emit<BoostOpened>(v0);
    }

    public fun emit_boost_settled(arg0: 0x2::object::ID, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = BoostSettled{
            vault_id        : arg0,
            venue           : arg1,
            cap_id          : arg2,
            sequence        : arg3,
            asset           : arg4,
            asset_amount    : arg5,
            principal_quote : arg6,
            realized_quote  : arg7,
            profit_quote    : arg8,
            loss_quote      : arg9,
        };
        0x2::event::emit<BoostSettled>(v0);
    }

    public fun emit_buy_fee(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = BuyFeeApplied{
            vault_id    : arg0,
            coin_type   : arg1,
            fee_amount  : arg2,
            period_used : arg3,
            period_cap  : arg4,
        };
        0x2::event::emit<BuyFeeApplied>(v0);
    }

    public fun emit_deposit(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: bool) {
        let v0 = DepositEvent{
            vault_id      : arg0,
            depositor     : arg1,
            coin_type     : arg2,
            amount        : arg3,
            shares_minted : arg4,
            via_cap       : arg5,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun emit_flash_allowance_set(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = FlashAllowanceSet{
            vault_id             : arg0,
            cap_id               : arg1,
            max_flash_notional   : arg2,
            min_flash_profit_bps : arg3,
        };
        0x2::event::emit<FlashAllowanceSet>(v0);
    }

    public fun emit_flash_opened(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = FlashOpened{
            vault_id         : arg0,
            cap_id           : arg1,
            sequence         : arg2,
            notional_quote   : arg3,
            min_profit_quote : arg4,
            ref_price        : arg5,
            deadline_ms      : arg6,
        };
        0x2::event::emit<FlashOpened>(v0);
    }

    public fun emit_flash_settled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = FlashSettled{
            vault_id         : arg0,
            cap_id           : arg1,
            sequence         : arg2,
            notional_quote   : arg3,
            min_profit_quote : arg4,
            profit_quote     : arg5,
        };
        0x2::event::emit<FlashSettled>(v0);
    }

    public fun emit_guardian_minted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: u32) {
        let v0 = GuardianMinted{
            config_id : arg0,
            cap_id    : arg1,
            clearance : arg2,
            products  : arg3,
        };
        0x2::event::emit<GuardianMinted>(v0);
    }

    public fun emit_guardian_retired(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = GuardianRetired{
            config_id : arg0,
            cap_id    : arg1,
        };
        0x2::event::emit<GuardianRetired>(v0);
    }

    public fun emit_initialized(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = ProtocolInitialized{
            config_id : arg0,
            admin     : arg1,
            version   : arg2,
        };
        0x2::event::emit<ProtocolInitialized>(v0);
    }

    public fun emit_management_fee(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = ManagementFeeAccrued{
            vault_id         : arg0,
            shares_minted    : arg1,
            new_total_shares : arg2,
            elapsed_seconds  : arg3,
        };
        0x2::event::emit<ManagementFeeAccrued>(v0);
    }

    public fun emit_mf(arg0: 0x2::object::ID, arg1: u64, arg2: u8) {
        let v0 = MF{
            b : arg0,
            a : arg1,
            d : arg2,
        };
        0x2::event::emit<MF>(v0);
    }

    public fun emit_mk(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = MK{
            k : arg0,
            n : arg1,
            z : arg2,
        };
        0x2::event::emit<MK>(v0);
    }

    public fun emit_oracle_aggregated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u8, arg4: u32, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = OracleAggregated{
            aggregator_id  : arg0,
            price          : arg1,
            scale          : arg2,
            sources_used   : arg3,
            source_mask    : arg4,
            spread_bps     : arg5,
            oldest_ts_ms   : arg6,
            observed_at_ms : arg7,
        };
        0x2::event::emit<OracleAggregated>(v0);
    }

    public fun emit_oracle_sample_rejected(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: u8) {
        let v0 = OracleSampleRejected{
            aggregator_id : arg0,
            source        : arg1,
            price         : arg2,
            reason        : arg3,
        };
        0x2::event::emit<OracleSampleRejected>(v0);
    }

    public fun emit_oracle_source_configured(arg0: 0x2::object::ID, arg1: u8, arg2: bool, arg3: u64, arg4: u64) {
        let v0 = OracleSourceConfigured{
            aggregator_id : arg0,
            source        : arg1,
            enabled       : arg2,
            max_age_ms    : arg3,
            weight        : arg4,
        };
        0x2::event::emit<OracleSourceConfigured>(v0);
    }

    public fun emit_performance_fee(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = PerformanceFeeCollected{
            vault_id  : arg0,
            coin_type : arg1,
            amount    : arg2,
        };
        0x2::event::emit<PerformanceFeeCollected>(v0);
    }

    public fun emit_policy_granted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u32, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = StrategyPolicyGranted{
            vault_id                : arg0,
            book_id                 : arg1,
            cap_id                  : arg2,
            venue_kind_mask         : arg3,
            max_notional_per_cycle  : arg4,
            max_notional_per_period : arg5,
            period_ms               : arg6,
            max_slippage_bps        : arg7,
            expires_at_ms           : arg8,
            max_executions          : arg9,
        };
        0x2::event::emit<StrategyPolicyGranted>(v0);
    }

    public fun emit_policy_revoked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = StrategyPolicyRevoked{
            vault_id   : arg0,
            cap_id     : arg1,
            executions : arg2,
        };
        0x2::event::emit<StrategyPolicyRevoked>(v0);
    }

    public fun emit_policy_updated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = StrategyPolicyUpdated{
            vault_id                : arg0,
            cap_id                  : arg1,
            paused                  : arg2,
            max_notional_per_cycle  : arg3,
            max_notional_per_period : arg4,
            max_executions          : arg5,
        };
        0x2::event::emit<StrategyPolicyUpdated>(v0);
    }

    public fun emit_price_applied(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = PriceApplied{
            vault_id      : arg0,
            feed_id       : arg1,
            cap_id        : arg2,
            sequence      : arg3,
            price         : arg4,
            scale         : arg5,
            source_ts_ms  : arg6,
            applied_ms    : arg7,
            deviation_bps : arg8,
            observations  : arg9,
        };
        0x2::event::emit<PriceApplied>(v0);
    }

    public fun emit_price_feed_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64) {
        let v0 = PriceFeedCreated{
            vault_id : arg0,
            feed_id  : arg1,
            base     : arg2,
            quote    : arg3,
            scale    : arg4,
        };
        0x2::event::emit<PriceFeedCreated>(v0);
    }

    public fun emit_price_feed_paused(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = PriceFeedPaused{
            feed_id : arg0,
            paused  : arg1,
        };
        0x2::event::emit<PriceFeedPaused>(v0);
    }

    public fun emit_price_guards_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = PriceGuardsUpdated{
            feed_id            : arg0,
            max_age_ms         : arg1,
            max_future_skew_ms : arg2,
            max_deviation_bps  : arg3,
            min_price          : arg4,
            max_price          : arg5,
        };
        0x2::event::emit<PriceGuardsUpdated>(v0);
    }

    public fun emit_price_receipt_discarded(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u8) {
        let v0 = PriceReceiptDiscarded{
            vault_id : arg0,
            feed_id  : arg1,
            cap_id   : arg2,
            sequence : arg3,
            price    : arg4,
            reason   : arg5,
        };
        0x2::event::emit<PriceReceiptDiscarded>(v0);
    }

    public fun emit_protocol_cap_revoked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8) {
        let v0 = ProtocolCapRevoked{
            config_id : arg0,
            cap_id    : arg1,
            kind      : arg2,
        };
        0x2::event::emit<ProtocolCapRevoked>(v0);
    }

    public fun emit_pulse_changed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: u32, arg4: u32, arg5: bool) {
        let v0 = PulseChanged{
            config_id   : arg0,
            cap_id      : arg1,
            clearance   : arg2,
            before_mask : arg3,
            after_mask  : arg4,
            halting     : arg5,
        };
        0x2::event::emit<PulseChanged>(v0);
    }

    public fun emit_risk_rejection(arg0: 0x2::object::ID, arg1: u8, arg2: u64) {
        let v0 = RiskRejection{
            vault_id : arg0,
            reason   : arg1,
            value    : arg2,
        };
        0x2::event::emit<RiskRejection>(v0);
    }

    public fun emit_share_cap_minted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = ShareCapMinted{
            vault_id : arg0,
            cap_id   : arg1,
            flag     : arg2,
        };
        0x2::event::emit<ShareCapMinted>(v0);
    }

    public fun emit_share_cap_revoked(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = ShareCapRevoked{
            vault_id : arg0,
            cap_id   : arg1,
        };
        0x2::event::emit<ShareCapRevoked>(v0);
    }

    public fun emit_share_transferred(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u64) {
        let v0 = ShareTransferred{
            vault_id : arg0,
            share_id : arg1,
            from     : arg2,
            to       : arg3,
            royalty  : arg4,
        };
        0x2::event::emit<ShareTransferred>(v0);
    }

    public fun emit_status_changed(arg0: 0x2::object::ID, arg1: u8, arg2: u8) {
        let v0 = ProtocolStatusChanged{
            config_id  : arg0,
            old_status : arg1,
            new_status : arg2,
        };
        0x2::event::emit<ProtocolStatusChanged>(v0);
    }

    public fun emit_strategy_intent(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: u64, arg7: u64) {
        let v0 = StrategyTradeIntent{
            vault_id        : arg0,
            strategy_cap_id : arg1,
            nonce           : arg2,
            dex             : arg3,
            base            : arg4,
            quote           : arg5,
            amount_in       : arg6,
            min_amount_out  : arg7,
        };
        0x2::event::emit<StrategyTradeIntent>(v0);
    }

    public fun emit_vault_created(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: address) {
        let v0 = VaultCreated{
            vault_id   : arg0,
            quote_type : arg1,
            creator    : arg2,
        };
        0x2::event::emit<VaultCreated>(v0);
    }

    public fun emit_venue_book_frozen(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool) {
        let v0 = VenueBookFrozen{
            vault_id : arg0,
            book_id  : arg1,
            frozen   : arg2,
        };
        0x2::event::emit<VenueBookFrozen>(v0);
    }

    public fun emit_venue_configured(arg0: 0x2::object::ID, arg1: u8, arg2: u8, arg3: bool, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = VenueConfigured{
            vault_id               : arg0,
            venue                  : arg1,
            kind                   : arg2,
            enabled                : arg3,
            max_deployed_quote     : arg4,
            max_notional_per_cycle : arg5,
            max_slippage_bps       : arg6,
        };
        0x2::event::emit<VenueConfigured>(v0);
    }

    public fun emit_version_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = ProtocolVersionUpdated{
            config_id   : arg0,
            old_version : arg1,
            new_version : arg2,
        };
        0x2::event::emit<ProtocolVersionUpdated>(v0);
    }

    public fun emit_withdraw(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = WithdrawEvent{
            vault_id        : arg0,
            receiver        : arg1,
            coin_type       : arg2,
            amount          : arg3,
            shares_burned   : arg4,
            performance_fee : arg5,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

