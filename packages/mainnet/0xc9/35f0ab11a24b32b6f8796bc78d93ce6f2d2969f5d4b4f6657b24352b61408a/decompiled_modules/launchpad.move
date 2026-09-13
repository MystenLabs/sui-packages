module 0xc935f0ab11a24b32b6f8796bc78d93ce6f2d2969f5d4b4f6657b24352b61408a::launchpad {
    struct LockAuth has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Launchpad has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        treasury: address,
        buyback_sink: address,
        launch_fee: u64,
        creator_fee_bps: u64,
        buyback_bps: u64,
        tick_spacings: 0x2::vec_set::VecSet<u32>,
        open_quotes: bool,
        quotes: 0x2::table::Table<0x1::type_name::TypeName, u8>,
        launches: 0x2::table_vec::TableVec<0x2::object::ID>,
        by_coin: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct Launch<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        index: u64,
        creator: address,
        fee_recipient: address,
        fee_route: u8,
        creator_fee_bps: u64,
        coin_is_a: bool,
        pool_id: 0x2::object::ID,
        tick_spacing: u32,
        tick_lower: u32,
        tick_upper: u32,
        supply: u64,
        created_at_ms: u64,
        metadata: 0x1::string::String,
        locker: 0xc3f6f683a5da0d555a303f9fa5a43e86a6dcfcd399760426428963bdacc242fc::locker::Locker<LockAuth>,
        dust: 0x2::balance::Balance<T0>,
        pending_buyback: 0x2::balance::Balance<T1>,
        earned_coin: u128,
        earned_quote: u128,
        burned: u64,
    }

    struct Launched has copy, drop {
        pool_id: 0x2::object::ID,
        launch_id: 0x2::object::ID,
        index: u64,
        coin_type: 0x1::string::String,
        quote_type: 0x1::string::String,
        position_id: 0x2::object::ID,
        creator: address,
        coin_is_a: bool,
        tick_spacing: u32,
        fee_rate: u64,
        tick_lower: u32,
        tick_upper: u32,
        open_sqrt_price: u128,
        supply: u64,
        creator_amount: u64,
        dev_buy_quote: u64,
        dev_buy_coins: u64,
        creator_fee_bps: u64,
        fee_route: u8,
        fee_recipient: address,
        metadata: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct FeesCollected has copy, drop {
        launch_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        earned_coin: u64,
        earned_quote: u64,
        creator_coin: u64,
        creator_quote: u64,
        buyback_coin: u64,
        buyback_quote: u64,
        ops_coin: u64,
        ops_quote: u64,
        burned: u64,
        fee_route: u8,
    }

    struct BoughtBackAndBurned has copy, drop {
        launch_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        quote_spent: u64,
        coin_bought: u64,
        coin_burned: u64,
    }

    struct FeeRouteUpdated has copy, drop {
        launch_id: 0x2::object::ID,
        fee_route: u8,
    }

    struct FeeRecipientUpdated has copy, drop {
        launch_id: 0x2::object::ID,
        recipient: address,
    }

    struct SettingsUpdated has copy, drop {
        launchpad_id: 0x2::object::ID,
    }

    struct QuoteDecisionUpdated has copy, drop {
        quote_type: 0x1::string::String,
        decision: u8,
    }

    struct Opening has drop {
        coin_is_a: bool,
        tick_spacing: u32,
        fee_rate: u64,
        tick_lower: u32,
        tick_upper: u32,
        sqrt_open: u128,
        supply: u64,
        premine: u64,
        dev_buy_quote: u64,
        dev_buy_coins: u64,
        fee_route: u8,
        fee_recipient: address,
        metadata: 0x1::string::String,
    }

    public fun liquidity<T0, T1>(arg0: &Launch<T0, T1>) : u128 {
        0xc3f6f683a5da0d555a303f9fa5a43e86a6dcfcd399760426428963bdacc242fc::locker::liquidity<LockAuth>(&arg0.locker)
    }

    public fun pool_id<T0, T1>(arg0: &Launch<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_id<T0, T1>(arg0: &Launch<T0, T1>) : 0x2::object::ID {
        0xc3f6f683a5da0d555a303f9fa5a43e86a6dcfcd399760426428963bdacc242fc::locker::position_id<LockAuth>(&arg0.locker)
    }

    public fun add_tick_spacing(arg0: &mut Launchpad, arg1: &AdminCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: u32) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::get_fee_rate(arg3, arg2);
        if (!0x2::vec_set::contains<u32>(&arg0.tick_spacings, &arg3)) {
            0x2::vec_set::insert<u32>(&mut arg0.tick_spacings, arg3);
        };
        emit_settings(arg0);
    }

    fun assert_aligned(arg0: u32, arg1: u32) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero()), 13906838525146038285);
    }

    fun burn_all<T0, T1>(arg0: &mut Launch<T0, T1>, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::balance::join<T0>(&mut arg2, arg3);
        0x2::balance::join<T0>(&mut arg2, 0x2::balance::withdraw_all<T0>(&mut arg0.dust));
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0
        };
        arg0.burned = arg0.burned + v0;
        if (0x2::coin_registry::is_supply_burn_only<T0>(arg1)) {
            0x2::coin_registry::burn_balance<T0>(arg1, arg2);
        } else {
            send<T0>(arg2, @0x0, arg4);
        };
        v0
    }

    public fun burned<T0, T1>(arg0: &Launch<T0, T1>) : u64 {
        arg0.burned
    }

    fun buy_with_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0 || !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_swap<T1, T0>(arg1)) {
            return (0x2::balance::zero<T0>(), arg2)
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1);
        let v2 = buyback_limit(v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T1, T0>(arg1), false);
        if (v2 >= v1) {
            return (0x2::balance::zero<T0>(), arg2)
        };
        let (_, v4, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::compute_swap_step(v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T1, T0>(arg1), v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T1, T0>(arg1), true, true);
        if (v4 == 0) {
            return (0x2::balance::zero<T0>(), arg2)
        };
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, true, true, v0, v2, arg3);
        let v10 = v9;
        0x2::balance::destroy_zero<T1>(v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::split<T1>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v10)), 0x2::balance::zero<T0>(), v10);
        (v8, arg2)
    }

    fun buy_with_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0 || !0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_allow_swap<T0, T1>(arg1)) {
            return (0x2::balance::zero<T0>(), arg2)
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v2 = buyback_limit(v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1), true);
        if (v2 <= v1) {
            return (0x2::balance::zero<T0>(), arg2)
        };
        let (_, v4, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::compute_swap_step(v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg1), v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1), false, true);
        if (v4 == 0) {
            return (0x2::balance::zero<T0>(), arg2)
        };
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, v2, arg3);
        let v10 = v9;
        0x2::balance::destroy_zero<T1>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10)), v10);
        (v7, arg2)
    }

    fun buyback_limit(arg0: u128, arg1: u64, arg2: bool) : u128 {
        let v0 = (((arg0 as u256) * (arg1 as u256) / ((4 * 1000000) as u256)) as u128);
        let v1 = if (v0 == 0) {
            1
        } else {
            v0
        };
        if (arg2) {
            let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price();
            if (arg0 >= v3 - v1) {
                v3
            } else {
                arg0 + v1
            }
        } else {
            let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price();
            if (arg0 <= v4 + v1) {
                v4
            } else {
                arg0 - v1
            }
        }
    }

    fun check_launchable<T0, T1>(arg0: &Launchpad, arg1: u32, arg2: u64, arg3: u8, arg4: &0x1::string::String) {
        check_version(arg0);
        assert!(!arg0.paused, 13906838327576887299);
        assert!(is_quote_allowed<T1>(arg0), 13906838331872116743);
        assert!(0x2::vec_set::contains<u32>(&arg0.tick_spacings, &arg1), 13906838336167346187);
        assert!(arg2 <= 2000, 13906838340462837779);
        assert!(arg3 == 0 || arg3 == 1, 13906838344758067223);
        assert!(0x1::string::length(arg4) <= 1024, 13906838349052903445);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.by_coin, 0x1::type_name::with_defining_ids<T0>()), 13906838353348526111);
    }

    fun check_version(arg0: &Launchpad) {
        assert!(arg0.version == 1, 13906838280332115969);
    }

    public fun coin_is_a<T0, T1>(arg0: &Launch<T0, T1>) : bool {
        arg0.coin_is_a
    }

    public fun collect_as_a<T0, T1>(arg0: &Launchpad, arg1: &mut Launch<T0, T1>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg1.coin_is_a && 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4) == arg1.pool_id, 13906836721261215779);
        let v0 = LockAuth{dummy_field: false};
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg3, arg4, 0xc3f6f683a5da0d555a303f9fa5a43e86a6dcfcd399760426428963bdacc242fc::locker::position<LockAuth>(v0, &arg1.locker), true);
        let (v3, v4) = settle<T0, T1>(arg0, arg1, v1, v2, arg6);
        if (arg1.fee_route == 1) {
            let v5 = v4;
            0x2::balance::join<T1>(&mut v5, 0x2::balance::withdraw_all<T1>(&mut arg1.pending_buyback));
            let (v6, v7) = buy_with_b<T0, T1>(arg3, arg4, v5, arg5);
            let v8 = v7;
            let v9 = v6;
            0x2::balance::join<T1>(&mut arg1.pending_buyback, v8);
            let v10 = burn_all<T0, T1>(arg1, arg2, v3, v9, arg6);
            let v11 = BoughtBackAndBurned{
                launch_id   : 0x2::object::id<Launch<T0, T1>>(arg1),
                coin_type   : type_string<T0>(),
                quote_spent : 0x2::balance::value<T1>(&v5) - 0x2::balance::value<T1>(&v8),
                coin_bought : 0x2::balance::value<T0>(&v9),
                coin_burned : v10,
            };
            0x2::event::emit<BoughtBackAndBurned>(v11);
        } else {
            let v12 = v4;
            0x2::balance::join<T1>(&mut v12, 0x2::balance::withdraw_all<T1>(&mut arg1.pending_buyback));
            pay_recipient<T0, T1>(arg1, v3, v12, arg2, arg6);
        };
    }

    public fun collect_as_b<T0, T1>(arg0: &Launchpad, arg1: &mut Launch<T0, T1>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg1.coin_is_a && 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4) == arg1.pool_id, 13906836897354874915);
        let v0 = LockAuth{dummy_field: false};
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T0>(arg3, arg4, 0xc3f6f683a5da0d555a303f9fa5a43e86a6dcfcd399760426428963bdacc242fc::locker::position<LockAuth>(v0, &arg1.locker), true);
        let (v3, v4) = settle<T0, T1>(arg0, arg1, v2, v1, arg6);
        if (arg1.fee_route == 1) {
            let v5 = v4;
            0x2::balance::join<T1>(&mut v5, 0x2::balance::withdraw_all<T1>(&mut arg1.pending_buyback));
            let (v6, v7) = buy_with_a<T0, T1>(arg3, arg4, v5, arg5);
            let v8 = v7;
            let v9 = v6;
            0x2::balance::join<T1>(&mut arg1.pending_buyback, v8);
            let v10 = burn_all<T0, T1>(arg1, arg2, v3, v9, arg6);
            let v11 = BoughtBackAndBurned{
                launch_id   : 0x2::object::id<Launch<T0, T1>>(arg1),
                coin_type   : type_string<T0>(),
                quote_spent : 0x2::balance::value<T1>(&v5) - 0x2::balance::value<T1>(&v8),
                coin_bought : 0x2::balance::value<T0>(&v9),
                coin_burned : v10,
            };
            0x2::event::emit<BoughtBackAndBurned>(v11);
        } else {
            let v12 = v4;
            0x2::balance::join<T1>(&mut v12, 0x2::balance::withdraw_all<T1>(&mut arg1.pending_buyback));
            pay_recipient<T0, T1>(arg1, v3, v12, arg2, arg6);
        };
    }

    public fun creator<T0, T1>(arg0: &Launch<T0, T1>) : address {
        arg0.creator
    }

    public fun creator_fee_bps(arg0: &Launchpad) : u64 {
        arg0.creator_fee_bps
    }

    public fun dust<T0, T1>(arg0: &Launch<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.dust)
    }

    public fun earned<T0, T1>(arg0: &Launch<T0, T1>) : (u128, u128) {
        (arg0.earned_coin, arg0.earned_quote)
    }

    fun emit_settings(arg0: &Launchpad) {
        let v0 = SettingsUpdated{launchpad_id: 0x2::object::id<Launchpad>(arg0)};
        0x2::event::emit<SettingsUpdated>(v0);
    }

    public fun fee_recipient<T0, T1>(arg0: &Launch<T0, T1>) : address {
        arg0.fee_recipient
    }

    public fun fee_route<T0, T1>(arg0: &Launch<T0, T1>) : u8 {
        arg0.fee_route
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<u32>();
        0x2::vec_set::insert<u32>(&mut v0, 200);
        0x2::vec_set::insert<u32>(&mut v0, 220);
        let v1 = Launchpad{
            id              : 0x2::object::new(arg0),
            version         : 1,
            paused          : false,
            treasury        : 0x2::tx_context::sender(arg0),
            buyback_sink    : 0x2::tx_context::sender(arg0),
            launch_fee      : 2000000000,
            creator_fee_bps : 8000,
            buyback_bps     : 10000,
            tick_spacings   : v0,
            open_quotes     : true,
            quotes          : 0x2::table::new<0x1::type_name::TypeName, u8>(arg0),
            launches        : 0x2::table_vec::empty<0x2::object::ID>(arg0),
            by_coin         : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Launchpad>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_quote_allowed<T0>(arg0: &Launchpad) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::table::contains<0x1::type_name::TypeName, u8>(&arg0.quotes, v0) && *0x2::table::borrow<0x1::type_name::TypeName, u8>(&arg0.quotes, v0) == 1 || arg0.open_quotes
    }

    public fun launch_as_a<T0, T1>(arg0: &mut Launchpad, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u32, arg7: u32, arg8: u64, arg9: u8, arg10: address, arg11: u64, arg12: 0x1::string::String, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        check_launchable<T0, T1>(arg0, arg6, arg8, arg9, &arg12);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_right_order<T0, T1>(), 13906835565913309193);
        take_launch_fee(arg0, arg5, arg14);
        let v0 = max_aligned_tick(arg6);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg7);
        assert_aligned(arg7, arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(v0)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v0)), 13906835591683506191);
        let v2 = 0x2::coin::value<T0>(&arg3);
        assert!(v2 > 0, 13906835604568539153);
        let v3 = 0x2::coin::split<T0>(&mut arg3, share_of(v2, arg8), arg14);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::get_fee_rate(arg6, arg1);
        let v5 = &mut arg4;
        take_dev_buy_fee<T1>(arg0, v5, v4, arg14);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v1);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v0));
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(v6, v7, 0x2::coin::value<T0>(&arg3), false);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_b_down(v6, v8, spendable(0x2::coin::value<T1>(&arg4)), true);
        assert!(v9 > v6, 13906835668993572889);
        assert!(v9 < v7, 13906835673288671259);
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(v6, v9, v8, false);
        assert!(v10 >= arg11, 13906835686173704221);
        let v11 = 0x2::coin::split<T0>(&mut arg3, v10, arg14);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T0, T1>(arg1, arg2, arg6, v9, 0x1::string::utf8(b""), arg7, v0, arg3, arg4, true, arg13, arg14);
        let v15 = v14;
        let v16 = Opening{
            coin_is_a     : true,
            tick_spacing  : arg6,
            fee_rate      : v4,
            tick_lower    : arg7,
            tick_upper    : v0,
            sqrt_open     : v9,
            supply        : v2,
            premine       : 0x2::coin::value<T0>(&v3),
            dev_buy_quote : 0x2::coin::value<T1>(&arg4) - 0x2::coin::value<T1>(&v15),
            dev_buy_coins : v10,
            fee_route     : arg9,
            fee_recipient : arg10,
            metadata      : arg12,
        };
        record<T0, T1>(arg0, v16, v12, v13, arg13, arg14);
        pay_creator<T0, T1>(v3, v11, v15, arg14);
    }

    public fun launch_as_b<T0, T1>(arg0: &mut Launchpad, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u32, arg7: u32, arg8: u64, arg9: u8, arg10: address, arg11: u64, arg12: 0x1::string::String, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        check_launchable<T0, T1>(arg0, arg6, arg8, arg9, &arg12);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_right_order<T1, T0>(), 13906835969640235017);
        take_launch_fee(arg0, arg5, arg14);
        let v0 = max_aligned_tick(arg6);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg7);
        assert_aligned(arg7, arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(v0)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v0)), 13906835995410432015);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(v0);
        let v3 = 0x2::coin::value<T0>(&arg3);
        assert!(v3 > 0, 13906836012590432273);
        let v4 = 0x2::coin::split<T0>(&mut arg3, share_of(v3, arg8), arg14);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::get_fee_rate(arg6, arg1);
        let v6 = &mut arg4;
        take_dev_buy_fee<T1>(arg0, v6, v5, arg14);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v2);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v1);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(v7, v8, 0x2::coin::value<T0>(&arg3), false);
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_a_up(v8, v9, spendable(0x2::coin::value<T1>(&arg4)), true);
        assert!(v10 < v8, 13906836072720498713);
        assert!(v10 > v7, 13906836077015597083);
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(v10, v8, v9, false);
        assert!(v11 >= arg11, 13906836089900630045);
        let v12 = 0x2::coin::split<T0>(&mut arg3, v11, arg14);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T1, T0>(arg1, arg2, arg6, v10, 0x1::string::utf8(b""), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v2), arg7, arg4, arg3, false, arg13, arg14);
        let v16 = v14;
        let v17 = Opening{
            coin_is_a     : false,
            tick_spacing  : arg6,
            fee_rate      : v5,
            tick_lower    : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v2),
            tick_upper    : arg7,
            sqrt_open     : v10,
            supply        : v3,
            premine       : 0x2::coin::value<T0>(&v4),
            dev_buy_quote : 0x2::coin::value<T1>(&arg4) - 0x2::coin::value<T1>(&v16),
            dev_buy_coins : v11,
            fee_route     : arg9,
            fee_recipient : arg10,
            metadata      : arg12,
        };
        record<T0, T1>(arg0, v17, v13, v15, arg13, arg14);
        pay_creator<T0, T1>(v4, v12, v16, arg14);
    }

    public fun launch_count(arg0: &Launchpad) : u64 {
        0x2::table_vec::length<0x2::object::ID>(&arg0.launches)
    }

    public fun launch_creator_fee_bps<T0, T1>(arg0: &Launch<T0, T1>) : u64 {
        arg0.creator_fee_bps
    }

    public fun launch_fee(arg0: &Launchpad) : u64 {
        arg0.launch_fee
    }

    public fun launch_id_of<T0>(arg0: &Launchpad) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.by_coin, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.by_coin, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun max_aligned_tick(arg0: u32) : u32 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::tick_bound();
        v0 - v0 % arg0
    }

    public fun migrate(arg0: &mut Launchpad, arg1: &AdminCap) {
        assert!(arg0.version < 1, 13906838039816568873);
        arg0.version = 1;
        emit_settings(arg0);
    }

    fun pay_creator<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::tx_context::TxContext) {
        0x2::coin::join<T0>(&mut arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
        if (0x2::coin::value<T1>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
    }

    fun pay_recipient<T0, T1>(arg0: &mut Launch<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        send<T0>(arg1, arg0.fee_recipient, arg4);
        send<T1>(arg2, arg0.fee_recipient, arg4);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.dust);
        burn_all<T0, T1>(arg0, arg3, v0, 0x2::balance::zero<T0>(), arg4);
    }

    public fun pending_buyback<T0, T1>(arg0: &Launch<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.pending_buyback)
    }

    fun record<T0, T1>(arg0: &mut Launchpad, arg1: Opening, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.by_coin, v0), 13906836394843439135);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = if (arg1.fee_recipient == @0x0) {
            v1
        } else {
            arg1.fee_recipient
        };
        let v3 = LockAuth{dummy_field: false};
        let v4 = 0xc3f6f683a5da0d555a303f9fa5a43e86a6dcfcd399760426428963bdacc242fc::locker::lock<LockAuth>(v3, arg2, arg5);
        let v5 = 0xc3f6f683a5da0d555a303f9fa5a43e86a6dcfcd399760426428963bdacc242fc::locker::pool_id<LockAuth>(&v4);
        let v6 = Launch<T0, T1>{
            id              : 0x2::object::new(arg5),
            index           : 0x2::table_vec::length<0x2::object::ID>(&arg0.launches),
            creator         : v1,
            fee_recipient   : v2,
            fee_route       : arg1.fee_route,
            creator_fee_bps : arg0.creator_fee_bps,
            coin_is_a       : arg1.coin_is_a,
            pool_id         : v5,
            tick_spacing    : arg1.tick_spacing,
            tick_lower      : arg1.tick_lower,
            tick_upper      : arg1.tick_upper,
            supply          : arg1.supply,
            created_at_ms   : 0x2::clock::timestamp_ms(arg4),
            metadata        : arg1.metadata,
            locker          : v4,
            dust            : 0x2::coin::into_balance<T0>(arg3),
            pending_buyback : 0x2::balance::zero<T1>(),
            earned_coin     : 0,
            earned_quote    : 0,
            burned          : 0,
        };
        let v7 = 0x2::object::id<Launch<T0, T1>>(&v6);
        let v8 = Launched{
            pool_id         : v5,
            launch_id       : v7,
            index           : v6.index,
            coin_type       : type_string<T0>(),
            quote_type      : type_string<T1>(),
            position_id     : 0xc3f6f683a5da0d555a303f9fa5a43e86a6dcfcd399760426428963bdacc242fc::locker::position_id<LockAuth>(&v4),
            creator         : v1,
            coin_is_a       : arg1.coin_is_a,
            tick_spacing    : arg1.tick_spacing,
            fee_rate        : arg1.fee_rate,
            tick_lower      : arg1.tick_lower,
            tick_upper      : arg1.tick_upper,
            open_sqrt_price : arg1.sqrt_open,
            supply          : arg1.supply,
            creator_amount  : arg1.premine,
            dev_buy_quote   : arg1.dev_buy_quote,
            dev_buy_coins   : arg1.dev_buy_coins,
            creator_fee_bps : v6.creator_fee_bps,
            fee_route       : arg1.fee_route,
            fee_recipient   : v2,
            metadata        : v6.metadata,
            timestamp_ms    : v6.created_at_ms,
        };
        0x2::event::emit<Launched>(v8);
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg0.launches, v7);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.by_coin, v0, v7);
        0x2::transfer::share_object<Launch<T0, T1>>(v6);
    }

    public fun remove_tick_spacing(arg0: &mut Launchpad, arg1: &AdminCap, arg2: u32) {
        if (0x2::vec_set::contains<u32>(&arg0.tick_spacings, &arg2)) {
            0x2::vec_set::remove<u32>(&mut arg0.tick_spacings, &arg2);
        };
        emit_settings(arg0);
    }

    fun send<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    public fun set_buyback_bps(arg0: &mut Launchpad, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 <= 10000, 13906837876607549477);
        arg0.buyback_bps = arg2;
        emit_settings(arg0);
    }

    public fun set_buyback_sink(arg0: &mut Launchpad, arg1: &AdminCap, arg2: address) {
        arg0.buyback_sink = arg2;
        emit_settings(arg0);
    }

    public fun set_creator_fee_bps(arg0: &mut Launchpad, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 <= 10000, 13906837850837745701);
        arg0.creator_fee_bps = arg2;
        emit_settings(arg0);
    }

    public fun set_fee_recipient<T0, T1>(arg0: &Launchpad, arg1: &mut Launch<T0, T1>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.creator, 13906837721988464673);
        let v0 = if (arg2 == @0x0) {
            arg1.creator
        } else {
            arg2
        };
        arg1.fee_recipient = v0;
        let v1 = FeeRecipientUpdated{
            launch_id : 0x2::object::id<Launch<T0, T1>>(arg1),
            recipient : arg1.fee_recipient,
        };
        0x2::event::emit<FeeRecipientUpdated>(v1);
    }

    public fun set_fee_route<T0, T1>(arg0: &Launchpad, arg1: &mut Launch<T0, T1>, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.creator, 13906837683333759009);
        assert!(arg2 == 0 || arg2 == 1, 13906837687628070935);
        arg1.fee_route = arg2;
        let v0 = FeeRouteUpdated{
            launch_id : 0x2::object::id<Launch<T0, T1>>(arg1),
            fee_route : arg2,
        };
        0x2::event::emit<FeeRouteUpdated>(v0);
    }

    public fun set_launch_fee(arg0: &mut Launchpad, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 <= 100000000000, 13906837820773105703);
        arg0.launch_fee = arg2;
        emit_settings(arg0);
    }

    public fun set_open_quotes(arg0: &mut Launchpad, arg1: &AdminCap, arg2: bool) {
        arg0.open_quotes = arg2;
        emit_settings(arg0);
    }

    public fun set_paused(arg0: &mut Launchpad, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
        emit_settings(arg0);
    }

    public fun set_quote_decision<T0>(arg0: &mut Launchpad, arg1: &AdminCap, arg2: u8) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u8>(&arg0.quotes, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u8>(&mut arg0.quotes, v0);
        };
        if (arg2 == 1 || arg2 == 2) {
            0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg0.quotes, v0, arg2);
        };
        let v1 = QuoteDecisionUpdated{
            quote_type : type_string<T0>(),
            decision   : arg2,
        };
        0x2::event::emit<QuoteDecisionUpdated>(v1);
    }

    public fun set_treasury(arg0: &mut Launchpad, arg1: &AdminCap, arg2: address) {
        arg0.treasury = arg2;
        emit_settings(arg0);
    }

    fun settle<T0, T1>(arg0: &Launchpad, arg1: &mut Launch<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::balance::value<T1>(&arg3);
        arg1.earned_coin = arg1.earned_coin + (v0 as u128);
        arg1.earned_quote = arg1.earned_quote + (v1 as u128);
        let v2 = 0x2::balance::split<T0>(&mut arg2, share_of(v0, arg1.creator_fee_bps));
        let v3 = 0x2::balance::split<T1>(&mut arg3, share_of(v1, arg1.creator_fee_bps));
        let v4 = 0x2::balance::split<T0>(&mut arg2, share_of(0x2::balance::value<T0>(&arg2), arg0.buyback_bps));
        let v5 = 0x2::balance::split<T1>(&mut arg3, share_of(0x2::balance::value<T1>(&arg3), arg0.buyback_bps));
        let v6 = if (arg1.fee_route == 1) {
            0x2::balance::value<T0>(&v2)
        } else {
            0
        };
        let v7 = FeesCollected{
            launch_id     : 0x2::object::id<Launch<T0, T1>>(arg1),
            coin_type     : type_string<T0>(),
            earned_coin   : v0,
            earned_quote  : v1,
            creator_coin  : 0x2::balance::value<T0>(&v2),
            creator_quote : 0x2::balance::value<T1>(&v3),
            buyback_coin  : 0x2::balance::value<T0>(&v4),
            buyback_quote : 0x2::balance::value<T1>(&v5),
            ops_coin      : 0x2::balance::value<T0>(&arg2),
            ops_quote     : 0x2::balance::value<T1>(&arg3),
            burned        : v6,
            fee_route     : arg1.fee_route,
        };
        0x2::event::emit<FeesCollected>(v7);
        send<T0>(v4, arg0.buyback_sink, arg4);
        send<T1>(v5, arg0.buyback_sink, arg4);
        send<T0>(arg2, arg0.treasury, arg4);
        send<T1>(arg3, arg0.treasury, arg4);
        (v2, v3)
    }

    fun share_of(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun spendable(arg0: u64) : u64 {
        let v0 = arg0 / 1000 + 10;
        assert!(arg0 > v0, 13906838477902184473);
        arg0 - v0
    }

    public fun supply<T0, T1>(arg0: &Launch<T0, T1>) : u64 {
        arg0.supply
    }

    fun take_dev_buy_fee<T0>(arg0: &Launchpad, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = (((0x2::coin::value<T0>(arg1) as u128) * (arg2 as u128) / (1000000 as u128)) as u64);
        let v1 = v0 - share_of(v0, arg0.creator_fee_bps);
        if (v1 == 0) {
            return
        };
        let v2 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v1, arg3));
        send<T0>(0x2::balance::split<T0>(&mut v2, share_of(v1, arg0.buyback_bps)), arg0.buyback_sink, arg3);
        send<T0>(v2, arg0.treasury, arg3);
    }

    fun take_launch_fee(arg0: &Launchpad, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.launch_fee, 13906838374821658629);
        if (arg0.launch_fee > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.launch_fee, arg2), arg0.treasury);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    fun type_string<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    // decompiled from Move bytecode v7
}

