module 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::events {
    struct UpgradedVersion has copy, drop {
        id: 0x2::object::ID,
        version: u64,
    }

    struct CreatedAccount<phantom T0> has copy, drop {
        account_obj_id: 0x2::object::ID,
        user: address,
        account_id: u64,
    }

    struct DepositedCollateral<phantom T0> has copy, drop {
        account_id: u64,
        collateral: u64,
    }

    struct AllocatedCollateral has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        collateral: u64,
    }

    struct WithdrewCollateral<phantom T0> has copy, drop {
        account_id: u64,
        collateral: u64,
    }

    struct RegisteredCollateralInfo<phantom T0> has copy, drop {
        storage_id: u32,
        source_id: u16,
        scaling_factor: u256,
    }

    struct DeallocatedCollateral has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        collateral: u64,
    }

    struct CreatedClearingHouse has copy, drop {
        ch_id: 0x2::object::ID,
        collateral: 0x1::string::String,
        coin_decimals: u64,
        margin_ratio_initial: u256,
        margin_ratio_maintenance: u256,
        base_storage_id: u32,
        base_source_id: u16,
        collateral_storage_id: u32,
        collateral_source_id: u16,
        funding_frequency_ms: u64,
        funding_period_ms: u64,
        premium_twap_frequency_ms: u64,
        premium_twap_period_ms: u64,
        spread_twap_frequency_ms: u64,
        spread_twap_period_ms: u64,
        maker_fee: u256,
        taker_fee: u256,
        liquidation_fee: u256,
        insurance_fund_fee: u256,
        lot_size: u64,
        tick_size: u64,
    }

    struct ClosedMarket has copy, drop {
        ch_id: 0x2::object::ID,
    }

    struct UpdatedSettlementPrices has copy, drop {
        ch_id: 0x2::object::ID,
        base_settlement_price: u256,
        collateral_settlement_price: u256,
        settlement_enabled: bool,
    }

    struct UpdatedIntegratorAddress has copy, drop {
        integrator_id: u32,
        previous_integrator_address: address,
        new_integrator_address: address,
    }

    struct UpdatedPremiumTwap has copy, drop {
        ch_id: 0x2::object::ID,
        actual_book_price: u256,
        clipped_book_price: u256,
        index_price: u256,
        premium_twap: u256,
        premium_twap_last_upd_ms: u64,
    }

    struct UpdatedSpreadTwap has copy, drop {
        ch_id: 0x2::object::ID,
        actual_book_price: u256,
        clipped_book_price: u256,
        index_price: u256,
        spread_twap: u256,
        spread_twap_last_upd_ms: u64,
    }

    struct UpdatedFunding has copy, drop {
        ch_id: 0x2::object::ID,
        cum_funding_rate_long: u256,
        cum_funding_rate_short: u256,
        funding_last_upd_ms: u64,
    }

    struct SettledFunding has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        collateral_change_usd: u256,
        collateral_after: u256,
        mkt_funding_rate_long: u256,
        mkt_funding_rate_short: u256,
    }

    struct SetPositionInitialMarginRatio has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        initial_margin_ratio: u256,
    }

    struct FilledMakerOrders has copy, drop {
        events: vector<FilledMakerOrder>,
    }

    struct FilledMakerOrder has copy, drop {
        ch_id: 0x2::object::ID,
        maker_account_id: u64,
        taker_account_id: u64,
        order_id: u128,
        client_order_id: 0x1::option::Option<u64>,
        filled_size: u64,
        remaining_size: u64,
        canceled_size: u64,
        cancelation_reason: 0x1::option::Option<u8>,
        pnl: u256,
        maker_fees: u256,
        mark_price: u256,
        integrator_id: 0x1::option::Option<u32>,
        integrator_fee_paid_usd: u256,
    }

    struct FilledTakerOrder has copy, drop {
        ch_id: 0x2::object::ID,
        taker_account_id: u64,
        taker_pnl: u256,
        taker_fees: u256,
        integrator_id: 0x1::option::Option<u32>,
        integrator_fee_paid_usd: u256,
        base_asset_delta_ask: u256,
        quote_asset_delta_ask: u256,
        base_asset_delta_bid: u256,
        quote_asset_delta_bid: u256,
        mark_price: u256,
    }

    struct ClosedPositionAtSettlementPrices has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        pnl: u256,
        base_asset_amount: u256,
        quote_asset_amount: u256,
        deallocated_collateral: u64,
        bad_debt: u256,
    }

    struct PostedOrder has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        order_id: u128,
        client_order_id: 0x1::option::Option<u64>,
        order_size: u64,
        reduce_only: bool,
        expiration_timestamp_ms: 0x1::option::Option<u64>,
        integrator_id: 0x1::option::Option<u32>,
        integrator_fee_rate: u32,
        mark_price: u256,
    }

    struct CanceledOrder has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        size: u64,
        order_id: u128,
        client_order_id: 0x1::option::Option<u64>,
        cancelation_reason: u8,
    }

    struct LiquidatedPosition has copy, drop {
        ch_id: 0x2::object::ID,
        liqee_account_id: u64,
        liqor_account_id: u64,
        is_liqee_long: bool,
        base_liquidated: u256,
        quote_liquidated: u256,
        liqee_pnl: u256,
        liquidation_fees: u256,
        insurance_fund_fees: u256,
        bad_debt: u256,
        mark_price: u256,
    }

    struct PerformedLiquidation has copy, drop {
        ch_id: 0x2::object::ID,
        liqee_account_id: u64,
        liqor_account_id: u64,
        is_liqee_long: bool,
        base_liquidated: u256,
        quote_liquidated: u256,
        liqor_pnl: u256,
        liqor_fees: u256,
        mark_price: u256,
    }

    struct PerformedADL has copy, drop {
        ch_id: 0x2::object::ID,
        bad_debt_account_id: u64,
        size_reduced: u64,
        collateral_transferred: u256,
        adl_price: u64,
        counterparty_account_id: u64,
        bad_debt_is_long: bool,
    }

    struct SocializedBadDebt has copy, drop {
        ch_id: 0x2::object::ID,
        bad_debt_usd: u256,
        socialized_fundings: u256,
        added_to_long: bool,
        cum_funding_rate_long: u256,
        cum_funding_rate_short: u256,
    }

    struct CreatedPosition has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        mkt_funding_rate_long: u256,
        mkt_funding_rate_short: u256,
    }

    struct CreatedStopOrderTicket<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        account_id: u64,
        executors: vector<address>,
        execution_domain: 0x1::option::Option<address>,
        gas: u64,
        stop_order_type: u64,
        encrypted_details: vector<u8>,
    }

    struct ExecutedStopOrderTicket<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        account_id: u64,
        executor: address,
    }

    struct DeletedStopOrderTicket<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        account_id: u64,
        executor: address,
    }

    struct EditedStopOrderTicketDetails<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        account_id: u64,
        encrypted_details: vector<u8>,
    }

    struct EditedStopOrderTicketExecutors<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        account_id: u64,
        executors: vector<address>,
    }

    struct CreatedTWAPOrderTicket<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        ch_id: 0x2::object::ID,
        account_id: u64,
        executors: vector<address>,
        execution_domain: 0x1::option::Option<address>,
        gas: u64,
        encrypted_details: vector<u8>,
    }

    struct ProcessedTWAPOrderTicket<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        account_id: u64,
        execution_amount: u64,
        filled_amount: u64,
        remainder: u64,
        processed_amount: u64,
        scheduled_amount: u64,
        last_attempt_timestamp_ms: u64,
        retry_anchor_timestamp_ms: u64,
        last_execution_timestamp_ms: u64,
    }

    struct FinalizedTWAPOrderTicket<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        account_id: u64,
        executor: address,
        deallocated_collateral: u64,
    }

    struct CanceledTWAPOrderTicket<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        account_id: u64,
        sender: address,
        deallocated_collateral: u64,
        partial_fill: bool,
    }

    struct DeletedTWAPOrderTicket<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        account_id: u64,
        executor: address,
    }

    struct EditedTWAPOrderTicketDetails<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        account_id: u64,
        encrypted_details: vector<u8>,
    }

    struct EditedTWAPOrderTicketExecutors<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        account_id: u64,
        executors: vector<address>,
    }

    struct UpdatedMarginRatios has copy, drop {
        ch_id: 0x2::object::ID,
        margin_ratio_initial: u256,
        margin_ratio_maintenance: u256,
    }

    struct SetFeeParams has copy, drop {
        ch_id: 0x2::object::ID,
        maker_fee: u256,
        taker_fee: u256,
        liquidation_fee: u256,
        insurance_fund_fee: u256,
        priority_taker_fee: 0x1::option::Option<u256>,
    }

    struct SetTwapParams has copy, drop {
        ch_id: 0x2::object::ID,
        funding_frequency_ms: u64,
        funding_period_ms: u64,
        premium_twap_frequency_ms: u64,
        premium_twap_period_ms: u64,
        spread_twap_frequency_ms: u64,
        spread_twap_period_ms: u64,
    }

    struct SetCoreParams has copy, drop {
        ch_id: 0x2::object::ID,
        lot_size: u64,
        tick_size: u64,
        collateral_haircut: u256,
    }

    struct SetBaseOracleParams has copy, drop {
        ch_id: 0x2::object::ID,
        storage_id: u32,
        source_id: u16,
        pfs_tolerance: u64,
    }

    struct SetCollateralOracleParams has copy, drop {
        ch_id: 0x2::object::ID,
        storage_id: u32,
        source_id: u16,
        pfs_tolerance: u64,
    }

    struct SetRiskLimitParams has copy, drop {
        ch_id: 0x2::object::ID,
        min_order_usd_value: u256,
        max_pending_orders: u64,
        max_open_interest: u256,
        max_open_interest_threshold: u256,
        max_open_interest_position_percent: u256,
        max_book_index_spread: u256,
        max_index_twap_divergence: u256,
        max_bad_debt: u256,
        max_socialize_losses_mr_decrease: u256,
    }

    struct DonatedToInsuranceFund has copy, drop {
        sender: address,
        ch_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct WithdrewFees has copy, drop {
        sender: address,
        ch_id: 0x2::object::ID,
        amount: u64,
        vault_balance_after: u64,
    }

    struct WithdrewInsuranceFund has copy, drop {
        sender: address,
        ch_id: 0x2::object::ID,
        amount: u64,
        insurance_fund_balance_after: u64,
    }

    struct UpdatedOpenInterestAndFeesAccrued has copy, drop {
        ch_id: 0x2::object::ID,
        open_interest: u256,
        fees_accrued: u256,
    }

    struct RegisteredVendor has copy, drop {
        vendor_key: 0x1::type_name::TypeName,
        vendor_admin_cap_id: 0x2::object::ID,
    }

    struct Froze has copy, drop {
        id: 0x2::object::ID,
        resume_version: u64,
        guardian_cap_id: 0x2::object::ID,
    }

    struct Unfroze has copy, drop {
        id: 0x2::object::ID,
        version: u64,
    }

    public(friend) fun e01<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = CreatedAccount<T0>{
            account_obj_id : arg0,
            user           : arg1,
            account_id     : arg2,
        };
        0x2::event::emit<CreatedAccount<T0>>(v0);
    }

    public(friend) fun e02<T0>(arg0: u64, arg1: u64) {
        let v0 = DepositedCollateral<T0>{
            account_id : arg0,
            collateral : arg1,
        };
        0x2::event::emit<DepositedCollateral<T0>>(v0);
    }

    public(friend) fun e03(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = AllocatedCollateral{
            ch_id      : arg0,
            account_id : arg1,
            collateral : arg2,
        };
        0x2::event::emit<AllocatedCollateral>(v0);
    }

    public(friend) fun e04(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u256, arg4: u256, arg5: u32, arg6: u16, arg7: u32, arg8: u16, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u256, arg16: u256, arg17: u256, arg18: u256, arg19: u64, arg20: u64) {
        let v0 = CreatedClearingHouse{
            ch_id                     : arg0,
            collateral                : arg1,
            coin_decimals             : arg2,
            margin_ratio_initial      : arg3,
            margin_ratio_maintenance  : arg4,
            base_storage_id           : arg5,
            base_source_id            : arg6,
            collateral_storage_id     : arg7,
            collateral_source_id      : arg8,
            funding_frequency_ms      : arg9,
            funding_period_ms         : arg10,
            premium_twap_frequency_ms : arg11,
            premium_twap_period_ms    : arg12,
            spread_twap_frequency_ms  : arg13,
            spread_twap_period_ms     : arg14,
            maker_fee                 : arg15,
            taker_fee                 : arg16,
            liquidation_fee           : arg17,
            insurance_fund_fee        : arg18,
            lot_size                  : arg19,
            tick_size                 : arg20,
        };
        0x2::event::emit<CreatedClearingHouse>(v0);
    }

    public(friend) fun e05(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpgradedVersion{
            id      : arg0,
            version : arg1,
        };
        0x2::event::emit<UpgradedVersion>(v0);
    }

    public(friend) fun e06(arg0: 0x1::type_name::TypeName, arg1: 0x2::object::ID) {
        let v0 = RegisteredVendor{
            vendor_key          : arg0,
            vendor_admin_cap_id : arg1,
        };
        0x2::event::emit<RegisteredVendor>(v0);
    }

    public(friend) fun e07(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID) {
        let v0 = Froze{
            id              : arg0,
            resume_version  : arg1,
            guardian_cap_id : arg2,
        };
        0x2::event::emit<Froze>(v0);
    }

    public(friend) fun e08(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = Unfroze{
            id      : arg0,
            version : arg1,
        };
        0x2::event::emit<Unfroze>(v0);
    }

    public(friend) fun e09(arg0: 0x2::object::ID) {
        let v0 = ClosedMarket{ch_id: arg0};
        0x2::event::emit<ClosedMarket>(v0);
    }

    public(friend) fun e10(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: bool) {
        let v0 = UpdatedSettlementPrices{
            ch_id                       : arg0,
            base_settlement_price       : arg1,
            collateral_settlement_price : arg2,
            settlement_enabled          : arg3,
        };
        0x2::event::emit<UpdatedSettlementPrices>(v0);
    }

    public(friend) fun e11(arg0: u32, arg1: address, arg2: address) {
        let v0 = UpdatedIntegratorAddress{
            integrator_id               : arg0,
            previous_integrator_address : arg1,
            new_integrator_address      : arg2,
        };
        0x2::event::emit<UpdatedIntegratorAddress>(v0);
    }

    public(friend) fun e12(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u64) {
        let v0 = UpdatedPremiumTwap{
            ch_id                    : arg0,
            actual_book_price        : arg1,
            clipped_book_price       : arg2,
            index_price              : arg3,
            premium_twap             : arg4,
            premium_twap_last_upd_ms : arg5,
        };
        0x2::event::emit<UpdatedPremiumTwap>(v0);
    }

    public(friend) fun e13(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u64) {
        let v0 = UpdatedSpreadTwap{
            ch_id                   : arg0,
            actual_book_price       : arg1,
            clipped_book_price      : arg2,
            index_price             : arg3,
            spread_twap             : arg4,
            spread_twap_last_upd_ms : arg5,
        };
        0x2::event::emit<UpdatedSpreadTwap>(v0);
    }

    public(friend) fun e14(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u64) {
        let v0 = UpdatedFunding{
            ch_id                  : arg0,
            cum_funding_rate_long  : arg1,
            cum_funding_rate_short : arg2,
            funding_last_upd_ms    : arg3,
        };
        0x2::event::emit<UpdatedFunding>(v0);
    }

    public(friend) fun e15(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: u256, arg4: u256, arg5: u256) {
        let v0 = SettledFunding{
            ch_id                  : arg0,
            account_id             : arg1,
            collateral_change_usd  : arg2,
            collateral_after       : arg3,
            mkt_funding_rate_long  : arg4,
            mkt_funding_rate_short : arg5,
        };
        0x2::event::emit<SettledFunding>(v0);
    }

    public(friend) fun e16(arg0: 0x2::object::ID, arg1: u64, arg2: u256) {
        let v0 = SetPositionInitialMarginRatio{
            ch_id                : arg0,
            account_id           : arg1,
            initial_margin_ratio : arg2,
        };
        0x2::event::emit<SetPositionInitialMarginRatio>(v0);
    }

    public(friend) fun e17(arg0: 0x2::object::ID, arg1: u64, arg2: u128, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: bool, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u32>, arg8: u32, arg9: u256) {
        let v0 = PostedOrder{
            ch_id                   : arg0,
            account_id              : arg1,
            order_id                : arg2,
            client_order_id         : arg3,
            order_size              : arg4,
            reduce_only             : arg5,
            expiration_timestamp_ms : arg6,
            integrator_id           : arg7,
            integrator_fee_rate     : arg8,
            mark_price              : arg9,
        };
        0x2::event::emit<PostedOrder>(v0);
    }

    public(friend) fun e18(arg0: vector<FilledMakerOrder>) {
        let v0 = FilledMakerOrders{events: arg0};
        0x2::event::emit<FilledMakerOrders>(v0);
    }

    public(friend) fun e19(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u8>, arg9: u256, arg10: u256, arg11: u256, arg12: 0x1::option::Option<u32>, arg13: u256) : FilledMakerOrder {
        FilledMakerOrder{
            ch_id                   : arg0,
            maker_account_id        : arg1,
            taker_account_id        : arg2,
            order_id                : arg3,
            client_order_id         : arg4,
            filled_size             : arg5,
            remaining_size          : arg6,
            canceled_size           : arg7,
            cancelation_reason      : arg8,
            pnl                     : arg9,
            maker_fees              : arg10,
            mark_price              : arg11,
            integrator_id           : arg12,
            integrator_fee_paid_usd : arg13,
        }
    }

    public(friend) fun e20(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: u256, arg4: 0x1::option::Option<u32>, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256) {
        let v0 = FilledTakerOrder{
            ch_id                   : arg0,
            taker_account_id        : arg1,
            taker_pnl               : arg2,
            taker_fees              : arg3,
            integrator_id           : arg4,
            integrator_fee_paid_usd : arg5,
            base_asset_delta_ask    : arg6,
            quote_asset_delta_ask   : arg7,
            base_asset_delta_bid    : arg8,
            quote_asset_delta_bid   : arg9,
            mark_price              : arg10,
        };
        0x2::event::emit<FilledTakerOrder>(v0);
    }

    public(friend) fun e21(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: u256, arg4: u256, arg5: u64, arg6: u256) {
        let v0 = ClosedPositionAtSettlementPrices{
            ch_id                  : arg0,
            account_id             : arg1,
            pnl                    : arg2,
            base_asset_amount      : arg3,
            quote_asset_amount     : arg4,
            deallocated_collateral : arg5,
            bad_debt               : arg6,
        };
        0x2::event::emit<ClosedPositionAtSettlementPrices>(v0);
    }

    public(friend) fun e22(arg0: 0x2::object::ID, arg1: u64, arg2: u128, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: u8) {
        let v0 = CanceledOrder{
            ch_id              : arg0,
            account_id         : arg1,
            size               : arg4,
            order_id           : arg2,
            client_order_id    : arg3,
            cancelation_reason : arg5,
        };
        0x2::event::emit<CanceledOrder>(v0);
    }

    public(friend) fun e23(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: bool, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256) {
        let v0 = LiquidatedPosition{
            ch_id               : arg0,
            liqee_account_id    : arg1,
            liqor_account_id    : arg2,
            is_liqee_long       : arg3,
            base_liquidated     : arg4,
            quote_liquidated    : arg5,
            liqee_pnl           : arg6,
            liquidation_fees    : arg7,
            insurance_fund_fees : arg8,
            bad_debt            : arg9,
            mark_price          : arg10,
        };
        0x2::event::emit<LiquidatedPosition>(v0);
    }

    public(friend) fun e24(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: bool, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256) {
        let v0 = PerformedLiquidation{
            ch_id            : arg0,
            liqee_account_id : arg1,
            liqor_account_id : arg2,
            is_liqee_long    : arg3,
            base_liquidated  : arg4,
            quote_liquidated : arg5,
            liqor_pnl        : arg6,
            liqor_fees       : arg7,
            mark_price       : arg8,
        };
        0x2::event::emit<PerformedLiquidation>(v0);
    }

    public(friend) fun e25(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u256, arg4: u64, arg5: u64, arg6: bool) {
        let v0 = PerformedADL{
            ch_id                   : arg0,
            bad_debt_account_id     : arg1,
            size_reduced            : arg2,
            collateral_transferred  : arg3,
            adl_price               : arg4,
            counterparty_account_id : arg5,
            bad_debt_is_long        : arg6,
        };
        0x2::event::emit<PerformedADL>(v0);
    }

    public(friend) fun e26(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: bool, arg4: u256, arg5: u256) {
        let v0 = SocializedBadDebt{
            ch_id                  : arg0,
            bad_debt_usd           : arg1,
            socialized_fundings    : arg2,
            added_to_long          : arg3,
            cum_funding_rate_long  : arg4,
            cum_funding_rate_short : arg5,
        };
        0x2::event::emit<SocializedBadDebt>(v0);
    }

    public(friend) fun e27<T0>(arg0: u64, arg1: u64) {
        let v0 = WithdrewCollateral<T0>{
            account_id : arg0,
            collateral : arg1,
        };
        0x2::event::emit<WithdrewCollateral<T0>>(v0);
    }

    public(friend) fun e28<T0>(arg0: u32, arg1: u16, arg2: u256) {
        let v0 = RegisteredCollateralInfo<T0>{
            storage_id     : arg0,
            source_id      : arg1,
            scaling_factor : arg2,
        };
        0x2::event::emit<RegisteredCollateralInfo<T0>>(v0);
    }

    public(friend) fun e29(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = DeallocatedCollateral{
            ch_id      : arg0,
            account_id : arg1,
            collateral : arg2,
        };
        0x2::event::emit<DeallocatedCollateral>(v0);
    }

    public(friend) fun e30(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: u256) {
        let v0 = CreatedPosition{
            ch_id                  : arg0,
            account_id             : arg1,
            mkt_funding_rate_long  : arg2,
            mkt_funding_rate_short : arg3,
        };
        0x2::event::emit<CreatedPosition>(v0);
    }

    public(friend) fun e31<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: vector<address>, arg3: 0x1::option::Option<address>, arg4: u64, arg5: u64, arg6: vector<u8>) {
        let v0 = CreatedStopOrderTicket<T0>{
            ticket_id         : arg0,
            account_id        : arg1,
            executors         : arg2,
            execution_domain  : arg3,
            gas               : arg4,
            stop_order_type   : arg5,
            encrypted_details : arg6,
        };
        0x2::event::emit<CreatedStopOrderTicket<T0>>(v0);
    }

    public(friend) fun e32<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = ExecutedStopOrderTicket<T0>{
            ticket_id  : arg0,
            account_id : arg1,
            executor   : arg2,
        };
        0x2::event::emit<ExecutedStopOrderTicket<T0>>(v0);
    }

    public(friend) fun e33<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = DeletedStopOrderTicket<T0>{
            ticket_id  : arg0,
            account_id : arg1,
            executor   : arg2,
        };
        0x2::event::emit<DeletedStopOrderTicket<T0>>(v0);
    }

    public(friend) fun e34<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>) {
        let v0 = EditedStopOrderTicketDetails<T0>{
            ticket_id         : arg0,
            account_id        : arg1,
            encrypted_details : arg2,
        };
        0x2::event::emit<EditedStopOrderTicketDetails<T0>>(v0);
    }

    public(friend) fun e35<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: vector<address>) {
        let v0 = EditedStopOrderTicketExecutors<T0>{
            ticket_id  : arg0,
            account_id : arg1,
            executors  : arg2,
        };
        0x2::event::emit<EditedStopOrderTicketExecutors<T0>>(v0);
    }

    public(friend) fun e36<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: vector<address>, arg4: 0x1::option::Option<address>, arg5: u64, arg6: vector<u8>) {
        let v0 = CreatedTWAPOrderTicket<T0>{
            ticket_id         : arg0,
            ch_id             : arg1,
            account_id        : arg2,
            executors         : arg3,
            execution_domain  : arg4,
            gas               : arg5,
            encrypted_details : arg6,
        };
        0x2::event::emit<CreatedTWAPOrderTicket<T0>>(v0);
    }

    public(friend) fun e37<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = ProcessedTWAPOrderTicket<T0>{
            ticket_id                   : arg0,
            account_id                  : arg1,
            execution_amount            : arg2,
            filled_amount               : arg3,
            remainder                   : arg4,
            processed_amount            : arg5,
            scheduled_amount            : arg6,
            last_attempt_timestamp_ms   : arg7,
            retry_anchor_timestamp_ms   : arg8,
            last_execution_timestamp_ms : arg9,
        };
        0x2::event::emit<ProcessedTWAPOrderTicket<T0>>(v0);
    }

    public(friend) fun e38<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64) {
        let v0 = FinalizedTWAPOrderTicket<T0>{
            ticket_id              : arg0,
            account_id             : arg1,
            executor               : arg2,
            deallocated_collateral : arg3,
        };
        0x2::event::emit<FinalizedTWAPOrderTicket<T0>>(v0);
    }

    public(friend) fun e39<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64, arg4: bool) {
        let v0 = CanceledTWAPOrderTicket<T0>{
            ticket_id              : arg0,
            account_id             : arg1,
            sender                 : arg2,
            deallocated_collateral : arg3,
            partial_fill           : arg4,
        };
        0x2::event::emit<CanceledTWAPOrderTicket<T0>>(v0);
    }

    public(friend) fun e40<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = DeletedTWAPOrderTicket<T0>{
            ticket_id  : arg0,
            account_id : arg1,
            executor   : arg2,
        };
        0x2::event::emit<DeletedTWAPOrderTicket<T0>>(v0);
    }

    public(friend) fun e41<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>) {
        let v0 = EditedTWAPOrderTicketDetails<T0>{
            ticket_id         : arg0,
            account_id        : arg1,
            encrypted_details : arg2,
        };
        0x2::event::emit<EditedTWAPOrderTicketDetails<T0>>(v0);
    }

    public(friend) fun e42<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: vector<address>) {
        let v0 = EditedTWAPOrderTicketExecutors<T0>{
            ticket_id  : arg0,
            account_id : arg1,
            executors  : arg2,
        };
        0x2::event::emit<EditedTWAPOrderTicketExecutors<T0>>(v0);
    }

    public(friend) fun e43(arg0: 0x2::object::ID, arg1: u256, arg2: u256) {
        let v0 = UpdatedMarginRatios{
            ch_id                    : arg0,
            margin_ratio_initial     : arg1,
            margin_ratio_maintenance : arg2,
        };
        0x2::event::emit<UpdatedMarginRatios>(v0);
    }

    public(friend) fun e44(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: 0x1::option::Option<u256>) {
        let v0 = SetFeeParams{
            ch_id              : arg0,
            maker_fee          : arg1,
            taker_fee          : arg2,
            liquidation_fee    : arg3,
            insurance_fund_fee : arg4,
            priority_taker_fee : arg5,
        };
        0x2::event::emit<SetFeeParams>(v0);
    }

    public(friend) fun e45(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = SetTwapParams{
            ch_id                     : arg0,
            funding_frequency_ms      : arg1,
            funding_period_ms         : arg2,
            premium_twap_frequency_ms : arg3,
            premium_twap_period_ms    : arg4,
            spread_twap_frequency_ms  : arg5,
            spread_twap_period_ms     : arg6,
        };
        0x2::event::emit<SetTwapParams>(v0);
    }

    public(friend) fun e46(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u256) {
        let v0 = SetCoreParams{
            ch_id              : arg0,
            lot_size           : arg1,
            tick_size          : arg2,
            collateral_haircut : arg3,
        };
        0x2::event::emit<SetCoreParams>(v0);
    }

    public(friend) fun e47(arg0: 0x2::object::ID, arg1: u32, arg2: u16, arg3: u64) {
        let v0 = SetBaseOracleParams{
            ch_id         : arg0,
            storage_id    : arg1,
            source_id     : arg2,
            pfs_tolerance : arg3,
        };
        0x2::event::emit<SetBaseOracleParams>(v0);
    }

    public(friend) fun e48(arg0: 0x2::object::ID, arg1: u32, arg2: u16, arg3: u64) {
        let v0 = SetCollateralOracleParams{
            ch_id         : arg0,
            storage_id    : arg1,
            source_id     : arg2,
            pfs_tolerance : arg3,
        };
        0x2::event::emit<SetCollateralOracleParams>(v0);
    }

    public(friend) fun e49(arg0: 0x2::object::ID, arg1: u256, arg2: u64, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256) {
        let v0 = SetRiskLimitParams{
            ch_id                              : arg0,
            min_order_usd_value                : arg1,
            max_pending_orders                 : arg2,
            max_open_interest                  : arg3,
            max_open_interest_threshold        : arg4,
            max_open_interest_position_percent : arg5,
            max_book_index_spread              : arg6,
            max_index_twap_divergence          : arg7,
            max_bad_debt                       : arg8,
            max_socialize_losses_mr_decrease   : arg9,
        };
        0x2::event::emit<SetRiskLimitParams>(v0);
    }

    public(friend) fun e50(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = DonatedToInsuranceFund{
            sender      : arg0,
            ch_id       : arg1,
            amount      : arg2,
            new_balance : arg3,
        };
        0x2::event::emit<DonatedToInsuranceFund>(v0);
    }

    public(friend) fun e51(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = WithdrewFees{
            sender              : arg0,
            ch_id               : arg1,
            amount              : arg2,
            vault_balance_after : arg3,
        };
        0x2::event::emit<WithdrewFees>(v0);
    }

    public(friend) fun e52(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = WithdrewInsuranceFund{
            sender                       : arg0,
            ch_id                        : arg1,
            amount                       : arg2,
            insurance_fund_balance_after : arg3,
        };
        0x2::event::emit<WithdrewInsuranceFund>(v0);
    }

    public(friend) fun e53(arg0: 0x2::object::ID, arg1: u256, arg2: u256) {
        let v0 = UpdatedOpenInterestAndFeesAccrued{
            ch_id         : arg0,
            open_interest : arg1,
            fees_accrued  : arg2,
        };
        0x2::event::emit<UpdatedOpenInterestAndFeesAccrued>(v0);
    }

    public(friend) fun e54(arg0: &FilledMakerOrder) : (u256, u256) {
        (arg0.maker_fees, arg0.integrator_fee_paid_usd)
    }

    // decompiled from Move bytecode v7
}

