module 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::drift {
    struct RebalanceAdapterReceipt<phantom T0, phantom T1> {
        asset_a: 0x2::balance::Balance<T0>,
        asset_b: 0x2::balance::Balance<T1>,
        vault_id: 0x2::object::ID,
        target_sqrt_price: u128,
        price_a_to_b: u64,
        price_b_to_a: u64,
        lower_tick_index: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
        upper_tick_index: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
        target_handler: 0x1::ascii::String,
        processed: bool,
    }

    struct DriftData has copy, drop, store {
        price_a_to_b: u64,
        price_b_to_a: u64,
        sqrt_price_a_to_b: u128,
        sqrt_price_b_to_a: u128,
        current_sqrt_price: u128,
    }

    public fun asset_ratio_receipt_consumer<T0, T1, T2>(arg0: RebalanceAdapterReceipt<T0, T1>, arg1: &mut 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::Vault<T0, T1, T2, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::RebalanceCap, arg4: &0x2::clock::Clock, arg5: &0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::version::Version, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = receipt_position_tick_index<T0, T1>(&arg0);
        let (v2, _, _) = receipt_prices<T0, T1>(&arg0);
        let (v5, v6) = burn_receipt<T0, T1>(arg0);
        let v7 = v6;
        let v8 = v5;
        0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::utils::add_liquidity<T0, T1, T2, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg1, arg2, &mut v8, &mut v7, arg4, arg6, arg7);
        0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::update_ticks_info<T0, T1, T2, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v1));
        0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::add_free_balance_a<T0, T1, T2, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg1, v8);
        0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::add_free_balance_b<T0, T1, T2, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg1, v7);
        let (v9, _) = 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::utils::lp_residual_amount<T0, T1, T2, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg1, arg2, arg4, true, 0, arg5, arg6, arg7);
        let (_, v12) = 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::utils::lp_residual_amount<T0, T1, T2, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg1, arg2, arg4, false, 0, arg5, arg6, arg7);
        0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::set_rebalance_time<T0, T1, T2, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg1, 0x2::clock::timestamp_ms(arg4));
        let v13 = 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::utils::scale(v2, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::drift_trigger_price_scalling(0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::borrow_config<T0, T1, T2, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg1)));
        0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::set_drift_trigger_price(0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::borrow_mut_config<T0, T1, T2, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg1), v13);
        0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::common::emit_rebalance_event(0x2::object::id<0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::Vault<T0, T1, T2, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>>(arg1), 0x2::object::id<0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::RebalanceCap>(arg3), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg2), v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v1), 0, v13, 0x2::clock::timestamp_ms(arg4), 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::last_rebalance_time<T0, T1, T2, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg1), v9, v12, 0x1::ascii::string(b"drift_vault"));
    }

    fun burn_receipt<T0, T1>(arg0: RebalanceAdapterReceipt<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(is_processed<T0, T1>(&arg0), 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::error::unprocessed_receipt());
        let RebalanceAdapterReceipt {
            asset_a           : v0,
            asset_b           : v1,
            vault_id          : _,
            target_sqrt_price : _,
            price_a_to_b      : _,
            price_b_to_a      : _,
            lower_tick_index  : _,
            upper_tick_index  : _,
            target_handler    : _,
            processed         : _,
        } = arg0;
        (v0, v1)
    }

    public(friend) fun fill_assets<T0, T1>(arg0: &mut RebalanceAdapterReceipt<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.asset_a, arg1);
        0x2::balance::join<T1>(&mut arg0.asset_b, arg2);
    }

    public fun get_vsui_stake_rate_sqrt_price(arg0: &mut 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64) {
        let v0 = 1000000000;
        let v1 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::get_ratio(arg2, arg4);
        let v2 = 1000000000 * v0 / (v1 as u128) / 1000000000;
        let v3 = (v1 as u128) / v0;
        (0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::utils::oracle_price_to_sqrt_price((v2 as u64), 9, 9), 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::utils::oracle_price_to_sqrt_price((v3 as u64), 9, 9), (v2 as u64), (v3 as u64))
    }

    public(friend) fun is_processed<T0, T1>(arg0: &RebalanceAdapterReceipt<T0, T1>) : bool {
        arg0.processed
    }

    public(friend) fun mark_processed<T0, T1, T2>(arg0: &mut RebalanceAdapterReceipt<T0, T1>, arg1: &T2) {
        assert!(receipt_target_handler<T0, T1>(arg0) == 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::utils::generate_auth_token<T2>(arg1), 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::error::adapter_not_authorised());
        arg0.processed = true;
    }

    public fun rebalance_vsui_sui<T0>(arg0: &mut 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::Vault<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg2: &0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::RebalanceCap, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg6: &0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::version::Version, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : RebalanceAdapterReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI> {
        0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::assert_rebalance_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg0, arg2, arg9);
        0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::check_pool_compatibility<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg0, arg1);
        let (v0, v1) = 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::utils::close_position<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg0, arg1, arg8, arg6, arg7, arg9);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let v5 = &mut v2;
        let (v6, v7, v8, v9) = get_vsui_stake_rate_sqrt_price(v4, v5, arg3, arg4, arg5, arg9);
        assert!(v6 > 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::drift_trigger_price(0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::borrow_config<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg0)) || 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::pop_force_rebalance_df_if_exists<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg0), 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::error::drift_rebalance_failed());
        let (v10, v11) = 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::get_price_scalling<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg0);
        let (v12, v13) = 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::utils::get_scalled_position_bounds(v6, v10, v11, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(arg1));
        0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::utils::create_position<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg0, arg1, v13, v12, arg7, arg9);
        0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::utils::add_liquidity<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg0, arg1, &mut v3, &mut v2, arg8, arg7, arg9);
        let v14 = DriftData{
            price_a_to_b       : v8,
            price_b_to_a       : v9,
            sqrt_price_a_to_b  : v6,
            sqrt_price_b_to_a  : v7,
            current_sqrt_price : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(arg1),
        };
        0x2::event::emit<DriftData>(v14);
        RebalanceAdapterReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>{
            asset_a           : v3,
            asset_b           : v2,
            vault_id          : 0x2::object::id<0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::Vault<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>>(arg0),
            target_sqrt_price : v6,
            price_a_to_b      : v8,
            price_b_to_a      : v9,
            lower_tick_index  : v12,
            upper_tick_index  : v13,
            target_handler    : 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::target_adapter(0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::vault::borrow_config<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::config::Drift>(arg0)),
            processed         : false,
        }
    }

    public(friend) fun receipt_position_tick_index<T0, T1>(arg0: &RebalanceAdapterReceipt<T0, T1>) : (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32) {
        (arg0.lower_tick_index, arg0.upper_tick_index)
    }

    public(friend) fun receipt_prices<T0, T1>(arg0: &RebalanceAdapterReceipt<T0, T1>) : (u128, u64, u64) {
        (arg0.target_sqrt_price, arg0.price_a_to_b, arg0.price_b_to_a)
    }

    public(friend) fun receipt_target_handler<T0, T1>(arg0: &RebalanceAdapterReceipt<T0, T1>) : 0x1::ascii::String {
        arg0.target_handler
    }

    public(friend) fun receipt_vault_id<T0, T1>(arg0: &RebalanceAdapterReceipt<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun take_assets<T0, T1, T2>(arg0: &mut RebalanceAdapterReceipt<T0, T1>, arg1: &T2) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(receipt_target_handler<T0, T1>(arg0) == 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::utils::generate_auth_token<T2>(arg1), 0xb3e8de599fbd7282ca3dd668a630140ca546699c6bfbddfa42f614b3d88f092e::error::adapter_not_authorised());
        (0x2::balance::split<T0>(&mut arg0.asset_a, 0x2::balance::value<T0>(&arg0.asset_a)), 0x2::balance::split<T1>(&mut arg0.asset_b, 0x2::balance::value<T1>(&arg0.asset_b)))
    }

    // decompiled from Move bytecode v6
}

