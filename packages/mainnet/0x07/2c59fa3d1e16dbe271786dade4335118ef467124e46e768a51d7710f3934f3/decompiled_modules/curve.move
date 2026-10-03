module 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
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
        lock_pool: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        fee_recipient: address,
        launch_fee: u64,
        base_fee_bps: u64,
        protocol_share_bps: u64,
        buyback_share_bps: u64,
        max_creator_tax_bps: u64,
        snipe_window_ms: u64,
        snipe_start_bps: u64,
        max_impact_bps: u64,
        vesting_ms: u64,
        cto_delay_ms: u64,
        cto_window_ms: u64,
        refund_delay_ms: u64,
        graduation_bounty: u64,
        keeper_generation: u64,
        quotes: 0x2::vec_map::VecMap<0x1::ascii::String, QuoteParams>,
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
        buyback_share_bps: u64,
        creator_tax_bps: u64,
        snipe_window_ms: u64,
        snipe_start_bps: u64,
        max_impact_bps: u64,
        vesting_ms: u64,
        migration_fee: u64,
        refund_delay_ms: u64,
        cto_delay_ms: u64,
        cto_window_ms: u64,
    }

    struct Vest<phantom T0> has store {
        tokens: 0x2::balance::Balance<T0>,
        base: u64,
        sched: u64,
        start: u64,
        released: u64,
    }

    struct Curve<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        creator: address,
        fee_recipient: address,
        status: u8,
        quote_reserve: 0x2::balance::Balance<T1>,
        token_reserve: 0x2::balance::Balance<T0>,
        virtual_quote: u64,
        virtual_token: u64,
        curve_left: u64,
        terms: Terms,
        snipe_exempt: 0x2::vec_set::VecSet<address>,
        created_ms: u64,
        completed_ms: u64,
        refund_circulating: u64,
        buyback_enabled: bool,
        buyback_quote: 0x2::balance::Balance<T1>,
        pending_token_fees: 0x2::balance::Balance<T0>,
        vest: Vest<T0>,
        cto: 0x1::option::Option<CtoProposal>,
        last_convert_ms: u64,
        last_buyback_ms: u64,
        bounty: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        quote_type: 0x1::ascii::String,
        quote_decimals: u8,
        creator: address,
        fee_recipient: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
        base_fee_bps: u64,
        protocol_share_bps: u64,
        buyback_share_bps: u64,
        creator_tax_bps: u64,
        buyback_enabled: bool,
        snipe_window_ms: u64,
        snipe_start_bps: u64,
        snipe_exempt: vector<address>,
        vesting_ms: u64,
        virtual_quote: u64,
        virtual_token: u64,
        curve_supply: u64,
        migration_fee: u64,
        refund_delay_ms: u64,
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

    struct CurveCompleted<phantom T0> has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        real_quote: u64,
        timestamp_ms: u64,
    }

    struct CurveMigrated has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        quote_to_pool: u64,
        tokens_to_pool: u64,
        migration_fee: u64,
    }

    struct BountyPaid has copy, drop {
        curve_id: 0x2::object::ID,
        to: address,
        amount: u64,
    }

    struct PoolFeesPaid has copy, drop {
        curve_id: 0x2::object::ID,
        fee_recipient: address,
        creator_amount: u64,
        protocol_amount: u64,
        buyback_amount: u64,
    }

    struct TokenFeesConverted has copy, drop {
        curve_id: 0x2::object::ID,
        tokens_sold: u64,
        quote_received: u64,
    }

    struct BuybackLocked has copy, drop {
        curve_id: 0x2::object::ID,
        venue: u8,
        quote_spent: u64,
        tokens: u64,
        vest_start: u64,
    }

    struct VestReleased has copy, drop {
        curve_id: 0x2::object::ID,
        fee_recipient: address,
        creator_amount: u64,
        protocol_amount: u64,
    }

    struct BuybackToggled has copy, drop {
        curve_id: 0x2::object::ID,
        enabled: bool,
        by_admin: bool,
        refunded: u64,
    }

    struct FeeRecipientChanged has copy, drop {
        curve_id: 0x2::object::ID,
        from: address,
        to: address,
        cto: bool,
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

    struct RefundOpened has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        quote_reserve: u64,
        circulating: u64,
    }

    struct Redeemed has copy, drop {
        curve_id: 0x2::object::ID,
        holder: address,
        tokens: u64,
        quote_out: u64,
    }

    public fun total_supply() : u64 {
        1000000000000000
    }

    public fun decimals() : u8 {
        6
    }

    public(friend) fun add_converted_fees<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: address) {
        let v0 = TokenFeesConverted{
            curve_id       : 0x2::object::id<Curve<T0, T1>>(arg0),
            tokens_sold    : arg2,
            quote_received : 0x2::balance::value<T1>(&arg1),
        };
        0x2::event::emit<TokenFeesConverted>(v0);
        pay_pool_quote<T0, T1>(arg0, arg1, arg3);
    }

    public(friend) fun add_pool_fees<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::balance::Balance<T0>, arg3: address) {
        0x2::balance::join<T0>(&mut arg0.pending_token_fees, arg2);
        pay_pool_quote<T0, T1>(arg0, arg1, arg3);
    }

    public fun admin_disable_buyback<T0, T1>(arg0: &AdminCap, arg1: &mut Curve<T0, T1>, arg2: &Config) {
        assert_version(arg2);
        toggle_buyback<T0, T1>(arg1, false, true);
    }

    fun amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg2 as u128) * (arg0 as u128) / ((arg1 as u128) + (arg0 as u128))) as u64)
    }

    public fun assert_keeper(arg0: &Config, arg1: &KeeperCap) {
        assert!(arg1.generation == arg0.keeper_generation, 25);
    }

    public fun assert_live(arg0: &Config) {
        assert_version(arg0);
        assert!(!arg0.paused, 1);
    }

    public fun assert_migratable(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = arg1 - arg2;
        let v1 = mul_div_up_u128((arg0 as u128), (arg2 as u128), (v0 as u128));
        assert!(v1 > 0 && v1 <= 4611686018427387903, 8);
        let v2 = (v1 as u64);
        assert!(arg3 <= v2 / 20, 8);
        let v3 = arg0 + v2;
        assert!(((v2 - arg3) as u128) * (v0 as u128) / (v3 as u128) * 1005 / 1000 <= ((1000000000000000 - arg2) as u128), 8);
        let v4 = sqrt_price_x64(v3, v0);
        let v5 = sqrt_price_x64(v0, v3);
        assert!(v4 > 4295048016 * 1000 && v4 < 79226673515401279992447579055, 8);
        assert!(v5 > 4295048016 * 1000 && v5 < 79226673515401279992447579055, 8);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public fun bounty<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.bounty)
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

    fun buy_internal<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: address, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.status == 0, 2);
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = effective_snipe_bps<T0, T1>(arg0, 0x2::tx_context::sender(arg5), v1);
        let v3 = arg0.terms.base_fee_bps + arg0.terms.creator_tax_bps + v2;
        let v4 = v0;
        let v5 = v0 - mul_div(v0, v3, 10000);
        let v6 = v5;
        let v7 = amount_out(v5, arg0.virtual_quote, arg0.virtual_token);
        let v8 = v7;
        let v9 = 0x2::coin::zero<T1>(arg5);
        if (v7 >= arg0.curve_left) {
            let v10 = arg0.curve_left;
            v8 = v10;
            let v11 = mul_div_up(mul_div_up(arg0.virtual_quote, v10, arg0.virtual_token - v10), 10000, 10000 - v3);
            v4 = v11;
            if (v11 > v0) {
                v4 = v0;
            };
            v6 = v4 - mul_div(v4, v3, 10000);
            0x2::coin::join<T1>(&mut v9, 0x2::coin::split<T1>(&mut arg2, v0 - v4, arg5));
        };
        assert!(v8 > 0, 5);
        assert!((v8 as u128) * (v0 as u128) >= (arg3 as u128) * (v4 as u128), 6);
        let v12 = v4 - v6;
        let v13 = mul_div(v4, arg0.terms.creator_tax_bps, 10000);
        let v14 = mul_div(v4, v2, 10000);
        let v15 = 0x2::coin::into_balance<T1>(arg2);
        let v16 = 0x2::balance::split<T1>(&mut v15, v12);
        0x2::balance::join<T1>(&mut arg0.quote_reserve, v15);
        let v17 = &mut v16;
        let (v18, v19, v20) = settle_trade_fees<T0, T1>(arg0, v17, v12 - v13 - v14 + v14, v13, arg1);
        0x2::balance::destroy_zero<T1>(v16);
        arg0.virtual_quote = arg0.virtual_quote + v6;
        arg0.virtual_token = arg0.virtual_token - v8;
        arg0.curve_left = arg0.curve_left - v8;
        let v21 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserve, v8), arg5);
        emit_trade<T0, T1>(arg0, true, v4, v8, v18, v19, v20, v14, v1, arg5);
        if (arg0.curve_left == 0) {
            complete<T0, T1>(arg0, v1);
        } else {
            curve_buyback<T0, T1>(arg0, v20, v1);
        };
        (v21, v9)
    }

    public fun buy_with_change<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_live(arg1);
        buy_internal<T0, T1>(arg0, arg1.fee_recipient, arg2, arg3, arg4, arg5)
    }

    public fun buyback_enabled<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.buyback_enabled
    }

    public fun buyback_pending<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.buyback_quote)
    }

    public fun cancel_cto<T0, T1>(arg0: &AdminCap, arg1: &mut Curve<T0, T1>, arg2: &Config) {
        assert_version(arg2);
        assert!(0x1::option::is_some<CtoProposal>(&arg1.cto), 21);
        arg1.cto = 0x1::option::none<CtoProposal>();
        let v0 = CtoCancelled{curve_id: 0x2::object::id<Curve<T0, T1>>(arg1)};
        0x2::event::emit<CtoCancelled>(v0);
    }

    fun complete<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: u64) {
        arg0.status = 1;
        arg0.completed_ms = arg1;
        let v0 = CurveCompleted<T0>{
            curve_id     : 0x2::object::id<Curve<T0, T1>>(arg0),
            coin_type    : type_key<T0>(),
            real_quote   : 0x2::balance::value<T1>(&arg0.quote_reserve),
            timestamp_ms : arg1,
        };
        0x2::event::emit<CurveCompleted<T0>>(v0);
    }

    public fun completed_ms<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.completed_ms
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

    fun curve_buyback<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: u64, arg2: u64) {
        if (!arg0.buyback_enabled || arg0.status != 0) {
            return
        };
        let v0 = 0x2::balance::value<T1>(&arg0.buyback_quote);
        if (v0 == 0 || arg1 == 0) {
            return
        };
        let v1 = 0x1::u64::min(0x1::u64::min(v0, arg1), mul_div(arg0.virtual_quote, arg0.terms.max_impact_bps, 2 * 10000 + arg0.terms.max_impact_bps));
        let v2 = amount_out(v1, arg0.virtual_quote, arg0.virtual_token);
        if (v2 == 0 || v2 >= arg0.curve_left) {
            return
        };
        0x2::balance::join<T1>(&mut arg0.quote_reserve, 0x2::balance::split<T1>(&mut arg0.buyback_quote, v1));
        arg0.virtual_quote = arg0.virtual_quote + v1;
        arg0.virtual_token = arg0.virtual_token - v2;
        arg0.curve_left = arg0.curve_left - v2;
        let v3 = 0x2::balance::split<T0>(&mut arg0.token_reserve, v2);
        lock_vest<T0, T1>(arg0, v3, v1, 0, arg2);
    }

    public fun curve_for_target(arg0: u64) : (u64, u64, u64) {
        let v0 = mul_div(arg0, 2, 5);
        (v0, 1000000000000000, mul_div(1000000000000000, arg0, v0 + arg0))
    }

    public fun curve_left<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.curve_left
    }

    fun default_config(arg0: &mut 0x2::tx_context::TxContext) : Config {
        let (v0, v1, v2) = curve_for_target(10000000000000);
        assert_migratable(v0, v1, v2, 0);
        let v3 = 0x2::vec_map::empty<0x1::ascii::String, QuoteParams>();
        let v4 = QuoteParams{
            enabled       : true,
            decimals      : 9,
            virtual_quote : v0,
            virtual_token : v1,
            curve_supply  : v2,
            migration_fee : 0,
            lock_pool     : true,
        };
        0x2::vec_map::insert<0x1::ascii::String, QuoteParams>(&mut v3, type_key<0x2::sui::SUI>(), v4);
        Config{
            id                  : 0x2::object::new(arg0),
            version             : 1,
            paused              : false,
            fee_recipient       : 0x2::tx_context::sender(arg0),
            launch_fee          : 1000000000,
            base_fee_bps        : 100,
            protocol_share_bps  : 3000,
            buyback_share_bps   : 5000,
            max_creator_tax_bps : 1000,
            snipe_window_ms     : 5000,
            snipe_start_bps     : 9900,
            max_impact_bps      : 300,
            vesting_ms          : 157680000000,
            cto_delay_ms        : 259200000,
            cto_window_ms       : 259200000,
            refund_delay_ms     : 604800000,
            graduation_bounty   : 50000000,
            keeper_generation   : 0,
            quotes              : v3,
        }
    }

    fun effective_snipe_bps<T0, T1>(arg0: &Curve<T0, T1>, arg1: address, arg2: u64) : u64 {
        if (0x2::vec_set::contains<address>(&arg0.snipe_exempt, &arg1)) {
            return 0
        };
        0x1::u64::min(snipe_tax_bps<T0, T1>(arg0, arg2), 10000 - arg0.terms.base_fee_bps - arg0.terms.creator_tax_bps - 100)
    }

    fun emit_trade<T0, T1>(arg0: &Curve<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) {
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

    public fun enter_refund<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg0.status == 1, 15);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.completed_ms + arg0.terms.refund_delay_ms, 15);
        arg0.status = 3;
        pay<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.buyback_quote), arg0.fee_recipient);
        arg0.refund_circulating = 1000000000000000 - 0x2::balance::value<T0>(&arg0.token_reserve);
        let v0 = RefundOpened{
            curve_id      : 0x2::object::id<Curve<T0, T1>>(arg0),
            coin_type     : type_key<T0>(),
            quote_reserve : 0x2::balance::value<T1>(&arg0.quote_reserve),
            circulating   : arg0.refund_circulating,
        };
        0x2::event::emit<RefundOpened>(v0);
        pay_bounty<T0, T1>(arg0, arg3);
    }

    public fun execute_cto<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: &0x2::clock::Clock) {
        assert_version(arg1);
        assert!(0x1::option::is_some<CtoProposal>(&arg0.cto), 21);
        let v0 = 0x1::option::extract<CtoProposal>(&mut arg0.cto);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= v0.effective_ms, 22);
        assert!(v1 < v0.expires_ms, 23);
        let v2 = FeeRecipientChanged{
            curve_id : 0x2::object::id<Curve<T0, T1>>(arg0),
            from     : arg0.fee_recipient,
            to       : v0.to,
            cto      : true,
        };
        0x2::event::emit<FeeRecipientChanged>(v2);
        arg0.fee_recipient = v0.to;
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    public fun graduation_bounty(arg0: &Config) : u64 {
        arg0.graduation_bounty
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Config>(default_config(arg0));
    }

    public fun is_complete<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.status == 1
    }

    public fun is_migrated<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.status == 2
    }

    public fun is_refund<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.status == 3
    }

    public fun is_snipe_exempt<T0, T1>(arg0: &Curve<T0, T1>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.snipe_exempt, &arg1)
    }

    public fun is_trading<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.status == 0
    }

    public fun issue_keeper_cap(arg0: &AdminCap, arg1: &Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = KeeperCap{
            id         : 0x2::object::new(arg3),
            generation : arg1.keeper_generation,
        };
        0x2::transfer::public_transfer<KeeperCap>(v0, arg2);
    }

    public fun launch_fee(arg0: &Config) : u64 {
        arg0.launch_fee
    }

    public(friend) fun lock_leftover<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun lock_pool(arg0: &QuoteParams) : bool {
        arg0.lock_pool
    }

    public(friend) fun lock_pool_buyback<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64) {
        0x2::balance::join<T1>(&mut arg0.buyback_quote, arg2);
        lock_vest<T0, T1>(arg0, arg1, arg3, 1, arg4);
    }

    fun lock_vest<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u8, arg4: u64) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        0x2::balance::join<T0>(&mut arg0.vest.tokens, arg1);
        if (arg0.vest.sched == 0) {
            arg0.vest.sched = v0;
            arg0.vest.start = arg4;
        } else if (arg4 - arg0.vest.start >= arg0.terms.vesting_ms) {
            arg0.vest.base = arg0.vest.base + arg0.vest.sched;
            arg0.vest.sched = v0;
            arg0.vest.start = arg4;
        } else {
            let v1 = (arg0.vest.sched as u128) + (v0 as u128);
            arg0.vest.start = ((((arg0.vest.start as u128) * (arg0.vest.sched as u128) + (arg4 as u128) * (v0 as u128) + v1 - 1) / v1) as u64);
            arg0.vest.sched = (v1 as u64);
        };
        let v2 = BuybackLocked{
            curve_id    : 0x2::object::id<Curve<T0, T1>>(arg0),
            venue       : arg3,
            quote_spent : arg2,
            tokens      : v0,
            vest_start  : arg0.vest.start,
        };
        0x2::event::emit<BuybackLocked>(v2);
    }

    public(friend) fun max_impact_bps<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.terms.max_impact_bps
    }

    public fun migrate_version(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    fun mul_div_up_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (arg0 * arg1 + arg2 - 1) / arg2
    }

    public(friend) fun new_curve<T0, T1>(arg0: &Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: address, arg4: u64, arg5: bool, arg6: vector<address>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: 0x2::coin::Coin<T1>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (Curve<T0, T1>, 0x2::coin::Coin<T0>) {
        assert_live(arg0);
        let v0 = quote_params<T1>(arg0);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 3);
        assert!(arg4 <= arg0.max_creator_tax_bps, 7);
        assert!(0x1::vector::length<address>(&arg6) <= 32, 20);
        verify_currency<T0>(arg2, &arg1, arg13);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg10) >= arg0.launch_fee + arg0.graduation_bounty, 9);
        let v1 = if (0x1::string::length(&arg7) <= 256) {
            if (0x1::string::length(&arg8) <= 256) {
                0x1::string::length(&arg9) <= 256
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 19);
        let v2 = if (arg3 == @0x0) {
            0x2::tx_context::sender(arg13)
        } else {
            arg3
        };
        let v3 = v2;
        if (arg0.launch_fee > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg10, arg0.launch_fee, arg13), arg0.fee_recipient);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg10, 0x2::tx_context::sender(arg13));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg10);
        };
        0x2::coin_registry::make_supply_fixed<T0>(arg2, arg1);
        let v4 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v4, 0x2::tx_context::sender(arg13));
        if (!0x2::vec_set::contains<address>(&v4, &v3)) {
            0x2::vec_set::insert<address>(&mut v4, v3);
        };
        0x1::vector::reverse<address>(&mut arg6);
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(&arg6)) {
            let v6 = 0x1::vector::pop_back<address>(&mut arg6);
            if (!0x2::vec_set::contains<address>(&v4, &v6)) {
                0x2::vec_set::insert<address>(&mut v4, v6);
            };
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<address>(arg6);
        let v7 = 0x2::clock::timestamp_ms(arg12);
        let v8 = Terms{
            quote_decimals     : v0.decimals,
            base_fee_bps       : arg0.base_fee_bps,
            protocol_share_bps : arg0.protocol_share_bps,
            buyback_share_bps  : arg0.buyback_share_bps,
            creator_tax_bps    : arg4,
            snipe_window_ms    : arg0.snipe_window_ms,
            snipe_start_bps    : arg0.snipe_start_bps,
            max_impact_bps     : arg0.max_impact_bps,
            vesting_ms         : arg0.vesting_ms,
            migration_fee      : v0.migration_fee,
            refund_delay_ms    : arg0.refund_delay_ms,
            cto_delay_ms       : arg0.cto_delay_ms,
            cto_window_ms      : arg0.cto_window_ms,
        };
        let v9 = Vest<T0>{
            tokens   : 0x2::balance::zero<T0>(),
            base     : 0,
            sched    : 0,
            start    : 0,
            released : 0,
        };
        let v10 = Curve<T0, T1>{
            id                 : 0x2::object::new(arg13),
            creator            : 0x2::tx_context::sender(arg13),
            fee_recipient      : v3,
            status             : 0,
            quote_reserve      : 0x2::balance::zero<T1>(),
            token_reserve      : 0x2::coin::mint_balance<T0>(&mut arg1, 1000000000000000),
            virtual_quote      : v0.virtual_quote,
            virtual_token      : v0.virtual_token,
            curve_left         : v0.curve_supply,
            terms              : v8,
            snipe_exempt       : v4,
            created_ms         : v7,
            completed_ms       : 0,
            refund_circulating : 0,
            buyback_enabled    : arg5,
            buyback_quote      : 0x2::balance::zero<T1>(),
            pending_token_fees : 0x2::balance::zero<T0>(),
            vest               : v9,
            cto                : 0x1::option::none<CtoProposal>(),
            last_convert_ms    : 0,
            last_buyback_ms    : 0,
            bounty             : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg10, arg0.graduation_bounty, arg13)),
            pool_id            : 0x1::option::none<0x2::object::ID>(),
        };
        let v11 = CurveCreated{
            curve_id           : 0x2::object::id<Curve<T0, T1>>(&v10),
            coin_type          : type_key<T0>(),
            quote_type         : type_key<T1>(),
            quote_decimals     : v0.decimals,
            creator            : 0x2::tx_context::sender(arg13),
            fee_recipient      : v3,
            name               : 0x2::coin_registry::name<T0>(arg2),
            symbol             : 0x2::coin_registry::symbol<T0>(arg2),
            description        : 0x2::coin_registry::description<T0>(arg2),
            icon_url           : 0x2::coin_registry::icon_url<T0>(arg2),
            twitter            : arg7,
            telegram           : arg8,
            website            : arg9,
            base_fee_bps       : arg0.base_fee_bps,
            protocol_share_bps : arg0.protocol_share_bps,
            buyback_share_bps  : arg0.buyback_share_bps,
            creator_tax_bps    : arg4,
            buyback_enabled    : arg5,
            snipe_window_ms    : arg0.snipe_window_ms,
            snipe_start_bps    : arg0.snipe_start_bps,
            snipe_exempt       : 0x2::vec_set::into_keys<address>(v10.snipe_exempt),
            vesting_ms         : arg0.vesting_ms,
            virtual_quote      : v0.virtual_quote,
            virtual_token      : v0.virtual_token,
            curve_supply       : v0.curve_supply,
            migration_fee      : v0.migration_fee,
            refund_delay_ms    : arg0.refund_delay_ms,
            graduation_bounty  : arg0.graduation_bounty,
            timestamp_ms       : v7,
        };
        0x2::event::emit<CurveCreated>(v11);
        let v12 = if (0x2::coin::value<T1>(&arg11) > 0) {
            let v13 = &mut v10;
            let (v14, v15) = buy_internal<T0, T1>(v13, arg0.fee_recipient, arg11, 0, arg12, arg13);
            let v16 = v15;
            if (0x2::coin::value<T1>(&v16) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v16, 0x2::tx_context::sender(arg13));
            } else {
                0x2::coin::destroy_zero<T1>(v16);
            };
            v14
        } else {
            0x2::coin::destroy_zero<T1>(arg11);
            0x2::coin::zero<T0>(arg13)
        };
        (v10, v12)
    }

    fun pay<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, arg1);
        };
    }

    public(friend) fun pay_bounty<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
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

    fun pay_pool_quote<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: address) {
        let v0 = 0x2::balance::value<T1>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
            return
        };
        let (v1, v2, v3) = split_policy<T0, T1>(arg0, v0);
        pay<T1>(0x2::balance::split<T1>(&mut arg1, v1), arg2);
        0x2::balance::join<T1>(&mut arg0.buyback_quote, 0x2::balance::split<T1>(&mut arg1, v2));
        pay<T1>(arg1, arg0.fee_recipient);
        let v4 = PoolFeesPaid{
            curve_id        : 0x2::object::id<Curve<T0, T1>>(arg0),
            fee_recipient   : arg0.fee_recipient,
            creator_amount  : v3,
            protocol_amount : v1,
            buyback_amount  : v2,
        };
        0x2::event::emit<PoolFeesPaid>(v4);
    }

    public fun pending_token_fees<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.pending_token_fees)
    }

    public fun pool_id<T0, T1>(arg0: &Curve<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.pool_id
    }

    public(friend) fun pool_op_buyback() : u8 {
        1
    }

    public(friend) fun pool_op_convert() : u8 {
        0
    }

    public(friend) fun pool_op_ready<T0, T1>(arg0: &Curve<T0, T1>, arg1: u8, arg2: u64) : bool {
        let v0 = if (arg1 == 0) {
            arg0.last_convert_ms
        } else {
            arg0.last_buyback_ms
        };
        v0 == 0 || arg2 >= v0 + 600000
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

    public fun quote_buy<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        if (arg0.status != 0) {
            return 0
        };
        0x1::u64::min(amount_out(arg1 - mul_div(arg1, arg0.terms.base_fee_bps + arg0.terms.creator_tax_bps + effective_snipe_bps<T0, T1>(arg0, arg2, 0x2::clock::timestamp_ms(arg3)), 10000), arg0.virtual_quote, arg0.virtual_token), arg0.curve_left)
    }

    public fun quote_params<T0>(arg0: &Config) : QuoteParams {
        let v0 = type_key<T0>();
        assert!(0x2::vec_map::contains<0x1::ascii::String, QuoteParams>(&arg0.quotes, &v0), 12);
        let v1 = *0x2::vec_map::get<0x1::ascii::String, QuoteParams>(&arg0.quotes, &v0);
        assert!(v1.enabled, 12);
        v1
    }

    public fun quote_sell<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64) : u64 {
        if (arg0.status != 0) {
            return 0
        };
        let v0 = amount_out(arg1, arg0.virtual_token, arg0.virtual_quote);
        if (v0 > 0x2::balance::value<T1>(&arg0.quote_reserve)) {
            return 0
        };
        v0 - mul_div(v0, arg0.terms.base_fee_bps, 10000) - mul_div(v0, arg0.terms.creator_tax_bps, 10000)
    }

    public fun real_quote<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_reserve)
    }

    public fun redeem<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version(arg1);
        assert!(arg0.status == 3, 15);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 5);
        let v1 = mul_div(0x2::balance::value<T1>(&arg0.quote_reserve), v0, arg0.refund_circulating);
        assert!(v1 > 0, 5);
        arg0.refund_circulating = arg0.refund_circulating - v0;
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg2));
        let v2 = Redeemed{
            curve_id  : 0x2::object::id<Curve<T0, T1>>(arg0),
            holder    : 0x2::tx_context::sender(arg3),
            tokens    : v0,
            quote_out : v1,
        };
        0x2::event::emit<Redeemed>(v2);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_reserve, v1), arg3)
    }

    public fun refund_delay(arg0: &Config) : u64 {
        arg0.refund_delay_ms
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
        let v0 = releasable<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg2));
        if (v0 == 0) {
            return
        };
        arg0.vest.released = arg0.vest.released + v0;
        let v1 = 0x2::balance::split<T0>(&mut arg0.vest.tokens, v0);
        let v2 = mul_div(v0, arg0.terms.protocol_share_bps, 10000);
        pay<T0>(0x2::balance::split<T0>(&mut v1, v2), arg1.fee_recipient);
        pay<T0>(v1, arg0.fee_recipient);
        let v3 = VestReleased{
            curve_id        : 0x2::object::id<Curve<T0, T1>>(arg0),
            fee_recipient   : arg0.fee_recipient,
            creator_amount  : 0x2::balance::value<T0>(&v1),
            protocol_amount : v2,
        };
        0x2::event::emit<VestReleased>(v3);
    }

    public(friend) fun return_pending_token_fees<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.pending_token_fees, arg1);
    }

    public fun rotate_keepers(arg0: &AdminCap, arg1: &mut Config) {
        assert_version(arg1);
        arg1.keeper_generation = arg1.keeper_generation + 1;
    }

    public fun sell<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version(arg1);
        assert!(arg0.status == 0, 2);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 5);
        let v1 = amount_out(v0, arg0.virtual_token, arg0.virtual_quote);
        assert!(v1 <= 0x2::balance::value<T1>(&arg0.quote_reserve), 16);
        let v2 = mul_div(v1, arg0.terms.base_fee_bps, 10000);
        let v3 = mul_div(v1, arg0.terms.creator_tax_bps, 10000);
        let v4 = v1 - v2 - v3;
        assert!(v4 > 0, 5);
        assert!(v4 >= arg3, 6);
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg2));
        arg0.virtual_quote = arg0.virtual_quote - v1;
        arg0.virtual_token = arg0.virtual_token + v0;
        arg0.curve_left = arg0.curve_left + v0;
        let v5 = 0x2::balance::split<T1>(&mut arg0.quote_reserve, v1);
        let v6 = 0x2::balance::split<T1>(&mut v5, v2 + v3);
        let v7 = &mut v6;
        let (v8, v9, v10) = settle_trade_fees<T0, T1>(arg0, v7, v2, v3, arg1.fee_recipient);
        0x2::balance::destroy_zero<T1>(v6);
        let v11 = 0x2::clock::timestamp_ms(arg4);
        emit_trade<T0, T1>(arg0, false, v4, v0, v8, v9, v10, 0, v11, arg5);
        curve_buyback<T0, T1>(arg0, v10, v11);
        0x2::coin::from_balance<T1>(v5, arg5)
    }

    public fun set_buyback<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.fee_recipient, 11);
        toggle_buyback<T0, T1>(arg0, arg2, false);
    }

    public fun set_creator_fee_recipient<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.fee_recipient, 11);
        assert!(arg2 != @0x0, 18);
        let v0 = FeeRecipientChanged{
            curve_id : 0x2::object::id<Curve<T0, T1>>(arg0),
            from     : arg0.fee_recipient,
            to       : arg2,
            cto      : false,
        };
        0x2::event::emit<FeeRecipientChanged>(v0);
        arg0.fee_recipient = arg2;
    }

    public fun set_fee_policy(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert_version(arg1);
        assert!(arg2 <= 10000000000, 8);
        assert!(arg3 <= 500 && arg6 <= 1000, 8);
        assert!(arg4 <= 10000 && arg5 <= 10000, 8);
        assert!(arg3 + arg6 + 100 <= 10000, 8);
        arg1.launch_fee = arg2;
        arg1.base_fee_bps = arg3;
        arg1.protocol_share_bps = arg4;
        arg1.buyback_share_bps = arg5;
        arg1.max_creator_tax_bps = arg6;
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

    public fun set_launch_terms(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert_version(arg1);
        assert!(arg2 <= 60000 && arg3 <= 9900, 8);
        assert!(arg2 > 0 || arg3 == 0, 8);
        assert!(arg4 > 0 && arg4 <= 1000, 8);
        assert!(arg5 >= 86400000 && arg5 <= 315360000000, 8);
        assert!(arg6 >= 259200000 && arg6 <= 2592000000, 8);
        assert!(arg7 >= 86400000 && arg7 <= 2592000000, 8);
        arg1.snipe_window_ms = arg2;
        arg1.snipe_start_bps = arg3;
        arg1.max_impact_bps = arg4;
        arg1.vesting_ms = arg5;
        arg1.cto_delay_ms = arg6;
        arg1.cto_window_ms = arg7;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        assert_version(arg1);
        arg1.paused = arg2;
    }

    public(friend) fun set_pool_id<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: 0x2::object::ID) {
        arg0.pool_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun set_quote<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool) {
        assert_version(arg1);
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
        assert_migratable(arg3, arg4, arg5, arg6);
        let v1 = type_key<T0>();
        let v2 = QuoteParams{
            enabled       : arg8,
            decimals      : arg2,
            virtual_quote : arg3,
            virtual_token : arg4,
            curve_supply  : arg5,
            migration_fee : arg6,
            lock_pool     : arg7,
        };
        if (0x2::vec_map::contains<0x1::ascii::String, QuoteParams>(&arg1.quotes, &v1)) {
            *0x2::vec_map::get_mut<0x1::ascii::String, QuoteParams>(&mut arg1.quotes, &v1) = v2;
        } else {
            0x2::vec_map::insert<0x1::ascii::String, QuoteParams>(&mut arg1.quotes, v1, v2);
        };
    }

    public(friend) fun set_refund_delay_internal(arg0: &mut Config, arg1: u64, arg2: u64) {
        assert_version(arg0);
        assert!(arg2 >= 3600000, 8);
        assert!(arg1 >= arg2 && arg1 <= 7776000000, 8);
        arg0.refund_delay_ms = arg1;
    }

    fun settle_trade_fees<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &mut 0x2::balance::Balance<T1>, arg2: u64, arg3: u64, arg4: address) : (u64, u64, u64) {
        let (v0, v1, v2) = split_policy<T0, T1>(arg0, arg2);
        pay<T1>(0x2::balance::split<T1>(arg1, v0), arg4);
        0x2::balance::join<T1>(&mut arg0.buyback_quote, 0x2::balance::split<T1>(arg1, v1));
        let v3 = v2 + arg3;
        pay<T1>(0x2::balance::split<T1>(arg1, v3), arg0.fee_recipient);
        (v0, v3, v1)
    }

    public(friend) fun share<T0, T1>(arg0: Curve<T0, T1>) {
        0x2::transfer::share_object<Curve<T0, T1>>(arg0);
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

    fun split_policy<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64) : (u64, u64, u64) {
        let v0 = mul_div(arg1, arg0.terms.protocol_share_bps, 10000);
        let v1 = arg1 - v0;
        let v2 = if (arg0.buyback_enabled) {
            mul_div(v1, arg0.terms.buyback_share_bps, 10000)
        } else {
            0
        };
        (v0, v2, v1 - v2)
    }

    public fun sqrt_price_x64(arg0: u64, arg1: u64) : u128 {
        (sqrt_u256(((arg0 as u256) << 128) / (arg1 as u256)) as u128)
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

    public(friend) fun take_for_migration<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.status == 1, 10);
        arg0.status = 2;
        pay<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.buyback_quote), arg0.fee_recipient);
        let v0 = 0x2::balance::value<T1>(&arg0.quote_reserve);
        let v1 = 0x1::u64::min(arg0.terms.migration_fee, v0);
        let v2 = v0 - v1;
        let v3 = CurveMigrated{
            curve_id       : 0x2::object::id<Curve<T0, T1>>(arg0),
            coin_type      : type_key<T0>(),
            quote_to_pool  : v2,
            tokens_to_pool : 0x1::u64::min(mul_div(v2, arg0.virtual_token, arg0.virtual_quote), 0x2::balance::value<T0>(&arg0.token_reserve)),
            migration_fee  : v1,
        };
        0x2::event::emit<CurveMigrated>(v3);
        (0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.quote_reserve), arg1), 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.token_reserve), arg1), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_reserve, v1), arg1))
    }

    public(friend) fun take_pending_token_fees<T0, T1>(arg0: &mut Curve<T0, T1>) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg0.pending_token_fees)
    }

    public(friend) fun take_pool_buyback<T0, T1>(arg0: &mut Curve<T0, T1>) : 0x2::balance::Balance<T1> {
        if (arg0.status != 2 || !arg0.buyback_enabled) {
            return 0x2::balance::zero<T1>()
        };
        0x2::balance::withdraw_all<T1>(&mut arg0.buyback_quote)
    }

    fun toggle_buyback<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: bool, arg2: bool) {
        arg0.buyback_enabled = arg1;
        let v0 = 0;
        if (!arg1) {
            let v1 = 0x2::balance::withdraw_all<T1>(&mut arg0.buyback_quote);
            v0 = 0x2::balance::value<T1>(&v1);
            pay<T1>(v1, arg0.fee_recipient);
        };
        let v2 = BuybackToggled{
            curve_id : 0x2::object::id<Curve<T0, T1>>(arg0),
            enabled  : arg1,
            by_admin : arg2,
            refunded : v0,
        };
        0x2::event::emit<BuybackToggled>(v2);
    }

    public fun token_reserve<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.token_reserve)
    }

    public(friend) fun touch_pool_op<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: u8, arg2: u64) {
        if (arg1 == 0) {
            arg0.last_convert_ms = arg2;
        } else {
            arg0.last_buyback_ms = arg2;
        };
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

    public fun vest_locked<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.vest.tokens)
    }

    public fun vest_released<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.vest.released
    }

    public fun vested_amount<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64) : u64 {
        if (arg0.vest.sched == 0) {
            return arg0.vest.base
        };
        let v0 = if (arg1 > arg0.vest.start) {
            arg1 - arg0.vest.start
        } else {
            0
        };
        let v1 = if (v0 >= arg0.terms.vesting_ms) {
            arg0.vest.sched
        } else {
            mul_div(arg0.vest.sched, v0, arg0.terms.vesting_ms)
        };
        arg0.vest.base + v1
    }

    public fun virtual_reserves<T0, T1>(arg0: &Curve<T0, T1>) : (u64, u64) {
        (arg0.virtual_quote, arg0.virtual_token)
    }

    // decompiled from Move bytecode v7
}

