module 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::uncorrelated {
    struct RebalanceAdapterReceipt {
        vault_id: 0x2::object::ID,
        mmt_current_sqrt_price: u128,
        lower_tick_index: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
        upper_tick_index: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
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
        assert!(is_processed(&arg0), 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::error::unprocessed_receipt());
        let RebalanceAdapterReceipt {
            vault_id               : _,
            mmt_current_sqrt_price : _,
            lower_tick_index       : _,
            upper_tick_index       : _,
            slippage_up            : _,
            slippage_down          : _,
            pool_liquidity         : _,
            target_handler         : _,
            is_target_reverse      : _,
            processed              : _,
            assets_bag             : v13,
        } = arg0;
        0x2::bag::destroy_empty(v13);
        (v1, v2)
    }

    public fun consume_rebalance_oracle_receipt<T0, T1, T2>(arg0: RebalanceAdapterReceipt, arg1: &mut 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::Vault<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::RebalanceCap, arg4: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::MmtOracle, arg5: &0x2::clock::Clock, arg6: &0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::version::Version, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::get_rebalance_price_source<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1) == 1, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::error::uncorrelated_rebalance_failed());
        let (v0, v1) = receipt_position_tick_index(&arg0);
        let (v2, v3) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::decimals<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1);
        let v4 = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::get_oracle_sqrt_price<T0, T1>(arg4, v2, v3, arg5);
        let (v5, v6) = burn_receipt<T0, T1>(arg0);
        let v7 = v6;
        let v8 = v5;
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::add_liquidity<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, arg2, &mut v8, &mut v7, arg5, arg7, arg8);
        let (v9, v10) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::get_trigger_price_scalling(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::borrow_config<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1));
        let v11 = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::scale(v4, v9);
        let v12 = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::scale(v4, v10);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::update_ticks_info<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v1));
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::set_trigger_price(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::borrow_mut_config<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1), v11, v12);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::add_free_balance_a<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, v8);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::add_free_balance_b<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, v7);
        let (v13, _) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::lp_residual_amount<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, arg2, arg5, true, 0, arg6, arg7, arg8);
        let (_, v16) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::lp_residual_amount<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, arg2, arg5, false, 0, arg6, arg7, arg8);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::set_rebalance_time<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, 0x2::clock::timestamp_ms(arg5));
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::common::emit_rebalance_event(0x2::object::id<0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::Vault<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>>(arg1), 0x2::object::id<0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::RebalanceCap>(arg3), v4, v4, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v1), v11, v12, 0x2::clock::timestamp_ms(arg5), 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::last_rebalance_time<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1), v13, v16, 0x1::ascii::string(b"uncorrelated"));
    }

    public fun consume_receipt<T0, T1, T2>(arg0: RebalanceAdapterReceipt, arg1: &mut 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::Vault<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::RebalanceCap, arg4: &0x2::clock::Clock, arg5: &0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::version::Version, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::get_rebalance_price_source<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1) == 0, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::error::uncorrelated_rebalance_failed());
        let (v0, v1) = receipt_position_tick_index(&arg0);
        let v2 = arg0.mmt_current_sqrt_price;
        let (v3, v4) = burn_receipt<T0, T1>(arg0);
        let v5 = v4;
        let v6 = v3;
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::add_liquidity<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, arg2, &mut v6, &mut v5, arg4, arg6, arg7);
        let (v7, v8) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::get_trigger_price_scalling(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::borrow_config<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1));
        let v9 = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::scale(v2, v7);
        let v10 = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::scale(v2, v8);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::update_ticks_info<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v1));
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::set_trigger_price(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::borrow_mut_config<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1), v9, v10);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::add_free_balance_a<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, v6);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::add_free_balance_b<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, v5);
        let (v11, _) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::lp_residual_amount<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, arg2, arg4, true, 0, arg5, arg6, arg7);
        let (_, v14) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::lp_residual_amount<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, arg2, arg4, false, 0, arg5, arg6, arg7);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::set_rebalance_time<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1, 0x2::clock::timestamp_ms(arg4));
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::common::emit_rebalance_event(0x2::object::id<0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::Vault<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>>(arg1), 0x2::object::id<0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::RebalanceCap>(arg3), v2, v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(v1), v9, v10, 0x2::clock::timestamp_ms(arg4), 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::last_rebalance_time<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg1), v11, v14, 0x1::ascii::string(b"uncorrelated"));
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
        assert!(receipt_target_handler(arg0) == 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::generate_auth_token<T0>(arg1), 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::error::adapter_not_authorised());
        arg0.processed = true;
    }

    public fun migrate<T0, T1, T2>(arg0: &mut 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::Vault<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::AdminCap, arg4: &0x2::clock::Clock, arg5: &0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::version::Version, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x2::tx_context::TxContext) : RebalanceAdapterReceipt {
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::check_pool_compatibility<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg1);
        assert!(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::get_rebalance_price_source<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0) == 0, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::error::uncorrelated_rebalance_failed());
        let (v0, v1) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::close_position<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg1, arg4, arg5, arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::set_clmm_pool_id<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2));
        let (v4, v5) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::get_price_scalling<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0);
        let v6 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg2);
        let (v7, v8) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::get_scalled_position_bounds(v6, v4, v5, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg2));
        let (v9, v10) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::get_slippage<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::create_position<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg2, v8, v7, arg6, arg7);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::add_liquidity<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg2, &mut v3, &mut v2, arg4, arg6, arg7);
        let v11 = RebalanceAdapterReceipt{
            vault_id               : 0x2::object::id<0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::Vault<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>>(arg0),
            mmt_current_sqrt_price : v6,
            lower_tick_index       : v7,
            upper_tick_index       : v8,
            slippage_up            : v9,
            slippage_down          : v10,
            pool_liquidity         : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg2),
            target_handler         : 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::get_uc_target_adapter(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::borrow_config<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0)),
            is_target_reverse      : 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::get_uc_is_target_reverse(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::borrow_config<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0)),
            processed              : false,
            assets_bag             : 0x2::bag::new(arg7),
        };
        let v12 = &mut v11;
        insert_assets<T0, T1>(v12, v3, v2);
        v11
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::Vault<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::RebalanceCap, arg3: &0x2::clock::Clock, arg4: &0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::version::Version, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2::tx_context::TxContext) : RebalanceAdapterReceipt {
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::assert_rebalance_cap<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg2, arg6);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::check_pool_compatibility<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg1);
        assert!(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::get_rebalance_price_source<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0) == 0, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::error::uncorrelated_rebalance_failed());
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1);
        let (v1, v2) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::get_trigger_price(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::borrow_config<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0));
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg1);
        let v4 = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::position_borrow<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0);
        let v5 = if (v0 <= v1) {
            true
        } else if (v0 >= v2) {
            true
        } else if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lte(v3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(v4))) {
            true
        } else if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gte(v3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(v4))) {
            true
        } else if (v1 == 0 && v2 == 0) {
            true
        } else {
            0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::pop_force_rebalance_df_if_exists<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0)
        };
        assert!(v5, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::error::uncorrelated_rebalance_failed());
        let (v6, v7) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::close_position<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg1, arg3, arg4, arg5, arg6);
        let v8 = v7;
        let v9 = v6;
        let (v10, v11) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::get_price_scalling<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0);
        let v12 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1);
        let (v13, v14) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::get_scalled_position_bounds(v12, v10, v11, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg1));
        let (v15, v16) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::get_slippage<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::create_position<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg1, v14, v13, arg5, arg6);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::add_liquidity<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg1, &mut v9, &mut v8, arg3, arg5, arg6);
        let v17 = RebalanceAdapterReceipt{
            vault_id               : 0x2::object::id<0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::Vault<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>>(arg0),
            mmt_current_sqrt_price : v12,
            lower_tick_index       : v13,
            upper_tick_index       : v14,
            slippage_up            : v15,
            slippage_down          : v16,
            pool_liquidity         : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg1),
            target_handler         : 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::get_uc_target_adapter(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::borrow_config<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0)),
            is_target_reverse      : 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::get_uc_is_target_reverse(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::borrow_config<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0)),
            processed              : false,
            assets_bag             : 0x2::bag::new(arg6),
        };
        let v18 = &mut v17;
        insert_assets<T0, T1>(v18, v9, v8);
        v17
    }

    public fun rebalance_around_oracle<T0, T1, T2>(arg0: &mut 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::Vault<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::RebalanceCap, arg3: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::MmtOracle, arg4: &0x2::clock::Clock, arg5: &0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::version::Version, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x2::tx_context::TxContext) : RebalanceAdapterReceipt {
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::assert_rebalance_cap<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg2, arg7);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::check_pool_compatibility<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg1);
        assert!(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::get_rebalance_price_source<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0) == 1, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::error::uncorrelated_rebalance_failed());
        let (v0, v1) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::decimals<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0);
        let v2 = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::get_oracle_sqrt_price<T0, T1>(arg3, v0, v1, arg4);
        let (v3, v4) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::get_trigger_price(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::borrow_config<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0));
        let v5 = if (v2 <= v3) {
            true
        } else if (v2 >= v4) {
            true
        } else if (v3 == 0 && v4 == 0) {
            true
        } else {
            0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::pop_force_rebalance_df_if_exists<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0)
        };
        assert!(v5, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::error::uncorrelated_rebalance_failed());
        let (v6, v7) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::close_position<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg1, arg4, arg5, arg6, arg7);
        let v8 = v7;
        let v9 = v6;
        let (v10, v11) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::get_price_scalling<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0);
        let (v12, v13) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::get_scalled_position_bounds(v2, v10, v11, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg1));
        let (v14, v15) = 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::get_slippage<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::create_position<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg1, v13, v12, arg6, arg7);
        0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::add_liquidity<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0, arg1, &mut v9, &mut v8, arg4, arg6, arg7);
        let v16 = RebalanceAdapterReceipt{
            vault_id               : 0x2::object::id<0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::Vault<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>>(arg0),
            mmt_current_sqrt_price : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1),
            lower_tick_index       : v12,
            upper_tick_index       : v13,
            slippage_up            : v14,
            slippage_down          : v15,
            pool_liquidity         : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg1),
            target_handler         : 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::get_uc_target_adapter(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::borrow_config<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0)),
            is_target_reverse      : 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::get_uc_is_target_reverse(0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::vault::borrow_config<T0, T1, T2, 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::config::Uncorrelated>(arg0)),
            processed              : false,
            assets_bag             : 0x2::bag::new(arg7),
        };
        let v17 = &mut v16;
        insert_assets<T0, T1>(v17, v9, v8);
        v16
    }

    public(friend) fun receipt_is_target_reverse(arg0: &RebalanceAdapterReceipt) : bool {
        arg0.is_target_reverse
    }

    public(friend) fun receipt_pool_liquidity(arg0: &RebalanceAdapterReceipt) : u128 {
        arg0.pool_liquidity
    }

    public(friend) fun receipt_position_tick_index(arg0: &RebalanceAdapterReceipt) : (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32) {
        (arg0.lower_tick_index, arg0.upper_tick_index)
    }

    public(friend) fun receipt_slippage(arg0: &RebalanceAdapterReceipt) : (u128, u128) {
        (arg0.slippage_up, arg0.slippage_down)
    }

    public(friend) fun receipt_sqrt_price(arg0: &RebalanceAdapterReceipt) : u128 {
        arg0.mmt_current_sqrt_price
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
        assert!(receipt_target_handler(arg0) == 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::utils::generate_auth_token<T2>(arg1), 0x33ace92cabb91c49d7ce075d4465b48e95733a685701cef357e2c0288792f87c::error::adapter_not_authorised());
        let v0 = get_receipt_key<T0>();
        let v1 = get_receipt_key<T1>();
        (0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.assets_bag, v0), 0x2::balance::value<T0>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.assets_bag, v0))), 0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.assets_bag, v1), 0x2::balance::value<T1>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T1>>(&arg0.assets_bag, v1))))
    }

    // decompiled from Move bytecode v6
}

