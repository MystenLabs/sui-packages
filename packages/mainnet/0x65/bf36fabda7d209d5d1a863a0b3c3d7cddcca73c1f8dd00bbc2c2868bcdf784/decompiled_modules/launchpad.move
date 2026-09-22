module 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::launchpad {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DistributorCap has store, key {
        id: 0x2::object::UID,
    }

    struct LockAuth has drop {
        dummy_field: bool,
    }

    struct Launchpad has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        treasury: address,
        ops: address,
        launch_fee: u64,
        protocol_bps: u64,
        tick_spacings: 0x2::vec_set::VecSet<u32>,
        partner_id: 0x1::option::Option<0x2::object::ID>,
        quotes: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        launches: 0x2::table_vec::TableVec<0x2::object::ID>,
        by_coin: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct Launch<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        index: u64,
        creator: address,
        created_at_ms: u64,
        metadata: 0x1::string::String,
        x_handle: 0x1::option::Option<0x1::string::String>,
        x_bps: u64,
        holders_bps: u64,
        creator_bps: u64,
        protocol_bps: u64,
        x_status: u8,
        coin_is_a: bool,
        pool_id: 0x2::object::ID,
        tick_spacing: u32,
        tick_lower: u32,
        tick_upper: u32,
        supply: u64,
        premine: u64,
        locker: 0xa1d8cc7314c0c0105d0851ff53e4f8133ec161a4778b2c5993691f38a24347ad::locker::Locker<LockAuth>,
        x_escrow: 0x2::balance::Balance<T1>,
        holder_pot: 0x2::balance::Balance<T1>,
        pending_coin: 0x2::balance::Balance<T0>,
        earned_coin: u128,
        earned_quote: u128,
        x_claimed: u64,
        holders_paid: u64,
    }

    struct Launched has copy, drop {
        launch_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        index: u64,
        coin_type: 0x1::string::String,
        quote_type: 0x1::string::String,
        creator: address,
        x_handle: 0x1::option::Option<0x1::string::String>,
        x_bps: u64,
        holders_bps: u64,
        creator_bps: u64,
        protocol_bps: u64,
        coin_is_a: bool,
        tick_spacing: u32,
        tick_lower: u32,
        tick_upper: u32,
        open_sqrt_price: u128,
        liquidity: u128,
        supply: u64,
        premine: u64,
        dev_buy_quote: u64,
        dev_buy_coins: u64,
        protocol_fee: u64,
        preload_x: u64,
        preload_holders: u64,
        metadata: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct FeesCollected has copy, drop {
        launch_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        earned_coin: u64,
        earned_quote: u64,
        to_x: u64,
        to_holders: u64,
        to_creator: u64,
        to_protocol: u64,
        x_active: bool,
    }

    struct Converted has copy, drop {
        launch_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        coin_sold: u64,
        quote_out: u64,
        to_x: u64,
        to_holders: u64,
        to_creator: u64,
        to_protocol: u64,
    }

    struct HoldersPaid has copy, drop {
        launch_id: 0x2::object::ID,
        recipients: vector<address>,
        amounts: vector<u64>,
        total: u64,
        pot_remaining: u64,
    }

    struct Claimed has copy, drop {
        launch_id: 0x2::object::ID,
        x_handle: 0x1::option::Option<0x1::string::String>,
        amount: u64,
        to: address,
        remaining: u64,
        total_claimed: u64,
    }

    struct XStatusChanged has copy, drop {
        launch_id: 0x2::object::ID,
        x_handle: 0x1::option::Option<0x1::string::String>,
        status: u8,
        swept_to_holders: u64,
    }

    struct SettingsChanged has copy, drop {
        treasury: address,
        ops: address,
        launch_fee: u64,
        protocol_bps: u64,
        paused: bool,
    }

    public fun pool_id<T0, T1>(arg0: &Launch<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun liquidity<T0, T1>(arg0: &Launch<T0, T1>) : u128 {
        0xa1d8cc7314c0c0105d0851ff53e4f8133ec161a4778b2c5993691f38a24347ad::locker::liquidity<LockAuth>(&arg0.locker)
    }

    public fun position_id<T0, T1>(arg0: &Launch<T0, T1>) : 0x2::object::ID {
        0xa1d8cc7314c0c0105d0851ff53e4f8133ec161a4778b2c5993691f38a24347ad::locker::position_id<LockAuth>(&arg0.locker)
    }

    public fun coin_is_a<T0, T1>(arg0: &Launch<T0, T1>) : bool {
        arg0.coin_is_a
    }

    public fun add_tick_spacing(arg0: &mut Launchpad, arg1: &AdminCap, arg2: u32) {
        if (!0x2::vec_set::contains<u32>(&arg0.tick_spacings, &arg2)) {
            0x2::vec_set::insert<u32>(&mut arg0.tick_spacings, arg2);
        };
    }

    public(friend) fun assert_partner(arg0: &Launchpad, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.partner_id), 19);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg1);
        assert!(0x1::option::borrow<0x2::object::ID>(&arg0.partner_id) == &v0, 20);
    }

    public fun bps<T0, T1>(arg0: &Launch<T0, T1>) : (u64, u64, u64, u64) {
        (arg0.x_bps, arg0.holders_bps, arg0.creator_bps, arg0.protocol_bps)
    }

    public fun burn_distributor_cap(arg0: DistributorCap) {
        let DistributorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun claim_x<T0, T1>(arg0: &Launchpad, arg1: &AdminCap, arg2: &mut Launch<T0, T1>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<T1>(&arg2.x_escrow), 15);
        pay<T1>(0x2::balance::split<T1>(&mut arg2.x_escrow, arg3), arg4, arg5);
        arg2.x_claimed = arg2.x_claimed + arg3;
        let v0 = Claimed{
            launch_id     : 0x2::object::id<Launch<T0, T1>>(arg2),
            x_handle      : arg2.x_handle,
            amount        : arg3,
            to            : arg4,
            remaining     : 0x2::balance::value<T1>(&arg2.x_escrow),
            total_claimed : arg2.x_claimed,
        };
        0x2::event::emit<Claimed>(v0);
    }

    public fun collect_as_a<T0, T1>(arg0: &Launchpad, arg1: &mut Launch<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(!arg0.paused, 2);
        assert!(arg1.coin_is_a, 11);
        let v0 = LockAuth{dummy_field: false};
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, 0xa1d8cc7314c0c0105d0851ff53e4f8133ec161a4778b2c5993691f38a24347ad::locker::position<LockAuth>(v0, &arg1.locker), true);
        settle<T0, T1>(arg0, arg1, v1, v2, arg4);
    }

    public fun collect_as_b<T0, T1>(arg0: &Launchpad, arg1: &mut Launch<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(!arg0.paused, 2);
        assert!(!arg1.coin_is_a, 11);
        let v0 = LockAuth{dummy_field: false};
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T0>(arg2, arg3, 0xa1d8cc7314c0c0105d0851ff53e4f8133ec161a4778b2c5993691f38a24347ad::locker::position<LockAuth>(v0, &arg1.locker), true);
        settle<T0, T1>(arg0, arg1, v2, v1, arg4);
    }

    public fun convert_as_a<T0, T1>(arg0: &Launchpad, arg1: &mut Launch<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(!arg0.paused, 2);
        assert!(arg1.coin_is_a, 11);
        let v0 = 0x2::balance::value<T0>(&arg1.pending_coin);
        assert!(v0 > 0, 12);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, true, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg5);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::split<T0>(&mut arg1.pending_coin, v6), 0x2::balance::zero<T1>(), v4);
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x2::balance::value<T1>(&v5) >= arg4, 10);
        finish_convert<T0, T1>(arg0, arg1, v6, v5, arg6);
    }

    public fun convert_as_a_with_partner<T0, T1>(arg0: &Launchpad, arg1: &mut Launch<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(!arg0.paused, 2);
        assert!(arg1.coin_is_a, 11);
        assert_partner(arg0, arg4);
        let v0 = 0x2::balance::value<T0>(&arg1.pending_coin);
        assert!(v0 > 0, 12);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg2, arg3, arg4, true, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg2, arg3, arg4, 0x2::balance::split<T0>(&mut arg1.pending_coin, v6), 0x2::balance::zero<T1>(), v4);
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x2::balance::value<T1>(&v5) >= arg5, 10);
        finish_convert<T0, T1>(arg0, arg1, v6, v5, arg7);
    }

    public fun convert_as_b<T0, T1>(arg0: &Launchpad, arg1: &mut Launch<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(!arg0.paused, 2);
        assert!(!arg1.coin_is_a, 11);
        let v0 = 0x2::balance::value<T0>(&arg1.pending_coin);
        assert!(v0 > 0, 12);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg2, arg3, false, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg5);
        let v4 = v3;
        let v5 = v1;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg2, arg3, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut arg1.pending_coin, v6), v4);
        0x2::balance::destroy_zero<T0>(v2);
        assert!(0x2::balance::value<T1>(&v5) >= arg4, 10);
        finish_convert<T0, T1>(arg0, arg1, v6, v5, arg6);
    }

    public fun convert_as_b_with_partner<T0, T1>(arg0: &Launchpad, arg1: &mut Launch<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(!arg0.paused, 2);
        assert!(!arg1.coin_is_a, 11);
        assert_partner(arg0, arg4);
        let v0 = 0x2::balance::value<T0>(&arg1.pending_coin);
        assert!(v0 > 0, 12);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T1, T0>(arg2, arg3, arg4, false, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg6);
        let v4 = v3;
        let v5 = v1;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T1, T0>(arg2, arg3, arg4, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut arg1.pending_coin, v6), v4);
        0x2::balance::destroy_zero<T0>(v2);
        assert!(0x2::balance::value<T1>(&v5) >= arg5, 10);
        finish_convert<T0, T1>(arg0, arg1, v6, v5, arg7);
    }

    public fun creator<T0, T1>(arg0: &Launch<T0, T1>) : address {
        arg0.creator
    }

    fun distribute<T0, T1>(arg0: &mut Launch<T0, T1>, arg1: address, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        let (v0, v1, v2, v3) = split_quote<T0, T1>(arg0, 0x2::balance::value<T1>(&arg2));
        0x2::balance::join<T1>(&mut arg0.x_escrow, 0x2::balance::split<T1>(&mut arg2, v0));
        0x2::balance::join<T1>(&mut arg0.holder_pot, 0x2::balance::split<T1>(&mut arg2, v1));
        pay<T1>(0x2::balance::split<T1>(&mut arg2, v2), arg0.creator, arg3);
        pay<T1>(arg2, arg1, arg3);
        (v0, v1, v2, v3)
    }

    public fun earned<T0, T1>(arg0: &Launch<T0, T1>) : (u128, u128) {
        (arg0.earned_coin, arg0.earned_quote)
    }

    fun emit_settings(arg0: &Launchpad) {
        let v0 = SettingsChanged{
            treasury     : arg0.treasury,
            ops          : arg0.ops,
            launch_fee   : arg0.launch_fee,
            protocol_bps : arg0.protocol_bps,
            paused       : arg0.paused,
        };
        0x2::event::emit<SettingsChanged>(v0);
    }

    fun finish<T0, T1>(arg0: &mut Launchpad, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::Opening, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T1>, arg6: u32, arg7: 0x1::option::Option<0x1::string::String>, arg8: u64, arg9: u64, arg10: u64, arg11: 0x1::string::String, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg1);
        let v2 = 0x2::table_vec::length<0x2::object::ID>(&arg0.launches);
        let v3 = 0x2::object::new(arg13);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = LockAuth{dummy_field: false};
        let v6 = Launch<T0, T1>{
            id            : v3,
            index         : v2,
            creator       : v0,
            created_at_ms : 0x2::clock::timestamp_ms(arg12),
            metadata      : arg11,
            x_handle      : arg7,
            x_bps         : arg8,
            holders_bps   : arg9,
            creator_bps   : arg10,
            protocol_bps  : arg0.protocol_bps,
            x_status      : 0,
            coin_is_a     : 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::coin_is_a(&arg2),
            pool_id       : v1,
            tick_spacing  : arg6,
            tick_lower    : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::tick_lower(&arg2)),
            tick_upper    : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::tick_upper(&arg2)),
            supply        : 1000000000000000000,
            premine       : 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::premine(&arg2),
            locker        : 0xa1d8cc7314c0c0105d0851ff53e4f8133ec161a4778b2c5993691f38a24347ad::locker::lock<LockAuth>(v5, arg1, arg13),
            x_escrow      : 0x2::balance::zero<T1>(),
            holder_pot    : 0x2::balance::zero<T1>(),
            pending_coin  : 0x2::balance::zero<T0>(),
            earned_coin   : 0,
            earned_quote  : 0,
            x_claimed     : 0,
            holders_paid  : 0,
        };
        let v7 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::protocol_fee(&arg2), arg13));
        pay<T1>(v7, arg0.treasury, arg13);
        let (v8, v9) = split_preload<T0, T1>(&v6, 0x2::coin::value<T1>(&arg5));
        let v10 = 0x2::coin::into_balance<T1>(arg5);
        0x2::balance::join<T1>(&mut v6.x_escrow, 0x2::balance::split<T1>(&mut v10, v8));
        0x2::balance::join<T1>(&mut v6.holder_pot, v10);
        let v11 = Launched{
            launch_id       : v4,
            pool_id         : v1,
            position_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1),
            index           : v2,
            coin_type       : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            quote_type      : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())),
            creator         : v0,
            x_handle        : v6.x_handle,
            x_bps           : arg8,
            holders_bps     : arg9,
            creator_bps     : arg10,
            protocol_bps    : v6.protocol_bps,
            coin_is_a       : v6.coin_is_a,
            tick_spacing    : v6.tick_spacing,
            tick_lower      : v6.tick_lower,
            tick_upper      : v6.tick_upper,
            open_sqrt_price : 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::sqrt_open(&arg2),
            liquidity       : 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::liquidity(&arg2),
            supply          : 1000000000000000000,
            premine         : 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::premine(&arg2),
            dev_buy_quote   : 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::spend(&arg2),
            dev_buy_coins   : 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::dev_buy_coins(&arg2),
            protocol_fee    : 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::protocol_fee(&arg2),
            preload_x       : v8,
            preload_holders : v9,
            metadata        : v6.metadata,
            timestamp_ms    : v6.created_at_ms,
        };
        0x2::event::emit<Launched>(v11);
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg0.launches, v4);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.by_coin, 0x1::type_name::with_defining_ids<T0>(), v4);
        pay<T0>(0x2::coin::into_balance<T0>(arg3), v0, arg13);
        pay<T1>(0x2::coin::into_balance<T1>(arg4), v0, arg13);
        0x2::transfer::share_object<Launch<T0, T1>>(v6);
    }

    fun finish_convert<T0, T1>(arg0: &Launchpad, arg1: &mut Launch<T0, T1>, arg2: u64, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Launch<T0, T1>>(arg1);
        let (v1, v2, v3, v4) = distribute<T0, T1>(arg1, arg0.treasury, arg3, arg4);
        let v5 = Converted{
            launch_id   : v0,
            coin_type   : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            coin_sold   : arg2,
            quote_out   : 0x2::balance::value<T1>(&arg3),
            to_x        : v1,
            to_holders  : v2,
            to_creator  : v3,
            to_protocol : v4,
        };
        0x2::event::emit<Converted>(v5);
    }

    public fun holder_pot<T0, T1>(arg0: &Launch<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.holder_pot)
    }

    public fun holders_paid<T0, T1>(arg0: &Launch<T0, T1>) : u64 {
        arg0.holders_paid
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = DistributorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DistributorCap>(v2, v0);
        let v3 = 0x2::vec_set::empty<u32>();
        0x2::vec_set::insert<u32>(&mut v3, 200);
        let v4 = Launchpad{
            id            : 0x2::object::new(arg0),
            version       : 1,
            paused        : false,
            treasury      : v0,
            ops           : v0,
            launch_fee    : 2000000000,
            protocol_bps  : 1000,
            tick_spacings : v3,
            partner_id    : 0x1::option::none<0x2::object::ID>(),
            quotes        : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
            launches      : 0x2::table_vec::empty<0x2::object::ID>(arg0),
            by_coin       : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Launchpad>(v4);
    }

    public fun is_quote_allowed<T0>(arg0: &Launchpad) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.quotes, v0) && *0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg0.quotes, v0)
    }

    public fun launch_as_a<T0, T1>(arg0: &mut Launchpad, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<T1>, arg7: u32, arg8: u32, arg9: u64, arg10: 0x1::option::Option<0x1::string::String>, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = preflight<T0, T1>(arg0, arg1, true, &arg3, &arg4, arg5, arg7, arg8, arg9, &arg10, arg11, arg12, arg13, arg18);
        assert!(0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::dev_buy_coins(&v0) >= arg14, 10);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T0, T1>(arg1, arg2, arg7, 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::sqrt_open(&v0), arg16, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::tick_lower(&v0)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::tick_upper(&v0)), 0x2::coin::split<T0>(&mut arg3, 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::coin_deposited(&v0), arg18), 0x2::coin::split<T1>(&mut arg4, 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::quote_deposited(&v0), arg18), true, arg17, arg18);
        0x2::coin::join<T0>(&mut arg3, v2);
        0x2::coin::join<T1>(&mut arg4, v3);
        finish<T0, T1>(arg0, v1, v0, arg3, arg4, arg6, arg7, arg10, arg11, arg12, arg13, arg15, arg17, arg18);
    }

    public fun launch_as_b<T0, T1>(arg0: &mut Launchpad, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<T1>, arg7: u32, arg8: u32, arg9: u64, arg10: 0x1::option::Option<0x1::string::String>, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = preflight<T0, T1>(arg0, arg1, false, &arg3, &arg4, arg5, arg7, arg8, arg9, &arg10, arg11, arg12, arg13, arg18);
        assert!(0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::dev_buy_coins(&v0) >= arg14, 10);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T1, T0>(arg1, arg2, arg7, 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::sqrt_open(&v0), arg16, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::tick_lower(&v0)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::tick_upper(&v0)), 0x2::coin::split<T1>(&mut arg4, 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::quote_deposited(&v0), arg18), 0x2::coin::split<T0>(&mut arg3, 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::coin_deposited(&v0), arg18), false, arg17, arg18);
        0x2::coin::join<T1>(&mut arg4, v2);
        0x2::coin::join<T0>(&mut arg3, v3);
        finish<T0, T1>(arg0, v1, v0, arg3, arg4, arg6, arg7, arg10, arg11, arg12, arg13, arg15, arg17, arg18);
    }

    public fun launch_count(arg0: &Launchpad) : u64 {
        0x2::table_vec::length<0x2::object::ID>(&arg0.launches)
    }

    public fun launch_fee(arg0: &Launchpad) : u64 {
        arg0.launch_fee
    }

    public fun launch_id_of<T0>(arg0: &Launchpad) : 0x2::object::ID {
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.by_coin, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun mark_ineligible<T0, T1>(arg0: &AdminCap, arg1: &mut Launch<T0, T1>) {
        assert!(arg1.x_status != 2, 16);
        arg1.x_status = 2;
        let v0 = 0x2::balance::value<T1>(&arg1.x_escrow);
        if (v0 > 0) {
            0x2::balance::join<T1>(&mut arg1.holder_pot, 0x2::balance::split<T1>(&mut arg1.x_escrow, v0));
        };
        let v1 = XStatusChanged{
            launch_id        : 0x2::object::id<Launch<T0, T1>>(arg1),
            x_handle         : arg1.x_handle,
            status           : 2,
            swept_to_holders : v0,
        };
        0x2::event::emit<XStatusChanged>(v1);
    }

    public fun mark_paid<T0, T1>(arg0: &AdminCap, arg1: &mut Launch<T0, T1>) {
        assert!(arg1.x_status != 2, 16);
        arg1.x_status = 1;
        let v0 = XStatusChanged{
            launch_id        : 0x2::object::id<Launch<T0, T1>>(arg1),
            x_handle         : arg1.x_handle,
            status           : 1,
            swept_to_holders : 0,
        };
        0x2::event::emit<XStatusChanged>(v0);
    }

    public fun migrate(arg0: &mut Launchpad, arg1: &AdminCap) {
        assert!(arg0.version < 1, 1);
        arg0.version = 1;
    }

    public fun new_distributor_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : DistributorCap {
        DistributorCap{id: 0x2::object::new(arg1)}
    }

    public fun ops(arg0: &Launchpad) : address {
        arg0.ops
    }

    public fun pad_protocol_bps(arg0: &Launchpad) : u64 {
        arg0.protocol_bps
    }

    public fun partner_id(arg0: &Launchpad) : 0x1::option::Option<0x2::object::ID> {
        arg0.partner_id
    }

    public fun paused(arg0: &Launchpad) : bool {
        arg0.paused
    }

    fun pay<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    public fun pay_holders<T0, T1>(arg0: &Launchpad, arg1: &DistributorCap, arg2: &mut Launch<T0, T1>, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u64>(&arg4), 14);
        let v0 = 0;
        let v1 = &arg4;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v1)) {
            v0 = v0 + *0x1::vector::borrow<u64>(v1, v2);
            v2 = v2 + 1;
        };
        assert!(v0 <= 0x2::balance::value<T1>(&arg2.holder_pot), 13);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg3)) {
            let v4 = *0x1::vector::borrow<u64>(&arg4, v3);
            if (v4 > 0) {
                pay<T1>(0x2::balance::split<T1>(&mut arg2.holder_pot, v4), *0x1::vector::borrow<address>(&arg3, v3), arg5);
            };
            v3 = v3 + 1;
        };
        arg2.holders_paid = arg2.holders_paid + v0;
        let v5 = HoldersPaid{
            launch_id     : 0x2::object::id<Launch<T0, T1>>(arg2),
            recipients    : arg3,
            amounts       : arg4,
            total         : v0,
            pot_remaining : 0x2::balance::value<T1>(&arg2.holder_pot),
        };
        0x2::event::emit<HoldersPaid>(v5);
    }

    public fun pending_coin<T0, T1>(arg0: &Launch<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.pending_coin)
    }

    fun preflight<T0, T1>(arg0: &mut Launchpad, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: bool, arg3: &0x2::coin::Coin<T0>, arg4: &0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u32, arg7: u32, arg8: u64, arg9: &0x1::option::Option<0x1::string::String>, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::Opening {
        assert!(arg0.version == 1, 1);
        assert!(!arg0.paused, 2);
        assert!(0x2::vec_set::contains<u32>(&arg0.tick_spacings, &arg6), 4);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.quotes, v0) && *0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg0.quotes, v0), 3);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.by_coin, 0x1::type_name::with_defining_ids<T0>()), 8);
        assert!(0x2::coin::value<T0>(arg3) == 1000000000000000000, 7);
        assert!(arg0.protocol_bps <= 1500, 6);
        assert!(arg10 + arg11 + arg12 + arg0.protocol_bps == 10000, 5);
        if (0x1::option::is_some<0x1::string::String>(arg9)) {
            assert!(0x1::string::length(0x1::option::borrow<0x1::string::String>(arg9)) > 0, 17);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= arg0.launch_fee, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, arg0.launch_fee, arg13), arg0.treasury);
        let v1 = 0x2::tx_context::sender(arg13);
        pay<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(arg5), v1, arg13);
        0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve::plan(arg2, 0x2::coin::value<T0>(arg3), 0x2::coin::value<T1>(arg4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::get_fee_rate(arg6, arg1), arg0.protocol_bps, arg8, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg7), arg6)
    }

    public fun remove_tick_spacing(arg0: &mut Launchpad, arg1: &AdminCap, arg2: u32) {
        if (0x2::vec_set::contains<u32>(&arg0.tick_spacings, &arg2)) {
            0x2::vec_set::remove<u32>(&mut arg0.tick_spacings, &arg2);
        };
    }

    public fun set_launch_fee(arg0: &mut Launchpad, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 <= 100000000000, 18);
        arg0.launch_fee = arg2;
        emit_settings(arg0);
    }

    public fun set_ops(arg0: &mut Launchpad, arg1: &AdminCap, arg2: address) {
        arg0.ops = arg2;
        emit_settings(arg0);
    }

    public fun set_partner(arg0: &mut Launchpad, arg1: &AdminCap, arg2: 0x1::option::Option<0x2::object::ID>) {
        arg0.partner_id = arg2;
    }

    public fun set_paused(arg0: &mut Launchpad, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
        emit_settings(arg0);
    }

    public fun set_protocol_bps(arg0: &mut Launchpad, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 <= 1500, 6);
        arg0.protocol_bps = arg2;
        emit_settings(arg0);
    }

    public fun set_quote<T0>(arg0: &mut Launchpad, arg1: &AdminCap, arg2: bool) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.quotes, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, bool>(&mut arg0.quotes, v0) = arg2;
        } else {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.quotes, v0, arg2);
        };
    }

    public fun set_treasury(arg0: &mut Launchpad, arg1: &AdminCap, arg2: address) {
        arg0.treasury = arg2;
        emit_settings(arg0);
    }

    fun settle<T0, T1>(arg0: &Launchpad, arg1: &mut Launch<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::balance::value<T1>(&arg3);
        arg1.earned_coin = arg1.earned_coin + (v0 as u128);
        arg1.earned_quote = arg1.earned_quote + (v1 as u128);
        0x2::balance::join<T0>(&mut arg1.pending_coin, arg2);
        let v2 = 0x2::object::id<Launch<T0, T1>>(arg1);
        let v3 = x_active<T0, T1>(arg1);
        let (v4, v5, v6, v7) = distribute<T0, T1>(arg1, arg0.treasury, arg3, arg4);
        let v8 = FeesCollected{
            launch_id    : v2,
            coin_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            earned_coin  : v0,
            earned_quote : v1,
            to_x         : v4,
            to_holders   : v5,
            to_creator   : v6,
            to_protocol  : v7,
            x_active     : v3,
        };
        0x2::event::emit<FeesCollected>(v8);
    }

    fun split_preload<T0, T1>(arg0: &Launch<T0, T1>, arg1: u64) : (u64, u64) {
        let v0 = arg0.x_bps + arg0.holders_bps;
        let v1 = if (arg1 == 0) {
            true
        } else if (v0 == 0) {
            true
        } else {
            !x_active<T0, T1>(arg0)
        };
        if (v1) {
            return (0, arg1)
        };
        let v2 = (((arg1 as u128) * (arg0.x_bps as u128) / (v0 as u128)) as u64);
        (v2, arg1 - v2)
    }

    fun split_quote<T0, T1>(arg0: &Launch<T0, T1>, arg1: u64) : (u64, u64, u64, u64) {
        0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::fees::split(arg1, arg0.x_bps, arg0.holders_bps, arg0.creator_bps, arg0.protocol_bps, x_active<T0, T1>(arg0))
    }

    public fun treasury(arg0: &Launchpad) : address {
        arg0.treasury
    }

    public fun version(arg0: &Launchpad) : u64 {
        arg0.version
    }

    public fun x_active<T0, T1>(arg0: &Launch<T0, T1>) : bool {
        0x1::option::is_some<0x1::string::String>(&arg0.x_handle) && arg0.x_status != 2
    }

    public fun x_claimed<T0, T1>(arg0: &Launch<T0, T1>) : u64 {
        arg0.x_claimed
    }

    public fun x_escrow<T0, T1>(arg0: &Launch<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.x_escrow)
    }

    public fun x_handle<T0, T1>(arg0: &Launch<T0, T1>) : 0x1::option::Option<0x1::string::String> {
        arg0.x_handle
    }

    public fun x_status<T0, T1>(arg0: &Launch<T0, T1>) : u8 {
        arg0.x_status
    }

    // decompiled from Move bytecode v7
}

