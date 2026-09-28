module 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve {
    struct QCurve<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        creator: address,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        metadata_cap: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>,
        last_metadata_ms: u64,
        links: 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Links,
        pool_creation_cap: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>,
        closer: address,
        params: 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Params,
        graduation: u64,
        virtual_quote: u64,
        virtual_tokens: u64,
        x: u64,
        y: u64,
        quote_reserve: 0x2::balance::Balance<T1>,
        token_reserve: 0x2::balance::Balance<T0>,
        lp_tokens: 0x2::balance::Balance<T0>,
        liquidity_bonus: 0x2::balance::Balance<T1>,
        creator_fees: 0x2::balance::Balance<T1>,
        created_ms: u64,
        snipe_window_ms: u64,
        status: u8,
    }

    struct QuoteCurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        quote: 0x1::ascii::String,
        graduation: u64,
        snipe_window_ms: u64,
        dev_buy: u64,
        dev_buy_tokens: u64,
        created_ms: u64,
    }

    struct QuoteTraded has copy, drop {
        curve_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        quote_amount: u64,
        token_amount: u64,
        fee: u64,
        fee_bps: u64,
        referrer: 0x1::option::Option<address>,
        x: u64,
        y: u64,
        timestamp_ms: u64,
    }

    struct QuoteReadyToGraduate has copy, drop {
        curve_id: 0x2::object::ID,
        raised: u64,
    }

    struct QuoteCreatorFeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    struct QuoteCreatorTransferred has copy, drop {
        curve_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct QuoteMetadataChanged has copy, drop {
        curve_id: 0x2::object::ID,
        field: u8,
        timestamp_ms: u64,
    }

    struct QuoteLinksChanged has copy, drop {
        curve_id: 0x2::object::ID,
        links: 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Links,
        timestamp_ms: u64,
    }

    struct QuoteBurned has copy, drop {
        curve_id: 0x2::object::ID,
        burner: address,
        amount: u64,
        total_supply: u64,
    }

    public fun burn<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap), 1111);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1112);
        let v1 = 0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap);
        0x2::coin::burn<T0>(v1, arg2);
        let v2 = QuoteBurned{
            curve_id     : 0x2::object::id<QCurve<T0, T1>>(arg0),
            burner       : 0x2::tx_context::sender(arg3),
            amount       : v0,
            total_supply : 0x2::coin::total_supply<T0>(v1),
        };
        0x2::event::emit<QuoteBurned>(v2);
    }

    public fun set_description<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        metadata_guard<T0, T1>(arg0, arg4, arg5);
        0x2::coin_registry::set_description<T0>(arg2, 0x1::option::borrow<0x2::coin_registry::MetadataCap<T0>>(&arg0.metadata_cap), arg3);
        let v0 = QuoteMetadataChanged{
            curve_id     : 0x2::object::id<QCurve<T0, T1>>(arg0),
            field        : 1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<QuoteMetadataChanged>(v0);
    }

    public fun set_icon_url<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        metadata_guard<T0, T1>(arg0, arg4, arg5);
        0x2::coin_registry::set_icon_url<T0>(arg2, 0x1::option::borrow<0x2::coin_registry::MetadataCap<T0>>(&arg0.metadata_cap), arg3);
        let v0 = QuoteMetadataChanged{
            curve_id     : 0x2::object::id<QCurve<T0, T1>>(arg0),
            field        : 2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<QuoteMetadataChanged>(v0);
    }

    public fun set_name<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        metadata_guard<T0, T1>(arg0, arg4, arg5);
        0x2::coin_registry::set_name<T0>(arg2, 0x1::option::borrow<0x2::coin_registry::MetadataCap<T0>>(&arg0.metadata_cap), arg3);
        let v0 = QuoteMetadataChanged{
            curve_id     : 0x2::object::id<QCurve<T0, T1>>(arg0),
            field        : 0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<QuoteMetadataChanged>(v0);
    }

    public(friend) fun add_creator_fee<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.creator_fees, arg1);
    }

    public(friend) fun burn_balance<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap)), arg1);
    }

    public fun buy<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: 0x1::option::Option<address>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(!0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::is_sell_only(arg1), 1100);
        assert!(arg0.status == 0, 1101);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = arg0.created_ms;
        let v2 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_max_ms(&arg0.params);
        if (0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::open_or_abort_at(&mut arg0.id, 0x2::object::id<QCurve<T0, T1>>(arg0), v1, v2, v0)) {
            arg0.snipe_window_ms = v2;
        };
        let v3 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::snipe_start_at(&arg0.id, v1);
        let v4 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::with_tax_at(&arg0.id, &arg0.params, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::buy_fee_bps_at(&arg0.params, v3, arg0.snipe_window_ms, v0));
        let v5 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::price_buy(k<T0, T1>(arg0), arg0.x, arg0.y, 0x2::balance::value<T0>(&arg0.token_reserve), arg5, v4);
        let v6 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::quote_tokens_out(&v5);
        assert!(v6 > 0 && v6 >= arg6, 1102);
        if (v0 - v3 < arg0.snipe_window_ms) {
            assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::snipe_tx_bought_at(&mut arg0.id, *0x2::tx_context::digest(arg9), v6) <= 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::total_supply(), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_tx_cap_bps(&arg0.params), 10000), 1103);
        };
        execute_buy<T0, T1>(arg0, arg2, arg3, arg4, v5, v4, arg7, v0, arg9)
    }

    public fun buy_with_proof<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: 0x1::option::Option<address>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(!0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::is_sell_only(arg1), 1100);
        assert!(arg0.status == 0, 1101);
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::has_launch_at(&arg0.id), 1120);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let (v1, v2) = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::wl_phase_at(&arg0.id, arg0.created_ms, v0);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg10);
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::wl_spent_at(&arg0.id, v4) < v2, 1117);
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::merkle::verify(&v3, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::merkle::address_leaf(v4), &arg8), 1119);
        whitelist_buy<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, v0, arg10)
    }

    public fun cancel_cto<T0, T1>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::AdminCap, arg1: &mut QCurve<T0, T1>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::cancel_cto_at(&mut arg1.id, 0x2::object::id<QCurve<T0, T1>>(arg1));
    }

    fun check_reserve<T0, T1>(arg0: &QCurve<T0, T1>) {
        assert!(0x2::balance::value<T1>(&arg0.quote_reserve) == arg0.x - arg0.virtual_quote, 1107);
    }

    public fun circulating_supply<T0, T1>(arg0: &QCurve<T0, T1>) : u64 {
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap), 1111);
        0x2::coin::total_supply<T0>(0x1::option::borrow<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap))
    }

    public fun claim_creator_fees<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1105);
        let v0 = QuoteCreatorFeesClaimed{
            curve_id : 0x2::object::id<QCurve<T0, T1>>(arg0),
            creator  : arg0.creator,
            amount   : 0x2::balance::value<T1>(&arg0.creator_fees),
        };
        0x2::event::emit<QuoteCreatorFeesClaimed>(v0);
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.creator_fees), arg2)
    }

    public fun closer<T0, T1>(arg0: &QCurve<T0, T1>) : address {
        arg0.closer
    }

    public(friend) fun configure_launch<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: u64, arg2: u64, arg3: 0x1::option::Option<0x2::object::ID>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::configure_launch_at(&mut arg0.id, 0x2::object::id<QCurve<T0, T1>>(arg0), arg0.created_ms, arg0.graduation, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun cooldown<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::check_cooldown(arg0.last_metadata_ms, v0);
        arg0.last_metadata_ms = v0;
    }

    entry fun create<T0, T1>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: 0x2::coin::TreasuryCap<T0>, arg5: 0x2::coin_registry::MetadataCap<T0>, arg6: &0x2::coin_registry::Currency<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: 0x1::string::String, arg19: &0x2::random::Random, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg0);
        assert!(!0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::is_sell_only(arg0), 1100);
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::quote_params<T1>(arg0);
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::quote_enabled(&v0), 1109);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::check_currency<T0>(arg6, &arg4);
        let v1 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::params(arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg2, arg3, &mut arg4, arg21);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, T1>(arg2, arg3, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::cetus_tick_spacing(), &v2, arg21);
        let v3 = 0x2::random::new_generator(arg19, arg21);
        let (v4, v5) = create_locked<T0, T1>(arg0, arg1, arg4, 0x1::option::some<0x2::coin_registry::MetadataCap<T0>>(arg5), 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(v2), arg7, arg8, arg9, 0x2::random::generate_u64_in_range(&mut v3, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_min_ms(&v1), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_max_ms(&v1)), arg20, arg21);
        let v6 = v4;
        v6.links = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::new_links(arg16, arg17, arg18);
        let v7 = &mut v6;
        configure_launch<T0, T1>(v7, arg8, arg9, v5, arg10, arg11, arg12, arg13, arg14, arg15);
        0x2::transfer::share_object<QCurve<T0, T1>>(v6);
    }

    public(friend) fun create_locked<T0, T1>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>, arg4: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (QCurve<T0, T1>, 0x1::option::Option<0x2::object::ID>) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg0);
        assert!(!0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::is_sell_only(arg0), 1100);
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::quote_params<T1>(arg0);
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::quote_enabled(&v0), 1109);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 1106);
        assert!(arg7 == 0 || arg6 > 0, 1116);
        let v1 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::params(arg0);
        let v2 = 0x2::tx_context::sender(arg10);
        let v3 = 0x2::clock::timestamp_ms(arg9);
        let v4 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::quote_launch_fee(&v0);
        assert!(0x2::coin::value<T1>(&arg5) >= v4 + arg6, 1108);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_quote_platform<T1>(arg1, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut arg5), v4));
        let v5 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::quote_graduation(&v0);
        let v6 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::initial_virtual_sui(v5);
        let v7 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::initial_virtual_tokens();
        let v8 = QCurve<T0, T1>{
            id                : 0x2::object::new(arg10),
            creator           : v2,
            treasury_cap      : 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg2),
            metadata_cap      : arg3,
            last_metadata_ms  : 0,
            links             : 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::new_links(0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b"")),
            pool_creation_cap : arg4,
            closer            : @0x0,
            params            : v1,
            graduation        : v5,
            virtual_quote     : v6,
            virtual_tokens    : v7,
            x                 : v6,
            y                 : v7,
            quote_reserve     : 0x2::balance::zero<T1>(),
            token_reserve     : 0x2::coin::mint_balance<T0>(&mut arg2, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::curve_supply()),
            lp_tokens         : 0x2::coin::mint_balance<T0>(&mut arg2, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::lp_supply()),
            liquidity_bonus   : 0x2::balance::zero<T1>(),
            creator_fees      : 0x2::balance::zero<T1>(),
            created_ms        : v3,
            snipe_window_ms   : arg8,
            status            : 0,
        };
        let v9 = 0;
        let v10 = 0x1::option::none<0x2::object::ID>();
        if (arg6 > 0) {
            let v11 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::price_buy(k<T0, T1>(&v8), v8.x, v8.y, 0x2::balance::value<T0>(&v8.token_reserve), arg6, 0);
            let (v12, v13, _, _, v16, v17, v18) = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::buy_quote_parts(&v11);
            assert!(!v16, 1104);
            assert!(v12 <= 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::total_supply(), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::max_dev_buy_bps(&v1), 10000), 1104);
            0x2::balance::join<T1>(&mut v8.quote_reserve, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut arg5), v13));
            v8.x = v17;
            v8.y = v18;
            v9 = v12;
            if (arg7 > 0) {
                let v19 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::vesting::new_lock<T0>(0x2::coin::take<T0>(&mut v8.token_reserve, v12, arg10), arg7, v2, arg9, arg10);
                v10 = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::vesting::VestingLock<T0>>(&v19));
                0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::vesting::share<T0>(v19);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v8.token_reserve, v12, arg10), v2);
            };
        };
        if (0x2::coin::value<T1>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, v2);
        } else {
            0x2::coin::destroy_zero<T1>(arg5);
        };
        check_reserve<T0, T1>(&v8);
        let v20 = QuoteCurveCreated{
            curve_id        : 0x2::object::id<QCurve<T0, T1>>(&v8),
            creator         : v2,
            quote           : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            graduation      : v5,
            snipe_window_ms : arg8,
            dev_buy         : arg6,
            dev_buy_tokens  : v9,
            created_ms      : v3,
        };
        0x2::event::emit<QuoteCurveCreated>(v20);
        (v8, v10)
    }

    public fun creator<T0, T1>(arg0: &QCurve<T0, T1>) : address {
        arg0.creator
    }

    public fun creator_fees<T0, T1>(arg0: &QCurve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.creator_fees)
    }

    public fun creator_tax_bps<T0, T1>(arg0: &QCurve<T0, T1>) : u64 {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::creator_tax_at(&arg0.id)
    }

    public fun cto_state<T0, T1>(arg0: &QCurve<T0, T1>) : (bool, address, u64, bool) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::cto_state_at(&arg0.id)
    }

    fun distribute_fee<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: u64) {
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::fee_shares(&arg0.params, 0x2::balance::value<T1>(&arg3), arg4, arg6, 0x1::option::is_some<address>(&arg5));
        let (v1, v2, v3, v4, v5, _, v7, _) = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::fee_shares_split(&v0);
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut arg3, v2 + v1));
        0x2::balance::join<T1>(&mut arg0.liquidity_bonus, 0x2::balance::split<T1>(&mut arg3, v3));
        if (0x1::option::is_some<address>(&arg5)) {
            0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::accrue_quote<T1>(arg2, 0x1::option::destroy_some<address>(arg5), 0x2::balance::split<T1>(&mut arg3, v4));
        };
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_quote_season<T1>(arg1, 0x2::balance::split<T1>(&mut arg3, v5 + v7));
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_quote_platform<T1>(arg1, arg3);
    }

    fun execute_buy<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg3: &mut 0x2::coin::Coin<T1>, arg4: 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::BuyQuote, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2, v3, v4, v5, v6) = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::buy_quote_parts(&arg4);
        assert!(0x2::coin::value<T1>(arg3) >= v3, 1108);
        let v7 = 0x2::tx_context::sender(arg8);
        let v8 = resolve_referrer<T0, T1>(arg0, arg2, v7, arg6);
        let v9 = 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg3), v3);
        0x2::balance::join<T1>(&mut arg0.quote_reserve, 0x2::balance::split<T1>(&mut v9, v1));
        let v10 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::creator_tax_at(&arg0.id);
        distribute_fee<T0, T1>(arg0, arg1, arg2, v9, v3, v8, v10);
        arg0.x = v5;
        arg0.y = v6;
        check_reserve<T0, T1>(arg0);
        let v11 = QuoteTraded{
            curve_id     : 0x2::object::id<QCurve<T0, T1>>(arg0),
            trader       : v7,
            is_buy       : true,
            quote_amount : v3,
            token_amount : v0,
            fee          : v2,
            fee_bps      : arg5,
            referrer     : v8,
            x            : arg0.x,
            y            : arg0.y,
            timestamp_ms : arg7,
        };
        0x2::event::emit<QuoteTraded>(v11);
        if (v4) {
            arg0.status = 1;
            arg0.closer = v7;
            let v12 = QuoteReadyToGraduate{
                curve_id : 0x2::object::id<QCurve<T0, T1>>(arg0),
                raised   : arg0.x - arg0.virtual_quote,
            };
            0x2::event::emit<QuoteReadyToGraduate>(v12);
        };
        0x2::coin::take<T0>(&mut arg0.token_reserve, v0, arg8)
    }

    public fun execute_cto<T0, T1>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::AdminCap, arg1: &mut QCurve<T0, T1>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::take_ready_cto_at(&mut arg1.id, 0x2::clock::timestamp_ms(arg3));
        let v1 = arg1.creator;
        let v2 = 0x2::balance::withdraw_all<T1>(&mut arg1.creator_fees);
        let v3 = 0x2::balance::value<T1>(&v2);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg4), v1);
        } else {
            0x2::balance::destroy_zero<T1>(v2);
        };
        arg1.creator = v0;
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::emit_cto_executed(0x2::object::id<QCurve<T0, T1>>(arg1), v1, v0, v3);
    }

    public fun graduation<T0, T1>(arg0: &QCurve<T0, T1>) : u64 {
        arg0.graduation
    }

    public(friend) fun is_graduated<T0, T1>(arg0: &QCurve<T0, T1>) : bool {
        arg0.status == 2
    }

    public fun is_ready_to_graduate<T0, T1>(arg0: &QCurve<T0, T1>) : bool {
        arg0.status == 1
    }

    fun k<T0, T1>(arg0: &QCurve<T0, T1>) : u128 {
        (arg0.virtual_quote as u128) * (arg0.virtual_tokens as u128)
    }

    public fun launch_phase<T0, T1>(arg0: &QCurve<T0, T1>, arg1: &0x2::clock::Clock) : u8 {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::launch_phase_at(&arg0.id, arg0.created_ms, 0x2::clock::timestamp_ms(arg1))
    }

    public fun launch_schedule<T0, T1>(arg0: &QCurve<T0, T1>) : (u64, u64, u64) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::launch_schedule_at(&arg0.id, arg0.created_ms)
    }

    public fun links<T0, T1>(arg0: &QCurve<T0, T1>) : 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::Links {
        arg0.links
    }

    public fun liquidity_bonus<T0, T1>(arg0: &QCurve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.liquidity_bonus)
    }

    public fun lower_creator_tax<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 1105);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::lower_creator_tax_at(&mut arg0.id, 0x2::object::id<QCurve<T0, T1>>(arg0), arg2);
    }

    public fun lp_tokens<T0, T1>(arg0: &QCurve<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.lp_tokens)
    }

    public(friend) fun mark_graduated<T0, T1>(arg0: &mut QCurve<T0, T1>) {
        arg0.status = 2;
    }

    fun metadata_guard<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1105);
        assert!(arg0.status == 0, 1101);
        assert!(0x1::option::is_some<0x2::coin_registry::MetadataCap<T0>>(&arg0.metadata_cap), 1110);
        cooldown<T0, T1>(arg0, arg1);
    }

    public fun object_cto<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 1105);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::object_cto_at(&mut arg0.id, 0x2::object::id<QCurve<T0, T1>>(arg0), arg0.creator, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    entry fun open<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        let v0 = 0x2::random::new_generator(arg2, arg4);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_min_ms(&arg0.params), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_max_ms(&arg0.params));
        open_with_window<T0, T1>(arg0, v1, arg3);
    }

    public(friend) fun open_with_window<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 1101);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::open_at(&mut arg0.id, 0x2::object::id<QCurve<T0, T1>>(arg0), arg0.created_ms, arg1, 0x2::clock::timestamp_ms(arg2));
        arg0.snipe_window_ms = arg1;
    }

    public(friend) fun pool_creation_cap<T0, T1>(arg0: &QCurve<T0, T1>) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap {
        0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg0.pool_creation_cap)
    }

    public fun propose_cto<T0, T1>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::AdminCap, arg1: &mut QCurve<T0, T1>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg3: address, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::propose_cto_at(&mut arg1.id, 0x2::object::id<QCurve<T0, T1>>(arg1), arg1.creator, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    public fun quote_buy<T0, T1>(arg0: &QCurve<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::BuyQuote {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::price_buy(k<T0, T1>(arg0), arg0.x, arg0.y, 0x2::balance::value<T0>(&arg0.token_reserve), arg1, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::with_tax_at(&arg0.id, &arg0.params, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::buy_fee_now_at(&arg0.id, &arg0.params, arg0.created_ms, arg0.snipe_window_ms, 0x2::clock::timestamp_ms(arg2))))
    }

    public fun quote_reserve<T0, T1>(arg0: &QCurve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_reserve)
    }

    public fun raised<T0, T1>(arg0: &QCurve<T0, T1>) : u64 {
        arg0.x - arg0.virtual_quote
    }

    public fun reopen_trading<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &0x2::clock::Clock) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(arg0.status == 1, 1115);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::take_stuck_at(&mut arg0.id, 0x2::object::id<QCurve<T0, T1>>(arg0), 0x2::balance::value<T0>(&arg0.token_reserve), 0x2::clock::timestamp_ms(arg2));
        arg0.status = 0;
        arg0.closer = @0x0;
    }

    public fun report_stuck<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(arg0.status == 1, 1115);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::report_stuck_at(&mut arg0.id, 0x2::object::id<QCurve<T0, T1>>(arg0), 0x2::tx_context::sender(arg3), 0x2::clock::timestamp_ms(arg2));
    }

    public fun reserves<T0, T1>(arg0: &QCurve<T0, T1>) : (u64, u64) {
        (arg0.x, arg0.y)
    }

    fun resolve_referrer<T0, T1>(arg0: &QCurve<T0, T1>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg2: address, arg3: 0x1::option::Option<address>) : 0x1::option::Option<address> {
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::resolve(arg1, arg2, arg3);
        if (0x1::option::is_some<address>(&v0) && *0x1::option::borrow<address>(&v0) == arg0.creator) {
            0x1::option::none<address>()
        } else {
            v0
        }
    }

    public fun sell<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(arg0.status == 0, 1101);
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::creator_tax_at(&arg0.id);
        let v2 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(&arg0.params) + v1;
        let (v3, v4, v5, v6, v7) = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::price_sell(k<T0, T1>(arg0), arg0.x, arg0.y, v0, v2);
        assert!(v5 >= arg5, 1102);
        let v8 = 0x2::tx_context::sender(arg8);
        let v9 = resolve_referrer<T0, T1>(arg0, arg3, v8, arg6);
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg4));
        let v10 = 0x2::balance::split<T1>(&mut arg0.quote_reserve, v3);
        distribute_fee<T0, T1>(arg0, arg2, arg3, 0x2::balance::split<T1>(&mut v10, v4), v3, v9, v1);
        arg0.x = v6;
        arg0.y = v7;
        check_reserve<T0, T1>(arg0);
        let v11 = QuoteTraded{
            curve_id     : 0x2::object::id<QCurve<T0, T1>>(arg0),
            trader       : v8,
            is_buy       : false,
            quote_amount : v3,
            token_amount : v0,
            fee          : v4,
            fee_bps      : v2,
            referrer     : v9,
            x            : arg0.x,
            y            : arg0.y,
            timestamp_ms : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<QuoteTraded>(v11);
        0x2::coin::from_balance<T1>(v10, arg8)
    }

    public fun set_links<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg6) == arg0.creator, 1105);
        cooldown<T0, T1>(arg0, arg5);
        arg0.links = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::new_links(arg2, arg3, arg4);
        let v0 = QuoteLinksChanged{
            curve_id     : 0x2::object::id<QCurve<T0, T1>>(arg0),
            links        : arg0.links,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<QuoteLinksChanged>(v0);
    }

    public(friend) fun settle_graduation<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: u64) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, u64, u64, u64) {
        assert!(arg0.status == 1, 1115);
        let v0 = 0x2::balance::withdraw_all<T1>(&mut arg0.quote_reserve);
        let v1 = 0x2::balance::value<T1>(&v0);
        let v2 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(v1, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_creator_bps(&arg0.params), 10000);
        let v3 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(v1, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_platform_bps(&arg0.params), 10000);
        0x2::balance::join<T1>(&mut arg0.creator_fees, 0x2::balance::split<T1>(&mut v0, v2));
        let v4 = 0x2::balance::split<T1>(&mut v0, v3);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_quote_platform<T1>(arg1, v4);
        0x2::balance::join<T1>(&mut v0, 0x2::balance::withdraw_all<T1>(&mut arg0.liquidity_bonus));
        (v0, 0x2::balance::withdraw_all<T0>(&mut arg0.lp_tokens), 0x2::balance::split<T1>(&mut v4, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(v3, arg2, 10000)), v1, v2, v3)
    }

    public fun snipe_start<T0, T1>(arg0: &QCurve<T0, T1>) : u64 {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::snipe_start_at(&arg0.id, arg0.created_ms)
    }

    public fun snipe_window_ms<T0, T1>(arg0: &QCurve<T0, T1>) : u64 {
        arg0.snipe_window_ms
    }

    public fun status<T0, T1>(arg0: &QCurve<T0, T1>) : u8 {
        arg0.status
    }

    public fun stuck_reopen_ms<T0, T1>(arg0: &QCurve<T0, T1>) : 0x1::option::Option<u64> {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::stuck_reopen_at(&arg0.id)
    }

    public(friend) fun take_metadata_cap<T0, T1>(arg0: &mut QCurve<T0, T1>) : 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>> {
        if (0x1::option::is_some<0x2::coin_registry::MetadataCap<T0>>(&arg0.metadata_cap)) {
            0x1::option::some<0x2::coin_registry::MetadataCap<T0>>(0x1::option::extract<0x2::coin_registry::MetadataCap<T0>>(&mut arg0.metadata_cap))
        } else {
            0x1::option::none<0x2::coin_registry::MetadataCap<T0>>()
        }
    }

    public(friend) fun take_treasury_cap<T0, T1>(arg0: &mut QCurve<T0, T1>) : 0x2::coin::TreasuryCap<T0> {
        0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap)
    }

    public fun tokens_left<T0, T1>(arg0: &QCurve<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.token_reserve)
    }

    public fun transfer_creator<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 1105);
        assert!(arg2 != @0x0, 1113);
        assert!(!0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::has_cto_at(&arg0.id), 1114);
        let v0 = QuoteCreatorTransferred{
            curve_id : 0x2::object::id<QCurve<T0, T1>>(arg0),
            from     : arg0.creator,
            to       : arg2,
        };
        0x2::event::emit<QuoteCreatorTransferred>(v0);
        arg0.creator = arg2;
    }

    public fun virtuals<T0, T1>(arg0: &QCurve<T0, T1>) : (u64, u64) {
        (arg0.virtual_quote, arg0.virtual_tokens)
    }

    public fun whitelist<T0, T1>(arg0: &QCurve<T0, T1>) : (vector<u8>, u64, u64, u64, u64) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::whitelist_at(&arg0.id)
    }

    public(friend) fun whitelist_buy<T0, T1>(arg0: &mut QCurve<T0, T1>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg8);
        let (v1, v2, v3) = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::wl_caps_at(&arg0.id);
        let v4 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::with_tax_at(&arg0.id, &arg0.params, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(&arg0.params));
        let v5 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::price_buy(k<T0, T1>(arg0), arg0.x, arg0.y, 0x2::balance::value<T0>(&arg0.token_reserve), arg4, v4);
        let (v6, v7, _, v9, v10, _, _) = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::buy_quote_parts(&v5);
        assert!(v6 > 0 && v6 >= arg5, 1102);
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::wl_spent_at(&arg0.id, v0) + v9 <= v1, 1117);
        assert!(v3 + v7 <= v2 && !v10, 1118);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::wl_record_at(&mut arg0.id, 0x2::object::id<QCurve<T0, T1>>(arg0), v0, v9, v7, arg7);
        execute_buy<T0, T1>(arg0, arg1, arg2, arg3, v5, v4, arg6, arg7, arg8)
    }

    public fun wl_spent<T0, T1>(arg0: &QCurve<T0, T1>, arg1: address) : u64 {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::wl_spent_at(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v7
}

