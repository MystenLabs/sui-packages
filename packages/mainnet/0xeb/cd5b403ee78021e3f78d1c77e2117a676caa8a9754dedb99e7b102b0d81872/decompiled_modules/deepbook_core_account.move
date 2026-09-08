module 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::deepbook_core_account {
    public fun cancel_live_order<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::AccountWrapper, arg2: 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Auth, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::load_account_mut(arg1, arg2);
        if (!0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::is_initialized(v0)) {
            return
        };
        let v1 = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::borrow_mut(v0);
        let v2 = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::generate_trader_proof(v1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_live_order<T0, T1>(arg0, 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::balance_manager_mut(v1), &v2, arg3, arg4, arg5);
        let (v3, v4, v5) = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::sweep_all<T0, T1>(v1, arg5);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::deposit_all<T0, T1>(v0, v3, v4, v5);
    }

    public fun cancel_live_orders<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::AccountWrapper, arg2: 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Auth, arg3: vector<u128>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::load_account_mut(arg1, arg2);
        if (!0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::is_initialized(v0)) {
            return
        };
        let v1 = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::borrow_mut(v0);
        let v2 = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::generate_trader_proof(v1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_live_orders<T0, T1>(arg0, 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::balance_manager_mut(v1), &v2, arg3, arg4, arg5);
        let (v3, v4, v5) = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::sweep_all<T0, T1>(v1, arg5);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::deposit_all<T0, T1>(v0, v3, v4, v5);
    }

    public fun locked_balance<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Account) : (u64, u64, u64) {
        if (!0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::is_initialized(arg1)) {
            (0, 0, 0)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<T0, T1>(arg0, 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::balance_manager(0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::borrow(arg1)))
        }
    }

    public fun place_limit_order<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &mut 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::AccountWrapper, arg3: 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Auth, arg4: u64, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: u64, arg12: &0x2::accumulator::AccumulatorRoot, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::settle<T0>(arg2, arg12, arg13);
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::settle<T1>(arg2, arg12, arg13);
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::settle<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg12, arg13);
        let v0 = 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::load_account_mut(arg2, arg3);
        let (v1, v2, v3) = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::withdraw_all<T0, T1>(v0, arg12, arg13, arg14);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::ensure(v0, arg1, arg14);
        let v4 = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::borrow_mut(v0);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::deposit_to_manager_if_nonzero<T0>(v4, v1, arg14);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::deposit_to_manager_if_nonzero<T1>(v4, v2, arg14);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::deposit_to_manager_if_nonzero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4, v3, arg14);
        let v5 = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::generate_trader_proof(v4, arg14);
        let (v6, v7, v8) = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::sweep_all<T0, T1>(v4, arg14);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::deposit_all<T0, T1>(v0, v6, v7, v8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::balance_manager_mut(v4), &v5, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13, arg14)
    }

    public fun place_market_order<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &mut 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::AccountWrapper, arg3: 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Auth, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: &0x2::accumulator::AccumulatorRoot, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::settle<T0>(arg2, arg10, arg11);
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::settle<T1>(arg2, arg10, arg11);
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::settle<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg10, arg11);
        let v0 = 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::load_account_mut(arg2, arg3);
        let (v1, v2, v3) = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::withdraw_all<T0, T1>(v0, arg10, arg11, arg12);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::ensure(v0, arg1, arg12);
        let v4 = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::borrow_mut(v0);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::deposit_to_manager_if_nonzero<T0>(v4, v1, arg12);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::deposit_to_manager_if_nonzero<T1>(v4, v2, arg12);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::deposit_to_manager_if_nonzero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4, v3, arg12);
        let v5 = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::generate_trader_proof(v4, arg12);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::balance_manager_mut(v4), &v5, arg4, arg5, arg6, arg8, arg9, arg11, arg12);
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v6) > 0) {
            assert!(arg8 && (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v6) as u128) * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128() <= (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v6) as u128) * (arg7 as u128) || (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v6) as u128) * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128() >= (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v6) as u128) * (arg7 as u128), 0);
        };
        let (v7, v8, v9) = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::sweep_all<T0, T1>(v4, arg12);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::deposit_all<T0, T1>(v0, v7, v8, v9);
        v6
    }

    public fun withdraw_settled_amounts<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::AccountWrapper, arg2: 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Auth, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::load_account_mut(arg1, arg2);
        if (!0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::is_initialized(v0)) {
            return
        };
        let v1 = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::borrow_mut(v0);
        let v2 = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::generate_trader_proof(v1, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::balance_manager_mut(v1), &v2);
        let (v3, v4, v5) = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::sweep_all<T0, T1>(v1, arg3);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::deposit_all<T0, T1>(v0, v3, v4, v5);
    }

    public fun withdraw_settled_amounts_permissionless<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account_registry::AccountRegistry, arg2: &mut 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::AccountWrapper, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::load_account_mut(arg2, 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::generate_auth_as_app(arg1));
        if (!0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::is_initialized(v0)) {
            return
        };
        let v1 = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::borrow_mut(v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts_permissionless<T0, T1>(arg0, 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::balance_manager_mut(v1));
        let (v2, v3, v4) = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::sweep_all<T0, T1>(v1, arg3);
        0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::deposit_all<T0, T1>(v0, v2, v3, v4);
    }

    public fun get_pool_account_order_details<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Account) : vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order> {
        if (!0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::is_initialized(arg1)) {
            0x1::vector::empty<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>()
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T0, T1>(arg0, 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::balance_manager(0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::borrow(arg1)))
        }
    }

    public fun pool_account<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Account) : 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::Account> {
        if (!0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::is_initialized(arg1)) {
            0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::Account>()
        } else {
            let v1 = 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::balance_manager(0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::borrow(arg1));
            if (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_exists<T0, T1>(arg0, v1)) {
                0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::Account>()
            } else {
                0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::Account>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T0, T1>(arg0, v1))
            }
        }
    }

    public fun pool_account_exists<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Account) : bool {
        !0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::is_initialized(arg1) && false || 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_exists<T0, T1>(arg0, 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::balance_manager(0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::borrow(arg1)))
    }

    public fun pool_account_open_orders<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account::Account) : 0x2::vec_set::VecSet<u128> {
        if (!0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::is_initialized(arg1)) {
            0x2::vec_set::empty<u128>()
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg0, 0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::balance_manager(0xebcd5b403ee78021e3f78d1c77e2117a676caa8a9754dedb99e7b102b0d81872::account_data::borrow(arg1)))
        }
    }

    // decompiled from Move bytecode v7
}

