module 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::dex {
    struct PoolCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BurnProofKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Graduated has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        quote_type: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        token_is_a: bool,
        sqrt_price: u128,
        quote_in_pool: u64,
        tokens_in_pool: u64,
    }

    fun assert_own_pool<T0, T1>(arg0: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Curve<T0, T1>, arg1: 0x2::object::ID) {
        assert!(0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::pool_id<T0, T1>(arg0) == 0x1::option::some<0x2::object::ID>(arg1), 103);
    }

    fun burn_proof<T0, T1>(arg0: &mut 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Curve<T0, T1>) : &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof {
        let v0 = BurnProofKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<BurnProofKey>(0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::uid<T0, T1>(arg0), v0), 100);
        let v1 = BurnProofKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<BurnProofKey, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::uid_mut<T0, T1>(arg0), v1)
    }

    public fun collect_pool_fees<T0, T1>(arg0: &mut 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Curve<T0, T1>, arg1: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Config, arg2: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) {
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::assert_version(arg1);
        assert!(token_is_a<T0, T1>(), 101);
        assert_own_pool<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4));
        let v0 = burn_proof<T0, T1>(arg0);
        let (v1, v2) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, T1>(arg2, arg3, arg4, v0, arg5);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::add_pool_fees<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v2), 0x2::coin::into_balance<T0>(v1), 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::fee_recipient(arg1));
    }

    public fun collect_pool_fees_rev<T0, T1>(arg0: &mut 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Curve<T0, T1>, arg1: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Config, arg2: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::assert_version(arg1);
        assert!(!token_is_a<T0, T1>(), 101);
        assert_own_pool<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4));
        let v0 = burn_proof<T0, T1>(arg0);
        let (v1, v2) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T1, T0>(arg2, arg3, arg4, v0, arg5);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::add_pool_fees<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v1), 0x2::coin::into_balance<T0>(v2), 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::fee_recipient(arg1));
    }

    public fun convert_token_fees<T0, T1>(arg0: &mut 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Curve<T0, T1>, arg1: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Config, arg2: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::KeeperCap, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) {
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::assert_version(arg1);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::assert_keeper(arg1, arg2);
        assert!(token_is_a<T0, T1>(), 101);
        assert!(0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::is_migrated<T0, T1>(arg0), 104);
        assert_own_pool<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4));
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::pool_op_convert();
        if (!0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::pool_op_ready<T0, T1>(arg0, v1, v0) || 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T0, T1>(arg4)) {
            return
        };
        let v2 = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::take_pending_token_fees<T0, T1>(arg0);
        if (!swap_outputs<T0, T1>(arg4, true, 0x2::balance::value<T0>(&v2))) {
            0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::return_pending_token_fees<T0, T1>(arg0, v2);
            return
        };
        let v3 = price_down_limit<T0, T1>(arg4, 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::max_impact_bps<T0, T1>(arg0));
        let (v4, v5) = swap_a2b<T0, T1>(arg3, arg4, v2, v3, arg5);
        let v6 = v5;
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::touch_pool_op<T0, T1>(arg0, v1, v0);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::return_pending_token_fees<T0, T1>(arg0, v6);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::add_converted_fees<T0, T1>(arg0, v4, 0x2::balance::value<T0>(&v2) - 0x2::balance::value<T0>(&v6), 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::fee_recipient(arg1));
    }

    public fun convert_token_fees_rev<T0, T1>(arg0: &mut 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Curve<T0, T1>, arg1: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Config, arg2: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::KeeperCap, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock) {
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::assert_version(arg1);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::assert_keeper(arg1, arg2);
        assert!(!token_is_a<T0, T1>(), 101);
        assert!(0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::is_migrated<T0, T1>(arg0), 104);
        assert_own_pool<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4));
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::pool_op_convert();
        if (!0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::pool_op_ready<T0, T1>(arg0, v1, v0) || 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T1, T0>(arg4)) {
            return
        };
        let v2 = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::take_pending_token_fees<T0, T1>(arg0);
        if (!swap_outputs<T1, T0>(arg4, false, 0x2::balance::value<T0>(&v2))) {
            0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::return_pending_token_fees<T0, T1>(arg0, v2);
            return
        };
        let v3 = price_up_limit<T1, T0>(arg4, 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::max_impact_bps<T0, T1>(arg0));
        let (v4, v5) = swap_b2a<T1, T0>(arg3, arg4, v2, v3, arg5);
        let v6 = v5;
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::touch_pool_op<T0, T1>(arg0, v1, v0);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::return_pending_token_fees<T0, T1>(arg0, v6);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::add_converted_fees<T0, T1>(arg0, v4, 0x2::balance::value<T0>(&v2) - 0x2::balance::value<T0>(&v6), 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::fee_recipient(arg1));
    }

    public fun create<T0, T1>(arg0: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: address, arg6: u64, arg7: bool, arg8: vector<address>, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: 0x2::coin::Coin<T1>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::assert_live(arg0);
        let v0 = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::quote_params<T1>(arg0);
        assert!(0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::lock_pool(&v0), 102);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg1, arg2, &mut arg3, arg15);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, T1>(arg1, arg2, 200, &v1, arg15);
        let v2 = 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(v1);
        let (v3, v4) = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::new_curve<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v5 = v3;
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&v2)) {
            let v6 = PoolCapKey{dummy_field: false};
            0x2::dynamic_object_field::add<PoolCapKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::uid_mut<T0, T1>(&mut v5), v6, 0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(v2));
        } else {
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(v2);
        };
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::share<T0, T1>(v5);
        v4
    }

    public fun migrate<T0, T1>(arg0: &mut 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Curve<T0, T1>, arg1: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::assert_version(arg1);
        let (v0, v1) = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::virtual_reserves<T0, T1>(arg0);
        let (v2, v3, v4) = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::take_for_migration<T0, T1>(arg0, arg6);
        let v5 = v3;
        let v6 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::fee_recipient(arg1));
        let v7 = token_is_a<T0, T1>();
        let (v8, v9, v10, v11) = if (v7) {
            let v12 = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::sqrt_price_x64(v0, v1);
            let (v13, v14, v15) = open_pool<T0, T1, T0, T1>(arg0, arg2, arg3, v12, v5, v6, false, arg5, arg6);
            (v13, v14, v15, v12)
        } else {
            let v16 = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::sqrt_price_x64(v1, v0);
            let (v17, v18, v19) = open_pool<T0, T1, T1, T0>(arg0, arg2, arg3, v16, v6, v5, true, arg5, arg6);
            (v17, v19, v18, v16)
        };
        let v20 = v10;
        let v21 = v9;
        let v22 = v8;
        let v23 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v22);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::set_pool_id<T0, T1>(arg0, v23);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::lock_leftover<T0, T1>(arg0, v21);
        if (0x2::coin::value<T1>(&v20) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v20, 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::fee_recipient(arg1));
        } else {
            0x2::coin::destroy_zero<T1>(v20);
        };
        let v24 = BurnProofKey{dummy_field: false};
        0x2::dynamic_object_field::add<BurnProofKey, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::uid_mut<T0, T1>(arg0), v24, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg4, v22, arg6));
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::pay_bounty<T0, T1>(arg0, arg6);
        let v25 = Graduated{
            curve_id       : 0x2::object::id<0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Curve<T0, T1>>(arg0),
            coin_type      : 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::type_key<T0>(),
            quote_type     : 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::type_key<T1>(),
            pool_id        : v23,
            token_is_a     : v7,
            sqrt_price     : v11,
            quote_in_pool  : 0x2::coin::value<T1>(&v6) - 0x2::coin::value<T1>(&v20),
            tokens_in_pool : 0x2::coin::value<T0>(&v5) - 0x2::coin::value<T0>(&v21),
        };
        0x2::event::emit<Graduated>(v25);
    }

    public fun network() : vector<u8> {
        b"mainnet"
    }

    fun open_pool<T0, T1, T2, T3>(arg0: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Curve<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: u128, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(200);
        let v2 = PoolCapKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists<PoolCapKey>(0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::uid<T0, T1>(arg0), v2)) {
            let v6 = PoolCapKey{dummy_field: false};
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T2, T3>(arg1, arg2, 0x2::dynamic_object_field::borrow<PoolCapKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::uid<T0, T1>(arg0), v6), 200, arg3, 0x1::string::utf8(b""), v0, v1, arg4, arg5, arg6, arg7, arg8)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T2, T3>(arg1, arg2, 200, arg3, 0x1::string::utf8(b""), v0, v1, arg4, arg5, arg6, arg7, arg8)
        }
    }

    public fun pool_buyback<T0, T1>(arg0: &mut 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Curve<T0, T1>, arg1: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Config, arg2: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::KeeperCap, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) {
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::assert_version(arg1);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::assert_keeper(arg1, arg2);
        assert!(token_is_a<T0, T1>(), 101);
        assert_own_pool<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4));
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::pool_op_buyback();
        if (!0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::pool_op_ready<T0, T1>(arg0, v1, v0) || 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T0, T1>(arg4)) {
            return
        };
        let v2 = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::take_pool_buyback<T0, T1>(arg0);
        if (!swap_outputs<T0, T1>(arg4, false, 0x2::balance::value<T1>(&v2))) {
            0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::lock_pool_buyback<T0, T1>(arg0, 0x2::balance::zero<T0>(), v2, 0, v0);
            return
        };
        let v3 = price_up_limit<T0, T1>(arg4, 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::max_impact_bps<T0, T1>(arg0));
        let (v4, v5) = swap_b2a<T0, T1>(arg3, arg4, v2, v3, arg5);
        let v6 = v5;
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::touch_pool_op<T0, T1>(arg0, v1, v0);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::lock_pool_buyback<T0, T1>(arg0, v4, v6, 0x2::balance::value<T1>(&v2) - 0x2::balance::value<T1>(&v6), v0);
    }

    public fun pool_buyback_rev<T0, T1>(arg0: &mut 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Curve<T0, T1>, arg1: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Config, arg2: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::KeeperCap, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock) {
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::assert_version(arg1);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::assert_keeper(arg1, arg2);
        assert!(!token_is_a<T0, T1>(), 101);
        assert_own_pool<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4));
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::pool_op_buyback();
        if (!0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::pool_op_ready<T0, T1>(arg0, v1, v0) || 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T1, T0>(arg4)) {
            return
        };
        let v2 = 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::take_pool_buyback<T0, T1>(arg0);
        if (!swap_outputs<T1, T0>(arg4, true, 0x2::balance::value<T1>(&v2))) {
            0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::lock_pool_buyback<T0, T1>(arg0, 0x2::balance::zero<T0>(), v2, 0, v0);
            return
        };
        let v3 = price_down_limit<T1, T0>(arg4, 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::max_impact_bps<T0, T1>(arg0));
        let (v4, v5) = swap_a2b<T1, T0>(arg3, arg4, v2, v3, arg5);
        let v6 = v5;
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::touch_pool_op<T0, T1>(arg0, v1, v0);
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::lock_pool_buyback<T0, T1>(arg0, v4, v6, 0x2::balance::value<T1>(&v2) - 0x2::balance::value<T1>(&v6), v0);
    }

    fun price_down_limit<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : u128 {
        let v0 = (10000 as u128);
        let v1 = (arg1 as u128);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) * (2 * v0 + v1) / 2 * (v0 + v1);
        if (v2 <= 4295048016) {
            4295048016 + 1
        } else {
            v2
        }
    }

    fun price_up_limit<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : u128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = (arg1 as u128);
        let v2 = v0 + v0 * v1 / (2 * (10000 as u128) + v1);
        if (v2 >= 79226673515401279992447579055) {
            79226673515401279992447579055 - 1
        } else {
            v2
        }
    }

    public fun set_refund_delay(arg0: &0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::AdminCap, arg1: &mut 0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::Config, arg2: u64) {
        0x72c59fa3d1e16dbe271786dade4335118ef467124e46e768a51d7710f3934f3::curve::set_refund_delay_internal(arg1, arg2, 604800000);
    }

    fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), arg3, arg4);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        0x2::balance::destroy_zero<T0>(v0);
        (v1, arg2)
    }

    fun swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u128, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), arg3, arg4);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        0x2::balance::destroy_zero<T1>(v1);
        (v0, arg2)
    }

    fun swap_outputs<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : bool {
        if (arg2 == 0) {
            return false
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, true, arg2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0) > 0
    }

    public fun token_is_a<T0, T1>() : bool {
        type_gt(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())))
    }

    public fun type_gt(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = 0x1::vector::length<u8>(&arg1);
        let v2 = 0;
        while (v2 < v1) {
            if (v2 >= v0) {
                return false
            };
            if (*0x1::vector::borrow<u8>(&arg0, v2) > *0x1::vector::borrow<u8>(&arg1, v2)) {
                return true
            };
            if (*0x1::vector::borrow<u8>(&arg0, v2) < *0x1::vector::borrow<u8>(&arg1, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        v0 > v1
    }

    // decompiled from Move bytecode v7
}

