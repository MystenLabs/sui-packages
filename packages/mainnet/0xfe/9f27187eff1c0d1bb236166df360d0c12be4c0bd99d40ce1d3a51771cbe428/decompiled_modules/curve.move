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

    struct LaunchConfigured has copy, drop {
        curve_id: 0x2::object::ID,
        dev_lock_days: u64,
        dev_lock_id: 0x1::option::Option<0x2::object::ID>,
        open_at_ms: u64,
        whitelist_root: vector<u8>,
        whitelist_ms: u64,
        whitelist_cap_sui: u64,
        whitelist_max_raise: u64,
        creator_tax_bps: u64,
    }

    struct CreatorTaxLowered has copy, drop {
        curve_id: 0x2::object::ID,
        from_bps: u64,
        to_bps: u64,
    }

    struct Opened has copy, drop {
        curve_id: 0x2::object::ID,
        opened_ms: u64,
        snipe_window_ms: u64,
    }

    struct WhitelistFilled has copy, drop {
        curve_id: 0x2::object::ID,
        raised: u64,
        filled_ms: u64,
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

    struct LaunchKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Launch has drop, store {
        open_at_ms: u64,
        whitelist_root: vector<u8>,
        whitelist_ms: u64,
        whitelist_cap_sui: u64,
        whitelist_max_raise: u64,
        whitelist_raised: u64,
        filled_ms: u64,
        opened_ms: u64,
    }

    struct WlSpentKey has copy, drop, store {
        buyer: address,
    }

    struct CreatorTaxKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeShares has copy, drop {
        tax: u64,
        creator: u64,
        liquidity: u64,
        referral: u64,
        season: u64,
        platform: u64,
        penalty_season: u64,
        penalty_platform: u64,
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

    struct ResizeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ResizePausesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ResizePaused has copy, drop {
        curve_id: 0x2::object::ID,
        graduation_sui: u64,
        resume_ms: u64,
    }

    struct ResizeCancelled has copy, drop {
        curve_id: 0x2::object::ID,
    }

    struct Resized has copy, drop {
        curve_id: 0x2::object::ID,
        old_graduation_sui: u64,
        graduation_sui: u64,
        virtual_sui: u64,
        x: u64,
        y: u64,
        extra_tokens: u64,
        recipients: u64,
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

    public(friend) fun apply_resize<T0>(arg0: &mut Curve<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = arg0.x - arg0.virtual_sui;
        assert!(arg1 < 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_sui(&arg0.params), 450);
        assert!(v0 < arg1, 451);
        let v1 = initial_virtual_sui(arg1);
        let v2 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::to_u64(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::div_up_u128(k_of(v1, arg0.virtual_tokens), ((v1 + v0) as u128)));
        arg0.params = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::with_graduation_sui(arg0.params, arg1);
        arg0.virtual_sui = v1;
        arg0.x = v1 + v0;
        arg0.y = v2;
        check_reserve<T0>(arg0);
        0x2::balance::split<T0>(&mut arg0.token_reserve, arg0.y - v2)
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
        open_or_abort<T0>(arg0, v0);
        let v1 = snipe_start_ms<T0>(arg0);
        let v2 = with_tax<T0>(arg0, buy_fee_bps_at(&arg0.params, v1, arg0.snipe_window_ms, v0));
        let v3 = price_buy(k_of(arg0.virtual_sui, arg0.virtual_tokens), arg0.x, arg0.y, 0x2::balance::value<T0>(&arg0.token_reserve), arg5, v2);
        assert!(v3.tokens_out > 0 && v3.tokens_out >= arg6, 402);
        if (v0 - v1 < arg0.snipe_window_ms) {
            let v4 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(1000000000000000, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_tx_cap_bps(&arg0.params), 10000);
            let v5 = snipe_tx_bought<T0>(arg0, *0x2::tx_context::digest(arg9), v3.tokens_out);
            assert!(v5 <= v4, 404);
        };
        execute_buy<T0>(arg0, arg2, arg3, arg4, v3, v2, arg7, v0, arg9)
    }

    public fun buy_fee_bps_at(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Params, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg3 - arg1;
        if (v0 >= arg2) {
            return 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(arg0)
        };
        let v1 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_start_fee_bps(arg0);
        v1 - 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(v1 - 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(arg0), v0, arg2)
    }

    fun buy_fee_now<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        buy_fee_now_at(&arg0.id, &arg0.params, arg0.created_ms, arg0.snipe_window_ms, arg1)
    }

    public(friend) fun buy_fee_now_at(arg0: &0x2::object::UID, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Params, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (in_whitelist_phase_at(arg0, arg2, arg4)) {
            return 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(arg1)
        };
        let v0 = snipe_start_at(arg0, arg2);
        if (arg4 < v0) {
            return 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_start_fee_bps(arg1)
        };
        buy_fee_bps_at(arg1, v0, arg3, arg4)
    }

    public(friend) fun buy_quote_parts(arg0: &BuyQuote) : (u64, u64, u64, u64, bool, u64, u64) {
        (arg0.tokens_out, arg0.net_in, arg0.fee, arg0.gross_in, arg0.sells_out, arg0.new_x, arg0.new_y)
    }

    public fun buy_with_proof<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: 0x1::option::Option<address>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(!0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::is_sell_only(arg1), 400);
        assert!(arg0.status == 0, 401);
        assert!(has_launch<T0>(arg0), 440);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let (v1, v2) = wl_phase_at(&arg0.id, arg0.created_ms, v0);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg10);
        assert!(wl_spent<T0>(arg0, v4) < v2, 434);
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::merkle::verify(&v3, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::merkle::address_leaf(v4), &arg8), 436);
        whitelist_buy<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, v0, arg10)
    }

    public(friend) fun buyback_buy<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        assert!(arg0.status == 0, 401);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = snipe_start_ms<T0>(arg0);
        let v2 = if (is_open<T0>(arg0)) {
            if (v0 >= v1) {
                v0 - v1 >= arg0.snipe_window_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 422);
        let v3 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(&arg0.params);
        let v4 = price_buy(k_of(arg0.virtual_sui, arg0.virtual_tokens), arg0.x, arg0.y, 0x2::balance::value<T0>(&arg0.token_reserve), 0x2::balance::value<0x2::sui::SUI>(&arg3), v3);
        assert!(!v4.sells_out, 423);
        assert!(v4.tokens_out > 0, 403);
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v4.gross_in);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v4.net_in));
        distribute_fee<T0>(arg0, arg1, arg2, v5, v4.gross_in, 0x1::option::none<address>(), 0);
        arg0.x = v4.new_x;
        arg0.y = v4.new_y;
        let v6 = 0x2::balance::split<T0>(&mut arg0.token_reserve, v4.tokens_out);
        burn_balance<T0>(arg0, v6);
        check_reserve<T0>(arg0);
        let v7 = Traded{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            trader       : 0x2::object::id_address<Curve<T0>>(arg0),
            is_buy       : true,
            sui_amount   : v4.gross_in,
            token_amount : v4.tokens_out,
            fee          : v4.fee,
            fee_bps      : v3,
            referrer     : 0x1::option::none<address>(),
            x            : arg0.x,
            y            : arg0.y,
            timestamp_ms : v0,
        };
        0x2::event::emit<Traded>(v7);
        (arg3, v4.tokens_out)
    }

    public fun cancel_cto<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::AdminCap, arg1: &mut Curve<T0>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        let v0 = &mut arg1.id;
        cancel_cto_at(v0, 0x2::object::id<Curve<T0>>(arg1));
    }

    public(friend) fun cancel_cto_at(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) {
        let v0 = CtoKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CtoKey>(arg0, v0), 415);
        let v1 = CtoKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::remove<CtoKey, CtoProposal>(arg0, v1);
        let v3 = CtoCancelled{
            curve_id : arg1,
            to       : v2.new_creator,
        };
        0x2::event::emit<CtoCancelled>(v3);
    }

    public fun cancel_resize<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::AdminCap, arg1: &mut Curve<T0>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        end_pause<T0>(arg1);
    }

    public(friend) fun cetus_tick_spacing() : u32 {
        200
    }

    public(friend) fun check_cooldown(arg0: u64, arg1: u64) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == arg0) {
            true
        } else {
            arg1 - arg0 >= 3600000
        };
        assert!(v0, 410);
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

    public(friend) fun configure_launch<T0>(arg0: &mut Curve<T0>, arg1: u64, arg2: u64, arg3: 0x1::option::Option<0x2::object::ID>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = &mut arg0.id;
        configure_launch_at(v0, 0x2::object::id<Curve<T0>>(arg0), arg0.created_ms, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_sui(&arg0.params), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public(friend) fun configure_launch_at(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>, arg7: u64, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: u64, arg12: u64) {
        assert!(arg12 <= 1000, 442);
        let v0 = !0x1::vector::is_empty<u8>(&arg8);
        let v1 = arg7 > 0;
        if (v1) {
            assert!(arg7 >= arg2 + 600000, 438);
            assert!(arg7 <= arg2 + 86400000, 438);
        };
        if (v0) {
            assert!(0x1::vector::length<u8>(&arg8) == 32, 438);
            assert!(arg9 >= 3600000 && arg9 <= 86400000, 438);
            assert!(arg10 > 0, 438);
            assert!(arg11 > 0 && arg11 < arg3, 438);
        } else {
            let v2 = if (arg9 == 0) {
                if (arg10 == 0) {
                    arg11 == 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v2, 438);
        };
        if (v1 || v0) {
            assert!(arg4 == 0 || arg5 > 0, 441);
        };
        let v3 = if (!v1) {
            if (!v0) {
                if (arg5 == 0) {
                    arg12 == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            return
        };
        if (arg12 > 0) {
            let v4 = CreatorTaxKey{dummy_field: false};
            0x2::dynamic_field::add<CreatorTaxKey, u64>(arg0, v4, arg12);
        };
        if (v1 || v0) {
            let v5 = LaunchKey{dummy_field: false};
            let v6 = Launch{
                open_at_ms          : arg7,
                whitelist_root      : arg8,
                whitelist_ms        : arg9,
                whitelist_cap_sui   : arg10,
                whitelist_max_raise : arg11,
                whitelist_raised    : 0,
                filled_ms           : 0,
                opened_ms           : 0,
            };
            0x2::dynamic_field::add<LaunchKey, Launch>(arg0, v5, v6);
        };
        let v7 = LaunchConfigured{
            curve_id            : arg1,
            dev_lock_days       : arg5,
            dev_lock_id         : arg6,
            open_at_ms          : arg7,
            whitelist_root      : arg8,
            whitelist_ms        : arg9,
            whitelist_cap_sui   : arg10,
            whitelist_max_raise : arg11,
            creator_tax_bps     : arg12,
        };
        0x2::event::emit<LaunchConfigured>(v7);
    }

    fun cooldown<T0>(arg0: &mut Curve<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        check_cooldown(arg0.last_metadata_ms, v0);
        arg0.last_metadata_ms = v0;
    }

    entry fun create<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: 0x2::coin::TreasuryCap<T0>, arg5: 0x2::coin_registry::MetadataCap<T0>, arg6: &0x2::coin_registry::Currency<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u8, arg13: &0x2::random::Random, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        launch<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0, 0, b"", 0, 0, 0, 0, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public(friend) fun create_internal<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>, arg4: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Curve<T0> {
        let (v0, _) = create_locked<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0, arg7, arg8, arg9);
        v0
    }

    public(friend) fun create_locked<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>, arg4: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (Curve<T0>, 0x1::option::Option<0x2::object::ID>) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg0);
        assert!(!0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::is_sell_only(arg0), 400);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 407);
        assert!(arg7 == 0 || arg6 > 0, 439);
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::params(arg0);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = 0x2::clock::timestamp_ms(arg9);
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
            id                : 0x2::object::new(arg10),
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
            snipe_window_ms   : arg8,
            status            : 0,
        };
        let v8 = 0;
        let v9 = 0x1::option::none<0x2::object::ID>();
        if (arg6 > 0) {
            let v10 = price_buy(k_of(v7.virtual_sui, v7.virtual_tokens), v7.x, v7.y, 0x2::balance::value<T0>(&v7.token_reserve), arg6, 0);
            assert!(!v10.sells_out, 405);
            assert!(v10.tokens_out <= 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(1000000000000000, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::max_dev_buy_bps(&v0), 10000), 405);
            0x2::balance::join<0x2::sui::SUI>(&mut v7.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg5), v10.net_in));
            v7.x = v10.new_x;
            v7.y = v10.new_y;
            v8 = v10.tokens_out;
            if (arg7 > 0) {
                let v11 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::vesting::new_lock<T0>(0x2::coin::take<T0>(&mut v7.token_reserve, v10.tokens_out, arg10), arg7, v1, arg9, arg10);
                v9 = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::vesting::VestingLock<T0>>(&v11));
                0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::vesting::share<T0>(v11);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v7.token_reserve, v10.tokens_out, arg10), v1);
            };
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        };
        check_reserve<T0>(&v7);
        let v12 = Created{
            curve_id        : 0x2::object::id<Curve<T0>>(&v7),
            creator         : v1,
            graduation_sui  : 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_sui(&v0),
            snipe_window_ms : arg8,
            dev_buy_sui     : arg6,
            dev_buy_tokens  : v8,
            created_ms      : v2,
        };
        0x2::event::emit<Created>(v12);
        (v7, v9)
    }

    entry fun create_with_options<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: 0x2::coin::TreasuryCap<T0>, arg5: 0x2::coin_registry::MetadataCap<T0>, arg6: &0x2::coin_registry::Currency<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: 0x1::string::String, arg19: u8, arg20: &0x2::random::Random, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) {
        launch<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22);
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

    public(friend) fun creator_tax_at(arg0: &0x2::object::UID) : u64 {
        let v0 = CreatorTaxKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<CreatorTaxKey, u64>(arg0, v0)) {
            return 0
        };
        let v1 = CreatorTaxKey{dummy_field: false};
        *0x2::dynamic_field::borrow<CreatorTaxKey, u64>(arg0, v1)
    }

    public fun creator_tax_bps<T0>(arg0: &Curve<T0>) : u64 {
        creator_tax_at(&arg0.id)
    }

    public fun cto_state<T0>(arg0: &Curve<T0>) : (bool, address, u64, bool) {
        cto_state_at(&arg0.id)
    }

    public(friend) fun cto_state_at(arg0: &0x2::object::UID) : (bool, address, u64, bool) {
        let v0 = CtoKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<CtoKey>(arg0, v0)) {
            return (false, @0x0, 0, false)
        };
        let v1 = CtoKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<CtoKey, CtoProposal>(arg0, v1);
        (true, v2.new_creator, v2.ready_ms, v2.objected)
    }

    public fun curve_supply() : u64 {
        800000000000000
    }

    public fun decimals_unit() : u64 {
        1000000
    }

    fun distribute_fee<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: u64) {
        let v0 = fee_shares(&arg0.params, 0x2::balance::value<0x2::sui::SUI>(&arg3), arg4, arg6, 0x1::option::is_some<address>(&arg5));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0.creator + v0.tax));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.liquidity_bonus, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0.liquidity));
        if (0x1::option::is_some<address>(&arg5)) {
            0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::accrue(arg2, 0x1::option::destroy_some<address>(arg5), 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0.referral));
        };
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_season(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0.season + v0.penalty_season));
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_platform(arg1, arg3);
    }

    public(friend) fun emit_cto_executed(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = CtoExecuted{
            curve_id         : arg0,
            from             : arg1,
            to               : arg2,
            fees_to_previous : arg3,
        };
        0x2::event::emit<CtoExecuted>(v0);
    }

    fun end_pause<T0>(arg0: &mut Curve<T0>) {
        assert!(arg0.status == 3, 452);
        let v0 = ResizeKey{dummy_field: false};
        0x2::dynamic_field::remove<ResizeKey, u64>(&mut arg0.id, v0);
        arg0.status = 0;
        let v1 = ResizeCancelled{curve_id: 0x2::object::id<Curve<T0>>(arg0)};
        0x2::event::emit<ResizeCancelled>(v1);
    }

    fun execute_buy<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: BuyQuote, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= arg4.gross_in, 409);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::resolve(arg2, v0, arg6);
        let v2 = if (0x1::option::is_some<address>(&v1) && *0x1::option::borrow<address>(&v1) == arg0.creator) {
            0x1::option::none<address>()
        } else {
            v1
        };
        let v3 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg3), arg4.gross_in);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v3, arg4.net_in));
        let v4 = creator_tax_bps<T0>(arg0);
        distribute_fee<T0>(arg0, arg1, arg2, v3, arg4.gross_in, v2, v4);
        arg0.x = arg4.new_x;
        arg0.y = arg4.new_y;
        check_reserve<T0>(arg0);
        let v5 = Traded{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            trader       : v0,
            is_buy       : true,
            sui_amount   : arg4.gross_in,
            token_amount : arg4.tokens_out,
            fee          : arg4.fee,
            fee_bps      : arg5,
            referrer     : v2,
            x            : arg0.x,
            y            : arg0.y,
            timestamp_ms : arg7,
        };
        0x2::event::emit<Traded>(v5);
        if (arg4.sells_out) {
            arg0.status = 1;
            arg0.closer = v0;
            let v6 = ReadyToGraduate{
                curve_id : 0x2::object::id<Curve<T0>>(arg0),
                raised   : arg0.x - arg0.virtual_sui,
            };
            0x2::event::emit<ReadyToGraduate>(v6);
        };
        0x2::coin::take<T0>(&mut arg0.token_reserve, arg4.tokens_out, arg8)
    }

    public fun execute_cto<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::AdminCap, arg1: &mut Curve<T0>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        let v0 = &mut arg1.id;
        let v1 = take_ready_cto_at(v0, 0x2::clock::timestamp_ms(arg3));
        let v2 = arg1.creator;
        let v3 = if (has_fee_mode<T0>(arg1)) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.creator_fees) == 0, 421);
            let v4 = CreatorClaimKey{dummy_field: false};
            0x2::balance::withdraw_all<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<CreatorClaimKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.id, v4))
        } else {
            0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.creator_fees)
        };
        let v5 = v3;
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v5);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg4), v2);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
        };
        arg1.creator = v1;
        emit_cto_executed(0x2::object::id<Curve<T0>>(arg1), v2, v1, v6);
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

    public(friend) fun fee_shares(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Params, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : FeeShares {
        let v0 = 0x1::u64::min(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg2, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(arg0), 10000), arg1);
        let v1 = arg1 - v0;
        let v2 = 0x1::u64::min(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg2, arg3, 10000), v1);
        let v3 = v1 - v2;
        let v4 = 0x1::u64::min(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg2, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::creator_bps(arg0), 10000), v0);
        let v5 = v0 - v4;
        let v6 = 0x1::u64::min(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg2, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::liquidity_bps(arg0), 10000), v5);
        let v7 = v5 - v6;
        let v8 = v7;
        let v9 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg2, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::season_bps(arg0), 10000);
        let v10 = v9;
        let v11 = 0;
        if (arg4) {
            let v12 = 0x1::u64::min(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg2, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::referral_bps(arg0), 10000), v7);
            v11 = v12;
            v10 = v9 - 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(arg2, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::referral_bps(arg0) / 2, 10000);
            v8 = v7 - v12;
        };
        let v13 = 0x1::u64::min(v10, v8);
        let v14 = v3 / 2;
        FeeShares{
            tax              : v2,
            creator          : v4,
            liquidity        : v6,
            referral         : v11,
            season           : v13,
            platform         : v8 - v13,
            penalty_season   : v14,
            penalty_platform : v3 - v14,
        }
    }

    public(friend) fun fee_shares_split(arg0: &FeeShares) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        (arg0.tax, arg0.creator, arg0.liquidity, arg0.referral, arg0.season, arg0.platform, arg0.penalty_season, arg0.penalty_platform)
    }

    public(friend) fun has_cto_at(arg0: &0x2::object::UID) : bool {
        let v0 = CtoKey{dummy_field: false};
        0x2::dynamic_field::exists_<CtoKey>(arg0, v0)
    }

    public fun has_fee_mode<T0>(arg0: &Curve<T0>) : bool {
        let v0 = FeeModeKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<FeeModeKey, FeeMode>(&arg0.id, v0)
    }

    fun has_launch<T0>(arg0: &Curve<T0>) : bool {
        has_launch_at(&arg0.id)
    }

    public(friend) fun has_launch_at(arg0: &0x2::object::UID) : bool {
        let v0 = LaunchKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<LaunchKey, Launch>(arg0, v0)
    }

    public(friend) fun in_whitelist_phase_at(arg0: &0x2::object::UID, arg1: u64, arg2: u64) : bool {
        if (!has_launch_at(arg0)) {
            return false
        };
        let v0 = LaunchKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<LaunchKey, Launch>(arg0, v0);
        if (0x1::vector::is_empty<u8>(&v1.whitelist_root)) {
            return false
        };
        let (v2, v3) = launch_times(v1, arg1);
        arg2 >= v2 && arg2 < v3
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

    fun is_open<T0>(arg0: &Curve<T0>) : bool {
        is_open_at(&arg0.id)
    }

    public(friend) fun is_open_at(arg0: &0x2::object::UID) : bool {
        if (!has_launch_at(arg0)) {
            return true
        };
        let v0 = LaunchKey{dummy_field: false};
        0x2::dynamic_field::borrow<LaunchKey, Launch>(arg0, v0).opened_ms > 0
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

    fun launch<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: 0x2::coin::TreasuryCap<T0>, arg5: 0x2::coin_registry::MetadataCap<T0>, arg6: &0x2::coin_registry::Currency<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: 0x1::string::String, arg19: u8, arg20: &0x2::random::Random, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg0);
        assert!(!0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::is_sell_only(arg0), 400);
        check_currency<T0>(arg6, &arg4);
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::params(arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg2, arg3, &mut arg4, arg22);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, 0x2::sui::SUI>(arg2, arg3, 200, &v1, arg22);
        let v2 = 0x2::random::new_generator(arg20, arg22);
        let (v3, v4) = create_locked<T0>(arg0, arg1, arg4, 0x1::option::some<0x2::coin_registry::MetadataCap<T0>>(arg5), 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(v1), arg7, arg8, arg9, 0x2::random::generate_u64_in_range(&mut v2, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_min_ms(&v0), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_max_ms(&v0)), arg21, arg22);
        let v5 = v3;
        v5.links = new_links(arg16, arg17, arg18);
        let v6 = &mut v5;
        set_fee_mode<T0>(v6, fee_mode_preset(arg19));
        let v7 = &mut v5;
        configure_launch<T0>(v7, arg8, arg9, v4, arg10, arg11, arg12, arg13, arg14, arg15);
        0x2::transfer::share_object<Curve<T0>>(v5);
    }

    public fun launch_phase<T0>(arg0: &Curve<T0>, arg1: &0x2::clock::Clock) : u8 {
        launch_phase_at(&arg0.id, arg0.created_ms, 0x2::clock::timestamp_ms(arg1))
    }

    public(friend) fun launch_phase_at(arg0: &0x2::object::UID, arg1: u64, arg2: u64) : u8 {
        if (is_open_at(arg0)) {
            return 0
        };
        let v0 = LaunchKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<LaunchKey, Launch>(arg0, v0);
        let (v2, v3) = launch_times(v1, arg1);
        if (arg2 < v2) {
            1
        } else if (arg2 < v3 && !0x1::vector::is_empty<u8>(&v1.whitelist_root)) {
            2
        } else {
            3
        }
    }

    public fun launch_schedule<T0>(arg0: &Curve<T0>) : (u64, u64, u64) {
        launch_schedule_at(&arg0.id, arg0.created_ms)
    }

    public(friend) fun launch_schedule_at(arg0: &0x2::object::UID, arg1: u64) : (u64, u64, u64) {
        if (!has_launch_at(arg0)) {
            return (arg1, arg1, arg1)
        };
        let v0 = LaunchKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<LaunchKey, Launch>(arg0, v0);
        let (v2, v3) = launch_times(v1, arg1);
        (v2, v3, v1.opened_ms)
    }

    fun launch_times(arg0: &Launch, arg1: u64) : (u64, u64) {
        let v0 = if (arg0.open_at_ms > arg1) {
            arg0.open_at_ms
        } else {
            arg1
        };
        let v1 = v0 + arg0.whitelist_ms;
        let v2 = if (arg0.filled_ms > 0 && arg0.filled_ms < v1) {
            arg0.filled_ms
        } else {
            v1
        };
        (v0, v2)
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

    public fun lower_creator_tax<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 406);
        let v0 = &mut arg0.id;
        lower_creator_tax_at(v0, 0x2::object::id<Curve<T0>>(arg0), arg2);
    }

    public(friend) fun lower_creator_tax_at(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = creator_tax_at(arg0);
        assert!(arg2 < v0, 443);
        let v1 = CreatorTaxKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<CreatorTaxKey, u64>(arg0, v1) = arg2;
        let v2 = CreatorTaxLowered{
            curve_id : arg1,
            from_bps : v0,
            to_bps   : arg2,
        };
        0x2::event::emit<CreatorTaxLowered>(v2);
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
        let v0 = &mut arg0.id;
        object_cto_at(v0, 0x2::object::id<Curve<T0>>(arg0), arg0.creator, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public(friend) fun object_cto_at(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::string::String, arg4: u64) {
        let v0 = CtoKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CtoKey>(arg0, v0), 415);
        assert!(0x1::string::length(&arg3) <= 280, 418);
        let v1 = CtoKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<CtoKey, CtoProposal>(arg0, v1).objected = true;
        let v2 = CtoObjected{
            curve_id     : arg1,
            creator      : arg2,
            reason       : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<CtoObjected>(v2);
    }

    entry fun open<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        let v0 = 0x2::random::new_generator(arg2, arg4);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_min_ms(&arg0.params), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_max_ms(&arg0.params));
        open_with_window<T0>(arg0, v1, arg3);
    }

    public(friend) fun open_at(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        assert!(has_launch_at(arg0), 437);
        let v0 = LaunchKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<LaunchKey, Launch>(arg0, v0);
        assert!(v1.opened_ms == 0, 437);
        let (_, v3) = launch_times(v1, arg2);
        assert!(arg4 >= v3, 432);
        v1.opened_ms = arg4;
        let v4 = Opened{
            curve_id        : arg1,
            opened_ms       : arg4,
            snipe_window_ms : arg3,
        };
        0x2::event::emit<Opened>(v4);
    }

    fun open_or_abort<T0>(arg0: &mut Curve<T0>, arg1: u64) {
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_max_ms(&arg0.params);
        let v1 = &mut arg0.id;
        if (open_or_abort_at(v1, 0x2::object::id<Curve<T0>>(arg0), arg0.created_ms, v0, arg1)) {
            arg0.snipe_window_ms = v0;
        };
    }

    public(friend) fun open_or_abort_at(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) : bool {
        if (is_open_at(arg0)) {
            return false
        };
        let v0 = LaunchKey{dummy_field: false};
        let (_, v2) = launch_times(0x2::dynamic_field::borrow<LaunchKey, Launch>(arg0, v0), arg2);
        assert!(arg4 >= v2 + 600000, 432);
        let v3 = LaunchKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<LaunchKey, Launch>(arg0, v3).opened_ms = arg4;
        let v4 = Opened{
            curve_id        : arg1,
            opened_ms       : arg4,
            snipe_window_ms : arg3,
        };
        0x2::event::emit<Opened>(v4);
        true
    }

    public(friend) fun open_with_window<T0>(arg0: &mut Curve<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 401);
        let v0 = &mut arg0.id;
        open_at(v0, 0x2::object::id<Curve<T0>>(arg0), arg0.created_ms, arg1, 0x2::clock::timestamp_ms(arg2));
        arg0.snipe_window_ms = arg1;
    }

    public(friend) fun params_of<T0>(arg0: &Curve<T0>) : 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Params {
        arg0.params
    }

    public fun pause_for_resize<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::AdminCap, arg1: &mut Curve<T0>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg3: &0x2::clock::Clock) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        assert!(arg1.status == 0, 401);
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::params(arg2);
        let v1 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_sui(&v0);
        assert!(v1 < 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_sui(&arg1.params), 450);
        assert!(arg1.x - arg1.virtual_sui < v1, 451);
        let v2 = ResizePausesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ResizePausesKey>(&arg1.id, v2)) {
            let v3 = ResizePausesKey{dummy_field: false};
            0x2::dynamic_field::add<ResizePausesKey, u8>(&mut arg1.id, v3, 0);
        };
        let v4 = ResizePausesKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow_mut<ResizePausesKey, u8>(&mut arg1.id, v4);
        assert!(*v5 < 2, 456);
        *v5 = *v5 + 1;
        let v6 = 0x2::clock::timestamp_ms(arg3) + 86400000;
        arg1.status = 3;
        let v7 = ResizeKey{dummy_field: false};
        0x2::dynamic_field::add<ResizeKey, u64>(&mut arg1.id, v7, v6);
        let v8 = ResizePaused{
            curve_id       : 0x2::object::id<Curve<T0>>(arg1),
            graduation_sui : v1,
            resume_ms      : v6,
        };
        0x2::event::emit<ResizePaused>(v8);
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
        let v0 = &mut arg1.id;
        propose_cto_at(v0, 0x2::object::id<Curve<T0>>(arg1), arg1.creator, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    public(friend) fun propose_cto_at(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: 0x1::string::String, arg5: u64) {
        let v0 = CtoKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<CtoKey>(arg0, v0), 414);
        assert!(arg3 != arg2, 417);
        assert!(arg3 != @0x0, 427);
        assert!(0x1::string::length(&arg4) <= 280, 418);
        let v1 = arg5 + 259200000;
        let v2 = CtoProposed{
            curve_id : arg1,
            from     : arg2,
            to       : arg3,
            reason   : arg4,
            ready_ms : v1,
        };
        0x2::event::emit<CtoProposed>(v2);
        let v3 = CtoKey{dummy_field: false};
        let v4 = CtoProposal{
            new_creator : arg3,
            reason      : arg4,
            proposed_ms : arg5,
            ready_ms    : v1,
            objected    : false,
        };
        0x2::dynamic_field::add<CtoKey, CtoProposal>(arg0, v3, v4);
    }

    public fun quote_buy<T0>(arg0: &Curve<T0>, arg1: u64, arg2: &0x2::clock::Clock) : BuyQuote {
        price_buy(k_of(arg0.virtual_sui, arg0.virtual_tokens), arg0.x, arg0.y, 0x2::balance::value<T0>(&arg0.token_reserve), arg1, with_tax<T0>(arg0, buy_fee_now<T0>(arg0, 0x2::clock::timestamp_ms(arg2))))
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
        let v0 = &mut arg0.id;
        take_stuck_at(v0, 0x2::object::id<Curve<T0>>(arg0), 0x2::balance::value<T0>(&arg0.token_reserve), 0x2::clock::timestamp_ms(arg2));
        arg0.status = 0;
        arg0.closer = @0x0;
    }

    public fun report_stuck<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(arg0.status == 1, 428);
        let v0 = &mut arg0.id;
        report_stuck_at(v0, 0x2::object::id<Curve<T0>>(arg0), 0x2::tx_context::sender(arg3), 0x2::clock::timestamp_ms(arg2));
    }

    public(friend) fun report_stuck_at(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = StuckKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<StuckKey>(arg0, v0), 429);
        let v1 = arg3 + 86400000;
        let v2 = StuckKey{dummy_field: false};
        0x2::dynamic_field::add<StuckKey, u64>(arg0, v2, v1);
        let v3 = GraduationStuckReported{
            curve_id  : arg1,
            reporter  : arg2,
            reopen_ms : v1,
        };
        0x2::event::emit<GraduationStuckReported>(v3);
    }

    public fun reserves<T0>(arg0: &Curve<T0>) : (u64, u64) {
        (arg0.x, arg0.y)
    }

    public fun resize<T0>(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::AdminCap, arg1: &mut Curve<T0>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        assert!(arg1.status == 3, 452);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4) && v0 <= 500, 454);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg4, v2) > 0 && *0x1::vector::borrow<address>(&arg3, v2) != @0x0, 454);
            v1 = v1 + *0x1::vector::borrow<u64>(&arg4, v2);
            v2 = v2 + 1;
        };
        assert!(v0 > 0 || 0x2::coin::total_supply<T0>(0x1::option::borrow<0x2::coin::TreasuryCap<T0>>(&arg1.treasury_cap)) - 0x2::balance::value<T0>(&arg1.token_reserve) - 0x2::balance::value<T0>(&arg1.lp_tokens) == 0, 454);
        let v3 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_sui(&arg1.params);
        let v4 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::params(arg2);
        let v5 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_sui(&v4);
        let v6 = ResizeKey{dummy_field: false};
        0x2::dynamic_field::remove<ResizeKey, u64>(&mut arg1.id, v6);
        let v7 = apply_resize<T0>(arg1, v5);
        let v8 = 0x2::balance::value<T0>(&v7);
        if (v0 == 0) {
            burn_balance<T0>(arg1, v7);
        } else {
            assert!(v1 == v8, 455);
            let v9 = 0;
            while (v9 < v0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, *0x1::vector::borrow<u64>(&arg4, v9)), arg5), *0x1::vector::borrow<address>(&arg3, v9));
                v9 = v9 + 1;
            };
            0x2::balance::destroy_zero<T0>(v7);
        };
        arg1.status = 0;
        let v10 = Resized{
            curve_id           : 0x2::object::id<Curve<T0>>(arg1),
            old_graduation_sui : v3,
            graduation_sui     : v5,
            virtual_sui        : arg1.virtual_sui,
            x                  : arg1.x,
            y                  : arg1.y,
            extra_tokens       : v8,
            recipients         : v0,
        };
        0x2::event::emit<Resized>(v10);
    }

    public fun resize_quote<T0>(arg0: &Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config) : (u64, u64, u64) {
        let v0 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::params(arg1);
        let v1 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_sui(&v0);
        let v2 = arg0.x - arg0.virtual_sui;
        assert!(v1 < 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::graduation_sui(&arg0.params), 450);
        assert!(v2 < v1, 451);
        let v3 = initial_virtual_sui(v1);
        let v4 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::to_u64(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::div_up_u128(k_of(v3, arg0.virtual_tokens), ((v3 + v2) as u128)));
        (v3, v4, arg0.y - v4)
    }

    public fun resize_resume_ms<T0>(arg0: &Curve<T0>) : 0x1::option::Option<u64> {
        let v0 = ResizeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ResizeKey>(&arg0.id, v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = ResizeKey{dummy_field: false};
        0x1::option::some<u64>(*0x2::dynamic_field::borrow<ResizeKey, u64>(&arg0.id, v1))
    }

    public fun resume_after_pause<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &0x2::clock::Clock) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(arg0.status == 3, 452);
        let v0 = ResizeKey{dummy_field: false};
        assert!(0x2::clock::timestamp_ms(arg2) >= *0x2::dynamic_field::borrow<ResizeKey, u64>(&arg0.id, v0), 453);
        end_pause<T0>(arg0);
    }

    public fun sell<T0>(arg0: &mut Curve<T0>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(arg0.status == 0, 401);
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = creator_tax_bps<T0>(arg0);
        let v2 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(&arg0.params) + v1;
        let (v3, v4, v5, v6, v7) = price_sell(k_of(arg0.virtual_sui, arg0.virtual_tokens), arg0.x, arg0.y, v0, v2);
        assert!(v5 >= arg5, 402);
        let v8 = 0x2::tx_context::sender(arg8);
        let v9 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::resolve(arg3, v8, arg6);
        let v10 = if (0x1::option::is_some<address>(&v9) && *0x1::option::borrow<address>(&v9) == arg0.creator) {
            0x1::option::none<address>()
        } else {
            v9
        };
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg4));
        let v11 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v3);
        distribute_fee<T0>(arg0, arg2, arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v11, v4), v3, v10, v1);
        arg0.x = v6;
        arg0.y = v7;
        check_reserve<T0>(arg0);
        let v12 = Traded{
            curve_id     : 0x2::object::id<Curve<T0>>(arg0),
            trader       : v8,
            is_buy       : false,
            sui_amount   : v3,
            token_amount : v0,
            fee          : v4,
            fee_bps      : v2,
            referrer     : v10,
            x            : arg0.x,
            y            : arg0.y,
            timestamp_ms : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<Traded>(v12);
        0x2::coin::from_balance<0x2::sui::SUI>(v11, arg8)
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

    public fun snipe_start<T0>(arg0: &Curve<T0>) : u64 {
        snipe_start_ms<T0>(arg0)
    }

    public(friend) fun snipe_start_at(arg0: &0x2::object::UID, arg1: u64) : u64 {
        if (!has_launch_at(arg0)) {
            return arg1
        };
        let v0 = LaunchKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<LaunchKey, Launch>(arg0, v0);
        if (v1.opened_ms > 0) {
            return v1.opened_ms
        };
        let (_, v3) = launch_times(v1, arg1);
        v3
    }

    fun snipe_start_ms<T0>(arg0: &Curve<T0>) : u64 {
        snipe_start_at(&arg0.id, arg0.created_ms)
    }

    fun snipe_tx_bought<T0>(arg0: &mut Curve<T0>, arg1: vector<u8>, arg2: u64) : u64 {
        let v0 = &mut arg0.id;
        snipe_tx_bought_at(v0, arg1, arg2)
    }

    public(friend) fun snipe_tx_bought_at(arg0: &mut 0x2::object::UID, arg1: vector<u8>, arg2: u64) : u64 {
        let v0 = SnipeTxKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<SnipeTxKey>(arg0, v0)) {
            let v1 = SnipeTxKey{dummy_field: false};
            let v2 = SnipeTx{
                digest : arg1,
                bought : arg2,
            };
            0x2::dynamic_field::add<SnipeTxKey, SnipeTx>(arg0, v1, v2);
            return arg2
        };
        let v3 = SnipeTxKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<SnipeTxKey, SnipeTx>(arg0, v3);
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

    public(friend) fun stuck_reopen_at(arg0: &0x2::object::UID) : 0x1::option::Option<u64> {
        let v0 = StuckKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<StuckKey>(arg0, v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = StuckKey{dummy_field: false};
        0x1::option::some<u64>(*0x2::dynamic_field::borrow<StuckKey, u64>(arg0, v1))
    }

    public fun stuck_reopen_ms<T0>(arg0: &Curve<T0>) : 0x1::option::Option<u64> {
        stuck_reopen_at(&arg0.id)
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

    public(friend) fun take_ready_cto_at(arg0: &mut 0x2::object::UID, arg1: u64) : address {
        let v0 = CtoKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CtoKey>(arg0, v0), 415);
        let v1 = CtoKey{dummy_field: false};
        assert!(arg1 >= 0x2::dynamic_field::borrow<CtoKey, CtoProposal>(arg0, v1).ready_ms, 416);
        let v2 = CtoKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::remove<CtoKey, CtoProposal>(arg0, v2);
        v3.new_creator
    }

    public(friend) fun take_stuck_at(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = StuckKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<StuckKey>(arg0, v0), 430);
        let v1 = StuckKey{dummy_field: false};
        assert!(arg3 >= 0x2::dynamic_field::remove<StuckKey, u64>(arg0, v1), 431);
        let v2 = TradingReopened{
            curve_id    : arg1,
            tokens_left : arg2,
        };
        0x2::event::emit<TradingReopened>(v2);
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
        assert!(!has_cto_at(&arg0.id), 414);
        let v0 = CreatorTransferred{
            curve_id : 0x2::object::id<Curve<T0>>(arg0),
            from     : arg0.creator,
            to       : arg2,
        };
        0x2::event::emit<CreatorTransferred>(v0);
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

    public fun whitelist<T0>(arg0: &Curve<T0>) : (vector<u8>, u64, u64, u64, u64) {
        whitelist_at(&arg0.id)
    }

    public(friend) fun whitelist_at(arg0: &0x2::object::UID) : (vector<u8>, u64, u64, u64, u64) {
        if (!has_launch_at(arg0)) {
            return (b"", 0, 0, 0, 0)
        };
        let v0 = LaunchKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<LaunchKey, Launch>(arg0, v0);
        (v1.whitelist_root, v1.whitelist_ms, v1.whitelist_cap_sui, v1.whitelist_max_raise, v1.whitelist_raised)
    }

    public(friend) fun whitelist_buy<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral::Registry, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg8);
        let (v1, v2, v3) = wl_caps_at(&arg0.id);
        let v4 = with_tax<T0>(arg0, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::trade_fee_bps(&arg0.params));
        let v5 = price_buy(k_of(arg0.virtual_sui, arg0.virtual_tokens), arg0.x, arg0.y, 0x2::balance::value<T0>(&arg0.token_reserve), arg4, v4);
        assert!(v5.tokens_out > 0 && v5.tokens_out >= arg5, 402);
        assert!(wl_spent<T0>(arg0, v0) + v5.gross_in <= v1, 434);
        assert!(v3 + v5.net_in <= v2 && !v5.sells_out, 435);
        let v6 = &mut arg0.id;
        wl_record_at(v6, 0x2::object::id<Curve<T0>>(arg0), v0, v5.gross_in, v5.net_in, arg7);
        execute_buy<T0>(arg0, arg1, arg2, arg3, v5, v4, arg6, arg7, arg8)
    }

    fun with_tax<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        with_tax_at(&arg0.id, &arg0.params, arg1)
    }

    public(friend) fun with_tax_at(arg0: &0x2::object::UID, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Params, arg2: u64) : u64 {
        let v0 = arg2 + creator_tax_at(arg0);
        let v1 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::snipe_start_fee_bps(arg1);
        if (v0 > v1) {
            0x1::u64::max(v1, arg2)
        } else {
            v0
        }
    }

    public(friend) fun wl_caps_at(arg0: &0x2::object::UID) : (u64, u64, u64) {
        let v0 = LaunchKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<LaunchKey, Launch>(arg0, v0);
        (v1.whitelist_cap_sui, v1.whitelist_max_raise, v1.whitelist_raised)
    }

    public(friend) fun wl_phase_at(arg0: &0x2::object::UID, arg1: u64, arg2: u64) : (vector<u8>, u64) {
        let v0 = LaunchKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<LaunchKey, Launch>(arg0, v0);
        assert!(!0x1::vector::is_empty<u8>(&v1.whitelist_root), 440);
        let (v2, v3) = launch_times(v1, arg1);
        assert!(arg2 >= v2, 432);
        assert!(arg2 < v3, 433);
        (v1.whitelist_root, v1.whitelist_cap_sui)
    }

    public(friend) fun wl_record_at(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = WlSpentKey{buyer: arg2};
        if (0x2::dynamic_field::exists_<WlSpentKey>(arg0, v0)) {
            let v1 = WlSpentKey{buyer: arg2};
            *0x2::dynamic_field::borrow_mut<WlSpentKey, u64>(arg0, v1) = wl_spent_at(arg0, arg2) + arg3;
        } else {
            let v2 = WlSpentKey{buyer: arg2};
            0x2::dynamic_field::add<WlSpentKey, u64>(arg0, v2, arg3);
        };
        let v3 = LaunchKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<LaunchKey, Launch>(arg0, v3);
        v4.whitelist_raised = v4.whitelist_raised + arg4;
        let v5 = v4.whitelist_raised >= 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(v4.whitelist_max_raise, 9900, 10000);
        if (v5) {
            v4.filled_ms = arg5;
        };
        if (v5) {
            let v6 = WhitelistFilled{
                curve_id  : arg1,
                raised    : v4.whitelist_raised,
                filled_ms : arg5,
            };
            0x2::event::emit<WhitelistFilled>(v6);
        };
    }

    public fun wl_spent<T0>(arg0: &Curve<T0>, arg1: address) : u64 {
        wl_spent_at(&arg0.id, arg1)
    }

    public(friend) fun wl_spent_at(arg0: &0x2::object::UID, arg1: address) : u64 {
        let v0 = WlSpentKey{buyer: arg1};
        if (!0x2::dynamic_field::exists_with_type<WlSpentKey, u64>(arg0, v0)) {
            return 0
        };
        let v1 = WlSpentKey{buyer: arg1};
        *0x2::dynamic_field::borrow<WlSpentKey, u64>(arg0, v1)
    }

    // decompiled from Move bytecode v7
}

