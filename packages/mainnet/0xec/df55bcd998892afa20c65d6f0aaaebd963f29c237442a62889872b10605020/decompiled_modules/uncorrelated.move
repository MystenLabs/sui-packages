module 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::uncorrelated {
    struct RebalanceAdapterReceipt {
        vault_id: 0x2::object::ID,
        kriya_current_sqrt_price: u128,
        lower_tick_index: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32,
        upper_tick_index: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32,
        slippage_up: u128,
        slippage_down: u128,
        pool_liquidity: u128,
        target_handler: 0x1::ascii::String,
        is_target_reverse: bool,
        processed: bool,
        assets_bag: 0x2::bag::Bag,
    }

    fun burn_receipt<T0, T1>(arg0: RebalanceAdapterReceipt) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg0;
        let (v1, v2) = remove_assets<T0, T1>(v0);
        assert!(is_processed(&arg0), 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::error::unprocessed_receipt());
        let RebalanceAdapterReceipt {
            vault_id                 : _,
            kriya_current_sqrt_price : _,
            lower_tick_index         : _,
            upper_tick_index         : _,
            slippage_up              : _,
            slippage_down            : _,
            pool_liquidity           : _,
            target_handler           : _,
            is_target_reverse        : _,
            processed                : _,
            assets_bag               : v13,
        } = arg0;
        0x2::bag::destroy_empty(v13);
        (v1, v2)
    }

    public fun consume_receipt<T0, T1, T2>(arg0: RebalanceAdapterReceipt, arg1: &mut 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::Vault<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::RebalanceCap, arg4: &0x2::clock::Clock, arg5: &0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::version::Version, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = receipt_position_tick_index(&arg0);
        let v2 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg2);
        let (v3, v4) = burn_receipt<T0, T1>(arg0);
        let v5 = v4;
        let v6 = v3;
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::utils::add_liquidity<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg1, arg2, &mut v6, &mut v5, arg4, arg6, arg7);
        let (v7, v8) = 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::get_trigger_price_scalling(0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::borrow_config<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg1));
        let v9 = 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::utils::scale(v2, v7);
        let v10 = 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::utils::scale(v2, v8);
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::update_ticks_info<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg1, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v1));
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::set_trigger_price(0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::borrow_mut_config<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg1), v9, v10);
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::add_free_balance_a<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg1, v6);
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::add_free_balance_b<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg1, v5);
        let (v11, _) = 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::utils::lp_residual_amount<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg1, arg2, arg4, true, 0, arg5, arg6, arg7);
        let (_, v14) = 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::utils::lp_residual_amount<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg1, arg2, arg4, false, 0, arg5, arg6, arg7);
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::set_rebalance_time<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg1, 0x2::clock::timestamp_ms(arg4));
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::common::emit_rebalance_event(0x2::object::id<0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::Vault<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>>(arg1), 0x2::object::id<0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::RebalanceCap>(arg3), v2, v2, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v1), v9, v10, 0x2::clock::timestamp_ms(arg4), 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::last_rebalance_time<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg1), v11, v14, 0x1::ascii::string(b"uncorrelated"));
    }

    public(friend) fun fill_assets<T0, T1>(arg0: &mut RebalanceAdapterReceipt, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.assets_bag, get_receipt_key<T0>()), arg1);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.assets_bag, get_receipt_key<T1>()), arg2);
    }

    fun get_receipt_key<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    fun insert_assets<T0, T1>(arg0: &mut RebalanceAdapterReceipt, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.assets_bag, get_receipt_key<T0>(), arg1);
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.assets_bag, get_receipt_key<T1>(), arg2);
    }

    public(friend) fun is_processed(arg0: &RebalanceAdapterReceipt) : bool {
        arg0.processed
    }

    public(friend) fun mark_processed<T0>(arg0: &mut RebalanceAdapterReceipt, arg1: &T0) {
        assert!(receipt_target_handler(arg0) == 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::utils::generate_auth_token<T0>(arg1), 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::error::adapter_not_authorised());
        arg0.processed = true;
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::Vault<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::RebalanceCap, arg3: &0x2::clock::Clock, arg4: &0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::version::Version, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) : RebalanceAdapterReceipt {
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::assert_rebalance_cap<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg0, arg2, arg6);
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::check_pool_compatibility<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg0, arg1);
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1);
        let (v1, v2) = 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::get_trigger_price(0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::borrow_config<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg0));
        let v3 = if (v0 <= v1) {
            true
        } else if (v0 >= v2) {
            true
        } else if (v1 == 0 && v2 == 0) {
            true
        } else {
            0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::pop_force_rebalance_df_if_exists<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg0)
        };
        assert!(v3, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::error::uncorrelated_rebalance_failed());
        let (v4, v5) = 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::utils::close_position<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg0, arg1, arg3, arg4, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9) = 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::get_price_scalling<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg0);
        let (v10, v11) = 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::utils::get_scalled_position_bounds(v0, v8, v9, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_spacing<T0, T1>(arg1));
        let (v12, v13) = 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::get_slippage<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg0);
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::utils::create_position<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg0, arg1, v11, v10, arg5, arg6);
        0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::utils::add_liquidity<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg0, arg1, &mut v7, &mut v6, arg3, arg5, arg6);
        let v14 = RebalanceAdapterReceipt{
            vault_id                 : 0x2::object::id<0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::Vault<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>>(arg0),
            kriya_current_sqrt_price : v0,
            lower_tick_index         : v10,
            upper_tick_index         : v11,
            slippage_up              : v12,
            slippage_down            : v13,
            pool_liquidity           : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::liquidity<T0, T1>(arg1),
            target_handler           : 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::get_uc_target_adapter(0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::borrow_config<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg0)),
            is_target_reverse        : 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::get_uc_is_target_reverse(0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::vault::borrow_config<T0, T1, T2, 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::config::Uncorrelated>(arg0)),
            processed                : false,
            assets_bag               : 0x2::bag::new(arg6),
        };
        let v15 = &mut v14;
        insert_assets<T0, T1>(v15, v7, v6);
        v14
    }

    public(friend) fun receipt_is_target_reverse(arg0: &RebalanceAdapterReceipt) : bool {
        arg0.is_target_reverse
    }

    public(friend) fun receipt_pool_liquidity(arg0: &RebalanceAdapterReceipt) : u128 {
        arg0.pool_liquidity
    }

    public(friend) fun receipt_position_tick_index(arg0: &RebalanceAdapterReceipt) : (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32) {
        (arg0.lower_tick_index, arg0.upper_tick_index)
    }

    public(friend) fun receipt_slippage(arg0: &RebalanceAdapterReceipt) : (u128, u128) {
        (arg0.slippage_up, arg0.slippage_down)
    }

    public(friend) fun receipt_sqrt_price(arg0: &RebalanceAdapterReceipt) : u128 {
        arg0.kriya_current_sqrt_price
    }

    public(friend) fun receipt_target_handler(arg0: &RebalanceAdapterReceipt) : 0x1::ascii::String {
        arg0.target_handler
    }

    public(friend) fun receipt_vault_id(arg0: &RebalanceAdapterReceipt) : 0x2::object::ID {
        arg0.vault_id
    }

    fun remove_assets<T0, T1>(arg0: &mut RebalanceAdapterReceipt) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.assets_bag, get_receipt_key<T0>()), 0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.assets_bag, get_receipt_key<T1>()))
    }

    public(friend) fun take_assets<T0, T1, T2>(arg0: &mut RebalanceAdapterReceipt, arg1: &T2) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(receipt_target_handler(arg0) == 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::utils::generate_auth_token<T2>(arg1), 0xecdf55bcd998892afa20c65d6f0aaaebd963f29c237442a62889872b10605020::error::adapter_not_authorised());
        let v0 = get_receipt_key<T0>();
        let v1 = get_receipt_key<T1>();
        (0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.assets_bag, v0), 0x2::balance::value<T0>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.assets_bag, v0))), 0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.assets_bag, v1), 0x2::balance::value<T1>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T1>>(&arg0.assets_bag, v1))))
    }

    // decompiled from Move bytecode v6
}

