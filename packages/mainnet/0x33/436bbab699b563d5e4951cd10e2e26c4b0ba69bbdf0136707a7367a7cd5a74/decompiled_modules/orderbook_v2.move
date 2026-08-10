module 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2 {
    struct OrderBookV2ParamsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OrderBookV2Params has copy, drop, store {
        max_total_slippage_bps: u16,
        max_layers_per_quote: u8,
    }

    struct SignerPolicyKey has copy, drop, store {
        mm_id: 0x2::object::ID,
    }

    struct SignerPolicy has store {
        threshold: u8,
        version: u64,
        signers: 0x2::vec_set::VecSet<address>,
        max_time_points: u8,
        max_fill_points: u8,
    }

    struct TrustedAggregatorSignerConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TrustedAggregatorSignerConfig has store {
        version: u64,
        signers: 0x2::vec_map::VecMap<address, AggregatorSignerInfo>,
    }

    struct AggregatorSignerInfo has copy, drop, store {
        provider_name: 0x1::string::String,
        enabled: bool,
    }

    struct QuoteEntryV2 has store {
        quote_hash: vector<u8>,
        layers: vector<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>,
        slippage: 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::SlippageCurveV2,
        signed_at_ms: u64,
        sig_expiry_ms: u64,
        fill_or_kill: bool,
        min_fill: u64,
        signer_policy_version: u64,
        inventory_version: u64,
        cumulative_filled_in: u64,
        total_depth: u64,
        cancelled: bool,
    }

    struct ReferenceRatioGuard has copy, drop, store {
        reference_base_amount: u64,
        reference_quote_amount: u64,
        max_loss_bps: u16,
    }

    struct RebalancePolicy has drop, store {
        enabled: bool,
        reference_ratio_guard: 0x1::option::Option<ReferenceRatioGuard>,
        max_borrow_balance_bps: u16,
        epoch_rebalance_coefficient_bps: u32,
        quote_provider_slippage_bps: 0x2::vec_map::VecMap<0x1::string::String, u16>,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        mm_id: 0x2::object::ID,
        pair_id: 0x1::string::String,
        paused: bool,
        base_balance: 0x2::balance::Balance<T0>,
        quote_balance: 0x2::balance::Balance<T1>,
        protocol_fee_base: 0x2::balance::Balance<T0>,
        protocol_fee_quote: 0x2::balance::Balance<T1>,
        fee_override: 0x1::option::Option<u16>,
        bid_quote: 0x1::option::Option<QuoteEntryV2>,
        ask_quote: 0x1::option::Option<QuoteEntryV2>,
        inventory_version: u64,
        rebalance_policy: RebalancePolicy,
        rebalance_pending: bool,
        rebalance_usage_epoch: u64,
        rebalance_borrowed_base_in_epoch: u64,
        rebalance_borrowed_quote_in_epoch: u64,
        created_at_ms: u64,
    }

    struct RebalanceReceipt {
        pool_id: 0x2::object::ID,
        a2b: bool,
        borrowed_amount: u64,
        min_repay_amount: u64,
        epoch_cap: u64,
        inventory_version_before: u64,
    }

    struct QuoteFill has copy, drop, store {
        fill_quote_hash: vector<u8>,
        amount_in: u64,
    }

    struct LayerFill has copy, drop, store {
        layer_index: u8,
        layer_price: u128,
        effective_price: u128,
        elapsed_ms: u64,
        time_slippage_bps: u64,
        fill_slippage_bps: u64,
        raw_slippage_bps: u128,
        applied_slippage_bps: u64,
        amount_in: u64,
        amount_out: u64,
    }

    struct ConsumeContext has drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        now_ms: u64,
        max_total_slippage_bps: u16,
        fee_bps: u16,
        signer_policy_version: u64,
        inventory_version: u64,
    }

    struct WalkResult has drop {
        consumed_in: u64,
        total_out: u64,
        layer_fills: vector<LayerFill>,
    }

    struct OrderBookV2ParamSetEvent has copy, drop {
        key: u8,
        value: u64,
    }

    struct SignerPolicyUpdatedEvent has copy, drop {
        mm_id: 0x2::object::ID,
        version: u64,
        threshold: u8,
    }

    struct SlippageSegmentLimitsUpdatedEvent has copy, drop {
        mm_id: 0x2::object::ID,
        version: u64,
        max_time_points: u8,
        max_fill_points: u8,
    }

    struct TrustedAggregatorSignerUpdatedEvent has copy, drop {
        signer: address,
        provider_name: 0x1::string::String,
        enabled: bool,
        version: u64,
    }

    struct PoolRegisteredEvent has copy, drop {
        pool_id: 0x2::object::ID,
        mm_id: 0x2::object::ID,
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        pool_type: u8,
    }

    struct PoolDeregisteredEvent has copy, drop {
        pool_id: 0x2::object::ID,
        mm_id: 0x2::object::ID,
    }

    struct PoolPausedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
    }

    struct PoolDepositEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct PoolWithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct PoolFeeOverrideSetEvent has copy, drop {
        pool_id: 0x2::object::ID,
        fee_bps: 0x1::option::Option<u16>,
    }

    struct ProtocolFeeCollectedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        collector: address,
        base: u64,
        quote: u64,
    }

    struct QuoteFirstSeenEvent has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        quote_hash: vector<u8>,
        layers_count: u8,
        signer: address,
    }

    struct QuoteAmendedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        old_hash: vector<u8>,
        new_hash: vector<u8>,
        signer: address,
    }

    struct QuoteCancelledEvent has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        quote_hash: 0x1::option::Option<vector<u8>>,
    }

    struct QuoteSweptEvent has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        quote_hash: vector<u8>,
        sig_expiry_ms: u64,
        cancelled: bool,
        version_invalid: bool,
    }

    struct ConsumeExecutedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        total_amount_in: u64,
        total_amount_out: u64,
        total_fee: u64,
        layer_fills: vector<LayerFill>,
        fill_quote_hash: vector<u8>,
        entry_quote_hash: vector<u8>,
        entry_fully_consumed: bool,
        entry_cancelled: bool,
    }

    struct RebalancePolicyUpdatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        enabled: bool,
        epoch_rebalance_coefficient_bps: u32,
    }

    struct RebalanceExecutedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        epoch: u64,
        a2b: bool,
        borrowed_amount: u64,
        repaid_amount: u64,
        epoch_cap: u64,
        used_in_epoch_after: u64,
    }

    public fun add_quote_signer(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MMAdminCap, arg4: address) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        assert_admin_cap_matches(arg3, arg2);
        let v0 = 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg2);
        let v1 = signer_policy_mut(arg1, v0);
        0x2::vec_set::insert<address>(&mut v1.signers, arg4);
        v1.version = v1.version + 1;
        let v2 = SignerPolicyUpdatedEvent{
            mm_id     : v0,
            version   : v1.version,
            threshold : v1.threshold,
        };
        0x2::event::emit<SignerPolicyUpdatedEvent>(v2);
    }

    fun address_lt(arg0: address, arg1: address) : bool {
        let v0 = 0x2::address::to_bytes(arg0);
        let v1 = 0x2::address::to_bytes(arg1);
        bytes_lt(&v0, &v1)
    }

    fun assert_admin_cap_matches(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MMAdminCap, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker) {
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::market_maker_id(arg0) == 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg1), 25);
    }

    fun assert_borrow_caps<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) {
        assert!((arg1 as u256) <= (arg2 as u256) * (arg0.rebalance_policy.max_borrow_balance_bps as u256) / (10000 as u256), 59);
    }

    fun assert_deposit_allowed<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &Pool<T0, T1>, arg4: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::assert_not_paused(arg1);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_not_paused(arg2);
        assert!(!arg3.paused, 33);
        assert!(!arg3.rebalance_pending, 55);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg2);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_role(arg2, 0x2::tx_context::sender(arg4), 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::mm_role_treasury());
    }

    fun assert_pool_belongs_to_mm<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker) {
        assert!(arg0.mm_id == 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg1), 2);
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::contains_pool(arg1, 0x2::object::id<Pool<T0, T1>>(arg0)), 40);
    }

    fun assert_pool_not_paused<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(!arg0.paused, 1);
    }

    fun assert_rebalance_quote_matches_a2b<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::RebalanceQuote, arg1: u64, arg2: bool) {
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::rebalance_quote_amount_in(arg0) == arg1, 62);
        if (arg2) {
            assert!(*0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::rebalance_quote_coin_in(arg0) == coin_type_string<T0>(), 62);
            assert!(*0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::rebalance_quote_coin_out(arg0) == coin_type_string<T1>(), 62);
        } else {
            assert!(*0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::rebalance_quote_coin_in(arg0) == coin_type_string<T1>(), 62);
            assert!(*0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::rebalance_quote_coin_out(arg0) == coin_type_string<T0>(), 62);
        };
    }

    fun assert_withdraw_allowed<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &Pool<T0, T1>, arg4: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::assert_not_paused(arg1);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_not_paused(arg2);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg2);
        assert!(!arg3.rebalance_pending, 55);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_role(arg2, 0x2::tx_context::sender(arg4), 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::mm_role_treasury());
    }

    public fun begin_rebalance_base_to_quote<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, RebalanceReceipt) {
        prepare_begin_rebalance<T0, T1>(arg0, arg1, arg2, arg3, arg4, true, arg8);
        let v0 = compute_rebalance_min_repay<T0, T1>(arg1, arg3, arg4, true, &arg5, &arg6, arg7);
        begin_rebalance_base_to_quote_validated<T0, T1>(arg3, arg4, v0, arg8)
    }

    fun begin_rebalance_base_to_quote_validated<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, RebalanceReceipt) {
        let v0 = update_epoch_usage<T0, T1>(arg0, arg1, true, arg3);
        arg0.rebalance_pending = true;
        let v1 = RebalanceReceipt{
            pool_id                  : 0x2::object::id<Pool<T0, T1>>(arg0),
            a2b                      : true,
            borrowed_amount          : arg1,
            min_repay_amount         : arg2,
            epoch_cap                : v0,
            inventory_version_before : arg0.inventory_version,
        };
        (0x2::balance::split<T0>(&mut arg0.base_balance, arg1), v1)
    }

    public fun begin_rebalance_quote_to_base<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, RebalanceReceipt) {
        prepare_begin_rebalance<T0, T1>(arg0, arg1, arg2, arg3, arg4, false, arg8);
        let v0 = compute_rebalance_min_repay<T0, T1>(arg1, arg3, arg4, false, &arg5, &arg6, arg7);
        begin_rebalance_quote_to_base_validated<T0, T1>(arg3, arg4, v0, arg8)
    }

    fun begin_rebalance_quote_to_base_validated<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, RebalanceReceipt) {
        let v0 = update_epoch_usage<T0, T1>(arg0, arg1, false, arg3);
        arg0.rebalance_pending = true;
        let v1 = RebalanceReceipt{
            pool_id                  : 0x2::object::id<Pool<T0, T1>>(arg0),
            a2b                      : false,
            borrowed_amount          : arg1,
            min_repay_amount         : arg2,
            epoch_cap                : v0,
            inventory_version_before : arg0.inventory_version,
        };
        (0x2::balance::split<T1>(&mut arg0.quote_balance, arg1), v1)
    }

    fun build_new_entry_from_envelope(arg0: vector<u8>, arg1: 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::SignedQuoteV2) : QuoteEntryV2 {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::unpack_envelope_v2(arg1);
        let v8 = reset_layers_filled(v0);
        let v9 = compute_total_depth(&v8);
        assert!(v9 > 0, 34);
        QuoteEntryV2{
            quote_hash            : arg0,
            layers                : v8,
            slippage              : v1,
            signed_at_ms          : v2,
            sig_expiry_ms         : v3,
            fill_or_kill          : v4,
            min_fill              : v5,
            signer_policy_version : v6,
            inventory_version     : v7,
            cumulative_filled_in  : 0,
            total_depth           : v9,
            cancelled             : false,
        }
    }

    fun build_signer_set(arg0: vector<address>) : 0x2::vec_set::VecSet<address> {
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            0x2::vec_set::insert<address>(&mut v0, *0x1::vector::borrow<address>(&arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun bump_inventory_and_clear_quotes<T0, T1>(arg0: &mut Pool<T0, T1>) {
        arg0.inventory_version = arg0.inventory_version + 1;
        let v0 = &mut arg0.bid_quote;
        clear_quote(v0);
        let v1 = &mut arg0.ask_quote;
        clear_quote(v1);
    }

    fun bytes_lt(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            let v2 = *0x1::vector::borrow<u8>(arg1, v0);
            if (v1 != v2) {
                return v1 < v2
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun cancel_quote_v2<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MMAdminCap, arg3: &mut Pool<T0, T1>, arg4: bool) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg1);
        assert_admin_cap_matches(arg2, arg1);
        assert!(!arg3.rebalance_pending, 55);
        let v0 = if (arg4) {
            &mut arg3.bid_quote
        } else {
            &mut arg3.ask_quote
        };
        let v1 = if (0x1::option::is_some<QuoteEntryV2>(v0)) {
            let v2 = 0x1::option::borrow_mut<QuoteEntryV2>(v0);
            v2.cancelled = true;
            0x1::option::some<vector<u8>>(v2.quote_hash)
        } else {
            0x1::option::none<vector<u8>>()
        };
        let v3 = QuoteCancelledEvent{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg3),
            a2b        : arg4,
            quote_hash : v1,
        };
        0x2::event::emit<QuoteCancelledEvent>(v3);
    }

    fun ceil_div_u256(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 > 0, 61);
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    fun clear_quote(arg0: &mut 0x1::option::Option<QuoteEntryV2>) {
        if (0x1::option::is_some<QuoteEntryV2>(arg0)) {
            destroy_quote(0x1::option::extract<QuoteEntryV2>(arg0));
        };
    }

    fun coin_type_string<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::assert_not_paused(arg1);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::assert_fee_collector(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::balance::value<T0>(&arg2.protocol_fee_base);
        let v1 = 0x2::balance::value<T1>(&arg2.protocol_fee_quote);
        let v2 = ProtocolFeeCollectedEvent{
            pool_id   : 0x2::object::id<Pool<T0, T1>>(arg2),
            collector : 0x2::tx_context::sender(arg3),
            base      : v0,
            quote     : v1,
        };
        0x2::event::emit<ProtocolFeeCollectedEvent>(v2);
        (0x2::balance::split<T0>(&mut arg2.protocol_fee_base, v0), 0x2::balance::split<T1>(&mut arg2.protocol_fee_quote, v1))
    }

    fun compute_effective_price(arg0: u128, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::SlippageCurveV2, arg2: u64, arg3: u64, arg4: u16, arg5: bool) : u128 {
        let (_, v1) = compute_slippage_bps(arg1, arg2, arg3, arg4);
        let v2 = if (arg5) {
            (10000 as u128) - (v1 as u128)
        } else {
            (10000 as u128) + (v1 as u128)
        };
        arg0 * v2 / (10000 as u128)
    }

    fun compute_epoch_cap(arg0: u64, arg1: u32) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (10000 as u256);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    fun compute_ratio_min_repay(arg0: u64, arg1: bool, arg2: &ReferenceRatioGuard) : u64 {
        let (v0, v1) = if (arg1) {
            (arg2.reference_base_amount, arg2.reference_quote_amount)
        } else {
            (arg2.reference_quote_amount, arg2.reference_base_amount)
        };
        let v2 = ceil_div_u256((arg0 as u256) * (v1 as u256) * ((10000 - (arg2.max_loss_bps as u64)) as u256), (v0 as u256) * (10000 as u256));
        assert!(v2 <= 18446744073709551615, 22);
        (v2 as u64)
    }

    fun compute_rebalance_min_repay<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg1: &Pool<T0, T1>, arg2: u64, arg3: bool, arg4: &vector<u8>, arg5: &vector<u8>, arg6: &0x2::clock::Clock) : u64 {
        let v0 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::decode_rebalance_quote(*arg4);
        compute_rebalance_min_repay_for_signer<T0, T1>(arg0, arg1, arg2, arg3, &v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::verify_rebalance_quote_signature(arg4, arg5), 0x2::clock::timestamp_ms(arg6))
    }

    fun compute_rebalance_min_repay_for_signer<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg1: &Pool<T0, T1>, arg2: u64, arg3: bool, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::RebalanceQuote, arg5: address, arg6: u64) : u64 {
        assert_rebalance_quote_matches_a2b<T0, T1>(arg4, arg2, arg3);
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::rebalance_quote_issued_at_ms(arg4) <= arg6, 62);
        assert!(arg6 < 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::rebalance_quote_expiry_ms(arg4), 14);
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::rebalance_quote_expiry_ms(arg4) - 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::rebalance_quote_issued_at_ms(arg4) <= 30000, 67);
        let v0 = floor_mul_bps(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::rebalance_quote_amount_out(arg4), (10000 as u16) - resolve_provider_slippage<T0, T1>(arg0, arg1, arg5, arg4));
        if (0x1::option::is_some<ReferenceRatioGuard>(&arg1.rebalance_policy.reference_ratio_guard)) {
            let v2 = compute_ratio_min_repay(arg2, arg3, 0x1::option::borrow<ReferenceRatioGuard>(&arg1.rebalance_policy.reference_ratio_guard));
            if (v2 > v0) {
                v2
            } else {
                v0
            }
        } else {
            v0
        }
    }

    fun compute_slippage_bps(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::SlippageCurveV2, arg1: u64, arg2: u64, arg3: u16) : (u128, u64) {
        let v0 = (arg1 as u128) + (arg2 as u128);
        let v1 = (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::slippage_v2_max_total_slippage_bps(arg0) as u128);
        let v2 = (arg3 as u128);
        let v3 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        let v4 = v3;
        if (v3 > v2) {
            v4 = v2;
        };
        (v0, (v4 as u64))
    }

    fun compute_time_bps(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::SlippageCurveV2, arg1: u64) : u64 {
        let v0 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::slippage_v2_time_points(arg0);
        let v1 = 0x1::vector::length<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::TimeSlippagePoint>(v0);
        if (v1 == 0 || arg1 == 0) {
            return 0
        };
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        while (v6 < v1) {
            let v7 = 0x1::vector::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::TimeSlippagePoint>(v0, v6);
            let v8 = (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::time_point_offset_ms(v7) as u64);
            if (arg1 <= v8) {
                return interpolate_time_bps(v2, v4, v8, (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::time_point_slippage_bps(v7) as u64), arg1)
            };
            v3 = v8;
            v5 = (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::time_point_slippage_bps(v7) as u64);
            v6 = v6 + 1;
        };
        let v9 = (v5 as u256) + ((arg1 - v3) as u256) * ((v5 - 0) as u256) / ((v3 - 0) as u256);
        assert!(v9 <= 18446744073709551615, 20);
        (v9 as u64)
    }

    fun compute_total_depth(arg0: &vector<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>(arg0)) {
            v0 = v0 + 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_depth(0x1::vector::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun default_rebalance_policy() : RebalancePolicy {
        RebalancePolicy{
            enabled                         : false,
            reference_ratio_guard           : 0x1::option::none<ReferenceRatioGuard>(),
            max_borrow_balance_bps          : 0,
            epoch_rebalance_coefficient_bps : 0,
            quote_provider_slippage_bps     : 0x2::vec_map::empty<0x1::string::String, u16>(),
        }
    }

    public fun deposit_base<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::tx_context::TxContext) {
        assert_deposit_allowed<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        0x2::balance::join<T0>(&mut arg3.base_balance, arg4);
        let v0 = PoolDepositEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg3),
            coin    : 0x1::type_name::get<T0>(),
            amount  : 0x2::balance::value<T0>(&arg4),
        };
        0x2::event::emit<PoolDepositEvent>(v0);
    }

    public fun deposit_quote<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::tx_context::TxContext) {
        assert_deposit_allowed<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        0x2::balance::join<T1>(&mut arg3.quote_balance, arg4);
        let v0 = PoolDepositEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg3),
            coin    : 0x1::type_name::get<T1>(),
            amount  : 0x2::balance::value<T1>(&arg4),
        };
        0x2::event::emit<PoolDepositEvent>(v0);
    }

    public fun deregister_pool<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::registry::Registry, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &mut Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        assert_pool_belongs_to_mm<T0, T1>(arg4, arg3);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_role(arg3, 0x2::tx_context::sender(arg6), 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::mm_role_pool_operator());
        assert!(!arg4.rebalance_pending, 55);
        assert!(0x2::balance::value<T0>(&arg4.base_balance) == 0, 3);
        assert!(0x2::balance::value<T1>(&arg4.quote_balance) == 0, 4);
        assert!(0x2::balance::value<T0>(&arg4.protocol_fee_base) == 0, 39);
        assert!(0x2::balance::value<T1>(&arg4.protocol_fee_quote) == 0, 39);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = if (0x1::option::is_some<QuoteEntryV2>(&arg4.bid_quote) || 0x1::option::is_some<QuoteEntryV2>(&arg4.ask_quote)) {
            signer_policy(arg1, 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg3)).version
        } else {
            0
        };
        let v2 = 0x2::object::id<Pool<T0, T1>>(arg4);
        let v3 = &mut arg4.bid_quote;
        sweep_dead_quote(v3, v2, true, v0, v1, arg4.inventory_version, true);
        let v4 = &mut arg4.ask_quote;
        sweep_dead_quote(v4, v2, false, v0, v1, arg4.inventory_version, true);
        assert!(0x1::option::is_none<QuoteEntryV2>(&arg4.bid_quote), 5);
        assert!(0x1::option::is_none<QuoteEntryV2>(&arg4.ask_quote), 6);
        arg4.paused = true;
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::remove_pool_id(arg3, v2);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::registry::remove_pool(arg2, v2);
        let v5 = PoolDeregisteredEvent{
            pool_id : v2,
            mm_id   : 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg3),
        };
        0x2::event::emit<PoolDeregisteredEvent>(v5);
    }

    fun destroy_quote(arg0: QuoteEntryV2) {
        let QuoteEntryV2 {
            quote_hash            : _,
            layers                : _,
            slippage              : _,
            signed_at_ms          : _,
            sig_expiry_ms         : _,
            fill_or_kill          : _,
            min_fill              : _,
            signer_policy_version : _,
            inventory_version     : _,
            cumulative_filled_in  : _,
            total_depth           : _,
            cancelled             : _,
        } = arg0;
    }

    public fun finish_rebalance_base_to_quote<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg2: &mut Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: RebalanceReceipt) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        assert_pool_belongs_to_mm<T0, T1>(arg2, arg1);
        let RebalanceReceipt {
            pool_id                  : v0,
            a2b                      : v1,
            borrowed_amount          : v2,
            min_repay_amount         : v3,
            epoch_cap                : v4,
            inventory_version_before : v5,
        } = arg4;
        assert!(arg2.rebalance_pending, 56);
        assert!(v0 == 0x2::object::id<Pool<T0, T1>>(arg2), 57);
        assert!(v1, 57);
        assert!(v5 == arg2.inventory_version, 57);
        let v6 = 0x2::balance::value<T1>(&arg3);
        assert!(v6 >= v3, 58);
        0x2::balance::join<T1>(&mut arg2.quote_balance, arg3);
        finish_rebalance_common<T0, T1>(arg2, v1, v2, v6, v4);
    }

    fun finish_rebalance_common<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64) {
        arg0.rebalance_pending = false;
        bump_inventory_and_clear_quotes<T0, T1>(arg0);
        let v0 = if (arg1) {
            arg0.rebalance_borrowed_base_in_epoch
        } else {
            arg0.rebalance_borrowed_quote_in_epoch
        };
        let v1 = RebalanceExecutedEvent{
            pool_id             : 0x2::object::id<Pool<T0, T1>>(arg0),
            epoch               : arg0.rebalance_usage_epoch,
            a2b                 : arg1,
            borrowed_amount     : arg2,
            repaid_amount       : arg3,
            epoch_cap           : arg4,
            used_in_epoch_after : v0,
        };
        0x2::event::emit<RebalanceExecutedEvent>(v1);
    }

    public fun finish_rebalance_quote_to_base<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg2: &mut Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: RebalanceReceipt) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        assert_pool_belongs_to_mm<T0, T1>(arg2, arg1);
        let RebalanceReceipt {
            pool_id                  : v0,
            a2b                      : v1,
            borrowed_amount          : v2,
            min_repay_amount         : v3,
            epoch_cap                : v4,
            inventory_version_before : v5,
        } = arg4;
        assert!(arg2.rebalance_pending, 56);
        assert!(v0 == 0x2::object::id<Pool<T0, T1>>(arg2), 57);
        assert!(!v1, 57);
        assert!(v5 == arg2.inventory_version, 57);
        let v6 = 0x2::balance::value<T0>(&arg3);
        assert!(v6 >= v3, 58);
        0x2::balance::join<T0>(&mut arg2.base_balance, arg3);
        finish_rebalance_common<T0, T1>(arg2, v1, v2, v6, v4);
    }

    fun floor_mul_bps(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u256) * (arg1 as u256) / (10000 as u256)) as u64)
    }

    public fun init_params(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::admin_cap::SuperAdminCap, arg2: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        let v0 = OrderBookV2ParamsKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<OrderBookV2ParamsKey>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid(arg2), v0), 36);
        let v1 = OrderBookV2ParamsKey{dummy_field: false};
        let v2 = OrderBookV2Params{
            max_total_slippage_bps : 100,
            max_layers_per_quote   : 20,
        };
        0x2::dynamic_field::add<OrderBookV2ParamsKey, OrderBookV2Params>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid_mut(arg2), v1, v2);
    }

    public fun init_signer_policy(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MMAdminCap, arg4: u8, arg5: vector<address>, arg6: u8, arg7: u8) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        assert_admin_cap_matches(arg3, arg2);
        assert!(arg6 <= 10, 30);
        assert!(arg7 <= 10, 30);
        let v0 = 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg2);
        let v1 = SignerPolicyKey{mm_id: v0};
        assert!(!0x2::dynamic_field::exists_<SignerPolicyKey>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid(arg1), v1), 48);
        let v2 = build_signer_set(arg5);
        validate_threshold(arg4, 0x2::vec_set::size<address>(&v2));
        let v3 = SignerPolicy{
            threshold       : arg4,
            version         : 0,
            signers         : v2,
            max_time_points : arg6,
            max_fill_points : arg7,
        };
        0x2::dynamic_field::add<SignerPolicyKey, SignerPolicy>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid_mut(arg1), v1, v3);
        let v4 = SignerPolicyUpdatedEvent{
            mm_id     : v0,
            version   : 0,
            threshold : arg4,
        };
        0x2::event::emit<SignerPolicyUpdatedEvent>(v4);
        let v5 = SlippageSegmentLimitsUpdatedEvent{
            mm_id           : v0,
            version         : 0,
            max_time_points : arg6,
            max_fill_points : arg7,
        };
        0x2::event::emit<SlippageSegmentLimitsUpdatedEvent>(v5);
    }

    public fun init_trusted_aggregator_signers(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::assert_param_manager(arg1, 0x2::tx_context::sender(arg2));
        let v0 = TrustedAggregatorSignerConfigKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<TrustedAggregatorSignerConfigKey>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid(arg1), v0), 64);
        let v1 = TrustedAggregatorSignerConfigKey{dummy_field: false};
        let v2 = TrustedAggregatorSignerConfig{
            version : 0,
            signers : 0x2::vec_map::empty<address, AggregatorSignerInfo>(),
        };
        0x2::dynamic_field::add<TrustedAggregatorSignerConfigKey, TrustedAggregatorSignerConfig>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid_mut(arg1), v1, v2);
    }

    fun interpolate_time_bps(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (arg1 as u256) + ((arg4 - arg0) as u256) * ((arg3 - arg1) as u256) / ((arg2 - arg0) as u256);
        assert!(v0 <= 18446744073709551615, 20);
        (v0 as u64)
    }

    public fun layer_fill_amount_in(arg0: &LayerFill) : u64 {
        arg0.amount_in
    }

    public fun layer_fill_amount_out(arg0: &LayerFill) : u64 {
        arg0.amount_out
    }

    public fun layer_fill_applied_slippage_bps(arg0: &LayerFill) : u64 {
        arg0.applied_slippage_bps
    }

    public fun layer_fill_effective_price(arg0: &LayerFill) : u128 {
        arg0.effective_price
    }

    public fun layer_fill_elapsed_ms(arg0: &LayerFill) : u64 {
        arg0.elapsed_ms
    }

    public fun layer_fill_fill_slippage_bps(arg0: &LayerFill) : u64 {
        arg0.fill_slippage_bps
    }

    public fun layer_fill_index(arg0: &LayerFill) : u8 {
        arg0.layer_index
    }

    public fun layer_fill_price(arg0: &LayerFill) : u128 {
        arg0.layer_price
    }

    public fun layer_fill_raw_slippage_bps(arg0: &LayerFill) : u128 {
        arg0.raw_slippage_bps
    }

    public fun layer_fill_time_slippage_bps(arg0: &LayerFill) : u64 {
        arg0.time_slippage_bps
    }

    public fun new_quote_fill(arg0: vector<u8>, arg1: u64) : QuoteFill {
        QuoteFill{
            fill_quote_hash : arg0,
            amount_in       : arg1,
        }
    }

    public fun new_reference_ratio_guard(arg0: u64, arg1: u64, arg2: u16) : ReferenceRatioGuard {
        assert!(arg0 > 0, 61);
        assert!(arg1 > 0, 61);
        assert!(arg2 < (10000 as u16), 61);
        ReferenceRatioGuard{
            reference_base_amount  : arg0,
            reference_quote_amount : arg1,
            max_loss_bps           : arg2,
        }
    }

    public fun params(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig) : &OrderBookV2Params {
        let v0 = OrderBookV2ParamsKey{dummy_field: false};
        0x2::dynamic_field::borrow<OrderBookV2ParamsKey, OrderBookV2Params>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid(arg0), v0)
    }

    public fun pause_pool<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg2: &mut Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        assert_pool_belongs_to_mm<T0, T1>(arg2, arg1);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_role(arg1, 0x2::tx_context::sender(arg3), 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::mm_role_pool_pauser());
        arg2.paused = true;
        let v0 = PoolPausedEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg2),
            paused  : true,
        };
        0x2::event::emit<PoolPausedEvent>(v0);
    }

    public fun pool_ask<T0, T1>(arg0: &Pool<T0, T1>) : &0x1::option::Option<QuoteEntryV2> {
        &arg0.ask_quote
    }

    public fun pool_base_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.base_balance)
    }

    public fun pool_bid<T0, T1>(arg0: &Pool<T0, T1>) : &0x1::option::Option<QuoteEntryV2> {
        &arg0.bid_quote
    }

    public fun pool_created_at_ms<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.created_at_ms
    }

    public fun pool_fee_override<T0, T1>(arg0: &Pool<T0, T1>) : &0x1::option::Option<u16> {
        &arg0.fee_override
    }

    public fun pool_has_ask<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        0x1::option::is_some<QuoteEntryV2>(&arg0.ask_quote)
    }

    public fun pool_has_bid<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        0x1::option::is_some<QuoteEntryV2>(&arg0.bid_quote)
    }

    public fun pool_inventory_version<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.inventory_version
    }

    public fun pool_mm_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        arg0.mm_id
    }

    public fun pool_pair_id<T0, T1>(arg0: &Pool<T0, T1>) : &0x1::string::String {
        &arg0.pair_id
    }

    public fun pool_paused<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.paused
    }

    public fun pool_protocol_fee_base_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.protocol_fee_base)
    }

    public fun pool_protocol_fee_quote_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.protocol_fee_quote)
    }

    public fun pool_quote_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_balance)
    }

    public fun pool_rebalance_pending<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.rebalance_pending
    }

    public fun pool_rebalance_policy<T0, T1>(arg0: &Pool<T0, T1>) : &RebalancePolicy {
        &arg0.rebalance_policy
    }

    fun precheck_decode_noop<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &Pool<T0, T1>, arg4: &vector<u8>, arg5: &0x2::clock::Clock) : (bool, vector<u8>, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::SignedQuoteV2, bool, u64, u64) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::assert_not_paused(arg1);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_not_paused(arg2);
        assert_pool_not_paused<T0, T1>(arg3);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg2);
        assert!(!arg3.rebalance_pending, 55);
        let v0 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::compute_quote_hash(arg4);
        let v1 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::decode_signed_quote_v2(*arg4);
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::envelope_v2_mm_object_id(&v1) == 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg2), 26);
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::envelope_v2_pool_object_id(&v1) == 0x2::object::id<Pool<T0, T1>>(arg3), 27);
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::envelope_v2_signer_policy_version(&v1) == signer_policy(arg1, 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg2)).version, 52);
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::envelope_v2_inventory_version(&v1) == arg3.inventory_version, 53);
        let v2 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::envelope_v2_a2b(&v1);
        let v3 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::envelope_v2_signed_at_ms(&v1);
        let v4 = if (v2) {
            &arg3.bid_quote
        } else {
            &arg3.ask_quote
        };
        let v5 = if (0x1::option::is_some<QuoteEntryV2>(v4)) {
            let v6 = 0x1::option::borrow<QuoteEntryV2>(v4);
            v6.quote_hash == v0 && false || v3 <= v6.signed_at_ms && false || true
        } else {
            true
        };
        (v5, v0, v1, v2, v3, 0x2::clock::timestamp_ms(arg5))
    }

    fun prepare_begin_rebalance<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &Pool<T0, T1>, arg4: u64, arg5: bool, arg6: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::assert_not_paused(arg1);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_not_paused(arg2);
        assert_pool_not_paused<T0, T1>(arg3);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg2);
        assert!(!arg3.rebalance_pending, 55);
        assert!(arg3.rebalance_policy.enabled, 54);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_role(arg2, 0x2::tx_context::sender(arg6), 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::mm_role_rebalancer());
        let v0 = if (arg5) {
            0x2::balance::value<T0>(&arg3.base_balance)
        } else {
            0x2::balance::value<T1>(&arg3.quote_balance)
        };
        assert!(v0 >= arg4, 32);
        assert_borrow_caps<T0, T1>(arg3, arg4, v0);
    }

    fun prepare_consume_context<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: bool) : ConsumeContext {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::assert_not_paused(arg1);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_not_paused(arg2);
        assert_pool_not_paused<T0, T1>(arg3);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg2);
        assert!(!arg3.rebalance_pending, 55);
        ConsumeContext{
            pool_id                : 0x2::object::id<Pool<T0, T1>>(arg3),
            a2b                    : arg5,
            now_ms                 : 0x2::clock::timestamp_ms(arg4),
            max_total_slippage_bps : params(arg1).max_total_slippage_bps,
            fee_bps                : 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::fee::resolve_fee_bps(arg1, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::fee_override(arg2), &arg3.fee_override, &arg3.pair_id),
            signer_policy_version  : signer_policy(arg1, 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg2)).version,
            inventory_version      : arg3.inventory_version,
        }
    }

    public fun quote_cancelled(arg0: &QuoteEntryV2) : bool {
        arg0.cancelled
    }

    public fun quote_cumulative_filled_in(arg0: &QuoteEntryV2) : u64 {
        arg0.cumulative_filled_in
    }

    public fun quote_hash(arg0: &QuoteEntryV2) : &vector<u8> {
        &arg0.quote_hash
    }

    public fun quote_inventory_version(arg0: &QuoteEntryV2) : u64 {
        arg0.inventory_version
    }

    public fun quote_sig_expiry_ms(arg0: &QuoteEntryV2) : u64 {
        arg0.sig_expiry_ms
    }

    public fun quote_signed_at_ms(arg0: &QuoteEntryV2) : u64 {
        arg0.signed_at_ms
    }

    public fun quote_signer_policy_version(arg0: &QuoteEntryV2) : u64 {
        arg0.signer_policy_version
    }

    public fun quote_total_depth(arg0: &QuoteEntryV2) : u64 {
        arg0.total_depth
    }

    fun read_entry_fully_consumed<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool) : bool {
        let v0 = if (arg1) {
            &arg0.bid_quote
        } else {
            &arg0.ask_quote
        };
        let v1 = 0x1::option::borrow<QuoteEntryV2>(v0);
        v1.cumulative_filled_in >= v1.total_depth
    }

    public fun rebalance_policy_enabled(arg0: &RebalancePolicy) : bool {
        arg0.enabled
    }

    public fun rebalance_policy_epoch_rebalance_coefficient_bps(arg0: &RebalancePolicy) : u32 {
        arg0.epoch_rebalance_coefficient_bps
    }

    public fun rebalance_policy_max_borrow_balance_bps(arg0: &RebalancePolicy) : u16 {
        arg0.max_borrow_balance_bps
    }

    public fun rebalance_policy_quote_provider_slippage_bps(arg0: &RebalancePolicy) : &0x2::vec_map::VecMap<0x1::string::String, u16> {
        &arg0.quote_provider_slippage_bps
    }

    public fun rebalance_policy_reference_ratio_guard(arg0: &RebalancePolicy) : &0x1::option::Option<ReferenceRatioGuard> {
        &arg0.reference_ratio_guard
    }

    public fun reference_ratio_guard_base_amount(arg0: &ReferenceRatioGuard) : u64 {
        arg0.reference_base_amount
    }

    public fun reference_ratio_guard_max_loss_bps(arg0: &ReferenceRatioGuard) : u16 {
        arg0.max_loss_bps
    }

    public fun reference_ratio_guard_quote_amount(arg0: &ReferenceRatioGuard) : u64 {
        arg0.reference_quote_amount
    }

    public fun register_pool<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::registry::Registry, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::assert_not_paused(arg1);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_not_paused(arg3);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_role(arg3, 0x2::tx_context::sender(arg5), 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::mm_role_pool_operator());
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg3);
        let v3 = Pool<T0, T1>{
            id                                : v0,
            mm_id                             : v2,
            pair_id                           : 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::fee::compute_pair_id<T0, T1>(),
            paused                            : false,
            base_balance                      : 0x2::balance::zero<T0>(),
            quote_balance                     : 0x2::balance::zero<T1>(),
            protocol_fee_base                 : 0x2::balance::zero<T0>(),
            protocol_fee_quote                : 0x2::balance::zero<T1>(),
            fee_override                      : 0x1::option::none<u16>(),
            bid_quote                         : 0x1::option::none<QuoteEntryV2>(),
            ask_quote                         : 0x1::option::none<QuoteEntryV2>(),
            inventory_version                 : 0,
            rebalance_policy                  : default_rebalance_policy(),
            rebalance_pending                 : false,
            rebalance_usage_epoch             : 0x2::tx_context::epoch(arg5),
            rebalance_borrowed_base_in_epoch  : 0,
            rebalance_borrowed_quote_in_epoch : 0,
            created_at_ms                     : 0x2::clock::timestamp_ms(arg4),
        };
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::add_pool_id(arg3, v1);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::registry::add_pool(arg2, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::registry::new_pool_info(v1, v2, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::registry::pool_type_orderbook_v2()));
        let v4 = PoolRegisteredEvent{
            pool_id   : v1,
            mm_id     : v2,
            base      : 0x1::type_name::get<T0>(),
            quote     : 0x1::type_name::get<T1>(),
            pool_type : 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::registry::pool_type_orderbook_v2(),
        };
        0x2::event::emit<PoolRegisteredEvent>(v4);
        0x2::transfer::share_object<Pool<T0, T1>>(v3);
    }

    public fun remove_quote_signer(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MMAdminCap, arg4: address) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        assert_admin_cap_matches(arg3, arg2);
        let v0 = 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg2);
        let v1 = signer_policy_mut(arg1, v0);
        assert!(0x2::vec_set::size<address>(&v1.signers) > (v1.threshold as u64), 49);
        0x2::vec_set::remove<address>(&mut v1.signers, &arg4);
        v1.version = v1.version + 1;
        let v2 = SignerPolicyUpdatedEvent{
            mm_id     : v0,
            version   : v1.version,
            threshold : v1.threshold,
        };
        0x2::event::emit<SignerPolicyUpdatedEvent>(v2);
    }

    fun reset_layers_filled(arg0: vector<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>) : vector<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2> {
        let v0 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>(&arg0)) {
            let v2 = 0x1::vector::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>(&arg0, v1);
            0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>(&mut v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::new_layer_v2(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_price(v2), 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_depth(v2), 0));
            v1 = v1 + 1;
        };
        v0
    }

    fun resolve_fill_band(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::SlippageCurveV2, arg1: u64, arg2: u64) : (u64, bool, u64) {
        let v0 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::slippage_v2_fill_points(arg0);
        let v1 = 0x1::vector::length<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::FillSlippagePoint>(v0);
        if (v1 == 0) {
            return (0, false, 0)
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x1::vector::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::FillSlippagePoint>(v0, v2);
            let v4 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::fill_point_amount_base(v3);
            if (arg2 < v4) {
                let v5 = if (arg1 >= (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::fill_point_start_ms(v3) as u64)) {
                    (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::fill_point_slippage_bps(v3) as u64)
                } else {
                    0
                };
                let v6 = v4 - arg2;
                assert!(v6 > 0, 70);
                return (v5, true, v6)
            };
            v2 = v2 + 1;
        };
        let v7 = 0x1::vector::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::FillSlippagePoint>(v0, v1 - 1);
        let v8 = if (arg1 >= (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::fill_point_start_ms(v7) as u64)) {
            (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::fill_point_slippage_bps(v7) as u64)
        } else {
            0
        };
        (v8, false, 0)
    }

    fun resolve_provider_slippage<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg1: &Pool<T0, T1>, arg2: address, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::RebalanceQuote) : u16 {
        let v0 = trusted_signer_config(arg0);
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::rebalance_quote_signer_version(arg3) == v0.version, 62);
        assert!(0x2::vec_map::contains<address, AggregatorSignerInfo>(&v0.signers, &arg2), 65);
        let v1 = 0x2::vec_map::get<address, AggregatorSignerInfo>(&v0.signers, &arg2);
        assert!(v1.enabled, 65);
        assert!(0x2::vec_map::contains<0x1::string::String, u16>(&arg1.rebalance_policy.quote_provider_slippage_bps, &v1.provider_name), 66);
        *0x2::vec_map::get<0x1::string::String, u16>(&arg1.rebalance_policy.quote_provider_slippage_bps, &v1.provider_name)
    }

    public fun set_mm_slippage_segment_limits(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MMAdminCap, arg4: u8, arg5: u8) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        assert_admin_cap_matches(arg3, arg2);
        assert!(arg4 <= 10, 30);
        assert!(arg5 <= 10, 30);
        let v0 = 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg2);
        let v1 = signer_policy_mut(arg1, v0);
        v1.max_time_points = arg4;
        v1.max_fill_points = arg5;
        v1.version = v1.version + 1;
        let v2 = SlippageSegmentLimitsUpdatedEvent{
            mm_id           : v0,
            version         : v1.version,
            max_time_points : arg4,
            max_fill_points : arg5,
        };
        0x2::event::emit<SlippageSegmentLimitsUpdatedEvent>(v2);
    }

    public fun set_param(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: u8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::assert_param_manager(arg1, 0x2::tx_context::sender(arg4));
        let v0 = OrderBookV2ParamsKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<OrderBookV2ParamsKey, OrderBookV2Params>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid_mut(arg1), v0);
        if (arg2 == 0) {
            assert!(arg3 <= (100 as u64), 30);
            v1.max_total_slippage_bps = (arg3 as u16);
        } else {
            assert!(arg2 == 1, 29);
            assert!(arg3 > 0, 41);
            assert!(arg3 <= (20 as u64), 30);
            v1.max_layers_per_quote = (arg3 as u8);
        };
        let v2 = OrderBookV2ParamSetEvent{
            key   : arg2,
            value : arg3,
        };
        0x2::event::emit<OrderBookV2ParamSetEvent>(v2);
    }

    public fun set_pool_fee_override<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: 0x1::option::Option<u16>, arg4: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::assert_fee_manager(arg1, 0x2::tx_context::sender(arg4));
        if (0x1::option::is_some<u16>(&arg3)) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::fee::assert_fee_bps_valid(*0x1::option::borrow<u16>(&arg3));
        };
        arg2.fee_override = arg3;
        let v0 = PoolFeeOverrideSetEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg2),
            fee_bps : arg3,
        };
        0x2::event::emit<PoolFeeOverrideSetEvent>(v0);
    }

    public fun set_quote_threshold(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MMAdminCap, arg4: u8) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        assert_admin_cap_matches(arg3, arg2);
        let v0 = 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg2);
        let v1 = signer_policy_mut(arg1, v0);
        validate_threshold(arg4, 0x2::vec_set::size<address>(&v1.signers));
        v1.threshold = arg4;
        v1.version = v1.version + 1;
        let v2 = SignerPolicyUpdatedEvent{
            mm_id     : v0,
            version   : v1.version,
            threshold : arg4,
        };
        0x2::event::emit<SignerPolicyUpdatedEvent>(v2);
    }

    public fun set_rebalance_policy<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MMAdminCap, arg3: &mut Pool<T0, T1>, arg4: bool, arg5: 0x1::option::Option<ReferenceRatioGuard>, arg6: u16, arg7: u32, arg8: 0x2::vec_map::VecMap<0x1::string::String, u16>) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg1);
        assert_admin_cap_matches(arg2, arg1);
        validate_rebalance_policy(arg4, &arg5, arg6, arg7, &arg8);
        let v0 = RebalancePolicy{
            enabled                         : arg4,
            reference_ratio_guard           : arg5,
            max_borrow_balance_bps          : arg6,
            epoch_rebalance_coefficient_bps : arg7,
            quote_provider_slippage_bps     : arg8,
        };
        arg3.rebalance_policy = v0;
        let v1 = RebalancePolicyUpdatedEvent{
            pool_id                         : 0x2::object::id<Pool<T0, T1>>(arg3),
            enabled                         : arg4,
            epoch_rebalance_coefficient_bps : arg7,
        };
        0x2::event::emit<RebalancePolicyUpdatedEvent>(v1);
    }

    public fun set_trusted_aggregator_signer(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: address, arg3: 0x1::string::String, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::assert_param_manager(arg1, 0x2::tx_context::sender(arg5));
        let v0 = trusted_signer_config_mut(arg1);
        let v1 = AggregatorSignerInfo{
            provider_name : arg3,
            enabled       : arg4,
        };
        if (0x2::vec_map::contains<address, AggregatorSignerInfo>(&v0.signers, &arg2)) {
            *0x2::vec_map::get_mut<address, AggregatorSignerInfo>(&mut v0.signers, &arg2) = v1;
        } else {
            0x2::vec_map::insert<address, AggregatorSignerInfo>(&mut v0.signers, arg2, v1);
        };
        v0.version = v0.version + 1;
        let v2 = TrustedAggregatorSignerUpdatedEvent{
            signer        : arg2,
            provider_name : arg3,
            enabled       : arg4,
            version       : v0.version,
        };
        0x2::event::emit<TrustedAggregatorSignerUpdatedEvent>(v2);
    }

    fun signer_policy(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg1: 0x2::object::ID) : &SignerPolicy {
        let v0 = SignerPolicyKey{mm_id: arg1};
        assert!(0x2::dynamic_field::exists_<SignerPolicyKey>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid(arg0), v0), 47);
        0x2::dynamic_field::borrow<SignerPolicyKey, SignerPolicy>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid(arg0), v0)
    }

    public fun signer_policy_contains(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg1: 0x2::object::ID, arg2: address) : bool {
        0x2::vec_set::contains<address>(&signer_policy(arg0, arg1).signers, &arg2)
    }

    public fun signer_policy_max_fill_points(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg1: 0x2::object::ID) : u8 {
        signer_policy(arg0, arg1).max_fill_points
    }

    public fun signer_policy_max_time_points(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg1: 0x2::object::ID) : u8 {
        signer_policy(arg0, arg1).max_time_points
    }

    fun signer_policy_mut(arg0: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg1: 0x2::object::ID) : &mut SignerPolicy {
        let v0 = SignerPolicyKey{mm_id: arg1};
        assert!(0x2::dynamic_field::exists_<SignerPolicyKey>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid(arg0), v0), 47);
        0x2::dynamic_field::borrow_mut<SignerPolicyKey, SignerPolicy>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid_mut(arg0), v0)
    }

    public fun signer_policy_threshold(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg1: 0x2::object::ID) : u8 {
        signer_policy(arg0, arg1).threshold
    }

    public fun signer_policy_version(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg1: 0x2::object::ID) : u64 {
        signer_policy(arg0, arg1).version
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: QuoteFill, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = prepare_consume_context<T0, T1>(arg0, arg1, arg2, arg3, arg6, true);
        assert!(0x2::balance::value<T0>(&arg5) >= arg4.amount_in, 8);
        assert!(0x1::option::is_some<QuoteEntryV2>(&arg3.bid_quote), 43);
        let v1 = 0x1::option::borrow<QuoteEntryV2>(&arg3.bid_quote).quote_hash;
        let v2 = 0x1::option::borrow<QuoteEntryV2>(&arg3.bid_quote).cancelled;
        let v3 = walk_one<T0, T1>(arg3, &v0, arg4.amount_in);
        let WalkResult {
            consumed_in : v4,
            total_out   : v5,
            layer_fills : v6,
        } = v3;
        assert!(0x2::balance::value<T1>(&arg3.quote_balance) >= v5, 7);
        0x2::balance::join<T0>(&mut arg3.base_balance, 0x2::balance::split<T0>(&mut arg5, v4));
        let v7 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::fee::compute_fee(v5, v0.fee_bps);
        let v8 = 0x2::balance::split<T1>(&mut arg3.quote_balance, v5);
        0x2::balance::join<T1>(&mut arg3.protocol_fee_quote, 0x2::balance::split<T1>(&mut v8, v7));
        let v9 = ConsumeExecutedEvent{
            pool_id              : v0.pool_id,
            a2b                  : true,
            total_amount_in      : v4,
            total_amount_out     : v5 - v7,
            total_fee            : v7,
            layer_fills          : v6,
            fill_quote_hash      : arg4.fill_quote_hash,
            entry_quote_hash     : v1,
            entry_fully_consumed : read_entry_fully_consumed<T0, T1>(arg3, true),
            entry_cancelled      : v2,
        };
        0x2::event::emit<ConsumeExecutedEvent>(v9);
        (v8, arg5)
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: QuoteFill, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = prepare_consume_context<T0, T1>(arg0, arg1, arg2, arg3, arg6, false);
        assert!(0x2::balance::value<T1>(&arg5) >= arg4.amount_in, 8);
        assert!(0x1::option::is_some<QuoteEntryV2>(&arg3.ask_quote), 43);
        let v1 = 0x1::option::borrow<QuoteEntryV2>(&arg3.ask_quote).quote_hash;
        let v2 = 0x1::option::borrow<QuoteEntryV2>(&arg3.ask_quote).cancelled;
        let v3 = walk_one<T0, T1>(arg3, &v0, arg4.amount_in);
        let WalkResult {
            consumed_in : v4,
            total_out   : v5,
            layer_fills : v6,
        } = v3;
        assert!(0x2::balance::value<T0>(&arg3.base_balance) >= v5, 7);
        0x2::balance::join<T1>(&mut arg3.quote_balance, 0x2::balance::split<T1>(&mut arg5, v4));
        let v7 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::fee::compute_fee(v5, v0.fee_bps);
        let v8 = 0x2::balance::split<T0>(&mut arg3.base_balance, v5);
        0x2::balance::join<T0>(&mut arg3.protocol_fee_base, 0x2::balance::split<T0>(&mut v8, v7));
        let v9 = ConsumeExecutedEvent{
            pool_id              : v0.pool_id,
            a2b                  : false,
            total_amount_in      : v4,
            total_amount_out     : v5 - v7,
            total_fee            : v7,
            layer_fills          : v6,
            fill_quote_hash      : arg4.fill_quote_hash,
            entry_quote_hash     : v1,
            entry_fully_consumed : read_entry_fully_consumed<T0, T1>(arg3, false),
            entry_cancelled      : v2,
        };
        0x2::event::emit<ConsumeExecutedEvent>(v9);
        (v8, arg5)
    }

    fun sweep_dead_quote(arg0: &mut 0x1::option::Option<QuoteEntryV2>, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: bool) {
        if (0x1::option::is_some<QuoteEntryV2>(arg0)) {
            let v0 = 0x1::option::borrow<QuoteEntryV2>(arg0);
            let v1 = v0.cancelled;
            let v2 = v0.signer_policy_version != arg4 || v0.inventory_version != arg5;
            let v3 = if (v0.sig_expiry_ms <= arg3) {
                true
            } else if (v2) {
                true
            } else {
                arg6 && v1
            };
            if (v3) {
                let v4 = 0x1::option::extract<QuoteEntryV2>(arg0);
                destroy_quote(v4);
                let v5 = QuoteSweptEvent{
                    pool_id         : arg1,
                    a2b             : arg2,
                    quote_hash      : v4.quote_hash,
                    sig_expiry_ms   : v4.sig_expiry_ms,
                    cancelled       : v1,
                    version_invalid : v2,
                };
                0x2::event::emit<QuoteSweptEvent>(v5);
            };
        };
    }

    fun trusted_signer_config(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig) : &TrustedAggregatorSignerConfig {
        let v0 = TrustedAggregatorSignerConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TrustedAggregatorSignerConfigKey>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid(arg0), v0), 63);
        let v1 = TrustedAggregatorSignerConfigKey{dummy_field: false};
        0x2::dynamic_field::borrow<TrustedAggregatorSignerConfigKey, TrustedAggregatorSignerConfig>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid(arg0), v1)
    }

    fun trusted_signer_config_mut(arg0: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig) : &mut TrustedAggregatorSignerConfig {
        let v0 = TrustedAggregatorSignerConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<TrustedAggregatorSignerConfigKey>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid(arg0), v0), 63);
        let v1 = TrustedAggregatorSignerConfigKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<TrustedAggregatorSignerConfigKey, TrustedAggregatorSignerConfig>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::uid_mut(arg0), v1)
    }

    public fun unpause_pool<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg0);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::assert_not_paused(arg1);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_not_paused(arg2);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg2);
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::assert_role(arg2, 0x2::tx_context::sender(arg4), 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::roles::mm_role_pool_operator());
        arg3.paused = false;
        let v0 = PoolPausedEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg3),
            paused  : false,
        };
        0x2::event::emit<PoolPausedEvent>(v0);
    }

    fun update_epoch_usage<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::epoch(arg3);
        if (v0 != arg0.rebalance_usage_epoch) {
            arg0.rebalance_usage_epoch = v0;
            arg0.rebalance_borrowed_base_in_epoch = 0;
            arg0.rebalance_borrowed_quote_in_epoch = 0;
        };
        if (arg2) {
            let v2 = compute_epoch_cap(0x2::balance::value<T0>(&arg0.base_balance), arg0.rebalance_policy.epoch_rebalance_coefficient_bps);
            let v3 = (arg0.rebalance_borrowed_base_in_epoch as u256) + (arg1 as u256);
            assert!(v3 <= (v2 as u256), 60);
            arg0.rebalance_borrowed_base_in_epoch = (v3 as u64);
            v2
        } else {
            let v4 = compute_epoch_cap(0x2::balance::value<T1>(&arg0.quote_balance), arg0.rebalance_policy.epoch_rebalance_coefficient_bps);
            let v5 = (arg0.rebalance_borrowed_quote_in_epoch as u256) + (arg1 as u256);
            assert!(v5 <= (v4 as u256), 60);
            arg0.rebalance_borrowed_quote_in_epoch = (v5 as u64);
            v4
        }
    }

    public fun update_quote_envelope_v2<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = precheck_decode_noop<T0, T1>(arg0, arg1, arg2, arg3, &arg4, arg6);
        if (!v0) {
            return
        };
        upsert_quote_validated<T0, T1>(arg1, arg3, v1, v2, verify_signature_bundle(signer_policy(arg1, 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg2)), &arg4, &arg5), v3, v4, v5);
    }

    fun upsert_quote_validated<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: vector<u8>, arg3: 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::SignedQuoteV2, arg4: vector<address>, arg5: bool, arg6: u64, arg7: u64) {
        let v0 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::envelope_v2_sig_expiry_ms(&arg3);
        let v1 = 0x1::vector::length<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::envelope_v2_layers(&arg3));
        assert!(arg6 <= arg7, 13);
        assert!(v0 > arg7, 14);
        let v2 = v0 - arg6;
        assert!(v2 >= (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::min_sig_expiry_seconds(arg0) as u64) * 1000, 15);
        assert!(v2 <= (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::max_sig_expiry_seconds(arg0) as u64) * 1000, 16);
        assert!(v1 >= 1, 17);
        let v3 = params(arg0);
        let v4 = signer_policy(arg0, arg1.mm_id);
        assert!(v1 <= (v3.max_layers_per_quote as u64), 18);
        validate_layers(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::envelope_v2_layers(&arg3), arg5);
        validate_slippage(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::envelope_v2_slippage(&arg3), v3.max_total_slippage_bps, v4.max_time_points, v4.max_fill_points);
        let v5 = if (arg5) {
            &mut arg1.bid_quote
        } else {
            &mut arg1.ask_quote
        };
        if (0x1::option::is_none<QuoteEntryV2>(v5)) {
            0x1::option::fill<QuoteEntryV2>(v5, build_new_entry_from_envelope(arg2, arg3));
            let v6 = QuoteFirstSeenEvent{
                pool_id      : 0x2::object::id<Pool<T0, T1>>(arg1),
                a2b          : arg5,
                quote_hash   : arg2,
                layers_count : (v1 as u8),
                signer       : *0x1::vector::borrow<address>(&arg4, 0),
            };
            0x2::event::emit<QuoteFirstSeenEvent>(v6);
        } else {
            destroy_quote(0x1::option::extract<QuoteEntryV2>(v5));
            0x1::option::fill<QuoteEntryV2>(v5, build_new_entry_from_envelope(arg2, arg3));
            let v7 = QuoteAmendedEvent{
                pool_id  : 0x2::object::id<Pool<T0, T1>>(arg1),
                a2b      : arg5,
                old_hash : 0x1::option::borrow<QuoteEntryV2>(v5).quote_hash,
                new_hash : arg2,
                signer   : *0x1::vector::borrow<address>(&arg4, 0),
            };
            0x2::event::emit<QuoteAmendedEvent>(v7);
        };
    }

    fun validate_layers(arg0: &vector<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>, arg1: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>(arg0)) {
            let v1 = 0x1::vector::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>(arg0, v0);
            assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_price(v1) > 0, 35);
            assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_depth(v1) > 0, 45);
            if (v0 > 0) {
                if (arg1) {
                    assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_price(0x1::vector::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>(arg0, v0 - 1)) > 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_price(v1), 46);
                } else {
                    assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_price(0x1::vector::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>(arg0, v0 - 1)) < 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_price(v1), 46);
                };
            };
            v0 = v0 + 1;
        };
    }

    fun validate_rebalance_policy(arg0: bool, arg1: &0x1::option::Option<ReferenceRatioGuard>, arg2: u16, arg3: u32, arg4: &0x2::vec_map::VecMap<0x1::string::String, u16>) {
        assert!(arg2 <= (10000 as u16), 68);
        assert!(arg3 <= 100000, 71);
        if (arg0) {
            assert!(arg2 > 0, 68);
            assert!(arg3 > 0, 68);
            assert!((arg2 as u32) <= arg3, 68);
        };
        if (0x1::option::is_some<ReferenceRatioGuard>(arg1)) {
            let v0 = 0x1::option::borrow<ReferenceRatioGuard>(arg1);
            assert!(v0.reference_base_amount > 0 && v0.reference_quote_amount > 0, 61);
            assert!(v0.max_loss_bps < (10000 as u16), 61);
        };
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<0x1::string::String, u16>(arg4)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, u16>(arg4, v1);
            assert!(*v3 < (10000 as u16), 72);
            v1 = v1 + 1;
        };
    }

    fun validate_slippage(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::SlippageCurveV2, arg1: u16, arg2: u8, arg3: u8) {
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::slippage_v2_max_total_slippage_bps(arg0) <= arg1, 20);
        let v0 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::slippage_v2_time_points(arg0);
        let v1 = 0x1::vector::length<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::TimeSlippagePoint>(v0);
        assert!(v1 <= (arg2 as u64), 69);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x1::vector::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::TimeSlippagePoint>(v0, v2);
            assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::time_point_offset_ms(v3) > 0, 70);
            assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::time_point_slippage_bps(v3) >= 0, 70);
            v2 = v2 + 1;
        };
        let v4 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::slippage_v2_fill_points(arg0);
        let v5 = 0x1::vector::length<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::FillSlippagePoint>(v4);
        assert!(v5 <= (arg3 as u64), 69);
        let v6 = 0;
        while (v6 < v5) {
            let v7 = 0x1::vector::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::FillSlippagePoint>(v4, v6);
            assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::fill_point_amount_base(v7) > 0, 70);
            assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::fill_point_slippage_bps(v7) >= 0, 70);
            v6 = v6 + 1;
        };
    }

    fun validate_threshold(arg0: u8, arg1: u64) {
        assert!(arg0 > 0, 49);
        assert!(arg0 <= 5, 49);
        assert!((arg0 as u64) <= arg1, 49);
    }

    fun verify_signature_bundle(arg0: &SignerPolicy, arg1: &vector<u8>, arg2: &vector<vector<u8>>) : vector<address> {
        assert!(0x1::vector::length<vector<u8>>(arg2) == (arg0.threshold as u64), 50);
        let v0 = 0x1::vector::empty<address>();
        let v1 = false;
        let v2 = @0x0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(arg2)) {
            let v4 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::verify_signature_v2(arg1, 0x1::vector::borrow<vector<u8>>(arg2, v3));
            assert!(0x2::vec_set::contains<address>(&arg0.signers, &v4), 25);
            if (v1) {
                assert!(address_lt(v2, v4), 51);
            };
            0x1::vector::push_back<address>(&mut v0, v4);
            v2 = v4;
            v1 = true;
            v3 = v3 + 1;
        };
        v0
    }

    fun walk_one<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &ConsumeContext, arg2: u64) : WalkResult {
        let v0 = arg1.a2b;
        let v1 = if (v0) {
            &mut arg0.bid_quote
        } else {
            &mut arg0.ask_quote
        };
        let v2 = 0x1::option::borrow_mut<QuoteEntryV2>(v1);
        if (v2.cancelled || v2.cumulative_filled_in >= v2.total_depth) {
            return WalkResult{
                consumed_in : 0,
                total_out   : 0,
                layer_fills : 0x1::vector::empty<LayerFill>(),
            }
        };
        assert!(v2.sig_expiry_ms > arg1.now_ms, 14);
        assert!(v2.signer_policy_version == arg1.signer_policy_version, 52);
        assert!(v2.inventory_version == arg1.inventory_version, 53);
        let v3 = if (arg1.now_ms >= v2.signed_at_ms) {
            arg1.now_ms - v2.signed_at_ms
        } else {
            0
        };
        let v4 = compute_time_bps(&v2.slippage, v3);
        let v5 = 0;
        let v6 = 0;
        let v7 = 0x1::vector::empty<LayerFill>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>(&v2.layers) && arg2 > 0) {
            let v9 = 0x1::vector::borrow_mut<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::QuoteLayerV2>(&mut v2.layers, v8);
            let v10 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_depth(v9) - 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_filled(v9);
            if (v10 == 0) {
                v8 = v8 + 1;
                continue
            };
            let (v11, v12, v13) = resolve_fill_band(&v2.slippage, v3, v5);
            let v14 = if (v12 && v13 < v10) {
                v13
            } else {
                v10
            };
            let v15 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_price(v9);
            let (v16, v17) = compute_slippage_bps(&v2.slippage, v4, v11, arg1.max_total_slippage_bps);
            let v18 = compute_effective_price(v15, &v2.slippage, v4, v11, arg1.max_total_slippage_bps, v0);
            assert!(v18 > 0, 35);
            let (v19, v20) = if (v0) {
                let v21 = if (arg2 < v14) {
                    arg2
                } else {
                    v14
                };
                let v22 = (v21 as u256) * (v18 as u256) / (1000000000000000000 as u256);
                assert!(v22 <= 18446744073709551615, 22);
                (v21, (v22 as u64))
            } else {
                let v23 = (arg2 as u256) * (1000000000000000000 as u256) / (v18 as u256);
                let v24 = if (v23 > 18446744073709551615) {
                    (18446744073709551615 as u64)
                } else {
                    (v23 as u64)
                };
                let (v25, v26) = if (v24 < v14) {
                    (arg2, v24)
                } else {
                    let v27 = (v14 as u256) * (v18 as u256) / (1000000000000000000 as u256);
                    assert!(v27 <= 18446744073709551615, 22);
                    ((v27 as u64), v14)
                };
                (v26, v25)
            };
            if (v19 > 0) {
                0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::add_layer_v2_filled(v9, v19);
                v5 = v5 + v19;
                v6 = v6 + v20;
                let v28 = if (v0) {
                    arg2 - v19
                } else {
                    arg2 - v20
                };
                arg2 = v28;
                let v29 = if (v0) {
                    v19
                } else {
                    v20
                };
                let v30 = if (v0) {
                    v20
                } else {
                    v19
                };
                let v31 = LayerFill{
                    layer_index          : (v8 as u8),
                    layer_price          : v15,
                    effective_price      : v18,
                    elapsed_ms           : v3,
                    time_slippage_bps    : v4,
                    fill_slippage_bps    : v11,
                    raw_slippage_bps     : v16,
                    applied_slippage_bps : v17,
                    amount_in            : v29,
                    amount_out           : v30,
                };
                0x1::vector::push_back<LayerFill>(&mut v7, v31);
                if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_filled(v9) >= 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope::layer_v2_depth(v9)) {
                    v8 = v8 + 1;
                    continue
                } else {
                    continue
                };
            };
            arg2 = 0;
        };
        v2.cumulative_filled_in = v2.cumulative_filled_in + v5;
        if (v2.fill_or_kill) {
            assert!(v5 == v2.total_depth, 23);
        };
        let v32 = if (v0) {
            v5
        } else {
            v6
        };
        let v33 = if (v0) {
            v6
        } else {
            v5
        };
        assert!(v32 >= v2.min_fill, 24);
        WalkResult{
            consumed_in : v32,
            total_out   : v33,
            layer_fills : v7,
        }
    }

    public fun withdraw_base<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: u64, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_withdraw_allowed<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        assert!(0x2::balance::value<T0>(&arg3.base_balance) >= arg4, 32);
        bump_inventory_and_clear_quotes<T0, T1>(arg3);
        let v0 = PoolWithdrawEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg3),
            coin    : 0x1::type_name::get<T0>(),
            amount  : arg4,
        };
        0x2::event::emit<PoolWithdrawEvent>(v0);
        0x2::balance::split<T0>(&mut arg3.base_balance, arg4)
    }

    public fun withdraw_quote<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: u64, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert_withdraw_allowed<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        assert!(0x2::balance::value<T1>(&arg3.quote_balance) >= arg4, 32);
        bump_inventory_and_clear_quotes<T0, T1>(arg3);
        let v0 = PoolWithdrawEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg3),
            coin    : 0x1::type_name::get<T1>(),
            amount  : arg4,
        };
        0x2::event::emit<PoolWithdrawEvent>(v0);
        0x2::balance::split<T1>(&mut arg3.quote_balance, arg4)
    }

    // decompiled from Move bytecode v7
}

