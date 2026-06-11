module 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::orderbook {
    struct OrderBookParamsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OrderBookParams has copy, drop, store {
        max_slope_bps_per_second: u16,
        max_total_slippage_bps: u16,
        max_layers_per_quote: u8,
    }

    struct QuoteEntry has store {
        quote_hash: vector<u8>,
        layers: vector<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::QuoteLayer>,
        slippage: 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::SlippagePoint,
        signed_at_ms: u64,
        sig_expiry_ms: u64,
        fill_or_kill: bool,
        min_fill: u64,
        cumulative_filled_in: u64,
        total_depth: u64,
        cancelled: bool,
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
        bid_quote: 0x1::option::Option<QuoteEntry>,
        ask_quote: 0x1::option::Option<QuoteEntry>,
        created_at_ms: u64,
    }

    struct OrderBookParamSetEvent has copy, drop {
        key: u8,
        value: u64,
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

    struct LayerFill has copy, drop, store {
        fill_index: u8,
        request_id: vector<u8>,
        quote_hash: vector<u8>,
        layer_index: u8,
        layer_price: u128,
        effective_price: u128,
        amount_in: u64,
        amount_out: u64,
    }

    struct WalkResult has drop {
        consumed_in: u64,
        total_out: u64,
        layer_fills: vector<LayerFill>,
    }

    struct ConsumeExecutedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        total_amount_in: u64,
        total_amount_out: u64,
        total_fee: u64,
        layer_fills: vector<LayerFill>,
        entry_quote_hash: vector<u8>,
        entry_fully_consumed: bool,
        entry_cancelled: bool,
        version_mismatch: bool,
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

    struct QuoteFill has copy, drop, store {
        request_id: vector<u8>,
        amount_in: u64,
    }

    struct ConsumeContext has drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        now_ms: u64,
        max_total_slippage_bps: u16,
        fee_bps: u16,
    }

    fun accumulate_walk_result(arg0: &mut u64, arg1: &mut u64, arg2: &mut vector<LayerFill>, arg3: u64, arg4: u64, arg5: vector<LayerFill>) {
        *arg0 = *arg0 + arg3;
        *arg1 = *arg1 + arg4;
        0x1::vector::append<LayerFill>(arg2, arg5);
    }

    fun assert_deposit_allowed<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg3: &Pool<T0, T1>, arg4: &0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_not_paused(arg1);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_not_paused(arg2);
        assert!(!arg3.paused, 33);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg2);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_role(arg2, 0x2::tx_context::sender(arg4), 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::roles::mm_role_treasury());
    }

    fun assert_pool_belongs_to_mm<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker) {
        assert!(arg0.mm_id == 0x2::object::id<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker>(arg1), 2);
    }

    fun assert_pool_not_paused<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(!arg0.paused, 1);
    }

    fun assert_quote_version(arg0: &0x1::option::Option<QuoteEntry>, arg1: &vector<u8>) : (vector<u8>, bool, bool) {
        assert!(0x1::option::is_some<QuoteEntry>(arg0), 43);
        let v0 = 0x1::option::borrow<QuoteEntry>(arg0);
        (v0.quote_hash, v0.cancelled, v0.quote_hash != *arg1)
    }

    fun assert_upfront_input<T0>(arg0: &0x2::balance::Balance<T0>, arg1: &vector<QuoteFill>) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<QuoteFill>(arg1)) {
            v0 = v0 + (0x1::vector::borrow<QuoteFill>(arg1, v1).amount_in as u128);
            v1 = v1 + 1;
        };
        assert!((0x2::balance::value<T0>(arg0) as u128) >= v0, 8);
    }

    fun build_new_entry_from_envelope(arg0: vector<u8>, arg1: 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::SignedQuote) : QuoteEntry {
        let (v0, v1, v2, v3, v4, v5) = 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::unpack_envelope(arg1);
        let v6 = reset_layers_filled(v0);
        let v7 = compute_total_depth(&v6);
        assert!(v7 > 0, 34);
        QuoteEntry{
            quote_hash           : arg0,
            layers               : v6,
            slippage             : v1,
            signed_at_ms         : v2,
            sig_expiry_ms        : v3,
            fill_or_kill         : v4,
            min_fill             : v5,
            cumulative_filled_in : 0,
            total_depth          : v7,
            cancelled            : false,
        }
    }

    public fun cancel_quote<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg2: &mut Pool<T0, T1>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        assert_pool_belongs_to_mm<T0, T1>(arg2, arg1);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_role(arg1, 0x2::tx_context::sender(arg4), 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::roles::mm_role_quote_signer());
        let v0 = if (arg3) {
            &mut arg2.bid_quote
        } else {
            &mut arg2.ask_quote
        };
        let v1 = if (0x1::option::is_some<QuoteEntry>(v0)) {
            let v2 = 0x1::option::borrow_mut<QuoteEntry>(v0);
            v2.cancelled = true;
            0x1::option::some<vector<u8>>(v2.quote_hash)
        } else {
            0x1::option::none<vector<u8>>()
        };
        let v3 = QuoteCancelledEvent{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg2),
            a2b        : arg3,
            quote_hash : v1,
        };
        0x2::event::emit<QuoteCancelledEvent>(v3);
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_fee_collector(arg1, v0);
        let v1 = 0x2::balance::value<T0>(&arg2.protocol_fee_base);
        let v2 = 0x2::balance::value<T1>(&arg2.protocol_fee_quote);
        let v3 = ProtocolFeeCollectedEvent{
            pool_id   : 0x2::object::id<Pool<T0, T1>>(arg2),
            collector : v0,
            base      : v1,
            quote     : v2,
        };
        0x2::event::emit<ProtocolFeeCollectedEvent>(v3);
        (0x2::balance::split<T0>(&mut arg2.protocol_fee_base, v1), 0x2::balance::split<T1>(&mut arg2.protocol_fee_quote, v2))
    }

    fun compute_effective_price(arg0: u128, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::SlippagePoint, arg2: u64, arg3: u64, arg4: u16, arg5: bool) : u128 {
        let v0 = 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::slippage_bps(arg1);
        if (v0 == 0) {
            return arg0
        };
        let v1 = if (arg3 >= arg2) {
            arg3 - arg2
        } else {
            0
        };
        let v2 = (v1 as u128) * (v0 as u128) / (0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::slippage_offset_ms(arg1) as u128);
        let v3 = if (v2 > (arg4 as u128)) {
            (arg4 as u128)
        } else {
            v2
        };
        let v4 = if (arg5) {
            (10000 as u128) - v3
        } else {
            (10000 as u128) + v3
        };
        arg0 * v4 / (10000 as u128)
    }

    fun compute_total_depth(arg0: &vector<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::QuoteLayer>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::QuoteLayer>(arg0)) {
            v0 = v0 + 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::layer_depth(0x1::vector::borrow<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::QuoteLayer>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun deposit_base<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::tx_context::TxContext) {
        assert_deposit_allowed<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        0x2::balance::join<T0>(&mut arg3.base_balance, arg4);
        let v0 = PoolDepositEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg3),
            coin    : 0x1::type_name::get<T0>(),
            amount  : 0x2::balance::value<T0>(&arg4),
        };
        0x2::event::emit<PoolDepositEvent>(v0);
    }

    public fun deposit_quote<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::tx_context::TxContext) {
        assert_deposit_allowed<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        0x2::balance::join<T1>(&mut arg3.quote_balance, arg4);
        let v0 = PoolDepositEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg3),
            coin    : 0x1::type_name::get<T1>(),
            amount  : 0x2::balance::value<T1>(&arg4),
        };
        0x2::event::emit<PoolDepositEvent>(v0);
    }

    public fun deregister_pool<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &mut 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::registry::Registry, arg2: &mut 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg2);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_role(arg2, 0x2::tx_context::sender(arg5), 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::roles::mm_role_pool_operator());
        assert!(0x2::balance::value<T0>(&arg3.base_balance) == 0, 3);
        assert!(0x2::balance::value<T1>(&arg3.quote_balance) == 0, 4);
        assert!(0x2::balance::value<T0>(&arg3.protocol_fee_base) == 0, 39);
        assert!(0x2::balance::value<T1>(&arg3.protocol_fee_quote) == 0, 39);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::object::id<Pool<T0, T1>>(arg3);
        let v2 = &mut arg3.bid_quote;
        sweep_dead_quote(v2, v1, true, v0);
        let v3 = &mut arg3.ask_quote;
        sweep_dead_quote(v3, v1, false, v0);
        assert!(0x1::option::is_none<QuoteEntry>(&arg3.bid_quote), 5);
        assert!(0x1::option::is_none<QuoteEntry>(&arg3.ask_quote), 6);
        arg3.paused = true;
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::remove_pool_id(arg2, v1);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::registry::remove_pool(arg1, v1);
        let v4 = PoolDeregisteredEvent{
            pool_id : v1,
            mm_id   : 0x2::object::id<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker>(arg2),
        };
        0x2::event::emit<PoolDeregisteredEvent>(v4);
    }

    fun destroy_quote(arg0: QuoteEntry) {
        let QuoteEntry {
            quote_hash           : _,
            layers               : _,
            slippage             : _,
            signed_at_ms         : _,
            sig_expiry_ms        : _,
            fill_or_kill         : _,
            min_fill             : _,
            cumulative_filled_in : _,
            total_depth          : _,
            cancelled            : _,
        } = arg0;
    }

    public fun init_params(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::admin_cap::SuperAdminCap, arg2: &mut 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        let v0 = OrderBookParamsKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<OrderBookParamsKey>(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::uid(arg2), v0), 36);
        let v1 = OrderBookParamsKey{dummy_field: false};
        let v2 = OrderBookParams{
            max_slope_bps_per_second : 1,
            max_total_slippage_bps   : 10,
            max_layers_per_quote     : 8,
        };
        0x2::dynamic_field::add<OrderBookParamsKey, OrderBookParams>(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::uid_mut(arg2), v1, v2);
    }

    public fun layer_fill_amount_in(arg0: &LayerFill) : u64 {
        arg0.amount_in
    }

    public fun layer_fill_amount_out(arg0: &LayerFill) : u64 {
        arg0.amount_out
    }

    public fun layer_fill_effective_price(arg0: &LayerFill) : u128 {
        arg0.effective_price
    }

    public fun layer_fill_index(arg0: &LayerFill) : u8 {
        arg0.layer_index
    }

    public fun layer_fill_price(arg0: &LayerFill) : u128 {
        arg0.layer_price
    }

    public fun new_quote_fill(arg0: vector<u8>, arg1: u64) : QuoteFill {
        QuoteFill{
            request_id : arg0,
            amount_in  : arg1,
        }
    }

    public fun params(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig) : &OrderBookParams {
        let v0 = OrderBookParamsKey{dummy_field: false};
        0x2::dynamic_field::borrow<OrderBookParamsKey, OrderBookParams>(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::uid(arg0), v0)
    }

    public fun pause_pool<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg2: &mut Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        assert_pool_belongs_to_mm<T0, T1>(arg2, arg1);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_role(arg1, 0x2::tx_context::sender(arg3), 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::roles::mm_role_pool_pauser());
        arg2.paused = true;
        let v0 = PoolPausedEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg2),
            paused  : true,
        };
        0x2::event::emit<PoolPausedEvent>(v0);
    }

    public fun pool_ask<T0, T1>(arg0: &Pool<T0, T1>) : &0x1::option::Option<QuoteEntry> {
        &arg0.ask_quote
    }

    public fun pool_base_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.base_balance)
    }

    public fun pool_bid<T0, T1>(arg0: &Pool<T0, T1>) : &0x1::option::Option<QuoteEntry> {
        &arg0.bid_quote
    }

    public fun pool_created_at_ms<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.created_at_ms
    }

    public fun pool_fee_override<T0, T1>(arg0: &Pool<T0, T1>) : &0x1::option::Option<u16> {
        &arg0.fee_override
    }

    public fun pool_has_ask<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        0x1::option::is_some<QuoteEntry>(&arg0.ask_quote)
    }

    public fun pool_has_bid<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        0x1::option::is_some<QuoteEntry>(&arg0.bid_quote)
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

    fun precheck_decode_noop<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg3: &Pool<T0, T1>, arg4: &vector<u8>, arg5: &0x2::clock::Clock) : (bool, vector<u8>, 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::SignedQuote, bool, u64, u64) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_not_paused(arg1);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_not_paused(arg2);
        assert_pool_not_paused<T0, T1>(arg3);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg2);
        let v0 = 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::compute_quote_hash(arg4);
        let v1 = 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::decode_signed_quote(*arg4);
        assert!(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::envelope_mm_object_id(&v1) == 0x2::object::id<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker>(arg2), 26);
        assert!(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::envelope_pool_object_id(&v1) == 0x2::object::id<Pool<T0, T1>>(arg3), 27);
        let v2 = 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::envelope_a2b(&v1);
        let v3 = 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::envelope_signed_at_ms(&v1);
        let v4 = if (v2) {
            &arg3.bid_quote
        } else {
            &arg3.ask_quote
        };
        let v5 = if (0x1::option::is_some<QuoteEntry>(v4)) {
            let v6 = 0x1::option::borrow<QuoteEntry>(v4);
            v6.quote_hash == v0 && false || v3 <= v6.signed_at_ms && false || true
        } else {
            true
        };
        (v5, v0, v1, v2, v3, 0x2::clock::timestamp_ms(arg5))
    }

    fun prepare_consume_context<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg3: &Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: bool) : ConsumeContext {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_not_paused(arg1);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_not_paused(arg2);
        assert_pool_not_paused<T0, T1>(arg3);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg2);
        ConsumeContext{
            pool_id                : 0x2::object::id<Pool<T0, T1>>(arg3),
            a2b                    : arg5,
            now_ms                 : 0x2::clock::timestamp_ms(arg4),
            max_total_slippage_bps : params(arg1).max_total_slippage_bps,
            fee_bps                : 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::fee::resolve_fee_bps(arg1, 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::fee_override(arg2), &arg3.fee_override, &arg3.pair_id),
        }
    }

    public fun quote_cancelled(arg0: &QuoteEntry) : bool {
        arg0.cancelled
    }

    public fun quote_cumulative_filled_in(arg0: &QuoteEntry) : u64 {
        arg0.cumulative_filled_in
    }

    public fun quote_hash(arg0: &QuoteEntry) : &vector<u8> {
        &arg0.quote_hash
    }

    public fun quote_sig_expiry_ms(arg0: &QuoteEntry) : u64 {
        arg0.sig_expiry_ms
    }

    public fun quote_signed_at_ms(arg0: &QuoteEntry) : u64 {
        arg0.signed_at_ms
    }

    public fun quote_total_depth(arg0: &QuoteEntry) : u64 {
        arg0.total_depth
    }

    fun read_entry_fully_consumed<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool) : bool {
        let v0 = if (arg1) {
            &arg0.bid_quote
        } else {
            &arg0.ask_quote
        };
        let v1 = 0x1::option::borrow<QuoteEntry>(v0);
        v1.cumulative_filled_in >= v1.total_depth
    }

    public fun register_pool<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &mut 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::registry::Registry, arg3: &mut 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_not_paused(arg1);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_not_paused(arg3);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_role(arg3, 0x2::tx_context::sender(arg5), 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::roles::mm_role_pool_operator());
        let v0 = Pool<T0, T1>{
            id                 : 0x2::object::new(arg5),
            mm_id              : 0x2::object::id<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker>(arg3),
            pair_id            : 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::fee::compute_pair_id<T0, T1>(),
            paused             : false,
            base_balance       : 0x2::balance::zero<T0>(),
            quote_balance      : 0x2::balance::zero<T1>(),
            protocol_fee_base  : 0x2::balance::zero<T0>(),
            protocol_fee_quote : 0x2::balance::zero<T1>(),
            fee_override       : 0x1::option::none<u16>(),
            bid_quote          : 0x1::option::none<QuoteEntry>(),
            ask_quote          : 0x1::option::none<QuoteEntry>(),
            created_at_ms      : 0x2::clock::timestamp_ms(arg4),
        };
        let v1 = 0x2::object::id<Pool<T0, T1>>(&v0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::add_pool_id(arg3, v1);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::registry::add_pool(arg2, 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::registry::new_pool_info(v1, 0x2::object::id<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker>(arg3), 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::registry::pool_type_orderbook()));
        let v2 = PoolRegisteredEvent{
            pool_id   : v1,
            mm_id     : 0x2::object::id<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker>(arg3),
            base      : 0x1::type_name::get<T0>(),
            quote     : 0x1::type_name::get<T1>(),
            pool_type : 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::registry::pool_type_orderbook(),
        };
        0x2::event::emit<PoolRegisteredEvent>(v2);
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    fun reset_layers_filled(arg0: vector<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::QuoteLayer>) : vector<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::QuoteLayer> {
        let v0 = 0x1::vector::empty<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::QuoteLayer>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::QuoteLayer>(&arg0)) {
            let v2 = 0x1::vector::borrow<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::QuoteLayer>(&arg0, v1);
            0x1::vector::push_back<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::QuoteLayer>(&mut v0, 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::new_layer(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::layer_price(v2), 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::layer_depth(v2), 0));
            v1 = v1 + 1;
        };
        v0
    }

    public fun set_param(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &mut 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: u8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_param_manager(arg1, 0x2::tx_context::sender(arg4));
        let v0 = OrderBookParamsKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<OrderBookParamsKey, OrderBookParams>(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::uid_mut(arg1), v0);
        if (arg2 == 0) {
            assert!(arg3 <= (10 as u64), 30);
            v1.max_slope_bps_per_second = (arg3 as u16);
        } else if (arg2 == 1) {
            assert!(arg3 <= (100 as u64), 30);
            v1.max_total_slippage_bps = (arg3 as u16);
        } else {
            assert!(arg2 == 2, 29);
            assert!(arg3 > 0, 41);
            assert!(arg3 <= (16 as u64), 30);
            v1.max_layers_per_quote = (arg3 as u8);
        };
        let v2 = OrderBookParamSetEvent{
            key   : arg2,
            value : arg3,
        };
        0x2::event::emit<OrderBookParamSetEvent>(v2);
    }

    public fun set_pool_fee_override<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &mut Pool<T0, T1>, arg3: 0x1::option::Option<u16>, arg4: &0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_fee_manager(arg1, 0x2::tx_context::sender(arg4));
        if (0x1::option::is_some<u16>(&arg3)) {
            0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::fee::assert_fee_bps_valid(*0x1::option::borrow<u16>(&arg3));
        };
        arg2.fee_override = arg3;
        let v0 = PoolFeeOverrideSetEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg2),
            fee_bps : arg3,
        };
        0x2::event::emit<PoolFeeOverrideSetEvent>(v0);
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: vector<QuoteFill>, arg5: 0x2::balance::Balance<T0>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = prepare_consume_context<T0, T1>(arg0, arg1, arg2, arg3, arg7, true);
        assert_upfront_input<T0>(&arg5, &arg4);
        let (v1, v2, v3) = assert_quote_version(&arg3.bid_quote, &arg6);
        let v4 = 0x2::balance::zero<T1>();
        let v5 = 0x1::vector::empty<LayerFill>();
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 0x1::vector::length<QuoteFill>(&arg4)) {
            let v10 = 0x1::vector::borrow<QuoteFill>(&arg4, v9);
            let v11 = walk_one<T0, T1>(arg3, &v0, v10.amount_in, (v9 as u8), v10.request_id);
            let WalkResult {
                consumed_in : v12,
                total_out   : v13,
                layer_fills : v14,
            } = v11;
            assert!(0x2::balance::value<T1>(&arg3.quote_balance) >= v13, 7);
            0x2::balance::join<T0>(&mut arg3.base_balance, 0x2::balance::split<T0>(&mut arg5, v12));
            let v15 = 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::fee::compute_fee(v13, v0.fee_bps);
            let v16 = 0x2::balance::split<T1>(&mut arg3.quote_balance, v13);
            0x2::balance::join<T1>(&mut arg3.protocol_fee_quote, 0x2::balance::split<T1>(&mut v16, v15));
            0x2::balance::join<T1>(&mut v4, v16);
            v8 = v8 + v15;
            let v17 = &mut v6;
            let v18 = &mut v7;
            let v19 = &mut v5;
            accumulate_walk_result(v17, v18, v19, v12, v13 - v15, v14);
            v9 = v9 + 1;
        };
        let v20 = ConsumeExecutedEvent{
            pool_id              : v0.pool_id,
            a2b                  : v0.a2b,
            total_amount_in      : v6,
            total_amount_out     : v7,
            total_fee            : v8,
            layer_fills          : v5,
            entry_quote_hash     : v1,
            entry_fully_consumed : read_entry_fully_consumed<T0, T1>(arg3, true),
            entry_cancelled      : v2,
            version_mismatch     : v3,
        };
        0x2::event::emit<ConsumeExecutedEvent>(v20);
        (v4, arg5)
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: vector<QuoteFill>, arg5: 0x2::balance::Balance<T1>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = prepare_consume_context<T0, T1>(arg0, arg1, arg2, arg3, arg7, false);
        assert_upfront_input<T1>(&arg5, &arg4);
        let (v1, v2, v3) = assert_quote_version(&arg3.ask_quote, &arg6);
        let v4 = 0x2::balance::zero<T0>();
        let v5 = 0x1::vector::empty<LayerFill>();
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 0x1::vector::length<QuoteFill>(&arg4)) {
            let v10 = 0x1::vector::borrow<QuoteFill>(&arg4, v9);
            let v11 = walk_one<T0, T1>(arg3, &v0, v10.amount_in, (v9 as u8), v10.request_id);
            let WalkResult {
                consumed_in : v12,
                total_out   : v13,
                layer_fills : v14,
            } = v11;
            assert!(0x2::balance::value<T0>(&arg3.base_balance) >= v13, 7);
            0x2::balance::join<T1>(&mut arg3.quote_balance, 0x2::balance::split<T1>(&mut arg5, v12));
            let v15 = 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::fee::compute_fee(v13, v0.fee_bps);
            let v16 = 0x2::balance::split<T0>(&mut arg3.base_balance, v13);
            0x2::balance::join<T0>(&mut arg3.protocol_fee_base, 0x2::balance::split<T0>(&mut v16, v15));
            0x2::balance::join<T0>(&mut v4, v16);
            v8 = v8 + v15;
            let v17 = &mut v6;
            let v18 = &mut v7;
            let v19 = &mut v5;
            accumulate_walk_result(v17, v18, v19, v12, v13 - v15, v14);
            v9 = v9 + 1;
        };
        let v20 = ConsumeExecutedEvent{
            pool_id              : v0.pool_id,
            a2b                  : v0.a2b,
            total_amount_in      : v6,
            total_amount_out     : v7,
            total_fee            : v8,
            layer_fills          : v5,
            entry_quote_hash     : v1,
            entry_fully_consumed : read_entry_fully_consumed<T0, T1>(arg3, false),
            entry_cancelled      : v2,
            version_mismatch     : v3,
        };
        0x2::event::emit<ConsumeExecutedEvent>(v20);
        (v4, arg5)
    }

    fun sweep_dead_quote(arg0: &mut 0x1::option::Option<QuoteEntry>, arg1: 0x2::object::ID, arg2: bool, arg3: u64) {
        if (0x1::option::is_some<QuoteEntry>(arg0)) {
            let v0 = 0x1::option::borrow<QuoteEntry>(arg0);
            let v1 = v0.sig_expiry_ms;
            let v2 = v0.cancelled;
            if (v1 <= arg3 || v2) {
                let v3 = 0x1::option::extract<QuoteEntry>(arg0);
                destroy_quote(v3);
                let v4 = QuoteSweptEvent{
                    pool_id       : arg1,
                    a2b           : arg2,
                    quote_hash    : v3.quote_hash,
                    sig_expiry_ms : v1,
                    cancelled     : v2,
                };
                0x2::event::emit<QuoteSweptEvent>(v4);
            };
        };
    }

    public fun unpause_pool<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg2: &mut Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        assert_pool_belongs_to_mm<T0, T1>(arg2, arg1);
        assert!(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::contains_pool(arg1, 0x2::object::id<Pool<T0, T1>>(arg2)), 40);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_role(arg1, 0x2::tx_context::sender(arg3), 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::roles::mm_role_pool_operator());
        arg2.paused = false;
        let v0 = PoolPausedEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg2),
            paused  : false,
        };
        0x2::event::emit<PoolPausedEvent>(v0);
    }

    public fun update_quote_envelope<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = precheck_decode_noop<T0, T1>(arg0, arg1, arg2, arg3, &arg4, arg6);
        if (!v0) {
            return
        };
        upsert_quote_validated<T0, T1>(arg1, arg2, arg3, v1, v2, 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::verify_signature(&arg4, &arg5), v3, v4, v5);
    }

    fun upsert_quote_validated<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg2: &mut Pool<T0, T1>, arg3: vector<u8>, arg4: 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::SignedQuote, arg5: address, arg6: bool, arg7: u64, arg8: u64) {
        assert!(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::has_role(arg1, arg5, 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::roles::mm_role_quote_signer()), 25);
        let v0 = 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::envelope_sig_expiry_ms(&arg4);
        let v1 = *0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::envelope_slippage(&arg4);
        let v2 = 0x1::vector::length<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::QuoteLayer>(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::envelope_layers(&arg4));
        assert!(arg7 <= arg8, 13);
        assert!(v0 > arg8, 14);
        let v3 = v0 - arg7;
        assert!(v3 >= (0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::min_sig_expiry_seconds(arg0) as u64) * 1000, 15);
        assert!(v3 <= (0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::max_sig_expiry_seconds(arg0) as u64) * 1000, 16);
        assert!(v2 >= 1, 17);
        let v4 = params(arg0);
        assert!(v2 <= (v4.max_layers_per_quote as u64), 18);
        validate_slippage(&v1, v4.max_total_slippage_bps, v4.max_slope_bps_per_second);
        let v5 = if (arg6) {
            &mut arg2.bid_quote
        } else {
            &mut arg2.ask_quote
        };
        if (0x1::option::is_none<QuoteEntry>(v5)) {
            0x1::option::fill<QuoteEntry>(v5, build_new_entry_from_envelope(arg3, arg4));
            let v6 = QuoteFirstSeenEvent{
                pool_id      : 0x2::object::id<Pool<T0, T1>>(arg2),
                a2b          : arg6,
                quote_hash   : arg3,
                layers_count : (v2 as u8),
                signer       : arg5,
            };
            0x2::event::emit<QuoteFirstSeenEvent>(v6);
        } else {
            destroy_quote(0x1::option::extract<QuoteEntry>(v5));
            0x1::option::fill<QuoteEntry>(v5, build_new_entry_from_envelope(arg3, arg4));
            let v7 = QuoteAmendedEvent{
                pool_id  : 0x2::object::id<Pool<T0, T1>>(arg2),
                a2b      : arg6,
                old_hash : 0x1::option::borrow<QuoteEntry>(v5).quote_hash,
                new_hash : arg3,
                signer   : arg5,
            };
            0x2::event::emit<QuoteAmendedEvent>(v7);
        };
    }

    fun validate_slippage(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::SlippagePoint, arg1: u16, arg2: u16) {
        let v0 = 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::slippage_bps(arg0);
        if (v0 == 0) {
            return
        };
        let v1 = 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::slippage_offset_ms(arg0);
        assert!(v1 > 0, 19);
        assert!(v0 <= arg1, 20);
        assert!((v0 as u128) * 1000 <= (v1 as u128) * (arg2 as u128), 21);
    }

    fun walk_one<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &ConsumeContext, arg2: u64, arg3: u8, arg4: vector<u8>) : WalkResult {
        let v0 = arg1.a2b;
        let v1 = arg1.now_ms;
        let v2 = if (v0) {
            &mut arg0.bid_quote
        } else {
            &mut arg0.ask_quote
        };
        let v3 = 0x1::option::borrow_mut<QuoteEntry>(v2);
        if (v3.cancelled || v3.cumulative_filled_in >= v3.total_depth) {
            return WalkResult{
                consumed_in : 0,
                total_out   : 0,
                layer_fills : 0x1::vector::empty<LayerFill>(),
            }
        };
        assert!(v3.sig_expiry_ms > v1, 14);
        let v4 = v3.slippage;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0x1::vector::empty<LayerFill>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::QuoteLayer>(&v3.layers) && arg2 > 0) {
            let v9 = 0x1::vector::borrow_mut<0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::QuoteLayer>(&mut v3.layers, v8);
            let v10 = 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::layer_depth(v9) - 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::layer_filled(v9);
            if (v10 > 0) {
                let v11 = 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::layer_price(v9);
                let v12 = compute_effective_price(v11, &v4, v3.signed_at_ms, v1, arg1.max_total_slippage_bps, v0);
                assert!(v12 > 0, 35);
                let v13 = if (v0) {
                    if (arg2 < v10) {
                        arg2
                    } else {
                        v10
                    }
                } else {
                    let v14 = (arg2 as u256) * (1000000000000000000 as u256) / (v12 as u256);
                    let v15 = if (v14 > 18446744073709551615) {
                        (18446744073709551615 as u64)
                    } else {
                        (v14 as u64)
                    };
                    if (v15 < v10) {
                        v15
                    } else {
                        v10
                    }
                };
                if (v13 > 0) {
                    let v16 = (v13 as u256) * (v12 as u256) / (1000000000000000000 as u256);
                    assert!(v16 <= 18446744073709551615, 22);
                    let v17 = (v16 as u64);
                    0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::envelope::add_layer_filled(v9, v13);
                    v5 = v5 + v13;
                    v6 = v6 + v17;
                    let v18 = if (v0) {
                        arg2 - v13
                    } else {
                        arg2 - v17
                    };
                    arg2 = v18;
                    let v19 = if (v0) {
                        v13
                    } else {
                        v17
                    };
                    let v20 = if (v0) {
                        v17
                    } else {
                        v13
                    };
                    let v21 = LayerFill{
                        fill_index      : arg3,
                        request_id      : arg4,
                        quote_hash      : v3.quote_hash,
                        layer_index     : (v8 as u8),
                        layer_price     : v11,
                        effective_price : v12,
                        amount_in       : v19,
                        amount_out      : v20,
                    };
                    0x1::vector::push_back<LayerFill>(&mut v7, v21);
                };
            };
            v8 = v8 + 1;
        };
        v3.cumulative_filled_in = v3.cumulative_filled_in + v5;
        if (v3.fill_or_kill) {
            assert!(v5 == v3.total_depth, 23);
        };
        let v22 = if (v0) {
            v5
        } else {
            v6
        };
        let v23 = if (v0) {
            v6
        } else {
            v5
        };
        assert!(v22 >= v3.min_fill, 24);
        WalkResult{
            consumed_in : v22,
            total_out   : v23,
            layer_fills : v7,
        }
    }

    public fun withdraw_base<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: u64, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_not_paused(arg1);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_not_paused(arg2);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg2);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_role(arg2, 0x2::tx_context::sender(arg5), 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::roles::mm_role_treasury());
        assert!(0x2::balance::value<T0>(&arg3.base_balance) >= arg4, 32);
        let v0 = PoolWithdrawEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg3),
            coin    : 0x1::type_name::get<T0>(),
            amount  : arg4,
        };
        0x2::event::emit<PoolWithdrawEvent>(v0);
        0x2::balance::split<T0>(&mut arg3.base_balance, arg4)
    }

    public fun withdraw_quote<T0, T1>(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::MarketMaker, arg3: &mut Pool<T0, T1>, arg4: u64, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_not_paused(arg1);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_not_paused(arg2);
        assert_pool_belongs_to_mm<T0, T1>(arg3, arg2);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker::assert_role(arg2, 0x2::tx_context::sender(arg5), 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::roles::mm_role_treasury());
        assert!(0x2::balance::value<T1>(&arg3.quote_balance) >= arg4, 32);
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

