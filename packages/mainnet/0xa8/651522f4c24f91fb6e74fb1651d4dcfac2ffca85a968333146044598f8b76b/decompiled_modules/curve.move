module 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve {
    struct Curve<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        metadata_cap: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>,
        last_metadata_ms: u64,
        links: Links,
        pool_creation_cap: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>,
        closer: address,
        params: 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Params,
        virtual_sui: u64,
        virtual_tokens: u64,
        x: u64,
        y: u64,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        token_reserve: 0x2::balance::Balance<T0>,
        lp_tokens: 0x2::balance::Balance<T0>,
        liquidity_bonus: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        created_ms: u64,
        snipe_window_ms: u64,
        status: u8,
    }

    struct Links has copy, drop, store {
        website: 0x1::string::String,
        x: 0x1::string::String,
        telegram: 0x1::string::String,
    }

    struct Created has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        graduation_sui: u64,
        snipe_window_ms: u64,
        dev_buy_sui: u64,
        dev_buy_tokens: u64,
        created_ms: u64,
    }

    struct Traded has copy, drop {
        curve_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        fee: u64,
        fee_bps: u64,
        referrer: 0x1::option::Option<address>,
        x: u64,
        y: u64,
        timestamp_ms: u64,
    }

    struct ReadyToGraduate has copy, drop {
        curve_id: 0x2::object::ID,
        raised: u64,
    }

    struct CreatorFeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    struct CreatorTransferred has copy, drop {
        curve_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct MetadataChanged has copy, drop {
        curve_id: 0x2::object::ID,
        field: u8,
        timestamp_ms: u64,
    }

    struct LinksChanged has copy, drop {
        curve_id: 0x2::object::ID,
        links: Links,
        timestamp_ms: u64,
    }

    struct CtoProposed has copy, drop {
        curve_id: 0x2::object::ID,
        from: address,
        to: address,
        reason: 0x1::string::String,
        ready_ms: u64,
    }

    struct CtoObjected has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        reason: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct CtoCancelled has copy, drop {
        curve_id: 0x2::object::ID,
        to: address,
    }

    struct CtoExecuted has copy, drop {
        curve_id: 0x2::object::ID,
        from: address,
        to: address,
        fees_to_previous: u64,
    }

    struct Burned has copy, drop {
        curve_id: 0x2::object::ID,
        burner: address,
        amount: u64,
        total_supply: u64,
    }

    struct BuyQuote has copy, drop {
        tokens_out: u64,
        net_in: u64,
        fee: u64,
        gross_in: u64,
        sells_out: bool,
        new_x: u64,
        new_y: u64,
    }

    struct SnipeTxKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SnipeTx has drop, store {
        digest: vector<u8>,
        bought: u64,
    }

    struct CtoKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CtoProposal has drop, store {
        new_creator: address,
        reason: 0x1::string::String,
        proposed_ms: u64,
        ready_ms: u64,
        objected: bool,
    }

    struct StuckKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GraduationStuckReported has copy, drop {
        curve_id: 0x2::object::ID,
        reporter: address,
        reopen_ms: u64,
    }

    struct TradingReopened has copy, drop {
        curve_id: 0x2::object::ID,
        tokens_left: u64,
    }

    struct FeeModeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeMode has copy, drop, store {
        creator_bps: u64,
        buyback_bps: u64,
        holders_bps: u64,
    }

    struct CreatorClaimKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeModeSet has copy, drop {
        curve_id: 0x2::object::ID,
        mode: u8,
        creator_bps: u64,
        buyback_bps: u64,
        holders_bps: u64,
    }

    struct TokensToBurnKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun burn<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap), 412);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 403);
        let v1 = 0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap);
        0x2::coin::burn<T0>(v1, arg2);
        let v2 = Burned{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            burner       : 0x2::tx_context::sender(arg3),
            amount       : v0,
            total_supply : 0x2::coin::total_supply<T0>(v1),
        };
        0x2::event::emit<Burned>(v2);
    }

    public fun total_supply() : u64 {
        1000000000000000
    }

    public fun set_description<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        metadata_guard<T0>(arg0, arg4, arg5);
        0x2::coin_registry::set_description<T0>(arg2, 0x1::option::borrow<0x2::coin_registry::MetadataCap<T0>>(&arg0.metadata_cap), arg3);
        let v0 = MetadataChanged{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            field        : 1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MetadataChanged>(v0);
    }

    public fun set_icon_url<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        metadata_guard<T0>(arg0, arg4, arg5);
        0x2::coin_registry::set_icon_url<T0>(arg2, 0x1::option::borrow<0x2::coin_registry::MetadataCap<T0>>(&arg0.metadata_cap), arg3);
        let v0 = MetadataChanged{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            field        : 2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MetadataChanged>(v0);
    }

    public fun set_name<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        metadata_guard<T0>(arg0, arg4, arg5);
        0x2::coin_registry::set_name<T0>(arg2, 0x1::option::borrow<0x2::coin_registry::MetadataCap<T0>>(&arg0.metadata_cap), arg3);
        let v0 = MetadataChanged{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            field        : 0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MetadataChanged>(v0);
    }

    public(friend) fun add_creator_fee<T0>(arg0: &mut Curve<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, arg1);
    }

    public(friend) fun burn_balance<T0>(arg0: &mut Curve<T0>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap)), arg1);
    }

    public fun buy<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: 0x1::option::Option<address>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(!0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::is_sell_only(arg1), 400);
        assert!(arg0.status == 0, 401);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = buy_fee_bps_at(&arg0.params, arg0.created_ms, arg0.snipe_window_ms, v0);
        let v2 = price_buy(k_of(arg0.virtual_sui, arg0.virtual_tokens), arg0.x, arg0.y, 0x2::balance::value<T0>(&arg0.token_reserve), arg5, v1);
        assert!(v2.tokens_out > 0 && v2.tokens_out >= arg6, 402);
        if (v0 - arg0.created_ms < arg0.snipe_window_ms) {
            let v3 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(1000000000000000, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_tx_cap_bps(&arg0.params), 10000);
            let v4 = snipe_tx_bought<T0>(arg0, *0x2::tx_context::digest(arg9), v2.tokens_out);
            assert!(v4 <= v3, 404);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg4) >= v2.gross_in, 409);
        let v5 = 0x2::tx_context::sender(arg9);
        let v6 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::resolve(arg3, v5, arg7);
        let v7 = if (0x1::option::is_some<address>(&v6) && *0x1::option::borrow<address>(&v6) == arg0.creator) {
            0x1::option::none<address>()
        } else {
            v6
        };
        let v8 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg4), v2.gross_in);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v8, v2.net_in));
        distribute_fee<T0>(arg0, arg2, arg3, v8, v2.gross_in, v7);
        arg0.x = v2.new_x;
        arg0.y = v2.new_y;
        check_reserve<T0>(arg0);
        let v9 = Traded{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            trader       : v5,
            is_buy       : true,
            sui_amount   : v2.gross_in,
            token_amount : v2.tokens_out,
            fee          : v2.fee,
            fee_bps      : v1,
            referrer     : v7,
            x            : arg0.x,
            y            : arg0.y,
            timestamp_ms : v0,
        };
        0x2::event::emit<Traded>(v9);
        if (v2.sells_out) {
            arg0.status = 1;
            arg0.closer = v5;
            let v10 = ReadyToGraduate{
                curve_id : 0x2::object::id<Curve<T0>>(arg0),
                raised   : arg0.x - arg0.virtual_sui,
            };
            0x2::event::emit<ReadyToGraduate>(v10);
        };
        0x2::coin::take<T0>(&mut arg0.token_reserve, v2.tokens_out, arg9)
    }

    public fun buy_fee_bps_at(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Params, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg3 - arg1;
        if (v0 >= arg2) {
            return 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(arg0)
        };
        let v1 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_start_fee_bps(arg0);
        v1 - 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(v1 - 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(arg0), v0, arg2)
    }

    public(friend) fun buyback_buy<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        assert!(arg0.status == 0, 401);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 - arg0.created_ms >= arg0.snipe_window_ms, 422);
        let v1 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(&arg0.params);
        let v2 = price_buy(k_of(arg0.virtual_sui, arg0.virtual_tokens), arg0.x, arg0.y, 0x2::balance::value<T0>(&arg0.token_reserve), 0x2::balance::value<0x2::sui::SUI>(&arg3), v1);
        assert!(!v2.sells_out, 423);
        assert!(v2.tokens_out > 0, 403);
        let v3 = 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v2.gross_in);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v2.net_in));
        distribute_fee<T0>(arg0, arg1, arg2, v3, v2.gross_in, 0x1::option::none<address>());
        arg0.x = v2.new_x;
        arg0.y = v2.new_y;
        let v4 = 0x2::balance::split<T0>(&mut arg0.token_reserve, v2.tokens_out);
        burn_balance<T0>(arg0, v4);
        check_reserve<T0>(arg0);
        let v5 = Traded{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            trader       : 0x2::object::id_address<Curve<T0>>(arg0),
            is_buy       : true,
            sui_amount   : v2.gross_in,
            token_amount : v2.tokens_out,
            fee          : v2.fee,
            fee_bps      : v1,
            referrer     : 0x1::option::none<address>(),
            x            : arg0.x,
            y            : arg0.y,
            timestamp_ms : v0,
        };
        0x2::event::emit<Traded>(v5);
        (arg3, v2.tokens_out)
    }

    public fun cancel_cto<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::AdminCap, arg1: &mut Curve<T0>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        let v0 = CtoKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CtoKey>(&arg1.id, v0), 415);
        let v1 = CtoKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::remove<CtoKey, CtoProposal>(&mut arg1.id, v1);
        let v3 = CtoCancelled{
            curve_id : 0x2::object::id<Curve<T0>>(arg1),
            to       : v2.new_creator,
        };
        0x2::event::emit<CtoCancelled>(v3);
    }

    public(friend) fun cetus_tick_spacing() : u32 {
        200
    }

    public(friend) fun check_currency<T0>(arg0: &0x2::coin_registry::Currency<T0>, arg1: &0x2::coin::TreasuryCap<T0>) {
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(arg1)), 424);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg0), 425);
        assert!(0x2::coin_registry::decimals<T0>(arg0) == 6, 426);
    }

    fun check_reserve<T0>(arg0: &Curve<T0>) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) == arg0.x - arg0.virtual_sui, 408);
    }

    public fun circulating_supply<T0>(arg0: &Curve<T0>) : u64 {
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap), 412);
        0x2::coin::total_supply<T0>(0x1::option::borrow<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap))
    }

    public fun claim_creator_fees<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 406);
        assert!(!has_fee_mode<T0>(arg0), 420);
        let v0 = CreatorFeesClaimed{
            curve_id : 0x2::object::id<Curve<T0>>(arg0),
            creator  : arg0.creator,
            amount   : 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees),
        };
        0x2::event::emit<CreatorFeesClaimed>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.creator_fees), arg2)
    }

    public fun closer<T0>(arg0: &Curve<T0>) : address {
        arg0.closer
    }

    fun cooldown<T0>(arg0: &mut Curve<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.last_metadata_ms;
        let v2 = if (v1 == 0) {
            true
        } else if (v0 == v1) {
            true
        } else {
            v0 - v1 >= 3600000
        };
        assert!(v2, 410);
        arg0.last_metadata_ms = v0;
    }

    entry fun create<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: 0x2::coin::TreasuryCap<T0>, arg5: 0x2::coin_registry::MetadataCap<T0>, arg6: &0x2::coin_registry::Currency<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u8, arg13: &0x2::random::Random, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg0);
        assert!(!0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::is_sell_only(arg0), 400);
        check_currency<T0>(arg6, &arg4);
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::params(arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg2, arg3, &mut arg4, arg15);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, 0x2::sui::SUI>(arg2, arg3, 200, &v1, arg15);
        let v2 = 0x2::random::new_generator(arg13, arg15);
        let v3 = create_internal<T0>(arg0, arg1, arg4, 0x1::option::some<0x2::coin_registry::MetadataCap<T0>>(arg5), 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(v1), arg7, arg8, 0x2::random::generate_u64_in_range(&mut v2, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_min_ms(&v0), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_max_ms(&v0)), arg14, arg15);
        v3.links = new_links(arg9, arg10, arg11);
        let v4 = &mut v3;
        set_fee_mode<T0>(v4, fee_mode_preset(arg12));
        0x2::transfer::share_object<Curve<T0>>(v3);
    }

    public(friend) fun create_internal<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>, arg4: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Curve<T0> {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg0);
        assert!(!0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::is_sell_only(arg0), 400);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 407);
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::params(arg0);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = 0x2::clock::timestamp_ms(arg8);
        let v3 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::launch_fee(&v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v3 + arg6, 409);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_platform(arg1, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg5), v3));
        let v4 = initial_virtual_sui(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_sui(&v0));
        let v5 = initial_virtual_tokens();
        let v6 = Links{
            website  : 0x1::string::utf8(b""),
            x        : 0x1::string::utf8(b""),
            telegram : 0x1::string::utf8(b""),
        };
        let v7 = Curve<T0>{
            id                : 0x2::object::new(arg9),
            creator           : v1,
            treasury_cap      : 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg2),
            metadata_cap      : arg3,
            last_metadata_ms  : 0,
            links             : v6,
            pool_creation_cap : arg4,
            closer            : @0x0,
            params            : v0,
            virtual_sui       : v4,
            virtual_tokens    : v5,
            x                 : v4,
            y                 : v5,
            sui_reserve       : 0x2::balance::zero<0x2::sui::SUI>(),
            token_reserve     : 0x2::coin::mint_balance<T0>(&mut arg2, 800000000000000),
            lp_tokens         : 0x2::coin::mint_balance<T0>(&mut arg2, 200000000000000),
            liquidity_bonus   : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_fees      : 0x2::balance::zero<0x2::sui::SUI>(),
            created_ms        : v2,
            snipe_window_ms   : arg7,
            status            : 0,
        };
        let v8 = 0;
        if (arg6 > 0) {
            let v9 = price_buy(k_of(v7.virtual_sui, v7.virtual_tokens), v7.x, v7.y, 0x2::balance::value<T0>(&v7.token_reserve), arg6, 0);
            assert!(!v9.sells_out, 405);
            assert!(v9.tokens_out <= 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(1000000000000000, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::max_dev_buy_bps(&v0), 10000), 405);
            0x2::balance::join<0x2::sui::SUI>(&mut v7.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg5), v9.net_in));
            v7.x = v9.new_x;
            v7.y = v9.new_y;
            v8 = v9.tokens_out;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v7.token_reserve, v9.tokens_out, arg9), v1);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        };
        check_reserve<T0>(&v7);
        let v10 = Created{
            curve_id        : 0x2::object::id<Curve<T0>>(&v7),
            creator         : v1,
            graduation_sui  : 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_sui(&v0),
            snipe_window_ms : arg7,
            dev_buy_sui     : arg6,
            dev_buy_tokens  : v8,
            created_ms      : v2,
        };
        0x2::event::emit<Created>(v10);
        v7
    }

    public fun creator<T0>(arg0: &Curve<T0>) : address {
        arg0.creator
    }

    public(friend) fun creator_claim_mut<T0>(arg0: &mut Curve<T0>) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = CreatorClaimKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<CreatorClaimKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v0)
    }

    public fun creator_claimable<T0>(arg0: &Curve<T0>) : u64 {
        let v0 = CreatorClaimKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<CreatorClaimKey, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.id, v0)) {
            return 0
        };
        let v1 = CreatorClaimKey{dummy_field: false};
        0x2::balance::value<0x2::sui::SUI>(0x2::dynamic_field::borrow<CreatorClaimKey, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.id, v1))
    }

    public fun creator_fees<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees)
    }

    public fun cto_state<T0>(arg0: &Curve<T0>) : (bool, address, u64, bool) {
        let v0 = CtoKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<CtoKey>(&arg0.id, v0)) {
            return (false, @0x0, 0, false)
        };
        let v1 = CtoKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<CtoKey, CtoProposal>(&arg0.id, v1);
        (true, v2.new_creator, v2.ready_ms, v2.objected)
    }

    public fun curve_supply() : u64 {
        800000000000000
    }

    public fun decimals_unit() : u64 {
        1000000
    }

    fun distribute_fee<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u64, arg5: 0x1::option::Option<address>) {
        let v0 = &arg0.params;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        let v2 = 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v1 - 0x1::u64::min(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg4, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(v0), 10000), v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, 0x1::u64::min(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg4, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::creator_bps(v0), 10000), 0x2::balance::value<0x2::sui::SUI>(&arg3))));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.liquidity_bonus, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, 0x1::u64::min(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg4, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::liquidity_bps(v0), 10000), 0x2::balance::value<0x2::sui::SUI>(&arg3))));
        let v3 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg4, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::season_bps(v0), 10000);
        let v4 = v3;
        if (0x1::option::is_some<address>(&arg5)) {
            v4 = v3 - 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg4, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::referral_bps(v0) / 2, 10000);
            0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::accrue(arg2, 0x1::option::destroy_some<address>(arg5), 0x2::balance::split<0x2::sui::SUI>(&mut arg3, 0x1::u64::min(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg4, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::referral_bps(v0), 10000), 0x2::balance::value<0x2::sui::SUI>(&arg3))));
        };
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_season(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, 0x1::u64::min(v4, 0x2::balance::value<0x2::sui::SUI>(&arg3))));
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_platform(arg1, arg3);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_season(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v2, 0x2::balance::value<0x2::sui::SUI>(&v2) / 2));
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_platform(arg1, v2);
    }

    public fun execute_cto<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::AdminCap, arg1: &mut Curve<T0>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        let v0 = CtoKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CtoKey>(&arg1.id, v0), 415);
        let v1 = CtoKey{dummy_field: false};
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x2::dynamic_field::borrow<CtoKey, CtoProposal>(&arg1.id, v1).ready_ms, 416);
        let v2 = CtoKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::remove<CtoKey, CtoProposal>(&mut arg1.id, v2);
        let v4 = arg1.creator;
        let v5 = if (has_fee_mode<T0>(arg1)) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.creator_fees) == 0, 421);
            let v6 = CreatorClaimKey{dummy_field: false};
            0x2::balance::withdraw_all<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<CreatorClaimKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.id, v6))
        } else {
            0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.creator_fees)
        };
        let v7 = v5;
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&v7);
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg4), v4);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v7);
        };
        arg1.creator = v3.new_creator;
        let v9 = CtoExecuted{
            curve_id         : 0x2::object::id<Curve<T0>>(arg1),
            from             : v4,
            to               : v3.new_creator,
            fees_to_previous : v8,
        };
        0x2::event::emit<CtoExecuted>(v9);
    }

    public fun fee_mode<T0>(arg0: &Curve<T0>) : (u64, u64, u64) {
        if (!has_fee_mode<T0>(arg0)) {
            return (10000, 0, 0)
        };
        let v0 = FeeModeKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<FeeModeKey, FeeMode>(&arg0.id, v0);
        (v1.creator_bps, v1.buyback_bps, v1.holders_bps)
    }

    public fun fee_mode_preset(arg0: u8) : FeeMode {
        if (arg0 == 0) {
            FeeMode{creator_bps: 10000, buyback_bps: 0, holders_bps: 0}
        } else if (arg0 == 1) {
            FeeMode{creator_bps: 0, buyback_bps: 10000, holders_bps: 0}
        } else if (arg0 == 2) {
            FeeMode{creator_bps: 0, buyback_bps: 0, holders_bps: 10000}
        } else {
            assert!(arg0 == 3, 419);
            FeeMode{creator_bps: 5000, buyback_bps: 2500, holders_bps: 2500}
        }
    }

    public fun fee_mode_split(arg0: &FeeMode) : (u64, u64, u64) {
        (arg0.creator_bps, arg0.buyback_bps, arg0.holders_bps)
    }

    public fun has_fee_mode<T0>(arg0: &Curve<T0>) : bool {
        let v0 = FeeModeKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<FeeModeKey, FeeMode>(&arg0.id, v0)
    }

    public fun initial_virtual_sui(arg0: u64) : u64 {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg0, 25, 74)
    }

    public fun initial_virtual_tokens() : u64 {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(800000000000000, 99, 74)
    }

    public(friend) fun is_graduated<T0>(arg0: &Curve<T0>) : bool {
        arg0.status == 2
    }

    public fun is_ready_to_graduate<T0>(arg0: &Curve<T0>) : bool {
        arg0.status == 1
    }

    public(friend) fun is_trading<T0>(arg0: &Curve<T0>) : bool {
        arg0.status == 0
    }

    public fun is_valid_link(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0) {
            return true
        };
        if (v1 > 200 || v1 <= 8) {
            return false
        };
        let v2 = b"https://";
        let v3 = 0;
        while (v3 < 8) {
            if (*0x1::vector::borrow<u8>(v0, v3) != *0x1::vector::borrow<u8>(&v2, v3)) {
                return false
            };
            v3 = v3 + 1;
        };
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u8>(v0, v3);
            let v5 = if (v4 <= 32) {
                true
            } else if (v4 == 34) {
                true
            } else if (v4 == 39) {
                true
            } else if (v4 == 60) {
                true
            } else if (v4 == 62) {
                true
            } else if (v4 == 92) {
                true
            } else {
                v4 == 127
            };
            if (v5) {
                return false
            };
            v3 = v3 + 1;
        };
        true
    }

    fun k_of(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun last_metadata_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.last_metadata_ms
    }

    public fun links<T0>(arg0: &Curve<T0>) : Links {
        arg0.links
    }

    public fun links_telegram(arg0: &Links) : 0x1::string::String {
        arg0.telegram
    }

    public fun links_website(arg0: &Links) : 0x1::string::String {
        arg0.website
    }

    public fun links_x(arg0: &Links) : 0x1::string::String {
        arg0.x
    }

    public fun liquidity_bonus<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.liquidity_bonus)
    }

    public fun lp_supply() : u64 {
        200000000000000
    }

    public fun lp_tokens<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.lp_tokens)
    }

    public(friend) fun mark_graduated<T0>(arg0: &mut Curve<T0>) {
        arg0.status = 2;
    }

    fun metadata_guard<T0>(arg0: &mut Curve<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 406);
        assert!(arg0.status == 0, 401);
        assert!(0x1::option::is_some<0x2::coin_registry::MetadataCap<T0>>(&arg0.metadata_cap), 411);
        cooldown<T0>(arg0, arg1);
    }

    public fun new_links(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : Links {
        let v0 = if (is_valid_link(&arg0)) {
            if (is_valid_link(&arg1)) {
                is_valid_link(&arg2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 413);
        Links{
            website  : arg0,
            x        : arg1,
            telegram : arg2,
        }
    }

    public fun object_cto<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 406);
        let v0 = CtoKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CtoKey>(&arg0.id, v0), 415);
        assert!(0x1::string::length(&arg2) <= 280, 418);
        let v1 = CtoKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<CtoKey, CtoProposal>(&mut arg0.id, v1).objected = true;
        let v2 = CtoObjected{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            creator      : arg0.creator,
            reason       : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CtoObjected>(v2);
    }

    public(friend) fun params_of<T0>(arg0: &Curve<T0>) : 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Params {
        arg0.params
    }

    public(friend) fun pool_creation_cap<T0>(arg0: &Curve<T0>) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap {
        0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg0.pool_creation_cap)
    }

    public fun price_buy(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : BuyQuote {
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div_up(arg4, arg5, 10000);
        assert!(arg4 > v0, 403);
        let v1 = arg4 - v0;
        let v2 = arg1 + v1;
        let v3 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::to_u64(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::div_up_u128(arg0, (v2 as u128)));
        let v4 = arg2 - v3;
        if (v4 < arg3) {
            return BuyQuote{
                tokens_out : v4,
                net_in     : v1,
                fee        : v0,
                gross_in   : arg4,
                sells_out  : false,
                new_x      : v2,
                new_y      : v3,
            }
        };
        let v5 = arg2 - arg3;
        let v6 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::to_u64(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::div_up_u128(arg0, (v5 as u128)));
        let v7 = v6 - arg1;
        let v8 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div_up(v7, arg5, 10000 - arg5);
        BuyQuote{
            tokens_out : arg3,
            net_in     : v7,
            fee        : v8,
            gross_in   : v7 + v8,
            sells_out  : true,
            new_x      : v6,
            new_y      : v5,
        }
    }

    public fun price_sell(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64, u64, u64) {
        assert!(arg3 > 0, 403);
        let v0 = arg2 + arg3;
        let v1 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::to_u64(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::div_up_u128(arg0, (v0 as u128)));
        let v2 = arg1 - v1;
        let v3 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div_up(v2, arg4, 10000);
        assert!(v2 > v3, 403);
        (v2, v3, v2 - v3, v1, v0)
    }

    public fun propose_cto<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::AdminCap, arg1: &mut Curve<T0>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg3: address, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        let v0 = CtoKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<CtoKey>(&arg1.id, v0), 414);
        assert!(arg3 != arg1.creator, 417);
        assert!(arg3 != @0x0, 427);
        assert!(0x1::string::length(&arg4) <= 280, 418);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = v1 + 259200000;
        let v3 = CtoProposed{
            curve_id : 0x2::object::id<Curve<T0>>(arg1),
            from     : arg1.creator,
            to       : arg3,
            reason   : arg4,
            ready_ms : v2,
        };
        0x2::event::emit<CtoProposed>(v3);
        let v4 = CtoKey{dummy_field: false};
        let v5 = CtoProposal{
            new_creator : arg3,
            reason      : arg4,
            proposed_ms : v1,
            ready_ms    : v2,
            objected    : false,
        };
        0x2::dynamic_field::add<CtoKey, CtoProposal>(&mut arg1.id, v4, v5);
    }

    public fun quote_buy<T0>(arg0: &Curve<T0>, arg1: u64, arg2: &0x2::clock::Clock) : BuyQuote {
        price_buy(k_of(arg0.virtual_sui, arg0.virtual_tokens), arg0.x, arg0.y, 0x2::balance::value<T0>(&arg0.token_reserve), arg1, buy_fee_bps_at(&arg0.params, arg0.created_ms, arg0.snipe_window_ms, 0x2::clock::timestamp_ms(arg2)))
    }

    public fun quote_fee(arg0: &BuyQuote) : u64 {
        arg0.fee
    }

    public fun quote_gross_in(arg0: &BuyQuote) : u64 {
        arg0.gross_in
    }

    public fun quote_sells_out(arg0: &BuyQuote) : bool {
        arg0.sells_out
    }

    public fun quote_tokens_out(arg0: &BuyQuote) : u64 {
        arg0.tokens_out
    }

    public fun raised<T0>(arg0: &Curve<T0>) : u64 {
        arg0.x - arg0.virtual_sui
    }

    public fun reopen_trading<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &0x2::clock::Clock) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(arg0.status == 1, 428);
        let v0 = StuckKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<StuckKey>(&arg0.id, v0), 430);
        let v1 = StuckKey{dummy_field: false};
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x2::dynamic_field::remove<StuckKey, u64>(&mut arg0.id, v1), 431);
        arg0.status = 0;
        arg0.closer = @0x0;
        let v2 = TradingReopened{
            curve_id    : 0x2::object::id<Curve<T0>>(arg0),
            tokens_left : 0x2::balance::value<T0>(&arg0.token_reserve),
        };
        0x2::event::emit<TradingReopened>(v2);
    }

    public fun report_stuck<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(arg0.status == 1, 428);
        let v0 = StuckKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<StuckKey>(&arg0.id, v0), 429);
        let v1 = 0x2::clock::timestamp_ms(arg2) + 86400000;
        let v2 = StuckKey{dummy_field: false};
        0x2::dynamic_field::add<StuckKey, u64>(&mut arg0.id, v2, v1);
        let v3 = GraduationStuckReported{
            curve_id  : 0x2::object::id<Curve<T0>>(arg0),
            reporter  : 0x2::tx_context::sender(arg3),
            reopen_ms : v1,
        };
        0x2::event::emit<GraduationStuckReported>(v3);
    }

    public fun reserves<T0>(arg0: &Curve<T0>) : (u64, u64) {
        (arg0.x, arg0.y)
    }

    public fun sell<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(arg0.status == 0, 401);
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(&arg0.params);
        let (v2, v3, v4, v5, v6) = price_sell(k_of(arg0.virtual_sui, arg0.virtual_tokens), arg0.x, arg0.y, v0, v1);
        assert!(v4 >= arg5, 402);
        let v7 = 0x2::tx_context::sender(arg8);
        let v8 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::resolve(arg3, v7, arg6);
        let v9 = if (0x1::option::is_some<address>(&v8) && *0x1::option::borrow<address>(&v8) == arg0.creator) {
            0x1::option::none<address>()
        } else {
            v8
        };
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg4));
        let v10 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v2);
        distribute_fee<T0>(arg0, arg2, arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v10, v3), v2, v9);
        arg0.x = v5;
        arg0.y = v6;
        check_reserve<T0>(arg0);
        let v11 = Traded{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            trader       : v7,
            is_buy       : false,
            sui_amount   : v2,
            token_amount : v0,
            fee          : v3,
            fee_bps      : v1,
            referrer     : v9,
            x            : arg0.x,
            y            : arg0.y,
            timestamp_ms : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<Traded>(v11);
        0x2::coin::from_balance<0x2::sui::SUI>(v10, arg8)
    }

    fun set_fee_mode<T0>(arg0: &mut Curve<T0>, arg1: FeeMode) {
        if (arg1.creator_bps == 10000) {
            return
        };
        let v0 = if (arg1.buyback_bps == 10000) {
            1
        } else if (arg1.holders_bps == 10000) {
            2
        } else {
            3
        };
        let v1 = FeeModeSet{
            curve_id    : 0x2::object::id<Curve<T0>>(arg0),
            mode        : v0,
            creator_bps : arg1.creator_bps,
            buyback_bps : arg1.buyback_bps,
            holders_bps : arg1.holders_bps,
        };
        0x2::event::emit<FeeModeSet>(v1);
        let v2 = FeeModeKey{dummy_field: false};
        0x2::dynamic_field::add<FeeModeKey, FeeMode>(&mut arg0.id, v2, arg1);
        let v3 = CreatorClaimKey{dummy_field: false};
        0x2::dynamic_field::add<CreatorClaimKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v3, 0x2::balance::zero<0x2::sui::SUI>());
    }

    public fun set_links<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg6) == arg0.creator, 406);
        cooldown<T0>(arg0, arg5);
        arg0.links = new_links(arg2, arg3, arg4);
        let v0 = LinksChanged{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            links        : arg0.links,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<LinksChanged>(v0);
    }

    public(friend) fun settle_graduation<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: u64) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>, u64, u64, u64) {
        let (v0, v1, v2) = take_graduation_assets<T0>(arg0);
        let v3 = v0;
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v5 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(v4, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_creator_bps(&arg0.params), 10000);
        let v6 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(v4, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_platform_bps(&arg0.params), 10000);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v5));
        let v7 = 0x2::balance::split<0x2::sui::SUI>(&mut v3, v6);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_platform(arg1, v7);
        0x2::balance::join<0x2::sui::SUI>(&mut v3, v1);
        (v3, v2, 0x2::balance::split<0x2::sui::SUI>(&mut v7, 0x1::u64::min(v6, arg2)), v4, v5, v6)
    }

    fun snipe_tx_bought<T0>(arg0: &mut Curve<T0>, arg1: vector<u8>, arg2: u64) : u64 {
        let v0 = SnipeTxKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<SnipeTxKey>(&arg0.id, v0)) {
            let v1 = SnipeTxKey{dummy_field: false};
            let v2 = SnipeTx{
                digest : arg1,
                bought : arg2,
            };
            0x2::dynamic_field::add<SnipeTxKey, SnipeTx>(&mut arg0.id, v1, v2);
            return arg2
        };
        let v3 = SnipeTxKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<SnipeTxKey, SnipeTx>(&mut arg0.id, v3);
        if (v4.digest != arg1) {
            v4.digest = arg1;
            v4.bought = 0;
        };
        v4.bought = v4.bought + arg2;
        v4.bought
    }

    public fun snipe_window_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.snipe_window_ms
    }

    public(friend) fun stash_tokens_to_burn<T0>(arg0: &mut Curve<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = TokensToBurnKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<TokensToBurnKey>(&arg0.id, v0)) {
            let v1 = TokensToBurnKey{dummy_field: false};
            0x2::dynamic_field::add<TokensToBurnKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::balance::zero<T0>());
        };
        let v2 = TokensToBurnKey{dummy_field: false};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<TokensToBurnKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), arg1);
    }

    public fun status<T0>(arg0: &Curve<T0>) : u8 {
        arg0.status
    }

    public fun stuck_reopen_ms<T0>(arg0: &Curve<T0>) : 0x1::option::Option<u64> {
        let v0 = StuckKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<StuckKey>(&arg0.id, v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = StuckKey{dummy_field: false};
        0x1::option::some<u64>(*0x2::dynamic_field::borrow<StuckKey, u64>(&arg0.id, v1))
    }

    public fun sui_reserve<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public(friend) fun take_creator_fees<T0>(arg0: &mut Curve<T0>) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.creator_fees)
    }

    public(friend) fun take_graduation_assets<T0>(arg0: &mut Curve<T0>) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        (0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_reserve), 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.liquidity_bonus), 0x2::balance::withdraw_all<T0>(&mut arg0.lp_tokens))
    }

    public(friend) fun take_metadata_cap<T0>(arg0: &mut Curve<T0>) : 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>> {
        if (0x1::option::is_some<0x2::coin_registry::MetadataCap<T0>>(&arg0.metadata_cap)) {
            0x1::option::some<0x2::coin_registry::MetadataCap<T0>>(0x1::option::extract<0x2::coin_registry::MetadataCap<T0>>(&mut arg0.metadata_cap))
        } else {
            0x1::option::none<0x2::coin_registry::MetadataCap<T0>>()
        }
    }

    public(friend) fun take_tokens_to_burn<T0>(arg0: &mut Curve<T0>) : 0x2::balance::Balance<T0> {
        let v0 = TokensToBurnKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<TokensToBurnKey>(&arg0.id, v0)) {
            return 0x2::balance::zero<T0>()
        };
        let v1 = TokensToBurnKey{dummy_field: false};
        0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<TokensToBurnKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1))
    }

    public(friend) fun take_treasury_cap<T0>(arg0: &mut Curve<T0>) : 0x2::coin::TreasuryCap<T0> {
        0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap)
    }

    public fun tokens_left<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.token_reserve)
    }

    public fun transfer_creator<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 406);
        assert!(arg2 != @0x0, 427);
        let v0 = CtoKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<CtoKey>(&arg0.id, v0), 414);
        let v1 = CreatorTransferred{
            curve_id : 0x2::object::id<Curve<T0>>(arg0),
            from     : arg0.creator,
            to       : arg2,
        };
        0x2::event::emit<CreatorTransferred>(v1);
        arg0.creator = arg2;
    }

    public(friend) fun uid<T0>(arg0: &Curve<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut<T0>(arg0: &mut Curve<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun virtuals<T0>(arg0: &Curve<T0>) : (u64, u64) {
        (arg0.virtual_sui, arg0.virtual_tokens)
    }

    // decompiled from Move bytecode v7
}

