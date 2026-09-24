module 0x5bb7750b5bd6bdd7babb22a8e38aa4789cf4624f7e87e9ca53802c72e33141ef::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BrakeCap has store, key {
        id: 0x2::object::UID,
    }

    struct Params has copy, drop, store {
        graduation_sui: u64,
        trade_fee_bps: u64,
        creator_bps: u64,
        platform_bps: u64,
        season_bps: u64,
        liquidity_bps: u64,
        referral_bps: u64,
        graduation_creator_bps: u64,
        graduation_platform_bps: u64,
        launch_fee: u64,
        max_dev_buy_bps: u64,
        snipe_min_ms: u64,
        snipe_max_ms: u64,
        snipe_start_fee_bps: u64,
        snipe_tx_cap_bps: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        params: Params,
        pending: 0x1::option::Option<Params>,
        pending_ready_ms: u64,
        sell_only: bool,
        version: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        platform: 0x2::balance::Balance<0x2::sui::SUI>,
        season: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ParamsProposed has copy, drop {
        params: Params,
        ready_ms: u64,
    }

    struct ParamsApplied has copy, drop {
        params: Params,
    }

    struct SellOnlyChanged has copy, drop {
        enabled: bool,
        reason: vector<u8>,
    }

    struct PlatformWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct Migrated has copy, drop {
        from: u64,
        to: u64,
    }

    struct ParamsCancelled has copy, drop {
        params: Params,
    }

    struct BrakeCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct RevokedBrakeKey has copy, drop, store {
        cap_id: 0x2::object::ID,
    }

    struct QuoteKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PendingQuoteKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct QuoteParams has copy, drop, store {
        enabled: bool,
        graduation: u64,
        launch_fee: u64,
    }

    struct PendingQuote has copy, drop, store {
        params: QuoteParams,
        ready_ms: u64,
    }

    struct QuoteProposed has copy, drop {
        quote: 0x1::ascii::String,
        params: QuoteParams,
        ready_ms: u64,
    }

    struct QuoteApplied has copy, drop {
        quote: 0x1::ascii::String,
        params: QuoteParams,
    }

    struct QuoteCancelled has copy, drop {
        quote: 0x1::ascii::String,
        params: QuoteParams,
    }

    struct QuoteBucketsKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct QuoteBuckets<phantom T0> has store {
        platform: 0x2::balance::Balance<T0>,
        season: 0x2::balance::Balance<T0>,
    }

    struct QuotePlatformWithdrawn has copy, drop {
        quote: 0x1::ascii::String,
        amount: u64,
        recipient: address,
    }

    struct SeasonConversion<phantom T0> {
        amount: u64,
        min_sui: u64,
    }

    struct SeasonConverted has copy, drop {
        quote: 0x1::ascii::String,
        amount: u64,
        sui: u64,
    }

    public fun apply_params(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(0x1::option::is_some<Params>(&arg0.pending), 101);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.pending_ready_ms, 102);
        let v0 = 0x1::option::extract<Params>(&mut arg0.pending);
        arg0.params = v0;
        let v1 = ParamsApplied{params: v0};
        0x2::event::emit<ParamsApplied>(v1);
    }

    public fun apply_quote<T0>(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert_version(arg0);
        let v0 = PendingQuoteKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<PendingQuoteKey<T0>, PendingQuote>(&arg0.id, v0), 101);
        let v1 = PendingQuoteKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::remove<PendingQuoteKey<T0>, PendingQuote>(&mut arg0.id, v1);
        assert!(0x2::clock::timestamp_ms(arg1) >= v2.ready_ms, 102);
        let v3 = v2.params;
        let v4 = QuoteKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<QuoteKey<T0>, QuoteParams>(&arg0.id, v4)) {
            let v5 = QuoteKey<T0>{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<QuoteKey<T0>, QuoteParams>(&mut arg0.id, v5) = v3;
        } else {
            let v6 = QuoteKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<QuoteKey<T0>, QuoteParams>(&mut arg0.id, v6, v3);
        };
        let v7 = QuoteApplied{
            quote  : quote_name<T0>(),
            params : v3,
        };
        0x2::event::emit<QuoteApplied>(v7);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 3, 104);
    }

    fun buckets_mut<T0>(arg0: &mut Treasury) : &mut QuoteBuckets<T0> {
        let v0 = QuoteBucketsKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<QuoteBucketsKey<T0>, QuoteBuckets<T0>>(&arg0.id, v0)) {
            let v1 = QuoteBucketsKey<T0>{dummy_field: false};
            let v2 = QuoteBuckets<T0>{
                platform : 0x2::balance::zero<T0>(),
                season   : 0x2::balance::zero<T0>(),
            };
            0x2::dynamic_field::add<QuoteBucketsKey<T0>, QuoteBuckets<T0>>(&mut arg0.id, v1, v2);
        };
        let v3 = QuoteBucketsKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<QuoteBucketsKey<T0>, QuoteBuckets<T0>>(&mut arg0.id, v3)
    }

    public fun cancel_params(arg0: &AdminCap, arg1: &mut Config) {
        assert_version(arg1);
        assert!(0x1::option::is_some<Params>(&arg1.pending), 101);
        let v0 = ParamsCancelled{params: 0x1::option::extract<Params>(&mut arg1.pending)};
        0x2::event::emit<ParamsCancelled>(v0);
    }

    public fun cancel_quote<T0>(arg0: &AdminCap, arg1: &mut Config) {
        assert_version(arg1);
        let v0 = PendingQuoteKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<PendingQuoteKey<T0>, PendingQuote>(&arg1.id, v0), 101);
        let v1 = PendingQuoteKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::remove<PendingQuoteKey<T0>, PendingQuote>(&mut arg1.id, v1);
        let v3 = QuoteCancelled{
            quote  : quote_name<T0>(),
            params : v2.params,
        };
        0x2::event::emit<QuoteCancelled>(v3);
    }

    fun check_bounds(arg0: &Params) {
        assert!(arg0.graduation_sui >= 10000000000 && arg0.graduation_sui <= 60000000000000, 100);
        assert!(arg0.trade_fee_bps <= 200, 100);
        assert!(arg0.creator_bps + arg0.platform_bps + arg0.season_bps + arg0.liquidity_bps == arg0.trade_fee_bps, 103);
        let v0 = if (arg0.referral_bps % 2 == 0) {
            if (arg0.referral_bps / 2 <= arg0.platform_bps) {
                arg0.referral_bps / 2 <= arg0.season_bps
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 103);
        assert!(arg0.platform_bps * 10 <= arg0.trade_fee_bps * 7, 100);
        assert!(arg0.graduation_creator_bps + arg0.graduation_platform_bps <= 500, 100);
        assert!(arg0.launch_fee <= 10000000000, 100);
        assert!(arg0.max_dev_buy_bps <= 1000, 100);
        let v1 = if (arg0.snipe_min_ms > 0) {
            if (arg0.snipe_min_ms <= arg0.snipe_max_ms) {
                arg0.snipe_max_ms <= 120000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 100);
        assert!(arg0.snipe_start_fee_bps >= arg0.trade_fee_bps && arg0.snipe_start_fee_bps < 10000, 100);
        assert!(arg0.snipe_tx_cap_bps > 0 && arg0.snipe_tx_cap_bps <= 1000, 100);
    }

    fun check_quote_bounds(arg0: &QuoteParams) {
        assert!(arg0.graduation >= 1000000 && arg0.graduation <= 1000000000000, 100);
        assert!(arg0.launch_fee * 1000 <= arg0.graduation, 100);
    }

    public fun conversion_amount<T0>(arg0: &SeasonConversion<T0>) : u64 {
        arg0.amount
    }

    public fun conversion_min_sui<T0>(arg0: &SeasonConversion<T0>) : u64 {
        arg0.min_sui
    }

    public fun creator_bps(arg0: &Params) : u64 {
        arg0.creator_bps
    }

    public fun default_params() : Params {
        Params{
            graduation_sui          : 10 * 1000000000,
            trade_fee_bps           : 100,
            creator_bps             : 50,
            platform_bps            : 30,
            season_bps              : 10,
            liquidity_bps           : 10,
            referral_bps            : 10,
            graduation_creator_bps  : 60,
            graduation_platform_bps : 40,
            launch_fee              : 1000000000 / 10,
            max_dev_buy_bps         : 1000,
            snipe_min_ms            : 15000,
            snipe_max_ms            : 60000,
            snipe_start_fee_bps     : 9900,
            snipe_tx_cap_bps        : 100,
        }
    }

    public(friend) fun deposit_platform(arg0: &mut Treasury, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform, arg1);
    }

    public(friend) fun deposit_quote_platform<T0>(arg0: &mut Treasury, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut buckets_mut<T0>(arg0).platform, arg1);
    }

    public(friend) fun deposit_quote_season<T0>(arg0: &mut Treasury, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut buckets_mut<T0>(arg0).season, arg1);
    }

    public(friend) fun deposit_season(arg0: &mut Treasury, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.season, arg1);
    }

    public fun disable_sell_only(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        assert_version(arg1);
        arg1.sell_only = false;
        let v0 = SellOnlyChanged{
            enabled : false,
            reason  : arg2,
        };
        0x2::event::emit<SellOnlyChanged>(v0);
    }

    public fun donate_quote_season<T0>(arg0: &Config, arg1: &mut Treasury, arg2: 0x2::coin::Coin<T0>) {
        assert_version(arg0);
        assert!(has_quote<T0>(arg0), 108);
        0x2::balance::join<T0>(&mut buckets_mut<T0>(arg1).season, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun donate_season(arg0: &Config, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_version(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.season, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public(friend) fun donate_season_balance(arg0: &mut Treasury, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.season, arg1);
    }

    public fun enable_sell_only(arg0: &BrakeCap, arg1: &mut Config, arg2: vector<u8>) {
        assert_version(arg1);
        assert!(!is_brake_revoked(arg1, 0x2::object::id<BrakeCap>(arg0)), 106);
        arg1.sell_only = true;
        let v0 = SellOnlyChanged{
            enabled : true,
            reason  : arg2,
        };
        0x2::event::emit<SellOnlyChanged>(v0);
    }

    public fun finish_season_conversion<T0>(arg0: &Config, arg1: &mut Treasury, arg2: SeasonConversion<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_version(arg0);
        let SeasonConversion {
            amount  : v0,
            min_sui : v1,
        } = arg2;
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v2 >= v1, 109);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.season, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v3 = SeasonConverted{
            quote  : quote_name<T0>(),
            amount : v0,
            sui    : v2,
        };
        0x2::event::emit<SeasonConverted>(v3);
    }

    public fun graduation_creator_bps(arg0: &Params) : u64 {
        arg0.graduation_creator_bps
    }

    public fun graduation_platform_bps(arg0: &Params) : u64 {
        arg0.graduation_platform_bps
    }

    public fun graduation_sui(arg0: &Params) : u64 {
        arg0.graduation_sui
    }

    public fun has_quote<T0>(arg0: &Config) : bool {
        let v0 = QuoteKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<QuoteKey<T0>, QuoteParams>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = default_params();
        check_bounds(&v0);
        let v1 = Config{
            id               : 0x2::object::new(arg0),
            params           : v0,
            pending          : 0x1::option::none<Params>(),
            pending_ready_ms : 0,
            sell_only        : false,
            version          : 3,
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = Treasury{
            id       : 0x2::object::new(arg0),
            platform : 0x2::balance::zero<0x2::sui::SUI>(),
            season   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun is_brake_revoked(arg0: &Config, arg1: 0x2::object::ID) : bool {
        let v0 = RevokedBrakeKey{cap_id: arg1};
        0x2::dynamic_field::exists_<RevokedBrakeKey>(&arg0.id, v0)
    }

    public fun is_sell_only(arg0: &Config) : bool {
        arg0.sell_only
    }

    public fun launch_fee(arg0: &Params) : u64 {
        arg0.launch_fee
    }

    public fun liquidity_bps(arg0: &Params) : u64 {
        arg0.liquidity_bps
    }

    public fun max_dev_buy_bps(arg0: &Params) : u64 {
        arg0.max_dev_buy_bps
    }

    public fun max_graduation_sui() : u64 {
        60000000000000
    }

    public fun max_quote_graduation() : u64 {
        1000000000000
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 3, 105);
        let v0 = Migrated{
            from : arg1.version,
            to   : 3,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 3;
    }

    public fun min_quote_graduation() : u64 {
        1000000
    }

    public fun mint_brake_cap(arg0: &AdminCap, arg1: &Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = BrakeCap{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<BrakeCap>(v0, arg2);
    }

    public fun new_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64) : Params {
        let v0 = Params{
            graduation_sui          : arg0,
            trade_fee_bps           : arg1,
            creator_bps             : arg2,
            platform_bps            : arg3,
            season_bps              : arg4,
            liquidity_bps           : arg5,
            referral_bps            : arg6,
            graduation_creator_bps  : arg7,
            graduation_platform_bps : arg8,
            launch_fee              : arg9,
            max_dev_buy_bps         : arg10,
            snipe_min_ms            : arg11,
            snipe_max_ms            : arg12,
            snipe_start_fee_bps     : arg13,
            snipe_tx_cap_bps        : arg14,
        };
        check_bounds(&v0);
        v0
    }

    public fun new_quote_params(arg0: bool, arg1: u64, arg2: u64) : QuoteParams {
        let v0 = QuoteParams{
            enabled    : arg0,
            graduation : arg1,
            launch_fee : arg2,
        };
        check_quote_bounds(&v0);
        v0
    }

    public fun package_version() : u64 {
        3
    }

    public fun params(arg0: &Config) : Params {
        arg0.params
    }

    public fun pending_quote<T0>(arg0: &Config) : 0x1::option::Option<PendingQuote> {
        let v0 = PendingQuoteKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<PendingQuoteKey<T0>, PendingQuote>(&arg0.id, v0)) {
            return 0x1::option::none<PendingQuote>()
        };
        let v1 = PendingQuoteKey<T0>{dummy_field: false};
        0x1::option::some<PendingQuote>(*0x2::dynamic_field::borrow<PendingQuoteKey<T0>, PendingQuote>(&arg0.id, v1))
    }

    public fun pending_quote_params(arg0: &PendingQuote) : QuoteParams {
        arg0.params
    }

    public fun pending_quote_ready_ms(arg0: &PendingQuote) : u64 {
        arg0.ready_ms
    }

    public fun platform_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.platform)
    }

    public fun platform_bps(arg0: &Params) : u64 {
        arg0.platform_bps
    }

    public fun propose_params(arg0: &AdminCap, arg1: &mut Config, arg2: Params, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        check_bounds(&arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 600000;
        arg1.pending = 0x1::option::some<Params>(arg2);
        arg1.pending_ready_ms = v0;
        let v1 = ParamsProposed{
            params   : arg2,
            ready_ms : v0,
        };
        0x2::event::emit<ParamsProposed>(v1);
    }

    public fun propose_quote<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: QuoteParams, arg3: &0x2::clock::Clock) {
        assert_version(arg1);
        check_quote_bounds(&arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 600000;
        let v1 = PendingQuote{
            params   : arg2,
            ready_ms : v0,
        };
        let v2 = PendingQuoteKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<PendingQuoteKey<T0>, PendingQuote>(&arg1.id, v2)) {
            let v3 = PendingQuoteKey<T0>{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<PendingQuoteKey<T0>, PendingQuote>(&mut arg1.id, v3) = v1;
        } else {
            let v4 = PendingQuoteKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<PendingQuoteKey<T0>, PendingQuote>(&mut arg1.id, v4, v1);
        };
        let v5 = QuoteProposed{
            quote    : quote_name<T0>(),
            params   : arg2,
            ready_ms : v0,
        };
        0x2::event::emit<QuoteProposed>(v5);
    }

    public fun quote_enabled(arg0: &QuoteParams) : bool {
        arg0.enabled
    }

    public fun quote_graduation(arg0: &QuoteParams) : u64 {
        arg0.graduation
    }

    public fun quote_launch_fee(arg0: &QuoteParams) : u64 {
        arg0.launch_fee
    }

    fun quote_name<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    public fun quote_params<T0>(arg0: &Config) : QuoteParams {
        assert!(has_quote<T0>(arg0), 108);
        let v0 = QuoteKey<T0>{dummy_field: false};
        *0x2::dynamic_field::borrow<QuoteKey<T0>, QuoteParams>(&arg0.id, v0)
    }

    public fun quote_platform_balance<T0>(arg0: &Treasury) : u64 {
        let v0 = QuoteBucketsKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<QuoteBucketsKey<T0>, QuoteBuckets<T0>>(&arg0.id, v0)) {
            return 0
        };
        let v1 = QuoteBucketsKey<T0>{dummy_field: false};
        0x2::balance::value<T0>(&0x2::dynamic_field::borrow<QuoteBucketsKey<T0>, QuoteBuckets<T0>>(&arg0.id, v1).platform)
    }

    public fun quote_season_balance<T0>(arg0: &Treasury) : u64 {
        let v0 = QuoteBucketsKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<QuoteBucketsKey<T0>, QuoteBuckets<T0>>(&arg0.id, v0)) {
            return 0
        };
        let v1 = QuoteBucketsKey<T0>{dummy_field: false};
        0x2::balance::value<T0>(&0x2::dynamic_field::borrow<QuoteBucketsKey<T0>, QuoteBuckets<T0>>(&arg0.id, v1).season)
    }

    public fun referral_bps(arg0: &Params) : u64 {
        arg0.referral_bps
    }

    public fun revoke_brake_cap(arg0: &AdminCap, arg1: &mut Config, arg2: 0x2::object::ID) {
        assert_version(arg1);
        assert!(!is_brake_revoked(arg1, arg2), 107);
        let v0 = RevokedBrakeKey{cap_id: arg2};
        0x2::dynamic_field::add<RevokedBrakeKey, bool>(&mut arg1.id, v0, true);
        let v1 = BrakeCapRevoked{cap_id: arg2};
        0x2::event::emit<BrakeCapRevoked>(v1);
    }

    public fun season_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.season)
    }

    public fun season_bps(arg0: &Params) : u64 {
        arg0.season_bps
    }

    public fun snipe_max_ms(arg0: &Params) : u64 {
        arg0.snipe_max_ms
    }

    public fun snipe_min_ms(arg0: &Params) : u64 {
        arg0.snipe_min_ms
    }

    public fun snipe_start_fee_bps(arg0: &Params) : u64 {
        arg0.snipe_start_fee_bps
    }

    public fun snipe_tx_cap_bps(arg0: &Params) : u64 {
        arg0.snipe_tx_cap_bps
    }

    public fun start_season_conversion<T0>(arg0: &AdminCap, arg1: &Config, arg2: &mut Treasury, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SeasonConversion<T0>) {
        assert_version(arg1);
        assert!(arg3 > 0 && arg4 > 0, 100);
        let v0 = SeasonConversion<T0>{
            amount  : arg3,
            min_sui : arg4,
        };
        (0x2::coin::take<T0>(&mut buckets_mut<T0>(arg2).season, arg3, arg5), v0)
    }

    public(friend) fun take_season(arg0: &mut Treasury, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.season, arg1)
    }

    public fun trade_fee_bps(arg0: &Params) : u64 {
        arg0.trade_fee_bps
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    public(friend) fun with_graduation_sui(arg0: Params, arg1: u64) : Params {
        arg0.graduation_sui = arg1;
        check_bounds(&arg0);
        arg0
    }

    public fun withdraw_platform(arg0: &AdminCap, arg1: &Config, arg2: &mut Treasury, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg2.platform, arg3, arg5), arg4);
        let v0 = PlatformWithdrawn{
            amount    : arg3,
            recipient : arg4,
        };
        0x2::event::emit<PlatformWithdrawn>(v0);
    }

    public fun withdraw_quote_platform<T0>(arg0: &AdminCap, arg1: &Config, arg2: &mut Treasury, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut buckets_mut<T0>(arg2).platform, arg3, arg5), arg4);
        let v0 = QuotePlatformWithdrawn{
            quote     : quote_name<T0>(),
            amount    : arg3,
            recipient : arg4,
        };
        0x2::event::emit<QuotePlatformWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

