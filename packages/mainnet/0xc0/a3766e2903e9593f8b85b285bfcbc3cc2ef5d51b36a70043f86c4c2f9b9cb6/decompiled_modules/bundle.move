module 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::bundle {
    struct Share<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct Bundle<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        icon_url: 0x1::string::String,
        start_tick_bits: u32,
        start_fdv: u64,
        target: u64,
        deadline_ms: u64,
        committed: 0x2::balance::Balance<T1>,
        share_cap: 0x1::option::Option<0x2::coin::TreasuryCap<Share<T0>>>,
        token_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        token_metadata_cap: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>,
        state: u8,
        filled_ms: u64,
        vault_id: 0x1::option::Option<0x2::object::ID>,
        venue: u8,
        cetus_cap: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>,
        launch_fee_bps: u64,
        platform_bps: u64,
        buy_bps: u64,
        sunset_bps: u64,
        limits: 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::Limits,
    }

    struct BundleCreated has copy, drop {
        bundle_id: 0x2::object::ID,
        creator: address,
        token: 0x1::ascii::String,
        quote: 0x1::ascii::String,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        start_tick_bits: u32,
        start_fdv: u64,
        target: u64,
        deadline_ms: u64,
        venue: u8,
    }

    struct Committed has copy, drop {
        bundle_id: 0x2::object::ID,
        backer: address,
        amount: u64,
        committed: u64,
        full: bool,
    }

    struct RefundStarted has copy, drop {
        bundle_id: 0x2::object::ID,
        committed: u64,
        timestamp_ms: u64,
    }

    struct Refunded has copy, drop {
        bundle_id: 0x2::object::ID,
        backer: address,
        amount: u64,
    }

    struct PoolTaken has copy, drop {
        bundle_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct Launched has copy, drop {
        bundle_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        launch_position_id: 0x2::object::ID,
        token: 0x1::ascii::String,
        share: 0x1::ascii::String,
        quote: 0x1::ascii::String,
        start_tick_bits: u32,
        upper_tick_bits: u32,
        start_sqrt_price: u128,
        liquidity_tokens: u64,
        launch_fee: u64,
        bought_tokens: u64,
        spent_quote: u64,
        vault_quote: u64,
        venue: u8,
        quote_first: bool,
    }

    public fun total_supply() : u64 {
        1000000000000000
    }

    fun assert_can_cancel<T0, T1>(arg0: &Bundle<T0, T1>) {
        assert!(arg0.venue == 1, 225);
        assert!(arg0.state == 0, 209);
    }

    fun cancel_taken<T0, T1>(arg0: &mut Bundle<T0, T1>, arg1: 0x2::object::ID, arg2: u64) {
        arg0.state = 2;
        let v0 = PoolTaken{
            bundle_id    : 0x2::object::id<Bundle<T0, T1>>(arg0),
            pool_id      : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<PoolTaken>(v0);
        let v1 = RefundStarted{
            bundle_id    : 0x2::object::id<Bundle<T0, T1>>(arg0),
            committed    : 0x2::balance::value<T1>(&arg0.committed),
            timestamp_ms : arg2,
        };
        0x2::event::emit<RefundStarted>(v1);
    }

    public fun cancel_taken_cetus<T0, T1>(arg0: &mut Bundle<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &0x2::clock::Clock) {
        assert_can_cancel<T0, T1>(arg0);
        cancel_taken<T0, T1>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_id(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_simple_info(arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::new_pool_key<T0, T1>(200))), 0x2::clock::timestamp_ms(arg2));
    }

    public fun cancel_taken_cetus_qf<T0, T1>(arg0: &mut Bundle<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &0x2::clock::Clock) {
        assert_can_cancel<T0, T1>(arg0);
        cancel_taken<T0, T1>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_id(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_simple_info(arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::new_pool_key<T1, T0>(200))), 0x2::clock::timestamp_ms(arg2));
    }

    fun cetus_prices<T0, T1>(arg0: &Bundle<T0, T1>, arg1: &0x2::balance::Balance<T1>) : (u128, u128, u128, u64) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.start_tick_bits));
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(cetus_upper_tick_bits()));
        let v2 = mul_div(0x2::balance::value<T1>(arg1), arg0.buy_bps, 10000);
        (v0, v1, synthetic_buy(1000000000000000, v0, v1, v2), v2)
    }

    public fun cetus_upper_tick_bits() : u32 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_tick());
        v0 - v0 % 200
    }

    fun check_start(arg0: u32) : u64 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::is_valid_index(v0, 200), 204);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(200)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero()), 204);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(upper_tick_bits())), 204);
        start_fdv(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(v0))
    }

    fun check_start_cetus(arg0: u32) : u64 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(v0, 200), 204);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(200)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero()), 204);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(cetus_upper_tick_bits())), 204);
        start_fdv(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v0))
    }

    public fun commit<T0, T1>(arg0: &mut Bundle<T0, T1>, arg1: &0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<Share<T0>>, 0x2::coin::Coin<T1>) {
        0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::assert_open<T1>(arg1);
        commit_internal<T0, T1>(arg0, arg2, 0x2::clock::timestamp_ms(arg3), arg4)
    }

    fun commit_internal<T0, T1>(arg0: &mut Bundle<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<Share<T0>>, 0x2::coin::Coin<T1>) {
        assert!(arg0.state == 0, 209);
        assert!(arg2 < arg0.deadline_ms, 210);
        let v0 = arg0.target - 0x2::balance::value<T1>(&arg0.committed);
        assert!(v0 > 0, 210);
        let v1 = 0x1::u64::min(0x2::coin::value<T1>(&arg1), v0);
        assert!(v1 > 0, 218);
        0x2::balance::join<T1>(&mut arg0.committed, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v1, arg3)));
        let v2 = 0x2::balance::value<T1>(&arg0.committed) == arg0.target;
        if (v2) {
            arg0.filled_ms = arg2;
        };
        let v3 = Committed{
            bundle_id : 0x2::object::id<Bundle<T0, T1>>(arg0),
            backer    : 0x2::tx_context::sender(arg3),
            amount    : v1,
            committed : 0x2::balance::value<T1>(&arg0.committed),
            full      : v2,
        };
        0x2::event::emit<Committed>(v3);
        (0x2::coin::mint<Share<T0>>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<Share<T0>>>(&mut arg0.share_cap), v1, arg3), arg1)
    }

    public fun committed<T0, T1>(arg0: &Bundle<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.committed)
    }

    public fun create<T0, T1>(arg0: &0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::Config, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin_registry::MetadataCap<T0>, arg4: &0x2::coin_registry::Currency<T0>, arg5: &0x2::coin_registry::Currency<T1>, arg6: u32, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<Share<T0>> {
        create_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, check_start(arg6), arg7, arg8, arg9, 0, 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(), arg10, arg11)
    }

    public fun create_cetus<T0, T1>(arg0: &0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::Config, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin_registry::MetadataCap<T0>, arg4: &0x2::coin_registry::Currency<T0>, arg5: &0x2::coin_registry::Currency<T1>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg8: u32, arg9: u64, arg10: u64, arg11: 0x2::coin::Coin<T1>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<Share<T0>> {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg6, arg7, &mut arg2, arg13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, T1>(arg6, arg7, 200, &v0, arg13);
        create_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg8, check_start_cetus(arg8), arg9, arg10, arg11, 1, 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(v0), arg12, arg13)
    }

    fun create_internal<T0, T1>(arg0: &0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::Config, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin_registry::MetadataCap<T0>, arg4: &0x2::coin_registry::Currency<T0>, arg5: &0x2::coin_registry::Currency<T1>, arg6: u32, arg7: u64, arg8: u64, arg9: u64, arg10: 0x2::coin::Coin<T1>, arg11: u8, arg12: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<Share<T0>> {
        let v0 = 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::assert_open<T1>(arg0);
        assert!(arg8 >= 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::min_target(&v0) && arg8 <= 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::max_target(&v0), 206);
        assert!(arg9 >= 300000 && arg9 <= 604800000, 207);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg4) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg2)), 200);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg4), 201);
        assert!(0x2::coin_registry::decimals<T0>(arg4) == 6, 202);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 203);
        let v1 = 0x2::coin_registry::name<T0>(arg4);
        let v2 = 0x2::coin_registry::symbol<T0>(arg4);
        let v3 = 0x2::coin_registry::icon_url<T0>(arg4);
        let v4 = b"b";
        0x1::vector::append<u8>(&mut v4, *0x1::string::as_bytes(&v2));
        let v5 = b"b";
        0x1::vector::append<u8>(&mut v5, *0x1::string::as_bytes(&v1));
        let (v6, v7) = 0x2::coin_registry::new_currency<Share<T0>>(arg1, 0x2::coin_registry::decimals<T1>(arg5), 0x1::string::utf8(v4), 0x1::string::utf8(v5), 0x1::string::utf8(b"POPULAR bundle share"), v3, arg14);
        0x2::coin_registry::finalize_and_delete_metadata_cap<Share<T0>>(v6, arg14);
        assert!(arg7 >= 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::min_start_fdv(&v0) && arg7 <= 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::max_start_fdv(&v0), 205);
        assert!(0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::target_fits(arg0, arg8, arg7), 222);
        let v8 = 0x2::tx_context::sender(arg14);
        let v9 = new_bundle<T0, T1>(v8, v1, v2, v3, arg6, arg7, arg8, 0x2::clock::timestamp_ms(arg13) + arg9, v7, arg0, 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::limits(&v0), arg14);
        v9.venue = arg11;
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg12)) {
            0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&mut v9.cetus_cap, 0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(arg12));
        } else {
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(arg12);
        };
        0x1::option::fill<0x2::coin::TreasuryCap<T0>>(&mut v9.token_cap, arg2);
        0x1::option::fill<0x2::coin_registry::MetadataCap<T0>>(&mut v9.token_metadata_cap, arg3);
        assert!(0x2::coin::value<T1>(&arg10) >= mul_div(arg8, 100, 10000), 208);
        let v10 = BundleCreated{
            bundle_id       : 0x2::object::id<Bundle<T0, T1>>(&v9),
            creator         : v9.creator,
            token           : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            quote           : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            name            : v9.name,
            symbol          : v9.symbol,
            start_tick_bits : arg6,
            start_fdv       : arg7,
            target          : arg8,
            deadline_ms     : v9.deadline_ms,
            venue           : arg11,
        };
        0x2::event::emit<BundleCreated>(v10);
        let v11 = &mut v9;
        let (v12, v13) = commit_internal<T0, T1>(v11, arg10, 0x2::clock::timestamp_ms(arg13), arg14);
        return_or_destroy<T1>(v13, arg14);
        0x2::transfer::share_object<Bundle<T0, T1>>(v9);
        v12
    }

    public fun creator<T0, T1>(arg0: &Bundle<T0, T1>) : address {
        arg0.creator
    }

    public fun creator_head_start_ms() : u64 {
        120000
    }

    public fun deadline_ms<T0, T1>(arg0: &Bundle<T0, T1>) : u64 {
        arg0.deadline_ms
    }

    public fun duration_bounds() : (u64, u64) {
        (300000, 604800000)
    }

    public fun fees<T0, T1>(arg0: &Bundle<T0, T1>) : (u64, u64, u64, u64) {
        (arg0.launch_fee_bps, arg0.platform_bps, arg0.buy_bps, arg0.sunset_bps)
    }

    public fun filled_ms<T0, T1>(arg0: &Bundle<T0, T1>) : u64 {
        arg0.filled_ms
    }

    fun finish_cetus<T0, T1>(arg0: &mut Bundle<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u32, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg1);
        let v1 = 0x2::balance::value<T0>(&arg2);
        let v2 = 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::book::new_on<T0, T1>(1, arg4, v0, arg0.limits, 200, arg2, arg3);
        0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::book::seed<T0, T1>(&mut v2, arg12, arg7);
        let v3 = 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::vault::new_on<T0, Share<T0>, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v2, 0x2::object::id<Bundle<T0, T1>>(arg0), arg1, arg0.platform_bps, arg0.sunset_bps, arg0.target, arg10, true, arg7, arg12, arg13);
        let v4 = 0x2::object::id<0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::vault::Vault<T0, Share<T0>, T1>>(&v3);
        arg0.state = 1;
        arg0.vault_id = 0x1::option::some<0x2::object::ID>(v4);
        let v5 = Launched{
            bundle_id          : 0x2::object::id<Bundle<T0, T1>>(arg0),
            vault_id           : v4,
            pool_id            : v0,
            launch_position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1),
            token              : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            share              : 0x1::type_name::into_string(0x1::type_name::with_original_ids<Share<T0>>()),
            quote              : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            start_tick_bits    : arg0.start_tick_bits,
            upper_tick_bits    : arg11,
            start_sqrt_price   : arg5,
            liquidity_tokens   : 1000000000000000 - v1,
            launch_fee         : arg9,
            bought_tokens      : v1,
            spent_quote        : arg8,
            vault_quote        : 0x2::balance::value<T1>(&arg3),
            venue              : 1,
            quote_first        : arg4,
        };
        0x2::event::emit<Launched>(v5);
        0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::vault::share<T0, Share<T0>, T1>(v3);
    }

    public fun is_filling<T0, T1>(arg0: &Bundle<T0, T1>) : bool {
        arg0.state == 0
    }

    public fun is_launched<T0, T1>(arg0: &Bundle<T0, T1>) : bool {
        arg0.state == 1
    }

    public fun is_refunding<T0, T1>(arg0: &Bundle<T0, T1>) : bool {
        arg0.state == 2
    }

    public fun launch<T0, T1>(arg0: &mut Bundle<T0, T1>, arg1: &0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::Config, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x2::coin_registry::Currency<T1>, arg5: &mut 0x2::coin_registry::Currency<Share<T0>>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.venue == 0, 223);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let (v1, v2, v3, v4) = prepare_launch<T0, T1>(arg0, arg1, arg3, arg5, v0, arg8);
        let v5 = v2;
        let (v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::get_pool_creation_fee_amount<0x2::sui::SUI>(arg2);
        assert!(v6 || v7 == 0, 216);
        return_or_destroy<0x2::sui::SUI>(arg6, arg8);
        let v8 = upper_tick_bits();
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.start_tick_bits));
        let v10 = 0x1::string::into_bytes(0x2::coin_registry::symbol<T0>(arg3));
        let v11 = 0x1::string::into_bytes(0x2::coin_registry::symbol<T1>(arg4));
        0x1::vector::append<u8>(&mut v10, b"-");
        0x1::vector::append<u8>(&mut v10, v11);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_and_get_object<T0, T1, 0x2::sui::SUI>(arg7, arg2, v10, 0x1::string::into_bytes(0x2::coin_registry::icon_url<T0>(arg3)), v10, 6, b"", v11, 0x2::coin_registry::decimals<T1>(arg4), b"", 200, 10000, v9, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, v7, arg8)), arg8);
        let v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, &mut v12, arg0.start_tick_bits, v8, arg8);
        let (v14, _, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg7, arg2, &mut v12, &mut v13, v1, 0x2::balance::zero<T1>(), 1000000000000000, true);
        let v18 = v17;
        let v19 = v16;
        assert!(0x2::balance::value<T1>(&v18) == 0, 217);
        0x2::balance::destroy_zero<T1>(v18);
        let (v20, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg7, arg2, &mut v12, false, true, mul_div(0x2::balance::value<T1>(&v5), arg0.buy_bps, 10000), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_sqrt_price() - 1);
        let v23 = v22;
        let v24 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v23);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg2, &mut v12, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, v24), v23);
        0x2::balance::destroy_zero<T1>(v21);
        let v25 = v20;
        let (_, _, v28, v29) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg7, arg2, &mut v12, &mut v13);
        0x2::balance::join<T0>(&mut v25, v28);
        0x2::balance::join<T1>(&mut v5, v29);
        if (0x2::balance::value<T0>(&v19) > 0) {
            0x2::coin_registry::burn_balance<T0>(arg3, v19);
        } else {
            0x2::balance::destroy_zero<T0>(v19);
        };
        let v30 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(&v12);
        let v31 = 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::vault::new<T0, Share<T0>, T1>(0x2::object::id<Bundle<T0, T1>>(arg0), v30, v13, arg0.limits, arg0.platform_bps, arg0.sunset_bps, arg0.target, v4, v25, v5, v0, arg8);
        0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::vault::place_launch_ladder<T0, Share<T0>, T1>(&mut v31, arg2, &mut v12, arg7, arg8);
        0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::vault::set_volume_baseline<T0, Share<T0>, T1>(&mut v31, &v12);
        let v32 = 0x2::object::id<0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::vault::Vault<T0, Share<T0>, T1>>(&v31);
        arg0.state = 1;
        arg0.vault_id = 0x1::option::some<0x2::object::ID>(v32);
        let v33 = Launched{
            bundle_id          : 0x2::object::id<Bundle<T0, T1>>(arg0),
            vault_id           : v32,
            pool_id            : v30,
            launch_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v13),
            token              : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            share              : 0x1::type_name::into_string(0x1::type_name::with_original_ids<Share<T0>>()),
            quote              : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            start_tick_bits    : arg0.start_tick_bits,
            upper_tick_bits    : v8,
            start_sqrt_price   : v9,
            liquidity_tokens   : v14,
            launch_fee         : v3,
            bought_tokens      : 0x2::balance::value<T0>(&v25),
            spent_quote        : v24,
            vault_quote        : 0x2::balance::value<T1>(&v5),
            venue              : 0,
            quote_first        : false,
        };
        0x2::event::emit<Launched>(v33);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::share_pool_object<T0, T1>(v12);
        0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::vault::share<T0, Share<T0>, T1>(v31);
    }

    public fun launch_cetus<T0, T1>(arg0: &mut Bundle<T0, T1>, arg1: &0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: &mut 0x2::coin_registry::Currency<Share<T0>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.venue == 1, 223);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let (v1, v2, v3, v4) = prepare_launch<T0, T1>(arg0, arg1, arg4, arg5, v0, arg7);
        let v5 = v2;
        let (v6, v7, v8, v9) = cetus_prices<T0, T1>(arg0, &v5);
        let v10 = cetus_upper_tick_bits();
        let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T0, T1>(arg2, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg0.cetus_cap), 200, v8, 0x1::string::utf8(b""), arg0.start_tick_bits, v10, 0x2::coin::from_balance<T0>(v1, arg7), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, v9), arg7), false, arg6, arg7);
        0x2::balance::join<T1>(&mut v5, 0x2::coin::into_balance<T1>(v13));
        finish_cetus<T0, T1>(arg0, v11, 0x2::coin::into_balance<T0>(v12), v5, false, v6, v7, v8, v9, v3, v4, v10, v0, arg7);
    }

    public fun launch_cetus_qf<T0, T1>(arg0: &mut Bundle<T0, T1>, arg1: &0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: &mut 0x2::coin_registry::Currency<Share<T0>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.venue == 1, 223);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let (v1, v2, v3, v4) = prepare_launch<T0, T1>(arg0, arg1, arg4, arg5, v0, arg7);
        let v5 = v2;
        let (v6, v7, v8, v9) = cetus_prices<T0, T1>(arg0, &v5);
        let v10 = cetus_upper_tick_bits();
        let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T1, T0>(arg2, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg0.cetus_cap), 200, 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::book_cetus::flip_sqrt(v8), 0x1::string::utf8(b""), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::book_cetus::neg(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v10))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::book_cetus::neg(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.start_tick_bits))), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, v9), arg7), 0x2::coin::from_balance<T0>(v1, arg7), true, arg6, arg7);
        0x2::balance::join<T1>(&mut v5, 0x2::coin::into_balance<T1>(v12));
        finish_cetus<T0, T1>(arg0, v11, 0x2::coin::into_balance<T0>(v13), v5, true, v6, v7, v8, v9, v3, v4, v10, v0, arg7);
    }

    public fun launch_window_ms() : u64 {
        1200000
    }

    public fun min_first_bps() : u64 {
        100
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun new_bundle<T0, T1>(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u32, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::coin::TreasuryCap<Share<T0>>, arg9: &0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::Config, arg10: 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::Limits, arg11: &mut 0x2::tx_context::TxContext) : Bundle<T0, T1> {
        Bundle<T0, T1>{
            id                 : 0x2::object::new(arg11),
            creator            : arg0,
            name               : arg1,
            symbol             : arg2,
            icon_url           : arg3,
            start_tick_bits    : arg4,
            start_fdv          : arg5,
            target             : arg6,
            deadline_ms        : arg7,
            committed          : 0x2::balance::zero<T1>(),
            share_cap          : 0x1::option::some<0x2::coin::TreasuryCap<Share<T0>>>(arg8),
            token_cap          : 0x1::option::none<0x2::coin::TreasuryCap<T0>>(),
            token_metadata_cap : 0x1::option::none<0x2::coin_registry::MetadataCap<T0>>(),
            state              : 0,
            filled_ms          : 0,
            vault_id           : 0x1::option::none<0x2::object::ID>(),
            venue              : 0,
            cetus_cap          : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(),
            launch_fee_bps     : 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::launch_fee_bps(arg9),
            platform_bps       : 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::platform_bps(arg9),
            buy_bps            : 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::buy_bps(arg9),
            sunset_bps         : 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::sunset_bps(arg9),
            limits             : arg10,
        }
    }

    fun prepare_launch<T0, T1>(arg0: &mut Bundle<T0, T1>, arg1: &0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::Config, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: &mut 0x2::coin_registry::Currency<Share<T0>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, u64, u64) {
        0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::assert_open<T1>(arg1);
        assert!(arg0.state == 0, 209);
        assert!(0x2::balance::value<T1>(&arg0.committed) == arg0.target, 211);
        assert!(0x2::tx_context::sender(arg5) == arg0.creator || arg4 >= arg0.filled_ms + 120000, 212);
        assert!(arg4 < arg0.filled_ms + 1200000, 220);
        let v0 = 0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg0.token_cap);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg2) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&v0)), 200);
        let v1 = 0x1::option::extract<0x2::coin::TreasuryCap<Share<T0>>>(&mut arg0.share_cap);
        assert!(0x2::coin_registry::treasury_cap_id<Share<T0>>(arg3) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<Share<T0>>>(&v1)), 215);
        0x2::coin_registry::make_supply_burn_only<Share<T0>>(arg3, v1);
        0x2::coin_registry::make_supply_burn_only<T0>(arg2, v0);
        0x2::coin_registry::delete_metadata_cap<T0>(arg2, 0x1::option::extract<0x2::coin_registry::MetadataCap<T0>>(&mut arg0.token_metadata_cap));
        let v2 = 0x2::balance::withdraw_all<T1>(&mut arg0.committed);
        let v3 = mul_div(arg0.target, arg0.launch_fee_bps, 10000);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, v3), arg5), 0xc0a3766e2903e9593f8b85b285bfcbc3cc2ef5d51b36a70043f86c4c2f9b9cb6::config::fee_recipient(arg1));
        };
        (0x2::coin::mint_balance<T0>(&mut v0, 1000000000000000), v2, v3, 0x2::coin::total_supply<Share<T0>>(&v1))
    }

    public fun reclaim_token<T0, T1>(arg0: &mut Bundle<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::coin_registry::MetadataCap<T0>) {
        start_refund_if_due<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg1));
        assert!(arg0.state == 2, 213);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 212);
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg0.cetus_cap)) {
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&mut arg0.cetus_cap), arg0.creator);
        };
        (0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg0.token_cap), 0x1::option::extract<0x2::coin_registry::MetadataCap<T0>>(&mut arg0.token_metadata_cap))
    }

    public fun refund<T0, T1>(arg0: &mut Bundle<T0, T1>, arg1: 0x2::coin::Coin<Share<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        start_refund_if_due<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg2));
        assert!(arg0.state == 2, 213);
        let v0 = 0x2::coin::value<Share<T0>>(&arg1);
        assert!(v0 > 0, 218);
        0x2::coin::burn<Share<T0>>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<Share<T0>>>(&mut arg0.share_cap), arg1);
        let v1 = Refunded{
            bundle_id : 0x2::object::id<Bundle<T0, T1>>(arg0),
            backer    : 0x2::tx_context::sender(arg3),
            amount    : v0,
        };
        0x2::event::emit<Refunded>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.committed, v0), arg3)
    }

    fun return_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun start_fdv(arg0: u128) : u64 {
        let v0 = (arg0 as u256);
        let v1 = (v0 * v0 >> 64) * (1000000000000000 as u256) >> 64;
        if (v1 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v1 as u64)
        }
    }

    fun start_refund_if_due<T0, T1>(arg0: &mut Bundle<T0, T1>, arg1: u64) {
        if (arg0.state != 0) {
            return
        };
        let v0 = 0x2::balance::value<T1>(&arg0.committed) == arg0.target && arg1 >= arg0.filled_ms + 1200000 || arg1 >= arg0.deadline_ms;
        if (!v0) {
            return
        };
        arg0.state = 2;
        let v1 = RefundStarted{
            bundle_id    : 0x2::object::id<Bundle<T0, T1>>(arg0),
            committed    : 0x2::balance::value<T1>(&arg0.committed),
            timestamp_ms : arg1,
        };
        0x2::event::emit<RefundStarted>(v1);
    }

    public fun synthetic_buy(arg0: u64, arg1: u128, arg2: u128, arg3: u64) : u128 {
        let v0 = if (arg1 > 0) {
            if (arg1 < arg2) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 224);
        let v1 = (arg0 as u256) * (arg1 as u256) * (arg2 as u256) / (((arg2 - arg1) as u256) << 64);
        assert!(v1 > 0, 224);
        let v2 = (arg1 as u256) + ((arg3 as u256) << 64) / v1;
        assert!(v2 < (arg2 as u256), 224);
        (v2 as u128)
    }

    public fun target<T0, T1>(arg0: &Bundle<T0, T1>) : u64 {
        arg0.target
    }

    public fun upper_tick_bits() : u32 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_tick());
        v0 - v0 % 200
    }

    public fun vault_id<T0, T1>(arg0: &Bundle<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.vault_id
    }

    public fun venue<T0, T1>(arg0: &Bundle<T0, T1>) : u8 {
        arg0.venue
    }

    // decompiled from Move bytecode v7
}

