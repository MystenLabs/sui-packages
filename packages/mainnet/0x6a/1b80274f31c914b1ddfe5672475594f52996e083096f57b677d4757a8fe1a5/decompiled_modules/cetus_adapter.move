module 0x6a1b80274f31c914b1ddfe5672475594f52996e083096f57b677d4757a8fe1a5::cetus_adapter {
    struct GraduatedPool<phantom T0> has key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        creator: address,
        pool_id: 0x2::object::ID,
        proof: 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof,
        sui_collected: u64,
        token_collected: u64,
    }

    struct MigratedToCetus has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        graduated_pool_id: 0x2::object::ID,
        sui_amount: u64,
        token_amount: u64,
        burn_proof: 0x2::object::ID,
    }

    public fun creator<T0>(arg0: &GraduatedPool<T0>) : address {
        arg0.creator
    }

    public fun curve_id<T0>(arg0: &GraduatedPool<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun collect_fees<T0>(arg0: &mut GraduatedPool<T0>, arg1: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg2: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4) == arg0.pool_id, 1);
        let (v0, v1) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, 0x2::sui::SUI>(arg2, arg3, arg4, &mut arg0.proof, arg6);
        let v2 = v1;
        let v3 = v0;
        arg0.sui_collected = arg0.sui_collected + 0x2::coin::value<0x2::sui::SUI>(&v2);
        arg0.token_collected = arg0.token_collected + 0x2::coin::value<T0>(&v3);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::router::deposit_pool_fees<T0>(arg1, arg0.curve_id, arg0.coin_type, arg0.creator, 0x2::coin::into_balance<0x2::sui::SUI>(v2), v3, arg5);
    }

    public fun collected<T0>(arg0: &GraduatedPool<T0>) : (u64, u64) {
        (arg0.sui_collected, arg0.token_collected)
    }

    public fun migrate<T0>(arg0: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::MigrationVault<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::MigrationCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::curve_id<T0>(arg0);
        let (v1, v2) = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::redeem<T0>(arg0, arg1);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        let v6 = 0x2::balance::value<T0>(&v3);
        assert!(v5 > 0 && v6 > 0, 0);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(200);
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, 0x2::sui::SUI>(arg2, arg3, 200, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::sqrt_price_x64(v6, v5), 0x1::string::utf8(b""), v7, v8, 0x2::coin::from_balance<T0>(v3, arg8), 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg8), arg6, arg5, false, arg7, arg8);
        let v12 = v9;
        let v13 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v12);
        let v14 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg4, v12, arg8);
        let v15 = 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&v14);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::return_dust<T0>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v11), 0x2::coin::into_balance<T0>(v10));
        let v16 = GraduatedPool<T0>{
            id              : 0x2::object::new(arg8),
            curve_id        : v0,
            coin_type       : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::coin_type<T0>(arg0),
            creator         : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::creator<T0>(arg0),
            pool_id         : v13,
            proof           : v14,
            sui_collected   : 0,
            token_collected : 0,
        };
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::confirm<T0>(arg0, arg1, v13, 0x1::option::some<0x2::object::ID>(v15), arg7);
        let v17 = MigratedToCetus{
            curve_id          : v0,
            pool_id           : v13,
            graduated_pool_id : 0x2::object::uid_to_inner(&v16.id),
            sui_amount        : v5,
            token_amount      : v6,
            burn_proof        : v15,
        };
        0x2::event::emit<MigratedToCetus>(v17);
        0x2::transfer::share_object<GraduatedPool<T0>>(v16);
    }

    public fun migrate_burn_position<T0>(arg0: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::MigrationVault<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::MigrationCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::redeem<T0>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v5 = 0x2::balance::value<T0>(&v2);
        assert!(v4 > 0 && v5 > 0, 0);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(200);
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, 0x2::sui::SUI>(arg2, arg3, 200, 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::sqrt_price_x64(v5, v4), 0x1::string::utf8(b""), v6, v7, 0x2::coin::from_balance<T0>(v2, arg7), 0x2::coin::from_balance<0x2::sui::SUI>(v3, arg7), arg5, arg4, false, arg6, arg7);
        let v11 = v8;
        let v12 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v11);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::return_dust<T0>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v10), 0x2::coin::into_balance<T0>(v9));
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::confirm<T0>(arg0, arg1, v12, 0x1::option::none<0x2::object::ID>(), arg6);
        let v13 = MigratedToCetus{
            curve_id          : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::curve_id<T0>(arg0),
            pool_id           : v12,
            graduated_pool_id : v12,
            sui_amount        : v4,
            token_amount      : v5,
            burn_proof        : v12,
        };
        0x2::event::emit<MigratedToCetus>(v13);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v11, @0x0);
    }

    public fun pool_id<T0>(arg0: &GraduatedPool<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    // decompiled from Move bytecode v7
}

