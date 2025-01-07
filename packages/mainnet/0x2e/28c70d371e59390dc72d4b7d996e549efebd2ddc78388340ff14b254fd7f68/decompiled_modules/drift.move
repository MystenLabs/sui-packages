module 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::drift {
    struct RebalanceAdapterReceipt<phantom T0, phantom T1> {
        asset_a: 0x2::balance::Balance<T0>,
        asset_b: 0x2::balance::Balance<T1>,
        vault_id: 0x2::object::ID,
        current_sqrt_price: u128,
        oracle_price_a: u64,
        oracle_price_b: u64,
        lower_tick_index: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32,
        upper_tick_index: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32,
        target_handler: u8,
    }

    struct DriftData has copy, drop, store {
        oracle_price_a: u64,
        oracle_price_b: u64,
        price_diff: u128,
        oracle_sqrt_price: u128,
    }

    public fun asset_ratio_receipt_consumer<T0, T1, T2, T3: copy + drop + store>(arg0: RebalanceAdapterReceipt<T0, T1>, arg1: &mut 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::Vault<T0, T1, T2, T3>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::RebalanceCap, arg4: &0x2::clock::Clock, arg5: &0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::version::Version, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = receipt_position_tick_index<T0, T1>(&arg0);
        let (v2, v3) = burn_receipt<T0, T1>(arg0);
        let v4 = v3;
        let v5 = v2;
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::utils::add_liquidity<T0, T1, T2, T3>(arg1, arg2, &mut v5, &mut v4, arg4, arg6, arg7);
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::update_ticks_info<T0, T1, T2, T3>(arg1, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v1));
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::add_free_balance_a<T0, T1, T2, T3>(arg1, v5);
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::add_free_balance_b<T0, T1, T2, T3>(arg1, v4);
        let (v6, _) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::common::lp_residual_amount<T0, T1, T2, T3>(arg1, arg2, arg4, true, 0, arg3, arg5, arg6, arg7);
        let (_, v9) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::common::lp_residual_amount<T0, T1, T2, T3>(arg1, arg2, arg4, false, 0, arg3, arg5, arg6, arg7);
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::set_rebalance_time<T0, T1, T2, T3>(arg1, 0x2::clock::timestamp_ms(arg4));
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::common::emit_rebalance_event(0x2::object::id<0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::Vault<T0, T1, T2, T3>>(arg1), 0x2::object::id<0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::RebalanceCap>(arg3), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg2), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v1), 0, 0, 0x2::clock::timestamp_ms(arg4), 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::last_rebalance_time<T0, T1, T2, T3>(arg1), v6, v9, 0x1::ascii::string(b"drift_vault"));
    }

    fun burn_receipt<T0, T1>(arg0: RebalanceAdapterReceipt<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let RebalanceAdapterReceipt {
            asset_a            : v0,
            asset_b            : v1,
            vault_id           : _,
            current_sqrt_price : _,
            oracle_price_a     : _,
            oracle_price_b     : _,
            lower_tick_index   : _,
            upper_tick_index   : _,
            target_handler     : _,
        } = arg0;
        (v0, v1)
    }

    public(friend) fun extract_assets<T0, T1>(arg0: &mut RebalanceAdapterReceipt<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::balance::split<T0>(&mut arg0.asset_a, 0x2::balance::value<T0>(&arg0.asset_a)), 0x2::balance::split<T1>(&mut arg0.asset_b, 0x2::balance::value<T1>(&arg0.asset_b)))
    }

    public(friend) fun fill_assets<T0, T1>(arg0: &mut RebalanceAdapterReceipt<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.asset_a, arg1);
        0x2::balance::join<T1>(&mut arg0.asset_b, arg2);
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::Vault<T0, T1, T2, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::Drift>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::RebalanceCap, arg3: &0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::KriyaOracle, arg4: &0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::version::Version, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : RebalanceAdapterReceipt<T0, T1> {
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::assert_rebalance_cap<T0, T1, T2, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::Drift>(arg0, arg2, arg8);
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::check_pool_compatibility<T0, T1, T2, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::Drift>(arg0, arg1);
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1);
        let v1 = 0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::get_price(arg6, arg3, 0x1::type_name::get<T0>(), arg7);
        let v2 = 0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::get_price(arg6, arg3, 0x1::type_name::get<T1>(), arg7);
        let (v3, v4) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::decimals<T0, T1, T2, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::Drift>(arg0);
        let v5 = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::utils::oracle_price_to_sqrt_price(0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::utils::get_a_to_b_price(v1, v2), v3, v4);
        let v6 = if (v5 >= v0) {
            v5 - v0
        } else {
            v0 - v5
        };
        let (v7, v8) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::utils::close_position<T0, T1, T2, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::Drift>(arg0, arg1, arg7, arg4, arg5, arg8);
        let v9 = v8;
        let v10 = v7;
        let (v11, v12) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::get_price_scalling<T0, T1, T2, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::Drift>(arg0);
        let (v13, v14) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::utils::get_scalled_position_bounds(v0, v11, v12, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_spacing<T0, T1>(arg1));
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::utils::create_position<T0, T1, T2, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::Drift>(arg0, arg1, v14, v13, arg5, arg8);
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::utils::add_liquidity<T0, T1, T2, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::Drift>(arg0, arg1, &mut v10, &mut v9, arg7, arg5, arg8);
        let v15 = DriftData{
            oracle_price_a    : v1,
            oracle_price_b    : v2,
            price_diff        : v6,
            oracle_sqrt_price : v5,
        };
        0x2::event::emit<DriftData>(v15);
        RebalanceAdapterReceipt<T0, T1>{
            asset_a            : v10,
            asset_b            : v9,
            vault_id           : 0x2::object::id<0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::Vault<T0, T1, T2, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::config::Drift>>(arg0),
            current_sqrt_price : v0,
            oracle_price_a     : v1,
            oracle_price_b     : v2,
            lower_tick_index   : v13,
            upper_tick_index   : v14,
            target_handler     : 1,
        }
    }

    public fun receipt_position_tick_index<T0, T1>(arg0: &RebalanceAdapterReceipt<T0, T1>) : (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32) {
        (arg0.lower_tick_index, arg0.upper_tick_index)
    }

    public fun receipt_prices<T0, T1>(arg0: &RebalanceAdapterReceipt<T0, T1>) : (u128, u64, u64) {
        (arg0.current_sqrt_price, arg0.oracle_price_a, arg0.oracle_price_b)
    }

    public fun receipt_target_handler<T0, T1>(arg0: &RebalanceAdapterReceipt<T0, T1>) : u8 {
        arg0.target_handler
    }

    public fun receipt_vault_id<T0, T1>(arg0: &RebalanceAdapterReceipt<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

