module 0xaf6f272b04784ade9c4ff623724a7b2fa0fae2c51b02b5be82c6b5b3761cabdb::router {
    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        referal_address: address,
    }

    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    struct PauseConfig has key {
        id: 0x2::object::UID,
        paused: bool,
        admin: address,
    }

    public fun bluefin_spot_swap_a2b_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u64, arg10: u8, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::balance::zero<T1>(), true, arg5, arg6, arg7, arg8);
        let v2 = 0x2::coin::from_balance<T1>(v1, arg11);
        destroy_or_transfer<T0>(0x2::coin::from_balance<T0>(v0, arg11), arg11);
        let v3 = 0x2::coin::value<T1>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    public fun bluefin_spot_swap_b2a_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u64, arg10: u8, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg4), false, arg5, arg6, arg7, arg8);
        let v2 = 0x2::coin::from_balance<T0>(v0, arg11);
        destroy_or_transfer<T1>(0x2::coin::from_balance<T1>(v1, arg11), arg11);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    public entry fun change_admin(arg0: &mut PauseConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 8);
        arg0.admin = arg1;
    }

    fun check_pause(arg0: &PauseConfig) {
        assert!(!arg0.paused, 9);
    }

    public fun deepbook_swap_base_to_quote_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0x9caccba6a5e9570a7cd712fc849daff8a0290874d4e4bcc046391b9620a253c9::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let (v0, v1, v2) = 0x9caccba6a5e9570a7cd712fc849daff8a0290874d4e4bcc046391b9620a253c9::deepbook_v3::swap_a2b_<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
        let v3 = v1;
        let v4 = 0x2::coin::value<T1>(&v3);
        destroy_or_transfer<T0>(v0, arg6);
        destroy_or_transfer<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg6);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    public fun deepbook_swap_quote_to_base_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0x9caccba6a5e9570a7cd712fc849daff8a0290874d4e4bcc046391b9620a253c9::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let (v0, v1, v2) = 0x9caccba6a5e9570a7cd712fc849daff8a0290874d4e4bcc046391b9620a253c9::deepbook_v3::swap_b2a_<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
        let v3 = v0;
        let v4 = 0x2::coin::value<T0>(&v3);
        destroy_or_transfer<T1>(v1, arg6);
        destroy_or_transfer<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg6);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun finalize<T0>(arg0: &PauseConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        check_pause(arg0);
        assert!(arg3 == 0 || arg3 > 0 && arg4 != @0x0, 5);
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 < arg2) {
            abort 1
        };
        let v1 = OrderRecord{
            order_id   : arg5,
            decimal    : arg6,
            out_amount : v0,
        };
        0x2::event::emit<OrderRecord>(v1);
        if (arg3 > 0) {
            let v2 = &mut arg1;
            let (v3, _) = split_with_percentage_for_commission<T0>(arg0, v2, arg3, arg4, arg7);
            destroy_or_transfer<T0>(v3, arg7);
            destroy_or_transfer<T0>(arg1, arg7);
        } else {
            destroy_or_transfer<T0>(arg1, arg7);
        };
    }

    public fun flowx_swap_exact_input_direct_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, arg2, arg3);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun flowxv3_swap_a2b_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0x2::clock::Clock, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: u128, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg3, arg4);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, true, arg6, 0x2::coin::value<T0>(&arg5), arg7, arg2, arg1, arg10);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v6, _) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v4, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut arg5), v6), 0x2::balance::zero<T1>(), arg2, arg10);
        let v8 = 0x2::balance::value<T1>(&v5);
        destroy_or_transfer<T0>(arg5, arg10);
        let v9 = HopRecord{out_amount: v8};
        0x2::event::emit<HopRecord>(v9);
        (0x2::coin::from_balance<T1>(v5, arg10), v8)
    }

    public fun flowxv3_swap_b2a_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0x2::clock::Clock, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: u128, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg3, arg4);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, false, arg6, 0x2::coin::value<T1>(&arg5), arg7, arg2, arg1, arg10);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        let (_, v7) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut arg5), v7), arg2, arg10);
        let v8 = 0x2::balance::value<T0>(&v5);
        destroy_or_transfer<T1>(arg5, arg10);
        let v9 = HopRecord{out_amount: v8};
        0x2::event::emit<HopRecord>(v9);
        (0x2::coin::from_balance<T0>(v5, arg10), v8)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PauseConfig{
            id     : 0x2::object::new(arg0),
            paused : false,
            admin  : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<PauseConfig>(v0);
    }

    public fun kriya_amm_swap_token_x_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, arg2, arg3, arg4, arg7);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun kriya_amm_swap_token_y_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let v0 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, arg2, arg3, arg4, arg7);
        let v1 = 0x2::coin::value<T0>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun kriya_clmm_swap_token_x_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: u64, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, true, true, arg3, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::min_sqrt_price(), arg5, arg6, arg9);
        let v3 = v1;
        let v4 = 0x2::balance::value<T1>(&v3);
        assert!(v4 >= arg4, 7);
        0x2::balance::destroy_zero<T0>(v0);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v2, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), arg6, arg9);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (0x2::coin::from_balance<T1>(v3, arg9), v4)
    }

    public fun kriya_clmm_swap_token_y_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: u64, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, false, true, arg3, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::max_sqrt_price(), arg5, arg6, arg9);
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&v3);
        assert!(v4 >= arg4, 7);
        0x2::balance::destroy_zero<T1>(v1);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), arg6, arg9);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (0x2::coin::from_balance<T0>(v3, arg9), v4)
    }

    public fun scallop_swap_exact_swap_a2b_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T1, T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::mint_s_coin<T1, T0>(arg3, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, arg4, arg5, arg6), arg6);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun scallop_swap_exact_swap_b2a_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg1, arg2, 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::burn_s_coin<T0, T1>(arg3, arg4, arg6), arg5, arg6);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun split_with_percentage<T0>(arg0: &PauseConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, 0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        assert!(arg2 <= 10000, 2);
        let v0 = 0x2::coin::value<T0>(arg1);
        let v1 = (((v0 as u128) * (arg2 as u128) / (10000 as u128)) as u64);
        (0x2::coin::split<T0>(arg1, v1, arg3), v1, 0x2::coin::split<T0>(arg1, v0 - v1, arg3), v0 - v1)
    }

    public fun split_with_percentage_for_commission<T0>(arg0: &PauseConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        assert!(arg2 <= 300, 3);
        assert!(arg2 == 0 || arg2 > 0 && arg3 != @0x0, 5);
        let (v0, v1, v2, v3) = split_with_percentage<T0>(arg0, arg1, arg2, arg4);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
            let v4 = CommissionRecord{
                commission_amount : v1,
                referal_address   : arg3,
            };
            0x2::event::emit<CommissionRecord>(v4);
        };
        (v2, v3)
    }

    public entry fun toggle_pause(arg0: &mut PauseConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 8);
        arg0.paused = arg1;
    }

    public fun turbos_swap_a_b_with_return<T0, T1, T2>(arg0: &PauseConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: bool, arg7: address, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: u64, arg12: u8, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg10);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13);
        let v2 = v0;
        destroy_or_transfer<T0>(v1, arg13);
        let v3 = 0x2::coin::value<T1>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    public fun turbos_swap_b_a_with_return<T0, T1, T2>(arg0: &PauseConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u128, arg6: bool, arg7: address, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: u64, arg12: u8, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg10);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13);
        let v2 = v0;
        destroy_or_transfer<T1>(v1, arg13);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

