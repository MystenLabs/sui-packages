module 0x8eb9a1f86396c658c05e6cfd90405b4f2b10dffd50de12861eceda4ee614ba02::curve {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
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
        protocol_fee_bps: u64,
        max_creator_fee_bps: u64,
        snipe_window_ms: u64,
        snipe_start_bps: u64,
        refund_delay_ms: u64,
        graduation_bounty: u64,
        quotes: 0x2::vec_map::VecMap<0x1::ascii::String, QuoteParams>,
    }

    struct Curve<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        creator: address,
        status: u8,
        quote_reserve: 0x2::balance::Balance<T1>,
        token_reserve: 0x2::balance::Balance<T0>,
        virtual_quote: u64,
        virtual_token: u64,
        curve_left: u64,
        quote_decimals: u8,
        protocol_fee_bps: u64,
        creator_fee_bps: u64,
        snipe_window_ms: u64,
        snipe_start_bps: u64,
        migration_fee: u64,
        refund_delay_ms: u64,
        created_ms: u64,
        completed_ms: u64,
        refund_circulating: u64,
        protocol_fees: 0x2::balance::Balance<T1>,
        creator_fees: 0x2::balance::Balance<T1>,
        bounty: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        quote_type: 0x1::ascii::String,
        quote_decimals: u8,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
        creator_fee_bps: u64,
        protocol_fee_bps: u64,
        snipe_window_ms: u64,
        snipe_start_bps: u64,
        virtual_quote: u64,
        virtual_token: u64,
        curve_supply: u64,
        migration_fee: u64,
        refund_delay_ms: u64,
        graduation_bounty: u64,
        timestamp_ms: u64,
    }

    struct BountyPaid has copy, drop {
        curve_id: 0x2::object::ID,
        to: address,
        amount: u64,
    }

    struct CreatorTransferred has copy, drop {
        curve_id: 0x2::object::ID,
        from: address,
        to: address,
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

    struct CurveMigrated has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        quote_to_pool: u64,
        tokens_to_pool: u64,
        migration_fee: u64,
    }

    public fun total_supply() : u64 {
        1000000000000000
    }

    public fun decimals() : u8 {
        6
    }

    public(friend) fun add_pool_fees<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::balance::Balance<T0>) {
        let v0 = arg0.protocol_fee_bps + arg0.creator_fee_bps;
        let v1 = if (v0 == 0) {
            0
        } else {
            mul_div(0x2::balance::value<T1>(&arg1), arg0.creator_fee_bps, v0)
        };
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut arg1, v1));
        0x2::balance::join<T1>(&mut arg0.protocol_fees, arg1);
        0x2::balance::join<T0>(&mut arg0.token_reserve, arg2);
    }

    fun amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg2 as u128) * (arg0 as u128) / ((arg1 as u128) + (arg0 as u128))) as u64)
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

    fun buy_internal<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.status == 0, 2);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = if (arg3) {
            snipe_tax_bps<T0, T1>(arg0, v1)
        } else {
            0
        };
        let v3 = arg0.protocol_fee_bps + arg0.creator_fee_bps + v2;
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
            0x2::coin::join<T1>(&mut v9, 0x2::coin::split<T1>(&mut arg1, v0 - v4, arg5));
        };
        assert!(v8 > 0, 5);
        assert!(v8 >= arg2, 6);
        let v12 = mul_div(v4, arg0.creator_fee_bps, 10000);
        let v13 = v4 - v6 - v12;
        let v14 = 0x2::coin::into_balance<T1>(arg1);
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut v14, v12));
        0x2::balance::join<T1>(&mut arg0.protocol_fees, 0x2::balance::split<T1>(&mut v14, v13));
        0x2::balance::join<T1>(&mut arg0.quote_reserve, v14);
        arg0.virtual_quote = arg0.virtual_quote + v6;
        arg0.virtual_token = arg0.virtual_token - v8;
        arg0.curve_left = arg0.curve_left - v8;
        emit_trade<T0, T1>(arg0, true, v4, v8, v13, v12, v1, arg5);
        if (arg0.curve_left == 0) {
            complete<T0, T1>(arg0, v1);
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserve, v8), arg5), v9)
    }

    public fun buy_with_change<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_live(arg1);
        buy_internal<T0, T1>(arg0, arg2, arg3, true, arg4, arg5)
    }

    public fun claim_creator_fees<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version(arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 11);
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.creator_fees), arg2)
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = 0x2::balance::withdraw_all<T1>(&mut arg0.protocol_fees);
        if (0x2::balance::value<T1>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg2), arg1.fee_recipient);
        } else {
            0x2::balance::destroy_zero<T1>(v0);
        };
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

    public fun creator_fees<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.creator_fees)
    }

    public fun curve_left<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.curve_left
    }

    fun default_config(arg0: &mut 0x2::tx_context::TxContext) : Config {
        assert_migratable(1411764705882, 1073000000000000, 793100000000000, 100000000000);
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, QuoteParams>();
        let v1 = QuoteParams{
            enabled       : true,
            decimals      : 9,
            virtual_quote : 1411764705882,
            virtual_token : 1073000000000000,
            curve_supply  : 793100000000000,
            migration_fee : 100000000000,
            lock_pool     : true,
        };
        0x2::vec_map::insert<0x1::ascii::String, QuoteParams>(&mut v0, type_key<0x2::sui::SUI>(), v1);
        Config{
            id                  : 0x2::object::new(arg0),
            version             : 1,
            paused              : false,
            fee_recipient       : 0x2::tx_context::sender(arg0),
            launch_fee          : 1000000000,
            protocol_fee_bps    : 100,
            max_creator_fee_bps : 100,
            snipe_window_ms     : 15000,
            snipe_start_bps     : 5000,
            refund_delay_ms     : 2592000000,
            graduation_bounty   : 50000000,
            quotes              : v0,
        }
    }

    fun emit_trade<T0, T1>(arg0: &Curve<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        let v0 = Trade<T0>{
            curve_id      : 0x2::object::id<Curve<T0, T1>>(arg0),
            coin_type     : type_key<T0>(),
            trader        : 0x2::tx_context::sender(arg7),
            is_buy        : arg1,
            quote_amount  : arg2,
            token_amount  : arg3,
            protocol_fee  : arg4,
            creator_fee   : arg5,
            virtual_quote : arg0.virtual_quote,
            virtual_token : arg0.virtual_token,
            real_quote    : 0x2::balance::value<T1>(&arg0.quote_reserve),
            curve_left    : arg0.curve_left,
            timestamp_ms  : arg6,
        };
        0x2::event::emit<Trade<T0>>(v0);
    }

    public fun enter_refund<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg0.status == 1, 15);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.completed_ms + arg0.refund_delay_ms, 15);
        arg0.status = 3;
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

    public fun is_trading<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.status == 0
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

    public(friend) fun new_curve<T0, T1>(arg0: &Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x2::coin::Coin<T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (Curve<T0, T1>, 0x2::coin::Coin<T0>) {
        assert_live(arg0);
        let v0 = quote_params<T1>(arg0);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 3);
        assert!(arg3 <= arg0.max_creator_fee_bps, 7);
        verify_currency<T0>(arg2, &arg1, arg10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= arg0.launch_fee + arg0.graduation_bounty, 9);
        let v1 = if (0x1::string::length(&arg4) <= 256) {
            if (0x1::string::length(&arg5) <= 256) {
                0x1::string::length(&arg6) <= 256
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 19);
        if (arg0.launch_fee > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, arg0.launch_fee, arg10), arg0.fee_recipient);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, 0x2::tx_context::sender(arg10));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg7);
        };
        0x2::coin_registry::make_supply_fixed<T0>(arg2, arg1);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        let v3 = Curve<T0, T1>{
            id                 : 0x2::object::new(arg10),
            creator            : 0x2::tx_context::sender(arg10),
            status             : 0,
            quote_reserve      : 0x2::balance::zero<T1>(),
            token_reserve      : 0x2::coin::mint_balance<T0>(&mut arg1, 1000000000000000),
            virtual_quote      : v0.virtual_quote,
            virtual_token      : v0.virtual_token,
            curve_left         : v0.curve_supply,
            quote_decimals     : v0.decimals,
            protocol_fee_bps   : arg0.protocol_fee_bps,
            creator_fee_bps    : arg3,
            snipe_window_ms    : arg0.snipe_window_ms,
            snipe_start_bps    : arg0.snipe_start_bps,
            migration_fee      : v0.migration_fee,
            refund_delay_ms    : arg0.refund_delay_ms,
            created_ms         : v2,
            completed_ms       : 0,
            refund_circulating : 0,
            protocol_fees      : 0x2::balance::zero<T1>(),
            creator_fees       : 0x2::balance::zero<T1>(),
            bounty             : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, arg0.graduation_bounty, arg10)),
            pool_id            : 0x1::option::none<0x2::object::ID>(),
        };
        let v4 = CurveCreated{
            curve_id          : 0x2::object::id<Curve<T0, T1>>(&v3),
            coin_type         : type_key<T0>(),
            quote_type        : type_key<T1>(),
            quote_decimals    : v0.decimals,
            creator           : 0x2::tx_context::sender(arg10),
            name              : 0x2::coin_registry::name<T0>(arg2),
            symbol            : 0x2::coin_registry::symbol<T0>(arg2),
            description       : 0x2::coin_registry::description<T0>(arg2),
            icon_url          : 0x2::coin_registry::icon_url<T0>(arg2),
            twitter           : arg4,
            telegram          : arg5,
            website           : arg6,
            creator_fee_bps   : arg3,
            protocol_fee_bps  : arg0.protocol_fee_bps,
            snipe_window_ms   : arg0.snipe_window_ms,
            snipe_start_bps   : arg0.snipe_start_bps,
            virtual_quote     : v0.virtual_quote,
            virtual_token     : v0.virtual_token,
            curve_supply      : v0.curve_supply,
            migration_fee     : v0.migration_fee,
            refund_delay_ms   : arg0.refund_delay_ms,
            graduation_bounty : arg0.graduation_bounty,
            timestamp_ms      : v2,
        };
        0x2::event::emit<CurveCreated>(v4);
        let v5 = if (0x2::coin::value<T1>(&arg8) > 0) {
            let v6 = &mut v3;
            let (v7, v8) = buy_internal<T0, T1>(v6, arg8, 0, false, arg9, arg10);
            let v9 = v8;
            if (0x2::coin::value<T1>(&v9) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v9, 0x2::tx_context::sender(arg10));
            } else {
                0x2::coin::destroy_zero<T1>(v9);
            };
            v7
        } else {
            0x2::coin::destroy_zero<T1>(arg8);
            0x2::coin::zero<T0>(arg10)
        };
        (v3, v5)
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

    public fun pool_id<T0, T1>(arg0: &Curve<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.pool_id
    }

    public fun protocol_fees<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.protocol_fees)
    }

    public fun quote_buy<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        if (arg0.status != 0) {
            return 0
        };
        0x1::u64::min(amount_out(arg1 - mul_div(arg1, arg0.protocol_fee_bps + arg0.creator_fee_bps + snipe_tax_bps<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg2)), 10000), arg0.virtual_quote, arg0.virtual_token), arg0.curve_left)
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
        v0 - mul_div(v0, arg0.protocol_fee_bps, 10000) - mul_div(v0, arg0.creator_fee_bps, 10000)
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

    public fun sell<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version(arg1);
        assert!(arg0.status == 0, 2);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 5);
        let v1 = amount_out(v0, arg0.virtual_token, arg0.virtual_quote);
        assert!(v1 <= 0x2::balance::value<T1>(&arg0.quote_reserve), 16);
        let v2 = mul_div(v1, arg0.protocol_fee_bps, 10000);
        let v3 = mul_div(v1, arg0.creator_fee_bps, 10000);
        let v4 = v1 - v2 - v3;
        assert!(v4 > 0, 5);
        assert!(v4 >= arg3, 6);
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg2));
        arg0.virtual_quote = arg0.virtual_quote - v1;
        arg0.virtual_token = arg0.virtual_token + v0;
        arg0.curve_left = arg0.curve_left + v0;
        let v5 = 0x2::balance::split<T1>(&mut arg0.quote_reserve, v1);
        0x2::balance::join<T1>(&mut arg0.protocol_fees, 0x2::balance::split<T1>(&mut v5, v2));
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut v5, v3));
        emit_trade<T0, T1>(arg0, false, v4, v0, v2, v3, 0x2::clock::timestamp_ms(arg4), arg5);
        0x2::coin::from_balance<T1>(v5, arg5)
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert_version(arg1);
        assert!(arg2 != @0x0, 18);
        arg1.fee_recipient = arg2;
    }

    public fun set_fees(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert_version(arg1);
        assert!(arg2 <= 10000000000, 8);
        assert!(arg3 + arg4 + arg6 < 10000, 8);
        assert!(arg3 <= 500 && arg4 <= 500, 8);
        assert!(arg5 <= 60000 && arg6 <= 5000, 8);
        assert!(arg5 > 0 || arg6 == 0, 8);
        arg1.launch_fee = arg2;
        arg1.protocol_fee_bps = arg3;
        arg1.max_creator_fee_bps = arg4;
        arg1.snipe_window_ms = arg5;
        arg1.snipe_start_bps = arg6;
    }

    public fun set_graduation_bounty(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 <= 1000000000, 8);
        arg1.graduation_bounty = arg2;
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
        assert!(arg4 > arg5 && arg5 < 1000000000000000, 8);
        assert_migratable(arg3, arg4, arg5, arg6);
        let v0 = type_key<T0>();
        let v1 = QuoteParams{
            enabled       : arg8,
            decimals      : arg2,
            virtual_quote : arg3,
            virtual_token : arg4,
            curve_supply  : arg5,
            migration_fee : arg6,
            lock_pool     : arg7,
        };
        if (0x2::vec_map::contains<0x1::ascii::String, QuoteParams>(&arg1.quotes, &v0)) {
            *0x2::vec_map::get_mut<0x1::ascii::String, QuoteParams>(&mut arg1.quotes, &v0) = v1;
        } else {
            0x2::vec_map::insert<0x1::ascii::String, QuoteParams>(&mut arg1.quotes, v0, v1);
        };
    }

    public(friend) fun set_refund_delay_internal(arg0: &mut Config, arg1: u64, arg2: u64) {
        assert_version(arg0);
        assert!(arg2 >= 3600000, 8);
        assert!(arg1 >= arg2 && arg1 <= 7776000000, 8);
        arg0.refund_delay_ms = arg1;
    }

    public(friend) fun share<T0, T1>(arg0: Curve<T0, T1>) {
        0x2::transfer::share_object<Curve<T0, T1>>(arg0);
    }

    fun snipe_tax_bps<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64) : u64 {
        let v0 = if (arg1 > arg0.created_ms) {
            arg1 - arg0.created_ms
        } else {
            0
        };
        if (v0 >= arg0.snipe_window_ms) {
            return 0
        };
        mul_div(arg0.snipe_start_bps, arg0.snipe_window_ms - v0, arg0.snipe_window_ms)
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
        let v0 = 0x2::balance::value<T1>(&arg0.quote_reserve);
        let v1 = 0x1::u64::min(arg0.migration_fee, v0);
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

    public fun token_reserve<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.token_reserve)
    }

    public fun transfer_creator<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: &Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 11);
        assert!(arg2 != @0x0, 18);
        let v0 = CreatorTransferred{
            curve_id : 0x2::object::id<Curve<T0, T1>>(arg0),
            from     : arg0.creator,
            to       : arg2,
        };
        0x2::event::emit<CreatorTransferred>(v0);
        arg0.creator = arg2;
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

    public fun virtual_reserves<T0, T1>(arg0: &Curve<T0, T1>) : (u64, u64) {
        (arg0.virtual_quote, arg0.virtual_token)
    }

    // decompiled from Move bytecode v7
}

