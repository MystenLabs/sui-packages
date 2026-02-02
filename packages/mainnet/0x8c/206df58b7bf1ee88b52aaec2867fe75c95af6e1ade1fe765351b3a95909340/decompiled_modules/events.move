module 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events {
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

    struct DeallocatedCollateral has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        collateral: u64,
    }

    struct CreatedOrderbook has copy, drop {
        branch_min: u64,
        branches_merge_max: u64,
        branch_max: u64,
        leaf_min: u64,
        leaves_merge_max: u64,
        leaf_max: u64,
    }

    struct CreatedClearingHouse has copy, drop {
        ch_id: 0x2::object::ID,
        collateral: 0x1::string::String,
        coin_decimals: u64,
        margin_ratio_initial: u256,
        margin_ratio_maintenance: u256,
        base_oracle_id: 0x2::object::ID,
        collateral_oracle_id: 0x2::object::ID,
        funding_frequency_ms: u64,
        funding_period_ms: u64,
        premium_twap_frequency_ms: u64,
        premium_twap_period_ms: u64,
        spread_twap_frequency_ms: u64,
        spread_twap_period_ms: u64,
        maker_fee: u256,
        taker_fee: u256,
        liquidation_fee: u256,
        force_cancel_fee: u256,
        insurance_fund_fee: u256,
        lot_size: u64,
        tick_size: u64,
    }

    struct RegisteredMarketInfo<phantom T0> has copy, drop {
        ch_id: 0x2::object::ID,
        base_pfs_id: 0x2::object::ID,
        base_pfs_source_id: 0x2::object::ID,
        collateral_pfs_id: 0x2::object::ID,
        collateral_pfs_source_id: 0x2::object::ID,
        scaling_factor: u256,
    }

    struct RemovedRegisteredMarketInfo<phantom T0> has copy, drop {
        ch_id: 0x2::object::ID,
    }

    struct RegisteredCollateralInfo<phantom T0> has copy, drop {
        ch_id: 0x2::object::ID,
        collateral_pfs_id: 0x2::object::ID,
        collateral_pfs_source_id: 0x2::object::ID,
        scaling_factor: u256,
    }

    struct PausedMarket has copy, drop {
        ch_id: 0x2::object::ID,
    }

    struct ResumedMarket has copy, drop {
        ch_id: 0x2::object::ID,
    }

    struct ClosedMarket has copy, drop {
        ch_id: 0x2::object::ID,
        base_settlement_price: u256,
        collateral_settlement_price: u256,
    }

    struct AddedIntegratorConfig<phantom T0> has copy, drop {
        account_id: u64,
        integrator_address: address,
        max_taker_fee: u256,
    }

    struct RemovedIntegratorConfig<phantom T0> has copy, drop {
        account_id: u64,
        integrator_address: address,
    }

    struct PaidIntegratorFees<phantom T0> has copy, drop {
        account_id: u64,
        integrator_address: address,
        fees: u256,
    }

    struct UpdatedClearingHouseVersion has copy, drop {
        ch_id: 0x2::object::ID,
        version: u64,
    }

    struct UpdatedPremiumTwap has copy, drop {
        ch_id: 0x2::object::ID,
        book_price: u256,
        index_price: u256,
        premium_twap: u256,
        premium_twap_last_upd_ms: u64,
    }

    struct UpdatedSpreadTwap has copy, drop {
        ch_id: 0x2::object::ID,
        book_price: u256,
        index_price: u256,
        spread_twap: u256,
        spread_twap_last_upd_ms: u64,
    }

    struct UpdatedGasPriceTwap has copy, drop {
        ch_id: 0x2::object::ID,
        gas_price: u256,
        mean: u256,
        variance: u256,
        gas_price_last_upd_ms: u64,
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

    struct FilledMakerOrders has copy, drop {
        events: vector<FilledMakerOrder>,
    }

    struct FilledMakerOrder has copy, drop {
        ch_id: 0x2::object::ID,
        maker_account_id: u64,
        taker_account_id: u64,
        order_id: u128,
        filled_size: u64,
        remaining_size: u64,
        canceled_size: u64,
        pnl: u256,
        fees: u256,
    }

    struct FilledTakerOrder has copy, drop {
        ch_id: 0x2::object::ID,
        taker_account_id: u64,
        taker_pnl: u256,
        taker_fees: u256,
        integrator_taker_fees: u256,
        integrator_address: 0x1::option::Option<address>,
        base_asset_delta_ask: u256,
        quote_asset_delta_ask: u256,
        base_asset_delta_bid: u256,
        quote_asset_delta_bid: u256,
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
        order_size: u64,
        reduce_only: bool,
        expiration_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct CanceledOrder has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        size: u64,
        order_id: u128,
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
        force_cancel_fees: u256,
        insurance_fund_fees: u256,
        bad_debt: u256,
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

    struct SetPositionInitialMarginRatio has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        initial_margin_ratio: u256,
    }

    struct CreatedStopOrderTicket<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        account_id: u64,
        executors: vector<address>,
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

    struct CreatedMarginRatiosProposal has copy, drop {
        ch_id: 0x2::object::ID,
        margin_ratio_initial: u256,
        margin_ratio_maintenance: u256,
    }

    struct UpdatedMarginRatios has copy, drop {
        ch_id: 0x2::object::ID,
        margin_ratio_initial: u256,
        margin_ratio_maintenance: u256,
    }

    struct DeletedMarginRatiosProposal has copy, drop {
        ch_id: 0x2::object::ID,
        margin_ratio_initial: u256,
        margin_ratio_maintenance: u256,
    }

    struct CreatedPositionFeesProposal has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        maker_fee: u256,
        taker_fee: u256,
    }

    struct DeletedPositionFeesProposal has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        maker_fee: u256,
        taker_fee: u256,
    }

    struct AcceptedPositionFeesProposal has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        maker_fee: u256,
        taker_fee: u256,
    }

    struct RejectedPositionFeesProposal has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
        maker_fee: u256,
        taker_fee: u256,
    }

    struct ResettedPositionFees has copy, drop {
        ch_id: 0x2::object::ID,
        account_id: u64,
    }

    struct CreatedIntegratorVault has copy, drop {
        ch_id: 0x2::object::ID,
        integrator_address: address,
    }

    struct WithdrewFromIntegratorVault has copy, drop {
        ch_id: 0x2::object::ID,
        integrator_address: address,
        fees: u64,
    }

    struct UpdatedFees has copy, drop {
        ch_id: 0x2::object::ID,
        maker_fee: u256,
        taker_fee: u256,
        liquidation_fee: u256,
        force_cancel_fee: u256,
        insurance_fund_fee: u256,
    }

    struct UpdatedFundingParameters has copy, drop {
        ch_id: 0x2::object::ID,
        funding_frequency_ms: u64,
        funding_period_ms: u64,
        premium_twap_frequency_ms: u64,
        premium_twap_period_ms: u64,
    }

    struct UpdatedSpreadTwapParameters has copy, drop {
        ch_id: 0x2::object::ID,
        spread_twap_frequency_ms: u64,
        spread_twap_period_ms: u64,
    }

    struct UpdatedGasPriceTwapParameters has copy, drop {
        ch_id: 0x2::object::ID,
        gas_price_twap_period_ms: u64,
        gas_price_taker_fee: u256,
        z_score_threshold: u256,
    }

    struct UpdatedMarketLotAndTick has copy, drop {
        ch_id: 0x2::object::ID,
        lot_size: u64,
        tick_size: u64,
    }

    struct UpdatedMinOrderUsdValue has copy, drop {
        ch_id: 0x2::object::ID,
        min_order_usd_value: u256,
    }

    struct UpdatedBasePfsID has copy, drop {
        ch_id: 0x2::object::ID,
        pfs_id: 0x2::object::ID,
    }

    struct UpdatedCollateralPfsID has copy, drop {
        ch_id: 0x2::object::ID,
        pfs_id: 0x2::object::ID,
    }

    struct UpdatedBasePfsSourceID has copy, drop {
        ch_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
    }

    struct UpdatedCollateralPfsSourceID has copy, drop {
        ch_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
    }

    struct UpdatedBasePfsTolerance has copy, drop {
        ch_id: 0x2::object::ID,
        pfs_tolerance: u64,
    }

    struct UpdatedCollateralPfsTolerance has copy, drop {
        ch_id: 0x2::object::ID,
        pfs_tolerance: u64,
    }

    struct UpdatedMaxOpenInterest has copy, drop {
        ch_id: 0x2::object::ID,
        max_open_interest: u256,
    }

    struct UpdatedMaxOpenInterestPositionParams has copy, drop {
        ch_id: 0x2::object::ID,
        max_open_interest_threshold: u256,
        max_open_interest_position_percent: u256,
    }

    struct UpdatedMaxBadDebt has copy, drop {
        ch_id: 0x2::object::ID,
        max_bad_debt: u256,
    }

    struct UpdatedMaxSocializeLossesMrDecrease has copy, drop {
        ch_id: 0x2::object::ID,
        max_socialize_losses_mr_decrease: u256,
    }

    struct UpdatedCollateralHaircut has copy, drop {
        ch_id: 0x2::object::ID,
        collateral_haircut: u256,
    }

    struct UpdatedMaxPendingOrders has copy, drop {
        ch_id: 0x2::object::ID,
        max_pending_orders: u64,
    }

    struct UpdatedStopOrderMistCost has copy, drop {
        stop_order_mist_cost: u64,
    }

    struct DonatedToInsuranceFund has copy, drop {
        sender: address,
        ch_id: 0x2::object::ID,
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

    public(friend) fun create_filled_maker_order(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: u256, arg8: u256) : FilledMakerOrder {
        FilledMakerOrder{
            ch_id            : arg0,
            maker_account_id : arg1,
            taker_account_id : arg2,
            order_id         : arg3,
            filled_size      : arg4,
            remaining_size   : arg5,
            canceled_size    : arg6,
            pnl              : arg7,
            fees             : arg8,
        }
    }

    public(friend) fun emit_accepted_position_fees_proposal(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: u256) {
        let v0 = AcceptedPositionFeesProposal{
            ch_id      : arg0,
            account_id : arg1,
            maker_fee  : arg2,
            taker_fee  : arg3,
        };
        0x2::event::emit<AcceptedPositionFeesProposal>(v0);
    }

    public(friend) fun emit_added_integrator_config<T0>(arg0: u64, arg1: address, arg2: u256) {
        let v0 = AddedIntegratorConfig<T0>{
            account_id         : arg0,
            integrator_address : arg1,
            max_taker_fee      : arg2,
        };
        0x2::event::emit<AddedIntegratorConfig<T0>>(v0);
    }

    public(friend) fun emit_allocated_collateral(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = AllocatedCollateral{
            ch_id      : arg0,
            account_id : arg1,
            collateral : arg2,
        };
        0x2::event::emit<AllocatedCollateral>(v0);
    }

    public(friend) fun emit_canceled_order(arg0: 0x2::object::ID, arg1: u64, arg2: u128, arg3: u64) {
        let v0 = CanceledOrder{
            ch_id      : arg0,
            account_id : arg1,
            size       : arg3,
            order_id   : arg2,
        };
        0x2::event::emit<CanceledOrder>(v0);
    }

    public(friend) fun emit_closed_market(arg0: 0x2::object::ID, arg1: u256, arg2: u256) {
        let v0 = ClosedMarket{
            ch_id                       : arg0,
            base_settlement_price       : arg1,
            collateral_settlement_price : arg2,
        };
        0x2::event::emit<ClosedMarket>(v0);
    }

    public(friend) fun emit_closed_position_at_settlement_prices(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: u256, arg4: u256, arg5: u64, arg6: u256) {
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

    public(friend) fun emit_created_account<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = CreatedAccount<T0>{
            account_obj_id : arg0,
            user           : arg1,
            account_id     : arg2,
        };
        0x2::event::emit<CreatedAccount<T0>>(v0);
    }

    public(friend) fun emit_created_clearing_house(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u256, arg4: u256, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u256, arg14: u256, arg15: u256, arg16: u256, arg17: u256, arg18: u64, arg19: u64) {
        let v0 = CreatedClearingHouse{
            ch_id                     : arg0,
            collateral                : arg1,
            coin_decimals             : arg2,
            margin_ratio_initial      : arg3,
            margin_ratio_maintenance  : arg4,
            base_oracle_id            : arg5,
            collateral_oracle_id      : arg6,
            funding_frequency_ms      : arg7,
            funding_period_ms         : arg8,
            premium_twap_frequency_ms : arg9,
            premium_twap_period_ms    : arg10,
            spread_twap_frequency_ms  : arg11,
            spread_twap_period_ms     : arg12,
            maker_fee                 : arg13,
            taker_fee                 : arg14,
            liquidation_fee           : arg15,
            force_cancel_fee          : arg16,
            insurance_fund_fee        : arg17,
            lot_size                  : arg18,
            tick_size                 : arg19,
        };
        0x2::event::emit<CreatedClearingHouse>(v0);
    }

    public(friend) fun emit_created_integrator_vault(arg0: 0x2::object::ID, arg1: address) {
        let v0 = CreatedIntegratorVault{
            ch_id              : arg0,
            integrator_address : arg1,
        };
        0x2::event::emit<CreatedIntegratorVault>(v0);
    }

    public(friend) fun emit_created_margin_ratios_proposal(arg0: 0x2::object::ID, arg1: u256, arg2: u256) {
        let v0 = CreatedMarginRatiosProposal{
            ch_id                    : arg0,
            margin_ratio_initial     : arg1,
            margin_ratio_maintenance : arg2,
        };
        0x2::event::emit<CreatedMarginRatiosProposal>(v0);
    }

    public(friend) fun emit_created_orderbook(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = CreatedOrderbook{
            branch_min         : arg0,
            branches_merge_max : arg1,
            branch_max         : arg2,
            leaf_min           : arg3,
            leaves_merge_max   : arg4,
            leaf_max           : arg5,
        };
        0x2::event::emit<CreatedOrderbook>(v0);
    }

    public(friend) fun emit_created_position(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: u256) {
        let v0 = CreatedPosition{
            ch_id                  : arg0,
            account_id             : arg1,
            mkt_funding_rate_long  : arg2,
            mkt_funding_rate_short : arg3,
        };
        0x2::event::emit<CreatedPosition>(v0);
    }

    public(friend) fun emit_created_position_fees_proposal(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: u256) {
        let v0 = CreatedPositionFeesProposal{
            ch_id      : arg0,
            account_id : arg1,
            maker_fee  : arg2,
            taker_fee  : arg3,
        };
        0x2::event::emit<CreatedPositionFeesProposal>(v0);
    }

    public(friend) fun emit_created_stop_order_ticket<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: vector<address>, arg3: u64, arg4: u64, arg5: vector<u8>) {
        let v0 = CreatedStopOrderTicket<T0>{
            ticket_id         : arg0,
            account_id        : arg1,
            executors         : arg2,
            gas               : arg3,
            stop_order_type   : arg4,
            encrypted_details : arg5,
        };
        0x2::event::emit<CreatedStopOrderTicket<T0>>(v0);
    }

    public(friend) fun emit_deallocated_collateral(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = DeallocatedCollateral{
            ch_id      : arg0,
            account_id : arg1,
            collateral : arg2,
        };
        0x2::event::emit<DeallocatedCollateral>(v0);
    }

    public(friend) fun emit_deleted_margin_ratios_proposal(arg0: 0x2::object::ID, arg1: u256, arg2: u256) {
        let v0 = DeletedMarginRatiosProposal{
            ch_id                    : arg0,
            margin_ratio_initial     : arg1,
            margin_ratio_maintenance : arg2,
        };
        0x2::event::emit<DeletedMarginRatiosProposal>(v0);
    }

    public(friend) fun emit_deleted_position_fees_proposal(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: u256) {
        let v0 = DeletedPositionFeesProposal{
            ch_id      : arg0,
            account_id : arg1,
            maker_fee  : arg2,
            taker_fee  : arg3,
        };
        0x2::event::emit<DeletedPositionFeesProposal>(v0);
    }

    public(friend) fun emit_deleted_stop_order_ticket<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = DeletedStopOrderTicket<T0>{
            ticket_id  : arg0,
            account_id : arg1,
            executor   : arg2,
        };
        0x2::event::emit<DeletedStopOrderTicket<T0>>(v0);
    }

    public(friend) fun emit_deposited_collateral<T0>(arg0: u64, arg1: u64) {
        let v0 = DepositedCollateral<T0>{
            account_id : arg0,
            collateral : arg1,
        };
        0x2::event::emit<DepositedCollateral<T0>>(v0);
    }

    public(friend) fun emit_donated_to_insurance_fund(arg0: address, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = DonatedToInsuranceFund{
            sender      : arg0,
            ch_id       : arg1,
            new_balance : arg2,
        };
        0x2::event::emit<DonatedToInsuranceFund>(v0);
    }

    public(friend) fun emit_edited_stop_order_ticket_details<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>) {
        let v0 = EditedStopOrderTicketDetails<T0>{
            ticket_id         : arg0,
            account_id        : arg1,
            encrypted_details : arg2,
        };
        0x2::event::emit<EditedStopOrderTicketDetails<T0>>(v0);
    }

    public(friend) fun emit_edited_stop_order_ticket_executors<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: vector<address>) {
        let v0 = EditedStopOrderTicketExecutors<T0>{
            ticket_id  : arg0,
            account_id : arg1,
            executors  : arg2,
        };
        0x2::event::emit<EditedStopOrderTicketExecutors<T0>>(v0);
    }

    public(friend) fun emit_executed_stop_order_ticket<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = ExecutedStopOrderTicket<T0>{
            ticket_id  : arg0,
            account_id : arg1,
            executor   : arg2,
        };
        0x2::event::emit<ExecutedStopOrderTicket<T0>>(v0);
    }

    public(friend) fun emit_filled_maker_orders(arg0: vector<FilledMakerOrder>) {
        let v0 = FilledMakerOrders{events: arg0};
        0x2::event::emit<FilledMakerOrders>(v0);
    }

    public(friend) fun emit_filled_taker_order(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: u256, arg4: u256, arg5: 0x1::option::Option<address>, arg6: u256, arg7: u256, arg8: u256, arg9: u256) {
        let v0 = FilledTakerOrder{
            ch_id                 : arg0,
            taker_account_id      : arg1,
            taker_pnl             : arg2,
            taker_fees            : arg3,
            integrator_taker_fees : arg4,
            integrator_address    : arg5,
            base_asset_delta_ask  : arg6,
            quote_asset_delta_ask : arg7,
            base_asset_delta_bid  : arg8,
            quote_asset_delta_bid : arg9,
        };
        0x2::event::emit<FilledTakerOrder>(v0);
    }

    public(friend) fun emit_liquidated_position(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: bool, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256) {
        let v0 = LiquidatedPosition{
            ch_id               : arg0,
            liqee_account_id    : arg1,
            liqor_account_id    : arg2,
            is_liqee_long       : arg3,
            base_liquidated     : arg4,
            quote_liquidated    : arg5,
            liqee_pnl           : arg6,
            liquidation_fees    : arg7,
            force_cancel_fees   : arg8,
            insurance_fund_fees : arg9,
            bad_debt            : arg10,
        };
        0x2::event::emit<LiquidatedPosition>(v0);
    }

    public(friend) fun emit_paid_integrator_fees<T0>(arg0: u64, arg1: address, arg2: u256) {
        let v0 = PaidIntegratorFees<T0>{
            account_id         : arg0,
            integrator_address : arg1,
            fees               : arg2,
        };
        0x2::event::emit<PaidIntegratorFees<T0>>(v0);
    }

    public(friend) fun emit_paused_market(arg0: 0x2::object::ID) {
        let v0 = PausedMarket{ch_id: arg0};
        0x2::event::emit<PausedMarket>(v0);
    }

    public(friend) fun emit_performed_adl(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u256, arg4: u64, arg5: u64, arg6: bool) {
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

    public(friend) fun emit_performed_liquidation(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: bool, arg4: u256, arg5: u256, arg6: u256, arg7: u256) {
        let v0 = PerformedLiquidation{
            ch_id            : arg0,
            liqee_account_id : arg1,
            liqor_account_id : arg2,
            is_liqee_long    : arg3,
            base_liquidated  : arg4,
            quote_liquidated : arg5,
            liqor_pnl        : arg6,
            liqor_fees       : arg7,
        };
        0x2::event::emit<PerformedLiquidation>(v0);
    }

    public(friend) fun emit_posted_order(arg0: 0x2::object::ID, arg1: u64, arg2: u128, arg3: u64, arg4: bool, arg5: 0x1::option::Option<u64>) {
        let v0 = PostedOrder{
            ch_id                   : arg0,
            account_id              : arg1,
            order_id                : arg2,
            order_size              : arg3,
            reduce_only             : arg4,
            expiration_timestamp_ms : arg5,
        };
        0x2::event::emit<PostedOrder>(v0);
    }

    public(friend) fun emit_registered_collateral_info<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u256) {
        let v0 = RegisteredCollateralInfo<T0>{
            ch_id                    : arg0,
            collateral_pfs_id        : arg1,
            collateral_pfs_source_id : arg2,
            scaling_factor           : arg3,
        };
        0x2::event::emit<RegisteredCollateralInfo<T0>>(v0);
    }

    public(friend) fun emit_registered_market_info<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u256) {
        let v0 = RegisteredMarketInfo<T0>{
            ch_id                    : arg0,
            base_pfs_id              : arg1,
            base_pfs_source_id       : arg2,
            collateral_pfs_id        : arg3,
            collateral_pfs_source_id : arg4,
            scaling_factor           : arg5,
        };
        0x2::event::emit<RegisteredMarketInfo<T0>>(v0);
    }

    public(friend) fun emit_rejected_position_fees_proposal(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: u256) {
        let v0 = RejectedPositionFeesProposal{
            ch_id      : arg0,
            account_id : arg1,
            maker_fee  : arg2,
            taker_fee  : arg3,
        };
        0x2::event::emit<RejectedPositionFeesProposal>(v0);
    }

    public(friend) fun emit_removed_integrator_config<T0>(arg0: u64, arg1: address) {
        let v0 = RemovedIntegratorConfig<T0>{
            account_id         : arg0,
            integrator_address : arg1,
        };
        0x2::event::emit<RemovedIntegratorConfig<T0>>(v0);
    }

    public(friend) fun emit_removed_registered_market_info<T0>(arg0: 0x2::object::ID) {
        let v0 = RemovedRegisteredMarketInfo<T0>{ch_id: arg0};
        0x2::event::emit<RemovedRegisteredMarketInfo<T0>>(v0);
    }

    public(friend) fun emit_resetted_position_fees(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ResettedPositionFees{
            ch_id      : arg0,
            account_id : arg1,
        };
        0x2::event::emit<ResettedPositionFees>(v0);
    }

    public(friend) fun emit_resumed_market(arg0: 0x2::object::ID) {
        let v0 = ResumedMarket{ch_id: arg0};
        0x2::event::emit<ResumedMarket>(v0);
    }

    public(friend) fun emit_settled_funding(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: u256, arg4: u256, arg5: u256) {
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

    public(friend) fun emit_socialized_bad_debt(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: bool, arg4: u256, arg5: u256) {
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

    public(friend) fun emit_updated_base_oracle_source_id(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = UpdatedBasePfsSourceID{
            ch_id     : arg0,
            source_id : arg1,
        };
        0x2::event::emit<UpdatedBasePfsSourceID>(v0);
    }

    public(friend) fun emit_updated_base_pfs_id(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = UpdatedBasePfsID{
            ch_id  : arg0,
            pfs_id : arg1,
        };
        0x2::event::emit<UpdatedBasePfsID>(v0);
    }

    public(friend) fun emit_updated_base_pfs_tolerance(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpdatedBasePfsTolerance{
            ch_id         : arg0,
            pfs_tolerance : arg1,
        };
        0x2::event::emit<UpdatedBasePfsTolerance>(v0);
    }

    public(friend) fun emit_updated_clearing_house_version(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpdatedClearingHouseVersion{
            ch_id   : arg0,
            version : arg1,
        };
        0x2::event::emit<UpdatedClearingHouseVersion>(v0);
    }

    public(friend) fun emit_updated_collateral_haircut(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = UpdatedCollateralHaircut{
            ch_id              : arg0,
            collateral_haircut : arg1,
        };
        0x2::event::emit<UpdatedCollateralHaircut>(v0);
    }

    public(friend) fun emit_updated_collateral_oracle_source_id(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = UpdatedCollateralPfsSourceID{
            ch_id     : arg0,
            source_id : arg1,
        };
        0x2::event::emit<UpdatedCollateralPfsSourceID>(v0);
    }

    public(friend) fun emit_updated_collateral_pfs_id(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = UpdatedCollateralPfsID{
            ch_id  : arg0,
            pfs_id : arg1,
        };
        0x2::event::emit<UpdatedCollateralPfsID>(v0);
    }

    public(friend) fun emit_updated_collateral_pfs_tolerance(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpdatedCollateralPfsTolerance{
            ch_id         : arg0,
            pfs_tolerance : arg1,
        };
        0x2::event::emit<UpdatedCollateralPfsTolerance>(v0);
    }

    public(friend) fun emit_updated_fees(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) {
        let v0 = UpdatedFees{
            ch_id              : arg0,
            maker_fee          : arg1,
            taker_fee          : arg2,
            liquidation_fee    : arg3,
            force_cancel_fee   : arg4,
            insurance_fund_fee : arg5,
        };
        0x2::event::emit<UpdatedFees>(v0);
    }

    public(friend) fun emit_updated_funding(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u64) {
        let v0 = UpdatedFunding{
            ch_id                  : arg0,
            cum_funding_rate_long  : arg1,
            cum_funding_rate_short : arg2,
            funding_last_upd_ms    : arg3,
        };
        0x2::event::emit<UpdatedFunding>(v0);
    }

    public(friend) fun emit_updated_funding_parameters(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = UpdatedFundingParameters{
            ch_id                     : arg0,
            funding_frequency_ms      : arg1,
            funding_period_ms         : arg2,
            premium_twap_frequency_ms : arg3,
            premium_twap_period_ms    : arg4,
        };
        0x2::event::emit<UpdatedFundingParameters>(v0);
    }

    public(friend) fun emit_updated_gas_price_twap(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u256, arg4: u64) {
        let v0 = UpdatedGasPriceTwap{
            ch_id                 : arg0,
            gas_price             : arg1,
            mean                  : arg2,
            variance              : arg3,
            gas_price_last_upd_ms : arg4,
        };
        0x2::event::emit<UpdatedGasPriceTwap>(v0);
    }

    public(friend) fun emit_updated_gas_price_twap_parameters(arg0: 0x2::object::ID, arg1: u64, arg2: u256, arg3: u256) {
        let v0 = UpdatedGasPriceTwapParameters{
            ch_id                    : arg0,
            gas_price_twap_period_ms : arg1,
            gas_price_taker_fee      : arg2,
            z_score_threshold        : arg3,
        };
        0x2::event::emit<UpdatedGasPriceTwapParameters>(v0);
    }

    public(friend) fun emit_updated_margin_ratios(arg0: 0x2::object::ID, arg1: u256, arg2: u256) {
        let v0 = UpdatedMarginRatios{
            ch_id                    : arg0,
            margin_ratio_initial     : arg1,
            margin_ratio_maintenance : arg2,
        };
        0x2::event::emit<UpdatedMarginRatios>(v0);
    }

    public(friend) fun emit_updated_market_lot_and_tick(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = UpdatedMarketLotAndTick{
            ch_id     : arg0,
            lot_size  : arg1,
            tick_size : arg2,
        };
        0x2::event::emit<UpdatedMarketLotAndTick>(v0);
    }

    public(friend) fun emit_updated_max_bad_debt(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = UpdatedMaxBadDebt{
            ch_id        : arg0,
            max_bad_debt : arg1,
        };
        0x2::event::emit<UpdatedMaxBadDebt>(v0);
    }

    public(friend) fun emit_updated_max_open_interest(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = UpdatedMaxOpenInterest{
            ch_id             : arg0,
            max_open_interest : arg1,
        };
        0x2::event::emit<UpdatedMaxOpenInterest>(v0);
    }

    public(friend) fun emit_updated_max_open_interest_position_params(arg0: 0x2::object::ID, arg1: u256, arg2: u256) {
        let v0 = UpdatedMaxOpenInterestPositionParams{
            ch_id                              : arg0,
            max_open_interest_threshold        : arg1,
            max_open_interest_position_percent : arg2,
        };
        0x2::event::emit<UpdatedMaxOpenInterestPositionParams>(v0);
    }

    public(friend) fun emit_updated_max_pending_orders(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpdatedMaxPendingOrders{
            ch_id              : arg0,
            max_pending_orders : arg1,
        };
        0x2::event::emit<UpdatedMaxPendingOrders>(v0);
    }

    public(friend) fun emit_updated_max_socialize_losses_mr_decrease(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = UpdatedMaxSocializeLossesMrDecrease{
            ch_id                            : arg0,
            max_socialize_losses_mr_decrease : arg1,
        };
        0x2::event::emit<UpdatedMaxSocializeLossesMrDecrease>(v0);
    }

    public(friend) fun emit_updated_min_order_usd_value(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = UpdatedMinOrderUsdValue{
            ch_id               : arg0,
            min_order_usd_value : arg1,
        };
        0x2::event::emit<UpdatedMinOrderUsdValue>(v0);
    }

    public(friend) fun emit_updated_open_interest_and_fees_accrued(arg0: 0x2::object::ID, arg1: u256, arg2: u256) {
        let v0 = UpdatedOpenInterestAndFeesAccrued{
            ch_id         : arg0,
            open_interest : arg1,
            fees_accrued  : arg2,
        };
        0x2::event::emit<UpdatedOpenInterestAndFeesAccrued>(v0);
    }

    public(friend) fun emit_updated_premium_twap(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u256, arg4: u64) {
        let v0 = UpdatedPremiumTwap{
            ch_id                    : arg0,
            book_price               : arg1,
            index_price              : arg2,
            premium_twap             : arg3,
            premium_twap_last_upd_ms : arg4,
        };
        0x2::event::emit<UpdatedPremiumTwap>(v0);
    }

    public(friend) fun emit_updated_spread_twap(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u256, arg4: u64) {
        let v0 = UpdatedSpreadTwap{
            ch_id                   : arg0,
            book_price              : arg1,
            index_price             : arg2,
            spread_twap             : arg3,
            spread_twap_last_upd_ms : arg4,
        };
        0x2::event::emit<UpdatedSpreadTwap>(v0);
    }

    public(friend) fun emit_updated_spread_twap_parameters(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = UpdatedSpreadTwapParameters{
            ch_id                    : arg0,
            spread_twap_frequency_ms : arg1,
            spread_twap_period_ms    : arg2,
        };
        0x2::event::emit<UpdatedSpreadTwapParameters>(v0);
    }

    public(friend) fun emit_updated_stop_order_mist_cost(arg0: u64) {
        let v0 = UpdatedStopOrderMistCost{stop_order_mist_cost: arg0};
        0x2::event::emit<UpdatedStopOrderMistCost>(v0);
    }

    public(friend) fun emit_withdrew_collateral<T0>(arg0: u64, arg1: u64) {
        let v0 = WithdrewCollateral<T0>{
            account_id : arg0,
            collateral : arg1,
        };
        0x2::event::emit<WithdrewCollateral<T0>>(v0);
    }

    public(friend) fun emit_withdrew_fees(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = WithdrewFees{
            sender              : arg0,
            ch_id               : arg1,
            amount              : arg2,
            vault_balance_after : arg3,
        };
        0x2::event::emit<WithdrewFees>(v0);
    }

    public(friend) fun emit_withdrew_from_integrator_vault(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = WithdrewFromIntegratorVault{
            ch_id              : arg0,
            integrator_address : arg1,
            fees               : arg2,
        };
        0x2::event::emit<WithdrewFromIntegratorVault>(v0);
    }

    public(friend) fun emit_withdrew_insurance_fund(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = WithdrewInsuranceFund{
            sender                       : arg0,
            ch_id                        : arg1,
            amount                       : arg2,
            insurance_fund_balance_after : arg3,
        };
        0x2::event::emit<WithdrewInsuranceFund>(v0);
    }

    public(friend) fun get_maker_event_fees(arg0: &FilledMakerOrder) : u256 {
        arg0.fees
    }

    public(friend) fun set_position_initial_margin_ratio(arg0: 0x2::object::ID, arg1: u64, arg2: u256) {
        let v0 = SetPositionInitialMarginRatio{
            ch_id                : arg0,
            account_id           : arg1,
            initial_margin_ratio : arg2,
        };
        0x2::event::emit<SetPositionInitialMarginRatio>(v0);
    }

    // decompiled from Move bytecode v6
}

