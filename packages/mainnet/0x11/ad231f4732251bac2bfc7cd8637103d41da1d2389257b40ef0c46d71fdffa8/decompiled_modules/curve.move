module 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        generation: u64,
    }

    struct GuardianCap has store, key {
        id: 0x2::object::UID,
        generation: u64,
    }

    struct QuoteParams has copy, drop, store {
        enabled: bool,
        decimals: u8,
        virtual_quote: u64,
        virtual_token: u64,
        curve_supply: u64,
        migration_fee: u64,
    }

    struct LaunchRules has copy, drop, store {
        taxless_base_to_protocol: bool,
        min_first_buy_ppm: u64,
        max_buyback_burn_bps: u64,
        min_vesting_ms: u64,
        max_vesting_ms: u64,
        min_creator_tax_bps: u64,
        snipe_tax_to_protocol: bool,
        max_koth_bps: u64,
        free_opening_buy: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused_until_ms: u64,
        fee_recipient: address,
        launch_fee: u64,
        base_fee_bps: u64,
        protocol_share_bps: u64,
        max_creator_tax_bps: u64,
        snipe_window_ms: u64,
        snipe_start_bps: u64,
        max_impact_bps: u64,
        vesting_ms: u64,
        cto_delay_ms: u64,
        cto_window_ms: u64,
        graduation_bounty: u64,
        keeper_generation: u64,
        keeper_caps_issued: u64,
        guardian_generation: u64,
        dividends_review_ms: u64,
        dividends_backlog_bps: u64,
        pending_changes: 0x2::vec_map::VecMap<u64, AdminChange>,
        next_change: u64,
        rules: 0x1::option::Option<LaunchRules>,
        identity_book: 0x1::option::Option<0x2::object::ID>,
        quotes: 0x2::vec_map::VecMap<0x1::ascii::String, QuoteParams>,
    }

    struct AdminChange has copy, drop, store {
        kind: u8,
        to: address,
        value: u64,
        ready_ms: u64,
    }

    struct CtoProposal has copy, drop, store {
        to: address,
        effective_ms: u64,
        expires_ms: u64,
    }

    struct Terms has copy, drop, store {
        quote_decimals: u8,
        base_fee_bps: u64,
        protocol_share_bps: u64,
        creator_tax_bps: u64,
        sell_tax_bps: u64,
        snipe_window_ms: u64,
        snipe_start_bps: u64,
        snipe_to_protocol: bool,
        max_impact_bps: u64,
        migration_fee: u64,
        cto_delay_ms: u64,
        cto_window_ms: u64,
        taxless: bool,
        alloc_creator: u64,
        alloc_buyback: u64,
        alloc_dividends: u64,
        alloc_liquidity: u64,
        buyback_burn_bps: u64,
        vesting_ms: u64,
        vest_to_holders: bool,
        koth_bps: u64,
        koth_vq: u64,
        koth_vt: u64,
    }

    struct Vest<phantom T0> has store {
        tokens: 0x2::balance::Balance<T0>,
        base: u64,
        sched: u64,
        start: u64,
        end: u64,
        released: u64,
    }

    struct PayoutSplit has copy, drop, store {
        to: vector<address>,
        bps: vector<u64>,
    }

    struct Curve<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        creator: address,
        fee_recipient: address,
        status: u8,
        quote_reserve: 0x2::balance::Balance<T1>,
        token_reserve: 0x2::balance::Balance<T0>,
        pool_tokens: 0x2::balance::Balance<T0>,
        virtual_quote: u64,
        virtual_token: u64,
        curve_left: u64,
        terms: Terms,
        kothed: bool,
        snipe_exempt: 0x2::vec_set::VecSet<address>,
        created_ms: u64,
        last_trade_ms: u64,
        graduated_ms: u64,
        buyback_quote: 0x2::balance::Balance<T1>,
        liquidity_quote: 0x2::balance::Balance<T1>,
        vest: Vest<T0>,
        burned: 0x2::balance::Balance<T0>,
        dividends: 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::Pool<T0, T1>,
        cto: 0x1::option::Option<CtoProposal>,
        last_contest_ms: 0x1::option::Option<u64>,
        recipient_changes: u64,
        pending_recipient: 0x1::option::Option<address>,
        split: 0x1::option::Option<PayoutSplit>,
        bounty: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct RoundKey has copy, drop, store {
        round: u64,
    }

    struct LaunchOptions has copy, drop {
        sell_tax_bps: u64,
        alloc_creator: u64,
        alloc_buyback: u64,
        alloc_dividends: u64,
        alloc_liquidity: u64,
        buyback_burn_bps: u64,
        vesting_ms: u64,
        vest_to_holders: bool,
        koth_bps: u64,
    }

    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        quote_type: 0x1::ascii::String,
        creator: address,
        fee_recipient: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
        snipe_exempt: vector<address>,
        terms: Terms,
        virtual_quote: u64,
        virtual_token: u64,
        curve_supply: u64,
        graduation_bounty: u64,
        timestamp_ms: u64,
    }

    struct Trade<phantom T0> has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        trader: address,
        is_buy: bool,
        quote_amount: u64,
        token_amount: u64,
        protocol_fee: u64,
        creator_fee: u64,
        buyback_fee: u64,
        snipe_tax: u64,
        virtual_quote: u64,
        virtual_token: u64,
        real_quote: u64,
        curve_left: u64,
        timestamp_ms: u64,
    }

    struct BountyPaid has copy, drop {
        curve_id: 0x2::object::ID,
        to: address,
        amount: u64,
    }

    struct BuybackLocked has copy, drop {
        curve_id: 0x2::object::ID,
        venue: u8,
        quote_spent: u64,
        tokens: u64,
        vest_start: u64,
        vest_end: u64,
    }

    struct BuybackBurned has copy, drop {
        curve_id: 0x2::object::ID,
        venue: u8,
        tokens: u64,
    }

    struct VestReleased has copy, drop {
        curve_id: 0x2::object::ID,
        fee_recipient: address,
        creator_amount: u64,
        protocol_amount: u64,
    }

    struct VestToHolders has copy, drop {
        curve_id: 0x2::object::ID,
        tokens: u64,
    }

    struct FeeRecipientChanged has copy, drop {
        curve_id: 0x2::object::ID,
        from: address,
        to: address,
        cto: bool,
    }

    struct FeeRecipientProposed has copy, drop {
        curve_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct PayoutSplitSet has copy, drop {
        curve_id: 0x2::object::ID,
        to: vector<address>,
        bps: vector<u64>,
    }

    struct CtoProposed has copy, drop {
        curve_id: 0x2::object::ID,
        to: address,
        effective_ms: u64,
        expires_ms: u64,
    }

    struct CtoCancelled has copy, drop {
        curve_id: 0x2::object::ID,
    }

    struct CtoContested has copy, drop {
        curve_id: 0x2::object::ID,
        by: address,
    }

    struct LaunchRulesSet has copy, drop {
        rules: LaunchRules,
    }

    struct AdminChangeProposed has copy, drop {
        id: u64,
        kind: u8,
        to: address,
        value: u64,
        ready_ms: u64,
    }

    struct AdminChangeExecuted has copy, drop {
        id: u64,
        kind: u8,
        to: address,
        value: u64,
    }

    struct FirstKeeperCapIssued has copy, drop {
        to: address,
        generation: u64,
    }

    struct AdminChangeCancelled has copy, drop {
        id: u64,
        kind: u8,
        guardian: bool,
    }

    struct AdminChangeExpired has copy, drop {
        id: u64,
        kind: u8,
    }

    struct PauseSet has copy, drop {
        paused: bool,
        paused_until_ms: u64,
    }

    struct LaneFeesPaid has copy, drop {
        curve_id: 0x2::object::ID,
        dividends: u64,
        liquidity: u64,
    }

    struct Kothed has copy, drop {
        curve_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct DividendsPosted has copy, drop {
        curve_id: 0x2::object::ID,
        round: u64,
        root: vector<u8>,
        leaves: u64,
        quote: u64,
        tokens: u64,
        ready_ms: u64,
        expires_ms: u64,
        period_start_ms: u64,
        period_end_ms: u64,
        generation: u64,
        max_quote: u64,
        max_tokens: u64,
        available_quote: u64,
        available_tokens: u64,
        credited_quote: u64,
        credited_tokens: u64,
    }

    struct DividendPaid has copy, drop {
        curve_id: 0x2::object::ID,
        round: u64,
        index: u64,
        holder: address,
        quote: u64,
        tokens: u64,
    }

    struct DividendsRoundEnded has copy, drop {
        curve_id: 0x2::object::ID,
        round: u64,
        cancelled: bool,
        guardian: bool,
        quote: u64,
        tokens: u64,
    }

    struct DividendsPeriodSkipped has copy, drop {
        curve_id: 0x2::object::ID,
        period_start_ms: u64,
        period_end_ms: u64,
    }

    struct DividendsBurned has copy, drop {
        curve_id: 0x2::object::ID,
        quote_spent: u64,
        tokens_bought: u64,
        dividend_tokens_burned: u64,
        quote_left: u64,
    }

    struct AmmGraduated<phantom T0> has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        quote_reserve: u64,
        token_reserve: u64,
        locked: u64,
        lane_quote: u64,
        lane_kept: u64,
        buyback_kept: u64,
        migration_fee: u64,
        final_virtual_quote: u64,
        final_virtual_token: u64,
        timestamp_ms: u64,
    }

    struct AmmLiquidityAdded has copy, drop {
        curve_id: 0x2::object::ID,
        quote_swapped: u64,
        tokens_bought: u64,
        quote_added: u64,
        tokens_added: u64,
        tokens_burned: u64,
        quote_donated: u64,
        quote_left: u64,
    }

    public fun total_supply() : u64 {
        1000000000000000
    }

    public fun decimals() : u8 {
        6
    }

    public fun accept_fee_recipient<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg0.pending_recipient == 0x1::option::some<address>(0x2::tx_context::sender(arg2)), 33);
        change_recipient<T0, T1>(arg0, 0x2::tx_context::sender(arg2), false);
    }

    public fun admin_change(arg0: &Config, arg1: u64) : (u8, address, u64, u64) {
        assert!(0x2::vec_map::contains<u64, AdminChange>(&arg0.pending_changes, &arg1), 47);
        let v0 = 0x2::vec_map::get<u64, AdminChange>(&arg0.pending_changes, &arg1);
        (v0.kind, v0.to, v0.value, v0.ready_ms)
    }

    public fun admin_execution_window_ms() : u64 {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::admin_execution_window_ms()
    }

    public fun admin_timelock_ms() : u64 {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::admin_timelock_ms()
    }

    fun amm_buy<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: address, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        assert!(v0 > 0, 5);
        let v1 = arg0.terms.creator_tax_bps;
        let (v2, v3) = amm_reserves<T0, T1>(arg0);
        let (v4, v5) = cp_buy_preview(v2, v3, v0, arg0.terms.base_fee_bps + v1);
        assert!(v4 > 0, 5);
        assert!(v4 >= arg3, 6);
        assert!(v4 < v3, 39);
        let v6 = v0 - v5;
        let v7 = mul_div_up(v0, v1, 10000);
        let v8 = 0x2::balance::split<T1>(&mut arg2, v6);
        0x2::balance::join<T1>(&mut arg0.quote_reserve, arg2);
        let v9 = 0x2::balance::split<T0>(&mut arg0.pool_tokens, v4);
        assert_k(v2, v3, v2 + v5, v3 - v4);
        let v10 = 0x2::balance::value<T1>(&arg0.liquidity_quote);
        let v11 = &mut v8;
        let (v12, v13, v14) = distribute<T0, T1>(arg0, v11, v6 - v7, 0, v7, arg1, arg4);
        0x2::balance::destroy_zero<T1>(v8);
        let v15 = 0x2::balance::value<T1>(&arg0.liquidity_quote) - v10;
        amm_lanes<T0, T1>(arg0, v14, v15, v12, arg4);
        amm_sync<T0, T1>(arg0);
        emit_trade<T0, T1>(arg0, true, v0, v4, v12, v13, v14, 0, arg4, arg5);
        v9
    }

    fun amm_buyback<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let (v0, v1) = amm_reserves<T0, T1>(arg0);
        let v2 = 0x1::u64::min(0x1::u64::min(0x2::balance::value<T1>(&arg0.buyback_quote), arg1), impact_cap(v0, arg0.terms.max_impact_bps));
        if (v2 == 0) {
            return 0
        };
        let v3 = cp_out(v2, v0, v1);
        if (v3 == 0 || v3 >= v1) {
            return 0
        };
        0x2::balance::join<T1>(&mut arg0.quote_reserve, 0x2::balance::split<T1>(&mut arg0.buyback_quote, v2));
        let v4 = 0x2::balance::split<T0>(&mut arg0.pool_tokens, v3);
        assert_k(v0, v1, v0 + v2, v1 - v3);
        lock_vest<T0, T1>(arg0, v4, v2, 2, arg2);
        v2
    }

    fun amm_lanes<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = arg3;
        let v1 = 0x2::balance::value<T1>(&arg0.buyback_quote);
        if (v1 > 0) {
            let v2 = amm_buyback<T0, T1>(arg0, arg1 + 0x1::u64::min(v1 - arg1, arg3), arg4);
            if (v2 > arg1) {
                v0 = arg3 - v2 - arg1;
            };
        };
        let v3 = 0x2::balance::value<T1>(&arg0.liquidity_quote);
        if (v3 > 0) {
            amm_zap<T0, T1>(arg0, arg2 + 0x1::u64::min(v3 - arg2, v0));
        };
    }

    public fun amm_reserves<T0, T1>(arg0: &Curve<T0, T1>) : (u64, u64) {
        if (arg0.status != 4) {
            return (0, 0)
        };
        (0x2::balance::value<T1>(&arg0.quote_reserve), 0x2::balance::value<T0>(&arg0.pool_tokens))
    }

    fun amm_sell<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: address, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0, 5);
        let (v1, v2) = amm_reserves<T0, T1>(arg0);
        let v3 = cp_out(v0, v2, v1);
        assert!(v3 < v1, 39);
        let (v4, v5) = amm_sell_fees(v3, arg0.terms.base_fee_bps, arg0.terms.sell_tax_bps);
        let v6 = v3 - v4 - v5;
        assert!(v6 > 0, 5);
        assert!(v6 >= arg3, 6);
        0x2::balance::join<T0>(&mut arg0.pool_tokens, arg2);
        let v7 = 0x2::balance::split<T1>(&mut arg0.quote_reserve, v3);
        assert_k(v1, v2, v1 - v3, v2 + v0);
        let v8 = 0x2::balance::split<T1>(&mut v7, v4 + v5);
        let v9 = 0x2::balance::value<T1>(&arg0.liquidity_quote);
        let v10 = &mut v8;
        let (v11, v12, v13) = distribute<T0, T1>(arg0, v10, v4, 0, v5, arg1, arg4);
        0x2::balance::destroy_zero<T1>(v8);
        let v14 = 0x2::balance::value<T1>(&arg0.liquidity_quote) - v9;
        amm_lanes<T0, T1>(arg0, v13, v14, v11, arg4);
        amm_sync<T0, T1>(arg0);
        emit_trade<T0, T1>(arg0, false, v6, v0, v11, v12, v13, 0, arg4, arg5);
        v7
    }

    fun amm_sell_fees(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = mul_div_up(arg0, arg1 + arg2, 10000);
        let v1 = 0x1::u64::min(mul_div_up(arg0, arg2, 10000), v0);
        (v0 - v1, v1)
    }

    fun amm_sync<T0, T1>(arg0: &mut Curve<T0, T1>) {
        let (v0, v1) = amm_reserves<T0, T1>(arg0);
        arg0.virtual_quote = v0;
        arg0.virtual_token = v1;
    }

    fun amm_zap<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let (v0, v1) = amm_reserves<T0, T1>(arg0);
        let v2 = (v0 as u256);
        let v3 = 0x1::u64::min(0x1::u64::min(((sqrt_u256(v2 * v2 + (arg1 as u256) * v2) - v2) as u64), arg1), impact_cap(v0, arg0.terms.max_impact_bps));
        let v4 = v3;
        let v5 = if (v3 == 0) {
            0
        } else {
            cp_out(v3, v0, v1)
        };
        let v6 = v5;
        if (v5 == 0 || v5 >= v1) {
            v4 = 0;
            v6 = 0;
        };
        let v7 = 0x2::balance::split<T1>(&mut arg0.liquidity_quote, arg1);
        0x2::balance::join<T1>(&mut arg0.quote_reserve, 0x2::balance::split<T1>(&mut v7, v4));
        let v8 = 0x2::balance::split<T0>(&mut arg0.pool_tokens, v6);
        let v9 = v0 + v4;
        let v10 = v1 - v6;
        assert_k(v0, v1, v9, v10);
        let v11 = arg1 - v4;
        let v12 = mul_div_sat(v11, v10, v9);
        let (v13, v14) = if (v12 <= v6) {
            (v11, v12)
        } else {
            (0x1::u64::min(mul_div_up(v6, v9, v10), v11), v6)
        };
        0x2::balance::join<T1>(&mut arg0.quote_reserve, 0x2::balance::split<T1>(&mut v7, v13));
        0x2::balance::join<T0>(&mut arg0.pool_tokens, 0x2::balance::split<T0>(&mut v8, v14));
        assert!((v13 as u256) * (v10 as u256) >= (v14 as u256) * (v9 as u256), 39);
        0x2::balance::join<T0>(&mut arg0.burned, v8);
        0x2::balance::join<T1>(&mut arg0.quote_reserve, v7);
        let v15 = AmmLiquidityAdded{
            curve_id      : 0x2::object::id<Curve<T0, T1>>(arg0),
            quote_swapped : v4,
            tokens_bought : v6,
            quote_added   : v13,
            tokens_added  : v14,
            tokens_burned : 0x2::balance::value<T0>(&v8),
            quote_donated : 0x2::balance::value<T1>(&v7),
            quote_left    : 0x2::balance::value<T1>(&arg0.liquidity_quote),
        };
        0x2::event::emit<AmmLiquidityAdded>(v15);
    }

    fun amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg2 as u128) * (arg0 as u128) / ((arg1 as u128) + (arg0 as u128))) as u64)
    }

    fun assert_backlog(arg0: u64) {
        assert!(arg0 >= 100 && arg0 <= 5000, 8);
    }

    public fun assert_curve_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = arg1 - arg2;
        let v1 = mul_div_up_u128((arg0 as u128), (arg2 as u128), (v0 as u128));
        assert!(v1 > 0 && v1 <= 4611686018427387903, 8);
        let v2 = (v1 as u64);
        assert!(arg3 <= v2 / 20, 8);
        let v3 = ((v2 - arg3) as u128) * (v0 as u128) / ((arg0 + v2) as u128);
        assert!(v3 > 0 && v3 * 1005 / 1000 <= ((1000000000000000 - arg2) as u128), 8);
    }

    fun assert_k(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg3 > 0 && arg2 > 0, 39);
        assert!((arg2 as u256) * (arg3 as u256) >= (arg0 as u256) * (arg1 as u256), 39);
    }

    public fun assert_keeper(arg0: &Config, arg1: &KeeperCap) {
        assert!(arg1.generation == arg0.keeper_generation, 25);
    }

    public fun assert_live(arg0: &Config, arg1: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(!is_paused(arg0, arg1), 1);
    }

    fun assert_review(arg0: u64) {
        assert!(arg0 >= 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::min_review_ms() && arg0 <= 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::max_review_ms(), 8);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public fun bounty<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.bounty)
    }

    public fun burn_idle_dividends<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: &0x2::clock::Clock) {
        assert_live(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::idle<T0, T1>(&arg0.dividends, v0, 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::dividends_idle_ms(), 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::fallback_interval_ms()), 44);
        assert!(arg0.last_trade_ms != v0, 50);
        let (v1, _) = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::available<T0, T1>(&arg0.dividends);
        let v3 = fallback_push_bps<T0, T1>(arg0);
        let (v4, v5) = if (arg0.status == 4) {
            let (v6, v7) = amm_reserves<T0, T1>(arg0);
            let v8 = 0x1::u64::min(v1, impact_cap(v6, v3));
            let v9 = if (v8 == 0) {
                0
            } else {
                cp_out(v8, v6, v7)
            };
            let (v10, v11) = if (v9 == 0 || v9 >= v7) {
                (0, 0)
            } else {
                (v8, v9)
            };
            (v11, v10)
        } else {
            let v12 = 0x1::u64::min(v1, mul_div(arg0.virtual_quote, v3, 2 * 10000 + v3));
            let v13 = if (v12 == 0) {
                0
            } else {
                amount_out(v12, arg0.virtual_quote, arg0.virtual_token)
            };
            let (v14, v15) = if (v13 == 0 || v13 >= arg0.curve_left) {
                (0, 0)
            } else {
                (v12, v13)
            };
            (v15, v14)
        };
        let (v16, v17) = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::take_idle<T0, T1>(&mut arg0.dividends, v5, v0);
        let v18 = v17;
        let v19 = 0x2::balance::value<T0>(&v18);
        assert!(v5 > 0 || v19 > 0, 45);
        0x2::balance::join<T0>(&mut arg0.burned, v18);
        if (v5 > 0) {
            0x2::balance::join<T1>(&mut arg0.quote_reserve, v16);
            let v20 = if (arg0.status == 4) {
                let v21 = arg0.virtual_quote;
                let v22 = arg0.virtual_token;
                let v23 = 0x2::balance::split<T0>(&mut arg0.pool_tokens, v4);
                assert_k(v21, v22, v21 + v5, v22 - v4);
                amm_sync<T0, T1>(arg0);
                v23
            } else {
                let v24 = curve_take<T0, T1>(arg0, v5, v4);
                check_koth<T0, T1>(arg0, v0);
                v24
            };
            0x2::balance::join<T0>(&mut arg0.burned, v20);
        } else {
            0x2::balance::destroy_zero<T1>(v16);
        };
        let (v25, _) = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::available<T0, T1>(&arg0.dividends);
        let v27 = DividendsBurned{
            curve_id               : 0x2::object::id<Curve<T0, T1>>(arg0),
            quote_spent            : v5,
            tokens_bought          : v4,
            dividend_tokens_burned : v19,
            quote_left             : v25,
        };
        0x2::event::emit<DividendsBurned>(v27);
    }

    public fun burned<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.burned)
    }

    public fun buy<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = buy_with_change<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = v1;
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
        v0
    }

    fun buy_internal<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: address, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        if (arg0.status == 4) {
            return (0x2::coin::from_balance<T0>(amm_buy<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(arg2), arg3, v0, arg6), arg6), 0x2::coin::zero<T1>(arg6))
        };
        assert!(arg0.status == 0, 2);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0, 5);
        let v2 = if (arg4) {
            0
        } else {
            effective_snipe_bps<T0, T1>(arg0, 0x2::tx_context::sender(arg6), v0)
        };
        let v3 = if (arg4) {
            0
        } else {
            arg0.terms.creator_tax_bps
        };
        let v4 = if (arg4) {
            0
        } else {
            arg0.terms.base_fee_bps + v3 + v2
        };
        let v5 = v1;
        let v6 = v1 - mul_div(v1, v4, 10000);
        let v7 = v6;
        let v8 = amount_out(v6, arg0.virtual_quote, arg0.virtual_token);
        let v9 = v8;
        let v10 = 0x2::coin::zero<T1>(arg6);
        if (v8 >= arg0.curve_left) {
            let v11 = arg0.curve_left;
            v9 = v11;
            let v12 = mul_div_up(mul_div_up(arg0.virtual_quote, v11, arg0.virtual_token - v11), 10000, 10000 - v4);
            v5 = v12;
            if (v12 > v1) {
                v5 = v1;
            };
            v7 = v5 - mul_div(v5, v4, 10000);
            0x2::coin::join<T1>(&mut v10, 0x2::coin::split<T1>(&mut arg2, v1 - v5, arg6));
        };
        assert!(v9 > 0, 5);
        let v13 = v5 - v7;
        let v14 = mul_div(v5, v3, 10000);
        let v15 = mul_div(v5, v2, 10000);
        let v16 = 0x2::coin::into_balance<T1>(arg2);
        let v17 = 0x2::balance::split<T1>(&mut v16, v13);
        0x2::balance::join<T1>(&mut arg0.quote_reserve, v16);
        let (v18, v19) = if (arg0.terms.snipe_to_protocol) {
            (v13 - v14 - v15, v15)
        } else {
            (v13 - v14 - v15 + v15, 0)
        };
        let v20 = &mut v17;
        let (v21, v22, v23) = distribute<T0, T1>(arg0, v20, v18, v19, v14, arg1, v0);
        0x2::balance::destroy_zero<T1>(v17);
        arg0.virtual_quote = arg0.virtual_quote + v7;
        arg0.virtual_token = arg0.virtual_token - v9;
        arg0.curve_left = arg0.curve_left - v9;
        let v24 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserve, v9), arg6);
        emit_trade<T0, T1>(arg0, true, v5, v9, v21, v22, v23, v15, v0, arg6);
        check_koth<T0, T1>(arg0, v0);
        if (arg0.curve_left > 0) {
            curve_buyback<T0, T1>(arg0, v23, v0);
        } else {
            graduate<T0, T1>(arg0, arg1, v0, arg6);
            let v25 = 0x2::coin::value<T1>(&v10);
            if (v25 > 0) {
                let (v26, v27) = amm_reserves<T0, T1>(arg0);
                let (v28, _) = cp_buy_preview(v26, v27, v25, arg0.terms.base_fee_bps + arg0.terms.creator_tax_bps);
                if (v28 > 0) {
                    0x2::coin::join<T0>(&mut v24, 0x2::coin::from_balance<T0>(amm_buy<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v10, v25, arg6)), 0, v0, arg6), arg6));
                };
            };
        };
        assert!((0x2::coin::value<T0>(&v24) as u128) * (v1 as u128) >= (arg3 as u128) * ((v1 - 0x2::coin::value<T1>(&v10)) as u128), 6);
        (v24, v10)
    }

    public fun buy_with_change<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_live(arg1, arg4);
        buy_internal<T0, T1>(arg0, arg1.fee_recipient, arg2, arg3, false, arg4, arg5)
    }

    public fun buyback_burn_bps<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.terms.buyback_burn_bps
    }

    public fun buyback_enabled<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.terms.alloc_buyback > 0
    }

    public fun buyback_pending<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.buyback_quote)
    }

    public fun cancel_admin_change(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        cancel_change(arg1, arg2, false);
    }

    fun cancel_change(arg0: &mut Config, arg1: u64, arg2: bool) {
        assert!(0x2::vec_map::contains<u64, AdminChange>(&arg0.pending_changes, &arg1), 47);
        let (_, v1) = 0x2::vec_map::remove<u64, AdminChange>(&mut arg0.pending_changes, &arg1);
        let v2 = v1;
        let v3 = AdminChangeCancelled{
            id       : arg1,
            kind     : v2.kind,
            guardian : arg2,
        };
        0x2::event::emit<AdminChangeCancelled>(v3);
    }

    public fun cancel_cto<T0, T1>(arg0: &AdminCap, arg1: &mut Curve<T0, T1>, arg2: &Config) {
        assert_version(arg2);
        assert!(0x1::option::is_some<CtoProposal>(&arg1.cto), 21);
        arg1.cto = 0x1::option::none<CtoProposal>();
        let v0 = CtoCancelled{curve_id: 0x2::object::id<Curve<T0, T1>>(arg1)};
        0x2::event::emit<CtoCancelled>(v0);
    }

    public fun cancel_dividends<T0, T1>(arg0: &AdminCap, arg1: &mut Curve<T0, T1>, arg2: &Config, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_version(arg2);
        end_round<T0, T1>(arg1, arg3, true, false, arg2.keeper_generation, 0x2::clock::timestamp_ms(arg4));
    }

    fun change_recipient<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: address, arg2: bool) {
        if (arg2) {
            arg0.last_contest_ms = 0x1::option::none<u64>();
        };
        arg0.recipient_changes = arg0.recipient_changes + 1;
        let v0 = FeeRecipientChanged{
            curve_id : 0x2::object::id<Curve<T0, T1>>(arg0),
            from     : arg0.fee_recipient,
            to       : arg1,
            cto      : arg2,
        };
        0x2::event::emit<FeeRecipientChanged>(v0);
        arg0.fee_recipient = arg1;
        if (0x1::option::is_some<PayoutSplit>(&arg0.split)) {
            arg0.split = 0x1::option::none<PayoutSplit>();
            let v1 = PayoutSplitSet{
                curve_id : 0x2::object::id<Curve<T0, T1>>(arg0),
                to       : vector[],
                bps      : vector[],
            };
            0x2::event::emit<PayoutSplitSet>(v1);
        };
        arg0.pending_recipient = 0x1::option::none<address>();
    }

    fun check_koth<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: u64) {
        let v0 = &arg0.terms;
        if (v0.koth_bps == 0 || arg0.kothed) {
            return
        };
        if ((arg0.virtual_quote as u256) * (v0.koth_vt as u256) * (10000 as u256) < (v0.koth_bps as u256) * (v0.koth_vq as u256) * (arg0.virtual_token as u256)) {
            return
        };
        arg0.kothed = true;
        let v1 = Kothed{
            curve_id     : 0x2::object::id<Curve<T0, T1>>(arg0),
            timestamp_ms : arg1,
        };
        0x2::event::emit<Kothed>(v1);
    }

    public(friend) fun claim_fee_recipient<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: address) {
        assert!(arg1 != @0x0, 18);
        change_recipient<T0, T1>(arg0, arg1, false);
    }

    public fun clear_expired_admin_change(arg0: &mut Config, arg1: u64, arg2: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(0x2::vec_map::contains<u64, AdminChange>(&arg0.pending_changes, &arg1), 47);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x2::vec_map::get<u64, AdminChange>(&arg0.pending_changes, &arg1).ready_ms + 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::admin_execution_window_ms(), 54);
        let (_, v1) = 0x2::vec_map::remove<u64, AdminChange>(&mut arg0.pending_changes, &arg1);
        let v2 = v1;
        let v3 = AdminChangeExpired{
            id   : arg1,
            kind : v2.kind,
        };
        0x2::event::emit<AdminChangeExpired>(v3);
    }

    public fun close_dividends<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        end_round<T0, T1>(arg0, arg2, false, false, arg1.keeper_generation, 0x2::clock::timestamp_ms(arg3));
    }

    public fun contest_cto<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.fee_recipient, 11);
        contest_cto_internal<T0, T1>(arg0, 0x2::tx_context::sender(arg3), 0x2::clock::timestamp_ms(arg2));
    }

    public(friend) fun contest_cto_internal<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: address, arg2: u64) {
        assert!(0x1::option::is_some<CtoProposal>(&arg0.cto), 21);
        if (0x1::option::is_some<u64>(&arg0.last_contest_ms)) {
            assert!(arg2 >= *0x1::option::borrow<u64>(&arg0.last_contest_ms) + 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::contest_cooldown_ms(), 35);
        };
        arg0.last_contest_ms = 0x1::option::some<u64>(arg2);
        arg0.cto = 0x1::option::none<CtoProposal>();
        let v0 = CtoContested{
            curve_id : 0x2::object::id<Curve<T0, T1>>(arg0),
            by       : arg1,
        };
        0x2::event::emit<CtoContested>(v0);
    }

    fun cp_buy_preview(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = arg2 - mul_div_up(arg2, arg3, 10000);
        (cp_out(v0, arg0, arg1), v0)
    }

    fun cp_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg2 as u256) * (arg0 as u256) / ((arg1 as u256) + (arg0 as u256))) as u64)
    }

    public fun created_ms<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.created_ms
    }

    public fun creator<T0, T1>(arg0: &Curve<T0, T1>) : address {
        arg0.creator
    }

    public fun creator_fee_recipient<T0, T1>(arg0: &Curve<T0, T1>) : address {
        arg0.fee_recipient
    }

    public fun creator_tax_bps<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.terms.creator_tax_bps
    }

    public fun cto<T0, T1>(arg0: &Curve<T0, T1>) : 0x1::option::Option<CtoProposal> {
        arg0.cto
    }

    public fun cto_info(arg0: &CtoProposal) : (address, u64, u64) {
        (arg0.to, arg0.effective_ms, arg0.expires_ms)
    }

    fun curve_buyback<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: u64, arg2: u64) {
        if (arg0.status != 0) {
            return
        };
        let v0 = 0x2::balance::value<T1>(&arg0.buyback_quote);
        if (v0 == 0 || arg1 == 0) {
            return
        };
        let v1 = 0x1::u64::min(0x1::u64::min(v0, arg1), curve_impact_cap<T0, T1>(arg0));
        let v2 = amount_out(v1, arg0.virtual_quote, arg0.virtual_token);
        if (v2 == 0 || v2 >= arg0.curve_left) {
            return
        };
        0x2::balance::join<T1>(&mut arg0.quote_reserve, 0x2::balance::split<T1>(&mut arg0.buyback_quote, v1));
        let v3 = curve_take<T0, T1>(arg0, v1, v2);
        lock_vest<T0, T1>(arg0, v3, v1, 0, arg2);
    }

    public fun curve_for_target(arg0: u64) : (u64, u64, u64) {
        let v0 = mul_div(arg0, 2, 5);
        (v0, 1000000000000000, mul_div(1000000000000000, arg0, v0 + arg0))
    }

    fun curve_impact_cap<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        mul_div(arg0.virtual_quote, arg0.terms.max_impact_bps, 2 * 10000 + arg0.terms.max_impact_bps)
    }

    public fun curve_left<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.curve_left
    }

    fun curve_take<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        arg0.virtual_quote = arg0.virtual_quote + arg1;
        arg0.virtual_token = arg0.virtual_token - arg2;
        arg0.curve_left = arg0.curve_left - arg2;
        0x2::balance::split<T0>(&mut arg0.token_reserve, arg2)
    }

    fun default_config(arg0: &mut 0x2::tx_context::TxContext) : Config {
        let (v0, v1, v2) = curve_for_target(5000000000000);
        assert_curve_params(v0, v1, v2, 0);
        let v3 = 0x2::vec_map::empty<0x1::ascii::String, QuoteParams>();
        let v4 = QuoteParams{
            enabled       : true,
            decimals      : 9,
            virtual_quote : v0,
            virtual_token : v1,
            curve_supply  : v2,
            migration_fee : 0,
        };
        0x2::vec_map::insert<0x1::ascii::String, QuoteParams>(&mut v3, type_key<0x2::sui::SUI>(), v4);
        Config{
            id                    : 0x2::object::new(arg0),
            version               : 1,
            paused_until_ms       : 0,
            fee_recipient         : 0x2::tx_context::sender(arg0),
            launch_fee            : 1000000000,
            base_fee_bps          : 100,
            protocol_share_bps    : 3000,
            max_creator_tax_bps   : 1000,
            snipe_window_ms       : 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::default_snipe_window_ms(),
            snipe_start_bps       : 9900,
            max_impact_bps        : 300,
            vesting_ms            : 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::default_vesting_ms(),
            cto_delay_ms          : 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::default_cto_delay_ms(),
            cto_window_ms         : 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::default_cto_window_ms(),
            graduation_bounty     : 50000000,
            keeper_generation     : 0,
            keeper_caps_issued    : 0,
            guardian_generation   : 0,
            dividends_review_ms   : 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::default_review_ms(),
            dividends_backlog_bps : 1000,
            pending_changes       : 0x2::vec_map::empty<u64, AdminChange>(),
            next_change           : 0,
            rules                 : 0x1::option::none<LaunchRules>(),
            identity_book         : 0x1::option::none<0x2::object::ID>(),
            quotes                : v3,
        }
    }

    fun distribute<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &mut 0x2::balance::Balance<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u64) : (u64, u64, u64) {
        if (arg0.terms.taxless) {
            let v0 = 0x2::balance::value<T1>(arg1);
            pay<T1>(0x2::balance::split<T1>(arg1, v0), arg5);
            return (v0, 0, 0)
        };
        let v1 = arg0.terms;
        let v2 = arg3 + mul_div(arg2, v1.protocol_share_bps, 10000);
        let v3 = arg2 + arg3 - v2 + arg4;
        let v4 = mul_div(v3, v1.alloc_buyback, 10000);
        let v5 = mul_div(v3, v1.alloc_dividends, 10000);
        let v6 = mul_div(v3, v1.alloc_liquidity, 10000);
        let v7 = v3 - v4 - v5 - v6;
        if (v5 > 0) {
            0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::deposit_quote<T0, T1>(&mut arg0.dividends, 0x2::balance::split<T1>(arg1, v5), arg6);
        };
        if (v6 > 0) {
            0x2::balance::join<T1>(&mut arg0.liquidity_quote, 0x2::balance::split<T1>(arg1, v6));
        };
        pay<T1>(0x2::balance::split<T1>(arg1, v2), arg5);
        0x2::balance::join<T1>(&mut arg0.buyback_quote, 0x2::balance::split<T1>(arg1, v4));
        pay_creator<T0, T1, T1>(arg0, 0x2::balance::split<T1>(arg1, v7));
        if (v5 > 0 || v6 > 0) {
            let v8 = LaneFeesPaid{
                curve_id  : 0x2::object::id<Curve<T0, T1>>(arg0),
                dividends : v5,
                liquidity : v6,
            };
            0x2::event::emit<LaneFeesPaid>(v8);
        };
        (v2, v7, v4)
    }

    public fun dividends_available<T0, T1>(arg0: &Curve<T0, T1>) : (u64, u64) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::available<T0, T1>(&arg0.dividends)
    }

    public fun dividends_backlog_bps(arg0: &Config) : u64 {
        arg0.dividends_backlog_bps
    }

    public fun dividends_idle<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64) : bool {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::idle<T0, T1>(&arg0.dividends, arg1, 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::dividends_idle_ms(), 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::fallback_interval_ms())
    }

    public fun dividends_idle_ms() : u64 {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::dividends_idle_ms()
    }

    public fun dividends_open_rounds<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::open_rounds<T0, T1>(&arg0.dividends)
    }

    public fun dividends_period_end<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::period_end_ms<T0, T1>(&arg0.dividends)
    }

    public fun dividends_postable<T0, T1>(arg0: &Curve<T0, T1>, arg1: &Config) : (u64, u64) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::postable<T0, T1>(&arg0.dividends, arg1.dividends_backlog_bps)
    }

    public fun dividends_review_ms(arg0: &Config) : u64 {
        arg0.dividends_review_ms
    }

    public fun dividends_round<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64) : &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::Round<T0, T1> {
        let v0 = RoundKey{round: arg1};
        assert!(0x2::dynamic_field::exists<RoundKey>(&arg0.id, v0), 36);
        0x2::dynamic_field::borrow<RoundKey, 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::Round<T0, T1>>(&arg0.id, v0)
    }

    public fun dividends_times<T0, T1>(arg0: &Curve<T0, T1>) : (0x1::option::Option<u64>, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::times<T0, T1>(&arg0.dividends)
    }

    public fun dividends_totals<T0, T1>(arg0: &Curve<T0, T1>) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2, v3) = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::totals<T0, T1>(&arg0.dividends);
        (v0, v1, v2, v3, 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::next_round<T0, T1>(&arg0.dividends))
    }

    fun effective_snipe_bps<T0, T1>(arg0: &Curve<T0, T1>, arg1: address, arg2: u64) : u64 {
        if (0x2::vec_set::contains<address>(&arg0.snipe_exempt, &arg1)) {
            return 0
        };
        0x1::u64::min(snipe_tax_bps<T0, T1>(arg0, arg2), 10000 - arg0.terms.base_fee_bps - arg0.terms.creator_tax_bps - 100)
    }

    fun emit_trade<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        arg0.last_trade_ms = arg8;
        let v0 = Trade<T0>{
            curve_id      : 0x2::object::id<Curve<T0, T1>>(arg0),
            coin_type     : type_key<T0>(),
            trader        : 0x2::tx_context::sender(arg9),
            is_buy        : arg1,
            quote_amount  : arg2,
            token_amount  : arg3,
            protocol_fee  : arg4,
            creator_fee   : arg5,
            buyback_fee   : arg6,
            snipe_tax     : arg7,
            virtual_quote : arg0.virtual_quote,
            virtual_token : arg0.virtual_token,
            real_quote    : 0x2::balance::value<T1>(&arg0.quote_reserve),
            curve_left    : arg0.curve_left,
            timestamp_ms  : arg8,
        };
        0x2::event::emit<Trade<T0>>(v0);
    }

    fun end_round<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: u64, arg2: bool, arg3: bool, arg4: u64, arg5: u64) {
        let v0 = RoundKey{round: arg1};
        assert!(0x2::dynamic_field::exists<RoundKey>(&arg0.id, v0), 36);
        let v1 = 0x2::dynamic_field::remove<RoundKey, 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::Round<T0, T1>>(&mut arg0.id, v0);
        let (_, _, v4, v5, _, _, _, _) = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::round_info<T0, T1>(&v1);
        let v10 = arg2 || 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::round_generation<T0, T1>(&v1) != arg4;
        if (arg3) {
            0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::cancel_in_review<T0, T1>(&mut arg0.dividends, v1, arg5);
        } else if (v10) {
            0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::cancel<T0, T1>(&mut arg0.dividends, v1, arg4, arg5);
        } else {
            0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::close<T0, T1>(&mut arg0.dividends, v1, arg4, arg5);
        };
        let v11 = DividendsRoundEnded{
            curve_id  : 0x2::object::id<Curve<T0, T1>>(arg0),
            round     : arg1,
            cancelled : v10,
            guardian  : arg3,
            quote     : v4,
            tokens    : v5,
        };
        0x2::event::emit<DividendsRoundEnded>(v11);
    }

    public fun execute_admin_change(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x2::vec_map::contains<u64, AdminChange>(&arg1.pending_changes, &arg2), 47);
        let v0 = 0x2::vec_map::get<u64, AdminChange>(&arg1.pending_changes, &arg2).ready_ms;
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= v0, 48);
        assert!(v1 < v0 + 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::admin_execution_window_ms(), 53);
        let (_, v3) = 0x2::vec_map::remove<u64, AdminChange>(&mut arg1.pending_changes, &arg2);
        let v4 = v3;
        if (v4.kind == 0) {
            arg1.keeper_caps_issued = arg1.keeper_caps_issued + 1;
            let v5 = KeeperCap{
                id         : 0x2::object::new(arg4),
                generation : arg1.keeper_generation,
            };
            0x2::transfer::public_transfer<KeeperCap>(v5, v4.to);
        } else if (v4.kind == 1) {
            arg1.guardian_generation = arg1.guardian_generation + 1;
        } else if (v4.kind == 2) {
            arg1.dividends_review_ms = v4.value;
        } else {
            arg1.dividends_backlog_bps = v4.value;
        };
        let v6 = AdminChangeExecuted{
            id    : arg2,
            kind  : v4.kind,
            to    : v4.to,
            value : v4.value,
        };
        0x2::event::emit<AdminChangeExecuted>(v6);
    }

    public fun execute_cto<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: &0x2::clock::Clock) {
        assert_version(arg1);
        assert!(0x1::option::is_some<CtoProposal>(&arg0.cto), 21);
        let v0 = 0x1::option::extract<CtoProposal>(&mut arg0.cto);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= v0.effective_ms, 22);
        assert!(v1 < v0.expires_ms, 23);
        change_recipient<T0, T1>(arg0, v0.to, true);
    }

    public fun fallback_interval_ms() : u64 {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::fallback_interval_ms()
    }

    fun fallback_push_bps<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x1::u64::min((arg0.terms.base_fee_bps + arg0.terms.sell_tax_bps) / 2, arg0.terms.max_impact_bps)
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    fun graduate<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0 && arg0.curve_left == 0, 2);
        arg0.status = 4;
        arg0.graduated_ms = arg2;
        let v0 = arg0.virtual_quote;
        let v1 = arg0.virtual_token;
        let v2 = 0x2::balance::value<T1>(&arg0.buyback_quote);
        let v3 = 0x2::balance::withdraw_all<T1>(&mut arg0.liquidity_quote);
        let (v4, v5, v6, v7) = graduation_split(0x2::balance::value<T1>(&arg0.quote_reserve), arg0.terms.migration_fee, 0x2::balance::value<T1>(&v3), 0x2::balance::value<T0>(&arg0.token_reserve), v0, v1);
        pay<T1>(0x2::balance::split<T1>(&mut arg0.quote_reserve, v4), arg1);
        0x2::balance::join<T1>(&mut arg0.quote_reserve, 0x2::balance::split<T1>(&mut v3, v5));
        0x2::balance::join<T1>(&mut arg0.liquidity_quote, v3);
        let v8 = if (0x2::balance::value<T1>(&arg0.quote_reserve) == v6) {
            if (v6 > 0) {
                v7 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 39);
        0x2::balance::join<T0>(&mut arg0.pool_tokens, 0x2::balance::split<T0>(&mut arg0.token_reserve, v7));
        amm_sync<T0, T1>(arg0);
        pay_bounty<T0, T1>(arg0, arg3);
        let v9 = AmmGraduated<T0>{
            curve_id            : 0x2::object::id<Curve<T0, T1>>(arg0),
            coin_type           : type_key<T0>(),
            quote_reserve       : v6,
            token_reserve       : v7,
            locked              : 0x2::balance::value<T0>(&arg0.token_reserve),
            lane_quote          : v5,
            lane_kept           : 0x2::balance::value<T1>(&v3),
            buyback_kept        : v2,
            migration_fee       : v4,
            final_virtual_quote : v0,
            final_virtual_token : v1,
            timestamp_ms        : arg2,
        };
        0x2::event::emit<AmmGraduated<T0>>(v9);
    }

    public fun graduated_ms<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.graduated_ms
    }

    public fun graduation_bounty(arg0: &Config) : u64 {
        arg0.graduation_bounty
    }

    fun graduation_split(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64, u64) {
        let v0 = 0x1::u64::min(arg1, arg0);
        let v1 = arg0 - v0;
        let v2 = mul_div_sat(arg3, arg4, arg5);
        let v3 = if (v2 > v1) {
            0x1::u64::min(arg2, v2 - v1)
        } else {
            0
        };
        let v4 = v1 + v3;
        (v0, v3, v4, 0x1::u64::min(mul_div_sat(v4, arg5, arg4), arg3))
    }

    public fun guardian_cancel_admin_change(arg0: &GuardianCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        assert!(arg0.generation == arg1.guardian_generation, 42);
        assert!(0x2::vec_map::contains<u64, AdminChange>(&arg1.pending_changes, &arg2), 47);
        assert!(0x2::vec_map::get<u64, AdminChange>(&arg1.pending_changes, &arg2).kind != 1, 52);
        cancel_change(arg1, arg2, true);
    }

    public fun guardian_cancel_dividends<T0, T1>(arg0: &GuardianCap, arg1: &mut Curve<T0, T1>, arg2: &Config, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_version(arg2);
        assert!(arg0.generation == arg2.guardian_generation, 42);
        end_round<T0, T1>(arg1, arg3, true, true, arg2.keeper_generation, 0x2::clock::timestamp_ms(arg4));
    }

    public fun guardian_cap_generation(arg0: &GuardianCap) : u64 {
        arg0.generation
    }

    public fun guardian_generation(arg0: &Config) : u64 {
        arg0.guardian_generation
    }

    public fun has_dividends_round<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64) : bool {
        let v0 = RoundKey{round: arg1};
        0x2::dynamic_field::exists<RoundKey>(&arg0.id, v0)
    }

    public fun identity_book(arg0: &Config) : 0x1::option::Option<0x2::object::ID> {
        arg0.identity_book
    }

    fun impact_cap(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, arg1, 2 * 10000 + arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Config>(default_config(arg0));
    }

    public fun is_amm<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.status == 4
    }

    public fun is_paused(arg0: &Config, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.paused_until_ms
    }

    public fun is_snipe_exempt<T0, T1>(arg0: &Curve<T0, T1>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.snipe_exempt, &arg1)
    }

    public fun is_taxless<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.terms.taxless
    }

    public fun is_trading<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.status == 0
    }

    public fun issue_first_keeper_cap(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg2 != @0x0, 18);
        assert!(arg1.keeper_caps_issued == 0 && arg1.keeper_generation == 0, 51);
        arg1.keeper_caps_issued = 1;
        let v0 = KeeperCap{
            id         : 0x2::object::new(arg3),
            generation : arg1.keeper_generation,
        };
        0x2::transfer::public_transfer<KeeperCap>(v0, arg2);
        let v1 = FirstKeeperCapIssued{
            to         : arg2,
            generation : arg1.keeper_generation,
        };
        0x2::event::emit<FirstKeeperCapIssued>(v1);
    }

    public fun issue_guardian_cap(arg0: &AdminCap, arg1: &Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = GuardianCap{
            id         : 0x2::object::new(arg3),
            generation : arg1.guardian_generation,
        };
        0x2::transfer::public_transfer<GuardianCap>(v0, arg2);
    }

    public fun keeper_cap_generation(arg0: &KeeperCap) : u64 {
        arg0.generation
    }

    public fun keeper_caps_issued(arg0: &Config) : u64 {
        arg0.keeper_caps_issued
    }

    public fun keeper_generation(arg0: &Config) : u64 {
        arg0.keeper_generation
    }

    public fun koth_bps<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.terms.koth_bps
    }

    public fun kothed<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.kothed
    }

    public fun lane_alloc<T0, T1>(arg0: &Curve<T0, T1>) : (u64, u64, u64, u64) {
        let v0 = &arg0.terms;
        (v0.alloc_creator, v0.alloc_buyback, v0.alloc_dividends, v0.alloc_liquidity)
    }

    public fun last_contest_ms<T0, T1>(arg0: &Curve<T0, T1>) : 0x1::option::Option<u64> {
        arg0.last_contest_ms
    }

    public fun last_trade_ms<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.last_trade_ms
    }

    public fun launch_fee(arg0: &Config) : u64 {
        arg0.launch_fee
    }

    public(friend) fun launch_options(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64) : LaunchOptions {
        LaunchOptions{
            sell_tax_bps     : arg0,
            alloc_creator    : arg1,
            alloc_buyback    : arg2,
            alloc_dividends  : arg3,
            alloc_liquidity  : arg4,
            buyback_burn_bps : arg5,
            vesting_ms       : arg6,
            vest_to_holders  : arg7,
            koth_bps         : arg8,
        }
    }

    public fun launch_rules(arg0: &Config) : LaunchRules {
        rules(arg0)
    }

    public fun liquidity_budget<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.liquidity_quote)
    }

    fun liquidity_slice<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0.terms.taxless) {
            return 0
        };
        mul_div(arg1 + arg2 - arg2 + mul_div(arg1, arg0.terms.protocol_share_bps, 10000) + arg3, arg0.terms.alloc_liquidity, 10000)
    }

    fun lock_vest<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u8, arg4: u64) {
        let v0 = mul_div(0x2::balance::value<T0>(&arg1), arg0.terms.buyback_burn_bps, 10000);
        if (v0 > 0) {
            0x2::balance::join<T0>(&mut arg0.burned, 0x2::balance::split<T0>(&mut arg1, v0));
            let v1 = BuybackBurned{
                curve_id : 0x2::object::id<Curve<T0, T1>>(arg0),
                venue    : arg3,
                tokens   : v0,
            };
            0x2::event::emit<BuybackBurned>(v1);
        };
        let v2 = 0x2::balance::value<T0>(&arg1);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            if (v0 > 0) {
                let v3 = BuybackLocked{
                    curve_id    : 0x2::object::id<Curve<T0, T1>>(arg0),
                    venue       : arg3,
                    quote_spent : arg2,
                    tokens      : 0,
                    vest_start  : arg0.vest.start,
                    vest_end    : arg0.vest.end,
                };
                0x2::event::emit<BuybackLocked>(v3);
            };
            return
        };
        0x2::balance::join<T0>(&mut arg0.vest.tokens, arg1);
        let v4 = &mut arg0.vest;
        let v5 = if (v4.sched == 0) {
            0
        } else if (arg4 >= v4.end) {
            v4.base = v4.base + v4.sched;
            0
        } else {
            let v6 = mul_div(v4.sched, arg4 - v4.start, v4.end - v4.start);
            v4.base = v4.base + v6;
            v4.sched - v6
        };
        let v7 = if (v5 == 0) {
            arg4 + arg0.terms.vesting_ms
        } else {
            let v8 = ((v5 + v2) as u128);
            arg4 + ((((v5 as u128) * ((v4.end - arg4) as u128) + (v2 as u128) * (arg0.terms.vesting_ms as u128) + v8 - 1) / v8) as u64)
        };
        v4.sched = v5 + v2;
        v4.start = arg4;
        v4.end = v7;
        let v9 = BuybackLocked{
            curve_id    : 0x2::object::id<Curve<T0, T1>>(arg0),
            venue       : arg3,
            quote_spent : arg2,
            tokens      : v2,
            vest_start  : arg4,
            vest_end    : v7,
        };
        0x2::event::emit<BuybackLocked>(v9);
    }

    public fun locked_tokens<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        if (arg0.status == 4) {
            0x2::balance::value<T0>(&arg0.token_reserve)
        } else {
            0
        }
    }

    public fun migrate_version(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun mul_div_sat(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    fun mul_div_up_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (arg0 * arg1 + arg2 - 1) / arg2
    }

    public(friend) fun new_curve<T0, T1>(arg0: &Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: address, arg4: u64, arg5: vector<address>, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0x2::coin::Coin<T1>, arg11: LaunchOptions, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (Curve<T0, T1>, 0x2::coin::Coin<T0>) {
        assert_live(arg0, arg12);
        let v0 = quote_params<T1>(arg0);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 3);
        let v1 = rules(arg0);
        let v2 = arg11.sell_tax_bps;
        assert!(arg4 <= arg0.max_creator_tax_bps && v2 <= arg0.max_creator_tax_bps, 7);
        assert!(arg4 == 0 || arg4 >= v1.min_creator_tax_bps, 30);
        assert!(v2 == 0 || v2 >= v1.min_creator_tax_bps, 30);
        let v3 = if (arg4 == 0) {
            if (v2 == 0) {
                v1.taxless_base_to_protocol
            } else {
                false
            }
        } else {
            false
        };
        let v4 = arg11.alloc_creator + arg11.alloc_buyback + arg11.alloc_dividends + arg11.alloc_liquidity;
        if (v3) {
            let v5 = if (v4 == 0) {
                if (!arg11.vest_to_holders) {
                    if (arg11.buyback_burn_bps == 0) {
                        arg11.vesting_ms == 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v5, 26);
        } else {
            assert!(v4 == 0 || v4 == 10000, 31);
        };
        let v6 = if (!v3 && v4 == 0) {
            10000
        } else {
            arg11.alloc_creator
        };
        assert!(arg11.buyback_burn_bps <= v1.max_buyback_burn_bps, 29);
        let v7 = if (arg11.vesting_ms == 0) {
            0x1::u64::min(0x1::u64::max(arg0.vesting_ms, v1.min_vesting_ms), v1.max_vesting_ms)
        } else {
            assert!(arg11.vesting_ms >= v1.min_vesting_ms && arg11.vesting_ms <= v1.max_vesting_ms, 29);
            arg11.vesting_ms
        };
        assert!(arg11.koth_bps <= v1.max_koth_bps, 32);
        assert!(0x1::vector::length<address>(&arg5) <= 32, 20);
        verify_currency<T0>(arg2, &arg1, arg13);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) >= arg0.launch_fee + arg0.graduation_bounty, 9);
        let v8 = if (0x1::string::length(&arg6) <= 256) {
            if (0x1::string::length(&arg7) <= 256) {
                0x1::string::length(&arg8) <= 256
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 19);
        let v9 = if (arg3 == @0x0) {
            0x2::tx_context::sender(arg13)
        } else {
            arg3
        };
        let v10 = v9;
        if (arg0.launch_fee > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg9, arg0.launch_fee, arg13), arg0.fee_recipient);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg9, 0x2::tx_context::sender(arg13));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg9);
        };
        0x2::coin_registry::make_supply_fixed<T0>(arg2, arg1);
        let v11 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v11, 0x2::tx_context::sender(arg13));
        if (!0x2::vec_set::contains<address>(&v11, &v10)) {
            0x2::vec_set::insert<address>(&mut v11, v10);
        };
        0x1::vector::reverse<address>(&mut arg5);
        let v12 = 0;
        while (v12 < 0x1::vector::length<address>(&arg5)) {
            let v13 = 0x1::vector::pop_back<address>(&mut arg5);
            if (!0x2::vec_set::contains<address>(&v11, &v13)) {
                0x2::vec_set::insert<address>(&mut v11, v13);
            };
            v12 = v12 + 1;
        };
        0x1::vector::destroy_empty<address>(arg5);
        let v14 = v0.virtual_token - v0.curve_supply;
        let v15 = Terms{
            quote_decimals     : v0.decimals,
            base_fee_bps       : arg0.base_fee_bps,
            protocol_share_bps : arg0.protocol_share_bps,
            creator_tax_bps    : arg4,
            sell_tax_bps       : v2,
            snipe_window_ms    : arg0.snipe_window_ms,
            snipe_start_bps    : arg0.snipe_start_bps,
            snipe_to_protocol  : v1.snipe_tax_to_protocol,
            max_impact_bps     : arg0.max_impact_bps,
            migration_fee      : v0.migration_fee,
            cto_delay_ms       : arg0.cto_delay_ms,
            cto_window_ms      : arg0.cto_window_ms,
            taxless            : v3,
            alloc_creator      : v6,
            alloc_buyback      : arg11.alloc_buyback,
            alloc_dividends    : arg11.alloc_dividends,
            alloc_liquidity    : arg11.alloc_liquidity,
            buyback_burn_bps   : arg11.buyback_burn_bps,
            vesting_ms         : v7,
            vest_to_holders    : arg11.vest_to_holders,
            koth_bps           : arg11.koth_bps,
            koth_vq            : mul_div_up(v0.virtual_quote, v0.virtual_token, v14),
            koth_vt            : v14,
        };
        let v16 = 0x2::clock::timestamp_ms(arg12);
        let v17 = Vest<T0>{
            tokens   : 0x2::balance::zero<T0>(),
            base     : 0,
            sched    : 0,
            start    : 0,
            end      : 0,
            released : 0,
        };
        let v18 = Curve<T0, T1>{
            id                : 0x2::object::new(arg13),
            creator           : 0x2::tx_context::sender(arg13),
            fee_recipient     : v10,
            status            : 0,
            quote_reserve     : 0x2::balance::zero<T1>(),
            token_reserve     : 0x2::coin::mint_balance<T0>(&mut arg1, 1000000000000000),
            pool_tokens       : 0x2::balance::zero<T0>(),
            virtual_quote     : v0.virtual_quote,
            virtual_token     : v0.virtual_token,
            curve_left        : v0.curve_supply,
            terms             : v15,
            kothed            : false,
            snipe_exempt      : v11,
            created_ms        : v16,
            last_trade_ms     : 0,
            graduated_ms      : 0,
            buyback_quote     : 0x2::balance::zero<T1>(),
            liquidity_quote   : 0x2::balance::zero<T1>(),
            vest              : v17,
            burned            : 0x2::balance::zero<T0>(),
            dividends         : 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::new<T0, T1>(v16),
            cto               : 0x1::option::none<CtoProposal>(),
            last_contest_ms   : 0x1::option::none<u64>(),
            recipient_changes : 0,
            pending_recipient : 0x1::option::none<address>(),
            split             : 0x1::option::none<PayoutSplit>(),
            bounty            : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg9, arg0.graduation_bounty, arg13)),
        };
        let v19 = CurveCreated{
            curve_id          : 0x2::object::id<Curve<T0, T1>>(&v18),
            coin_type         : type_key<T0>(),
            quote_type        : type_key<T1>(),
            creator           : 0x2::tx_context::sender(arg13),
            fee_recipient     : v10,
            name              : 0x2::coin_registry::name<T0>(arg2),
            symbol            : 0x2::coin_registry::symbol<T0>(arg2),
            description       : 0x2::coin_registry::description<T0>(arg2),
            icon_url          : 0x2::coin_registry::icon_url<T0>(arg2),
            twitter           : arg6,
            telegram          : arg7,
            website           : arg8,
            snipe_exempt      : 0x2::vec_set::into_keys<address>(v18.snipe_exempt),
            terms             : v15,
            virtual_quote     : v0.virtual_quote,
            virtual_token     : v0.virtual_token,
            curve_supply      : v0.curve_supply,
            graduation_bounty : arg0.graduation_bounty,
            timestamp_ms      : v16,
        };
        0x2::event::emit<CurveCreated>(v19);
        let v20 = if (0x2::coin::value<T1>(&arg10) > 0) {
            let v21 = v18.virtual_quote / 20;
            let v22 = 0x2::coin::value<T1>(&arg10);
            let v23 = if (v1.free_opening_buy && v22 > v21) {
                0x2::coin::split<T1>(&mut arg10, v22 - v21, arg13)
            } else {
                0x2::coin::zero<T1>(arg13)
            };
            let v24 = v23;
            let v25 = &mut v18;
            let (v26, v27) = buy_internal<T0, T1>(v25, arg0.fee_recipient, arg10, 0, v1.free_opening_buy, arg12, arg13);
            let v28 = v27;
            let v29 = v26;
            if (0x2::coin::value<T1>(&v28) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v28, 0x2::tx_context::sender(arg13));
            } else {
                0x2::coin::destroy_zero<T1>(v28);
            };
            if (0x2::coin::value<T1>(&v24) > 0) {
                let v30 = &mut v18;
                let (v31, v32) = buy_internal<T0, T1>(v30, arg0.fee_recipient, v24, 0, false, arg12, arg13);
                let v33 = v32;
                0x2::coin::join<T0>(&mut v29, v31);
                if (0x2::coin::value<T1>(&v33) > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v33, 0x2::tx_context::sender(arg13));
                } else {
                    0x2::coin::destroy_zero<T1>(v33);
                };
            } else {
                0x2::coin::destroy_zero<T1>(v24);
            };
            v29
        } else {
            0x2::coin::destroy_zero<T1>(arg10);
            0x2::coin::zero<T0>(arg13)
        };
        let v34 = v20;
        if (v1.min_first_buy_ppm > 0) {
            assert!(0x2::coin::value<T0>(&v34) >= mul_div(1000000000000000, v1.min_first_buy_ppm, 1000000), 28);
        };
        (v18, v34)
    }

    public fun package_version() : u64 {
        1
    }

    public fun pause_ms() : u64 {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::pause_ms()
    }

    public fun paused_until_ms(arg0: &Config) : u64 {
        arg0.paused_until_ms
    }

    fun pay<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, arg1);
        };
    }

    fun pay_bounty<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.bounty);
        if (v0 == 0) {
            return
        };
        let v1 = BountyPaid{
            curve_id : 0x2::object::id<Curve<T0, T1>>(arg0),
            to       : 0x2::tx_context::sender(arg1),
            amount   : v0,
        };
        0x2::event::emit<BountyPaid>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.bounty), arg1), 0x2::tx_context::sender(arg1));
    }

    fun pay_creator<T0, T1, T2>(arg0: &Curve<T0, T1>, arg1: 0x2::balance::Balance<T2>) {
        if (0x1::option::is_none<PayoutSplit>(&arg0.split)) {
            pay<T2>(arg1, arg0.fee_recipient);
            return
        };
        let v0 = 0x1::option::borrow<PayoutSplit>(&arg0.split);
        let v1 = 0x1::vector::length<address>(&v0.to);
        let v2 = 0;
        while (v2 + 1 < v1) {
            pay<T2>(0x2::balance::split<T2>(&mut arg1, mul_div(0x2::balance::value<T2>(&arg1), *0x1::vector::borrow<u64>(&v0.bps, v2), 10000)), *0x1::vector::borrow<address>(&v0.to, v2));
            v2 = v2 + 1;
        };
        pay<T2>(arg1, *0x1::vector::borrow<address>(&v0.to, v1 - 1));
    }

    public fun pay_dividends<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: u64, arg3: vector<u64>, arg4: vector<address>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<vector<vector<u8>>>, arg8: &0x2::clock::Clock) {
        assert_version(arg1);
        let v0 = 0x1::vector::length<u64>(&arg3);
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::assert_lengths(v0, 0x1::vector::length<address>(&arg4), 0x1::vector::length<u64>(&arg5), 0x1::vector::length<u64>(&arg6), 0x1::vector::length<vector<vector<u8>>>(&arg7));
        let v1 = 0x2::object::id<Curve<T0, T1>>(arg0);
        let v2 = RoundKey{round: arg2};
        assert!(0x2::dynamic_field::exists<RoundKey>(&arg0.id, v2), 36);
        let v3 = 0x2::dynamic_field::remove<RoundKey, 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::Round<T0, T1>>(&mut arg0.id, v2);
        let v4 = 0;
        while (v4 < v0) {
            if (!0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::round_paid<T0, T1>(&v3, *0x1::vector::borrow<u64>(&arg3, v4))) {
                let (v5, v6) = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::pay<T0, T1>(&mut arg0.dividends, &mut v3, 0x2::object::id_to_address(&v1), arg2, *0x1::vector::borrow<u64>(&arg3, v4), *0x1::vector::borrow<address>(&arg4, v4), *0x1::vector::borrow<u64>(&arg5, v4), *0x1::vector::borrow<u64>(&arg6, v4), 0x1::vector::borrow<vector<vector<u8>>>(&arg7, v4), arg1.keeper_generation, 0x2::clock::timestamp_ms(arg8));
                let v7 = DividendPaid{
                    curve_id : v1,
                    round    : arg2,
                    index    : *0x1::vector::borrow<u64>(&arg3, v4),
                    holder   : *0x1::vector::borrow<address>(&arg4, v4),
                    quote    : *0x1::vector::borrow<u64>(&arg5, v4),
                    tokens   : *0x1::vector::borrow<u64>(&arg6, v4),
                };
                0x2::event::emit<DividendPaid>(v7);
                pay<T1>(v5, *0x1::vector::borrow<address>(&arg4, v4));
                pay<T0>(v6, *0x1::vector::borrow<address>(&arg4, v4));
            };
            v4 = v4 + 1;
        };
        0x2::dynamic_field::add<RoundKey, 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::Round<T0, T1>>(&mut arg0.id, v2, v3);
    }

    public fun payout_split<T0, T1>(arg0: &Curve<T0, T1>) : (vector<address>, vector<u64>) {
        if (0x1::option::is_none<PayoutSplit>(&arg0.split)) {
            return (vector[], vector[])
        };
        let v0 = 0x1::option::borrow<PayoutSplit>(&arg0.split);
        (v0.to, v0.bps)
    }

    public fun pending_admin_changes(arg0: &Config) : vector<u64> {
        0x2::vec_map::keys<u64, AdminChange>(&arg0.pending_changes)
    }

    public fun pending_fee_recipient<T0, T1>(arg0: &Curve<T0, T1>) : 0x1::option::Option<address> {
        arg0.pending_recipient
    }

    public fun post_dividends<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: &KeeperCap, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) {
        assert_live(arg1, arg9);
        assert_keeper(arg1, arg2);
        let (v0, v1) = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::available<T0, T1>(&arg0.dividends);
        let (v2, v3) = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::postable<T0, T1>(&arg0.dividends, arg1.dividends_backlog_bps);
        let (v4, v5) = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::post<T0, T1>(&mut arg0.dividends, arg3, arg4, arg5, arg6, arg1.dividends_review_ms, arg1.dividends_backlog_bps, arg1.keeper_generation, arg7, arg8, 0x2::clock::timestamp_ms(arg9));
        let v6 = v5;
        let (_, _, _, _, _, _, v13, v14) = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::round_info<T0, T1>(&v6);
        let (v15, v16, _, _) = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::totals<T0, T1>(&arg0.dividends);
        let v19 = RoundKey{round: v4};
        0x2::dynamic_field::add<RoundKey, 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::Round<T0, T1>>(&mut arg0.id, v19, v6);
        let v20 = DividendsPosted{
            curve_id         : 0x2::object::id<Curve<T0, T1>>(arg0),
            round            : v4,
            root             : arg3,
            leaves           : arg4,
            quote            : arg5,
            tokens           : arg6,
            ready_ms         : v13,
            expires_ms       : v14,
            period_start_ms  : arg7,
            period_end_ms    : arg8,
            generation       : arg1.keeper_generation,
            max_quote        : v2,
            max_tokens       : v3,
            available_quote  : v0,
            available_tokens : v1,
            credited_quote   : v15,
            credited_tokens  : v16,
        };
        0x2::event::emit<DividendsPosted>(v20);
    }

    fun propose(arg0: &mut Config, arg1: u8, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        assert_version(arg0);
        assert!(0x2::vec_map::length<u64, AdminChange>(&arg0.pending_changes) < 16, 49);
        let v0 = arg0.next_change;
        arg0.next_change = v0 + 1;
        let v1 = 0x2::clock::timestamp_ms(arg4) + 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::admin_timelock_ms();
        let v2 = AdminChange{
            kind     : arg1,
            to       : arg2,
            value    : arg3,
            ready_ms : v1,
        };
        0x2::vec_map::insert<u64, AdminChange>(&mut arg0.pending_changes, v0, v2);
        let v3 = AdminChangeProposed{
            id       : v0,
            kind     : arg1,
            to       : arg2,
            value    : arg3,
            ready_ms : v1,
        };
        0x2::event::emit<AdminChangeProposed>(v3);
        v0
    }

    public fun propose_cto<T0, T1>(arg0: &AdminCap, arg1: &mut Curve<T0, T1>, arg2: &Config, arg3: address, arg4: &0x2::clock::Clock) {
        assert_version(arg2);
        assert!(arg3 != @0x0, 18);
        assert!(0x1::option::is_none<CtoProposal>(&arg1.cto), 24);
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg1.terms.cto_delay_ms;
        let v1 = v0 + arg1.terms.cto_window_ms;
        let v2 = CtoProposal{
            to           : arg3,
            effective_ms : v0,
            expires_ms   : v1,
        };
        arg1.cto = 0x1::option::some<CtoProposal>(v2);
        let v3 = CtoProposed{
            curve_id     : 0x2::object::id<Curve<T0, T1>>(arg1),
            to           : arg3,
            effective_ms : v0,
            expires_ms   : v1,
        };
        0x2::event::emit<CtoProposed>(v3);
    }

    public fun propose_dividends_backlog(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        assert_backlog(arg2);
        propose(arg1, 3, @0x0, arg2, arg3)
    }

    public fun propose_dividends_review(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        assert_review(arg2);
        propose(arg1, 2, @0x0, arg2, arg3)
    }

    public fun propose_fee_recipient<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.fee_recipient, 11);
        assert!(arg2 != @0x0, 18);
        arg0.pending_recipient = 0x1::option::some<address>(arg2);
        let v0 = FeeRecipientProposed{
            curve_id : 0x2::object::id<Curve<T0, T1>>(arg0),
            from     : arg0.fee_recipient,
            to       : arg2,
        };
        0x2::event::emit<FeeRecipientProposed>(v0);
    }

    public fun propose_issue_keeper_cap(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        assert!(arg2 != @0x0, 18);
        propose(arg1, 0, arg2, 0, arg3)
    }

    public fun propose_rotate_guardians(arg0: &AdminCap, arg1: &mut Config, arg2: &0x2::clock::Clock) : u64 {
        propose(arg1, 1, @0x0, 0, arg2)
    }

    public fun quote_buy<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        let v0 = arg0.terms.base_fee_bps + arg0.terms.creator_tax_bps;
        if (arg0.status == 4) {
            let (v1, v2) = amm_reserves<T0, T1>(arg0);
            let (v3, _) = cp_buy_preview(v1, v2, arg1, v0);
            return v3
        };
        if (arg0.status != 0) {
            return 0
        };
        let v5 = effective_snipe_bps<T0, T1>(arg0, arg2, 0x2::clock::timestamp_ms(arg3));
        let v6 = v0 + v5;
        let v7 = amount_out(arg1 - mul_div(arg1, v6, 10000), arg0.virtual_quote, arg0.virtual_token);
        if (v7 < arg0.curve_left) {
            return v7
        };
        let v8 = arg0.curve_left;
        let v9 = mul_div_up(mul_div_up(arg0.virtual_quote, v8, arg0.virtual_token - v8), 10000, 10000 - v6);
        let v10 = v9;
        if (v9 > arg1) {
            v10 = arg1;
        };
        let v11 = v10 - mul_div(v10, v6, 10000);
        let v12 = arg1 - v10;
        if (v12 == 0) {
            return v8
        };
        let v13 = mul_div(v10, arg0.terms.creator_tax_bps, 10000);
        let v14 = mul_div(v10, v5, 10000);
        let (v15, v16) = if (arg0.terms.snipe_to_protocol) {
            (v10 - v11 - v13 - v14, v14)
        } else {
            (v10 - v11 - v13 - v14 + v14, 0)
        };
        let (_, _, v19, v20) = graduation_split(0x2::balance::value<T1>(&arg0.quote_reserve) + v11, arg0.terms.migration_fee, 0x2::balance::value<T1>(&arg0.liquidity_quote) + liquidity_slice<T0, T1>(arg0, v15, v16, v13), 0x2::balance::value<T0>(&arg0.token_reserve) - v8, arg0.virtual_quote + v11, arg0.virtual_token - v8);
        let (v21, _) = cp_buy_preview(v19, v20, v12, v0);
        v8 + v21
    }

    public fun quote_params<T0>(arg0: &Config) : QuoteParams {
        let v0 = type_key<T0>();
        assert!(0x2::vec_map::contains<0x1::ascii::String, QuoteParams>(&arg0.quotes, &v0), 12);
        let v1 = *0x2::vec_map::get<0x1::ascii::String, QuoteParams>(&arg0.quotes, &v0);
        assert!(v1.enabled, 12);
        v1
    }

    public fun quote_sell<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64) : u64 {
        if (arg0.status == 4) {
            let (v0, v1) = amm_reserves<T0, T1>(arg0);
            let v2 = cp_out(arg1, v1, v0);
            if (v2 >= v0) {
                return 0
            };
            let (v3, v4) = amm_sell_fees(v2, arg0.terms.base_fee_bps, arg0.terms.sell_tax_bps);
            return v2 - v3 - v4
        };
        if (arg0.status != 0) {
            return 0
        };
        let v5 = amount_out(arg1, arg0.virtual_token, arg0.virtual_quote);
        if (v5 > 0x2::balance::value<T1>(&arg0.quote_reserve)) {
            return 0
        };
        v5 - mul_div(v5, arg0.terms.base_fee_bps, 10000) - mul_div(v5, arg0.terms.sell_tax_bps, 10000)
    }

    public fun real_quote<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_reserve)
    }

    public fun recipient_changes<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.recipient_changes
    }

    public(friend) fun redirect_fee_recipient<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: address) {
        assert!(arg1 != @0x0, 18);
        if (0x1::option::is_some<CtoProposal>(&arg0.cto)) {
            arg0.cto = 0x1::option::none<CtoProposal>();
            let v0 = CtoCancelled{curve_id: 0x2::object::id<Curve<T0, T1>>(arg0)};
            0x2::event::emit<CtoCancelled>(v0);
        };
        change_recipient<T0, T1>(arg0, arg1, false);
    }

    public(friend) fun register_identity_book(arg0: &mut Config, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.identity_book), 8);
        arg0.identity_book = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun releasable<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64) : u64 {
        let v0 = vested_amount<T0, T1>(arg0, arg1);
        if (v0 > arg0.vest.released) {
            v0 - arg0.vest.released
        } else {
            0
        }
    }

    public fun release_vested<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: &0x2::clock::Clock) {
        assert_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = releasable<T0, T1>(arg0, v0);
        if (v1 == 0) {
            return
        };
        arg0.vest.released = arg0.vest.released + v1;
        let v2 = 0x2::balance::split<T0>(&mut arg0.vest.tokens, v1);
        let v3 = mul_div(v1, arg0.terms.protocol_share_bps, 10000);
        pay<T0>(0x2::balance::split<T0>(&mut v2, v3), arg1.fee_recipient);
        let v4 = 0x2::balance::value<T0>(&v2);
        if (arg0.terms.vest_to_holders) {
            0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::deposit_tokens<T0, T1>(&mut arg0.dividends, v2, v0);
            let v5 = VestToHolders{
                curve_id : 0x2::object::id<Curve<T0, T1>>(arg0),
                tokens   : v4,
            };
            0x2::event::emit<VestToHolders>(v5);
        } else {
            pay_creator<T0, T1, T0>(arg0, v2);
        };
        let v6 = VestReleased{
            curve_id        : 0x2::object::id<Curve<T0, T1>>(arg0),
            fee_recipient   : arg0.fee_recipient,
            creator_amount  : v4,
            protocol_amount : v3,
        };
        0x2::event::emit<VestReleased>(v6);
    }

    public fun rotate_keepers(arg0: &AdminCap, arg1: &mut Config) {
        assert_version(arg1);
        arg1.keeper_generation = arg1.keeper_generation + 1;
    }

    fun rules(arg0: &Config) : LaunchRules {
        if (0x1::option::is_some<LaunchRules>(&arg0.rules)) {
            return *0x1::option::borrow<LaunchRules>(&arg0.rules)
        };
        LaunchRules{
            taxless_base_to_protocol : false,
            min_first_buy_ppm        : 0,
            max_buyback_burn_bps     : 0,
            min_vesting_ms           : arg0.vesting_ms,
            max_vesting_ms           : arg0.vesting_ms,
            min_creator_tax_bps      : 0,
            snipe_tax_to_protocol    : false,
            max_koth_bps             : 0,
            free_opening_buy         : false,
        }
    }

    public fun rules_free_opening_buy(arg0: &LaunchRules) : bool {
        arg0.free_opening_buy
    }

    public fun rules_max_buyback_burn_bps(arg0: &LaunchRules) : u64 {
        arg0.max_buyback_burn_bps
    }

    public fun rules_max_koth_bps(arg0: &LaunchRules) : u64 {
        arg0.max_koth_bps
    }

    public fun rules_min_creator_tax_bps(arg0: &LaunchRules) : u64 {
        arg0.min_creator_tax_bps
    }

    public fun rules_min_first_buy_ppm(arg0: &LaunchRules) : u64 {
        arg0.min_first_buy_ppm
    }

    public fun rules_snipe_tax_to_protocol(arg0: &LaunchRules) : bool {
        arg0.snipe_tax_to_protocol
    }

    public fun rules_taxless(arg0: &LaunchRules) : bool {
        arg0.taxless_base_to_protocol
    }

    public fun rules_vesting_bounds(arg0: &LaunchRules) : (u64, u64) {
        (arg0.min_vesting_ms, arg0.max_vesting_ms)
    }

    public fun sell<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (arg0.status == 4) {
            return 0x2::coin::from_balance<T1>(amm_sell<T0, T1>(arg0, arg1.fee_recipient, 0x2::coin::into_balance<T0>(arg2), arg3, v0, arg5), arg5)
        };
        assert!(arg0.status == 0, 2);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 5);
        let v2 = amount_out(v1, arg0.virtual_token, arg0.virtual_quote);
        assert!(v2 <= 0x2::balance::value<T1>(&arg0.quote_reserve), 16);
        let v3 = mul_div(v2, arg0.terms.base_fee_bps, 10000);
        let v4 = mul_div(v2, arg0.terms.sell_tax_bps, 10000);
        let v5 = v2 - v3 - v4;
        assert!(v5 > 0, 5);
        assert!(v5 >= arg3, 6);
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg2));
        arg0.virtual_quote = arg0.virtual_quote - v2;
        arg0.virtual_token = arg0.virtual_token + v1;
        arg0.curve_left = arg0.curve_left + v1;
        let v6 = 0x2::balance::split<T1>(&mut arg0.quote_reserve, v2);
        let v7 = 0x2::balance::split<T1>(&mut v6, v3 + v4);
        let v8 = &mut v7;
        let (v9, v10, v11) = distribute<T0, T1>(arg0, v8, v3, 0, v4, arg1.fee_recipient, v0);
        0x2::balance::destroy_zero<T1>(v7);
        emit_trade<T0, T1>(arg0, false, v5, v1, v9, v10, v11, 0, v0, arg5);
        curve_buyback<T0, T1>(arg0, v11, v0);
        0x2::coin::from_balance<T1>(v6, arg5)
    }

    public fun sell_tax_bps<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.terms.sell_tax_bps
    }

    public fun set_creator_fee_recipient<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.fee_recipient, 11);
        assert!(arg2 != @0x0, 18);
        change_recipient<T0, T1>(arg0, arg2, false);
    }

    public fun set_dividends_backlog(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        assert_backlog(arg2);
        assert!(arg2 <= arg1.dividends_backlog_bps, 46);
        arg1.dividends_backlog_bps = arg2;
    }

    public fun set_dividends_review(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        assert_review(arg2);
        assert!(arg2 >= arg1.dividends_review_ms, 46);
        arg1.dividends_review_ms = arg2;
    }

    public fun set_fee_policy(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert_version(arg1);
        assert!(arg2 <= 10000000000, 8);
        assert!(arg3 <= 500 && arg5 <= 1000, 8);
        assert!(arg4 <= 10000, 8);
        assert!(arg3 + arg5 + 100 <= 10000, 8);
        arg1.launch_fee = arg2;
        arg1.base_fee_bps = arg3;
        arg1.protocol_share_bps = arg4;
        arg1.max_creator_tax_bps = arg5;
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert_version(arg1);
        assert!(arg2 != @0x0, 18);
        arg1.fee_recipient = arg2;
    }

    public fun set_graduation_bounty(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 <= 1000000000, 8);
        arg1.graduation_bounty = arg2;
    }

    public fun set_launch_rules(arg0: &AdminCap, arg1: &mut Config, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: bool) {
        assert_version(arg1);
        let v0 = if (arg3 == 0) {
            true
        } else if (arg3 == 1) {
            true
        } else if (arg3 == 10) {
            true
        } else {
            arg3 == 100
        };
        assert!(v0, 8);
        assert!(arg4 <= 10000, 8);
        let v1 = if (arg5 >= 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::min_vesting_ms()) {
            if (arg5 <= arg6) {
                arg6 <= 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::max_vesting_ms()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 8);
        assert!(arg7 <= arg1.max_creator_tax_bps, 8);
        assert!(arg9 < 10000, 8);
        let v2 = LaunchRules{
            taxless_base_to_protocol : arg2,
            min_first_buy_ppm        : arg3,
            max_buyback_burn_bps     : arg4,
            min_vesting_ms           : arg5,
            max_vesting_ms           : arg6,
            min_creator_tax_bps      : arg7,
            snipe_tax_to_protocol    : arg8,
            max_koth_bps             : arg9,
            free_opening_buy         : arg10,
        };
        arg1.rules = 0x1::option::some<LaunchRules>(v2);
        let v3 = LaunchRulesSet{rules: v2};
        0x2::event::emit<LaunchRulesSet>(v3);
    }

    public fun set_launch_terms(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert_version(arg1);
        assert!(arg2 <= 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::max_snipe_window_ms() && arg3 <= 9900, 8);
        assert!(arg2 > 0 || arg3 == 0, 8);
        assert!(arg4 > 0 && arg4 <= 1000, 8);
        assert!(arg5 >= 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::min_vesting_ms() && arg5 <= 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::max_vesting_ms(), 8);
        assert!(arg6 >= 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::min_cto_delay_ms() && arg6 <= 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::max_cto_ms(), 8);
        assert!(arg7 >= 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::min_cto_window_ms() && arg7 <= 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::max_cto_ms(), 8);
        arg1.snipe_window_ms = arg2;
        arg1.snipe_start_bps = arg3;
        arg1.max_impact_bps = arg4;
        arg1.vesting_ms = arg5;
        arg1.cto_delay_ms = arg6;
        arg1.cto_window_ms = arg7;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        let v0 = if (arg2) {
            0x2::clock::timestamp_ms(arg3) + 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::pause_ms()
        } else {
            0
        };
        arg1.paused_until_ms = v0;
        let v1 = PauseSet{
            paused          : arg2,
            paused_until_ms : arg1.paused_until_ms,
        };
        0x2::event::emit<PauseSet>(v1);
    }

    public fun set_payout_split<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.fee_recipient, 11);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3) && v0 <= 8, 34);
        if (v0 > 0) {
            let v1 = 0x2::vec_set::empty<address>();
            let v2 = 0;
            let v3 = 0;
            while (v3 < v0) {
                let v4 = if (*0x1::vector::borrow<address>(&arg2, v3) != @0x0) {
                    if (*0x1::vector::borrow<u64>(&arg3, v3) > 0) {
                        !0x2::vec_set::contains<address>(&v1, 0x1::vector::borrow<address>(&arg2, v3))
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v4, 34);
                0x2::vec_set::insert<address>(&mut v1, *0x1::vector::borrow<address>(&arg2, v3));
                v2 = v2 + *0x1::vector::borrow<u64>(&arg3, v3);
                v3 = v3 + 1;
            };
            assert!(v2 == 10000, 34);
            let v5 = PayoutSplit{
                to  : arg2,
                bps : arg3,
            };
            arg0.split = 0x1::option::some<PayoutSplit>(v5);
        } else {
            arg0.split = 0x1::option::none<PayoutSplit>();
        };
        let v6 = PayoutSplitSet{
            curve_id : 0x2::object::id<Curve<T0, T1>>(arg0),
            to       : arg2,
            bps      : arg3,
        };
        0x2::event::emit<PayoutSplitSet>(v6);
    }

    public fun set_quote<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool) {
        assert_version(arg1);
        assert!(arg2 <= 18, 8);
        assert!(arg3 > 0 && arg5 > 0, 8);
        let v0 = if (arg4 > arg5) {
            if (arg5 < 1000000000000000) {
                arg4 <= 1000000000000000 * 2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8);
        assert_curve_params(arg3, arg4, arg5, arg6);
        let v1 = type_key<T0>();
        let v2 = QuoteParams{
            enabled       : arg7,
            decimals      : arg2,
            virtual_quote : arg3,
            virtual_token : arg4,
            curve_supply  : arg5,
            migration_fee : arg6,
        };
        if (0x2::vec_map::contains<0x1::ascii::String, QuoteParams>(&arg1.quotes, &v1)) {
            *0x2::vec_map::get_mut<0x1::ascii::String, QuoteParams>(&mut arg1.quotes, &v1) = v2;
        } else {
            0x2::vec_map::insert<0x1::ascii::String, QuoteParams>(&mut arg1.quotes, v1, v2);
        };
    }

    public(friend) fun share<T0, T1>(arg0: Curve<T0, T1>) {
        0x2::transfer::share_object<Curve<T0, T1>>(arg0);
    }

    public fun skip_dividends_period<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: &KeeperCap, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_version(arg1);
        assert_keeper(arg1, arg2);
        let v0 = DividendsPeriodSkipped{
            curve_id        : 0x2::object::id<Curve<T0, T1>>(arg0),
            period_start_ms : 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends::skip_period<T0, T1>(&mut arg0.dividends, arg3, arg1.dividends_backlog_bps, 0x2::clock::timestamp_ms(arg4)),
            period_end_ms   : arg3,
        };
        0x2::event::emit<DividendsPeriodSkipped>(v0);
    }

    public fun snipe_tax_bps<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64) : u64 {
        let v0 = if (arg1 > arg0.created_ms) {
            arg1 - arg0.created_ms
        } else {
            0
        };
        if (v0 >= arg0.terms.snipe_window_ms || arg0.terms.snipe_start_bps == 0) {
            return 0
        };
        let v1 = vector[10000, 5025, 2525, 875, 303, 160, 80, 40, 20, 10, 0];
        let v2 = (v0 as u128) * 10;
        let v3 = (arg0.terms.snipe_window_ms as u128);
        let v4 = ((v2 / v3) as u64);
        let v5 = (*0x1::vector::borrow<u64>(&v1, v4) as u128);
        (((arg0.terms.snipe_start_bps as u128) * (v5 - (v5 - (*0x1::vector::borrow<u64>(&v1, v4 + 1) as u128)) * v2 % v3 / v3) / (10000 as u128)) as u64)
    }

    public fun snipe_to_protocol<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.terms.snipe_to_protocol
    }

    fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 0;
        while (arg0 > 0) {
            arg0 = arg0 >> 1;
            v0 = v0 + 1;
        };
        let v1 = 1 << (((v0 + 1) / 2) as u8);
        loop {
            let v2 = v1 + arg0 / v1 >> 1;
            if (v2 >= v1) {
                break
            };
            v1 = v2;
        };
        v1
    }

    public fun status<T0, T1>(arg0: &Curve<T0, T1>) : u8 {
        arg0.status
    }

    public fun terms<T0, T1>(arg0: &Curve<T0, T1>) : Terms {
        arg0.terms
    }

    public fun token_reserve<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.token_reserve)
    }

    public(friend) fun type_key<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    public(friend) fun uid<T0, T1>(arg0: &Curve<T0, T1>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut<T0, T1>(arg0: &mut Curve<T0, T1>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun verify_currency<T0>(arg0: &mut 0x2::coin_registry::Currency<T0>, arg1: &0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin_registry::decimals<T0>(arg0) == 6, 4);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(arg1)), 17);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg0), 13);
        assert!(0x2::coin_registry::is_metadata_cap_deleted<T0>(arg0), 14);
        let (v0, v1) = 0x2::coin_registry::borrow_legacy_metadata<T0>(arg0, arg2);
        0x2::coin_registry::return_borrowed_legacy_metadata<T0>(arg0, v0, v1, arg2);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    public fun vest_locked<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.vest.tokens)
    }

    public fun vest_released<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.vest.released
    }

    public fun vest_schedule<T0, T1>(arg0: &Curve<T0, T1>) : (u64, u64, u64, u64) {
        (arg0.vest.base, arg0.vest.sched, arg0.vest.start, arg0.vest.end)
    }

    public fun vest_to_holders_enabled<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.terms.vest_to_holders
    }

    public fun vested_amount<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64) : u64 {
        let v0 = &arg0.vest;
        if (v0.sched == 0) {
            return v0.base
        };
        if (arg1 >= v0.end) {
            return v0.base + v0.sched
        };
        let v1 = if (arg1 > v0.start) {
            arg1 - v0.start
        } else {
            0
        };
        v0.base + mul_div(v0.sched, v1, v0.end - v0.start)
    }

    public fun vesting_ms<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.terms.vesting_ms
    }

    public fun virtual_reserves<T0, T1>(arg0: &Curve<T0, T1>) : (u64, u64) {
        (arg0.virtual_quote, arg0.virtual_token)
    }

    // decompiled from Move bytecode v7
}

