module 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a1c61f525b4283a20 {
    struct A78ebf2415cd19e52 has drop {
        order_id: u128,
        price: u64,
        aeca93d50e3d2504a: u64,
        filled_quantity: u64,
        expiry_timestamp: u64,
    }

    struct A8eaa8c1bdbc9ed0a has drop {
        a0c4b816b0a50ba9c: vector<0x1::option::Option<A78ebf2415cd19e52>>,
        ab814e822c301efb4: u64,
        a021d28fd92bb1654: u64,
        ad24db9c79e9012ee: u64,
    }

    public(friend) fun a027c74de64f71d0f(arg0: &A8eaa8c1bdbc9ed0a, arg1: &0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::A0ea878587b719a64, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        let v0 = 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::ab78d0325509532d4(arg1, arg2);
        let v1 = v0;
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 1))) {
            let v2 = 0x1::option::borrow<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 1));
            v1 = v0 + v2.aeca93d50e3d2504a - v2.filled_quantity;
        };
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 3))) {
            let v3 = 0x1::option::borrow<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 3));
            let v4 = v1 + v3.aeca93d50e3d2504a;
            v1 = v4 - v3.filled_quantity;
        };
        v1
    }

    public(friend) fun a12ebe31e44811936(arg0: &A8eaa8c1bdbc9ed0a) : u64 {
        let v0 = arg0.a021d28fd92bb1654;
        let v1 = v0;
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 1))) {
            let v2 = 0x1::option::borrow<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 1)).price;
            if (v2 < v0) {
                v1 = v2;
            };
        };
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 3))) {
            let v3 = 0x1::option::borrow<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 3)).price;
            if (v3 < v1) {
                v1 = v3;
            };
        };
        v1
    }

    fun a1dfacedd162259df(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo) : A78ebf2415cd19e52 {
        A78ebf2415cd19e52{
            order_id          : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(arg0),
            price             : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::price(arg0),
            aeca93d50e3d2504a : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(arg0),
            filled_quantity   : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(arg0),
            expiry_timestamp  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::expire_timestamp(arg0),
        }
    }

    fun a26ba90ad8ce9a778(arg0: &mut A8eaa8c1bdbc9ed0a, arg1: &0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: &0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::aaeb58f742bb7d09d::Aacc01655d0dfbab1, arg12: bool, arg13: bool, arg14: &0x2::clock::Clock, arg15: &0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
        let v3 = arg6;
        if (arg12) {
            v3 = 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::aaeb58f742bb7d09d::ad2b2505b5ae4a829(arg11, arg1, arg6, arg8, v0);
        };
        let v4 = 0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, arg5);
        if (0x1::option::is_some<A78ebf2415cd19e52>(v4)) {
            let v5 = 0x1::option::borrow<A78ebf2415cd19e52>(v4);
            if (v5.price >= v3 - arg7 && v5.price <= v3 + arg7) {
                let v6 = v5.expiry_timestamp;
                if (v6 > 0x2::clock::timestamp_ms(arg14) && v6 - 0x2::clock::timestamp_ms(arg14) > 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::aaa372af3148e91d6(arg1) / 2) {
                    return
                };
            };
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, v5.order_id, arg14, arg15);
            0x1::option::extract<A78ebf2415cd19e52>(v4);
        };
        if (0x2::tx_context::gas_price(arg15) > 3000) {
            return
        };
        let v7 = a2719df4ae928c371(arg0, arg1, arg2, arg9 + 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::ad3e462cd25333e7f(arg6, v3) * 1000 / v3 / 10000 * arg10 / 1000, arg8);
        let v8 = v7;
        if (arg8) {
            if (arg13) {
                a7b7e6cc5534d020a(arg0, arg1, arg2, arg4, arg3, 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::abe7ab0b8cf6b9d08(arg1, v7, v3), arg14, arg15);
            };
            let v9 = 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::ac89fc20276c7e30c(arg1, 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::a9d9f98ebd95b9dad(arg1, arg2), v3);
            if (v7 > v9) {
                v8 = v9;
            };
            let v10 = v3 / v0 * v0;
            let v11 = v10;
            let v12 = v8 / v1 * v1;
            if (v12 < v2) {
                return
            };
            let v13 = a12ebe31e44811936(arg0);
            if (v10 >= v13) {
                v11 = v13 - v0;
            };
            if (v11 > 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::a82053465eda9bdc4(arg1)) {
                return
            };
            let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v11, v12, true, false, 0x2::clock::timestamp_ms(arg14) + 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::aaa372af3148e91d6(arg1), arg14, arg15);
            0x1::option::fill<A78ebf2415cd19e52>(0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, arg5), a1dfacedd162259df(&v14));
        } else {
            if (arg13) {
                a7e4799d1951fe624(arg0, arg1, arg2, arg4, arg3, v7, arg14, arg15);
            };
            let v15 = 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::ab78d0325509532d4(arg1, arg2);
            if (v7 > v15) {
                v8 = v15;
            };
            let v16 = (v3 + v0 - 1) / v0 * v0;
            let v17 = v16;
            let v18 = v8 / v1 * v1;
            if (v18 < v2) {
                return
            };
            let v19 = aa98af7d37398f210(arg0);
            if (v16 <= v19) {
                v17 = v19 + v0;
            };
            if (v17 < 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::af5b451c97d6b5192(arg1)) {
                return
            };
            let v20 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v17, v18, false, false, 0x2::clock::timestamp_ms(arg14) + 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::aaa372af3148e91d6(arg1), arg14, arg15);
            0x1::option::fill<A78ebf2415cd19e52>(0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, arg5), a1dfacedd162259df(&v20));
        };
    }

    public(friend) fun a2719df4ae928c371(arg0: &A8eaa8c1bdbc9ed0a, arg1: &0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::A0ea878587b719a64, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: bool) : u64 {
        let v0 = a027c74de64f71d0f(arg0, arg1, arg2);
        let v1 = v0;
        if (v0 > arg0.ad24db9c79e9012ee) {
            v1 = arg0.ad24db9c79e9012ee;
        };
        let v2 = if (arg4) {
            1000 + 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::a24721a1521e81292(arg1) - 2 * 1000 * v1 / arg0.ad24db9c79e9012ee * 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::a24721a1521e81292(arg1) / 1000
        } else {
            1000 + 2 * 1000 * v1 / arg0.ad24db9c79e9012ee * 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::a24721a1521e81292(arg1) / 1000 - 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::a24721a1521e81292(arg1)
        };
        arg3 * v2 / 1000
    }

    public(friend) fun a38a80653e93a075b(arg0: &mut A8eaa8c1bdbc9ed0a, arg1: &0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::aaeb58f742bb7d09d::Aacc01655d0dfbab1, arg9: &0x2::tx_context::TxContext) {
        if (!0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::a7cea368357b7d971(arg1)) {
            return
        };
        if (arg7 >= 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::a3a9b9d10c7fad14a(arg1)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg2, arg3, arg5, arg9);
            let v0 = &mut arg0.a0c4b816b0a50ba9c;
            let v1 = 0;
            while (v1 < 0x1::vector::length<0x1::option::Option<A78ebf2415cd19e52>>(v0)) {
                let v2 = 0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(v0, v1);
                if (0x1::option::is_some<A78ebf2415cd19e52>(v2)) {
                    0x1::option::extract<A78ebf2415cd19e52>(v2);
                };
                v1 = v1 + 1;
            };
            return
        };
        let v3 = arg6 / 10000;
        let v4 = v3 * 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::a028c32870d59a6e8(arg1) / 1000;
        let v5 = v4;
        let v6 = v3 * 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::ad66eeaefed209b0f(arg1) / 1000;
        let v7 = v6;
        if (arg7 > 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::a31f95bf83694efb8(arg1)) {
            let v8 = 10000 + 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::a95922dffece9e7da(arg1) * (arg7 - 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::a31f95bf83694efb8(arg1));
            v5 = v4 * v8 / 10000;
            v7 = v6 * v8 / 10000;
        };
        let v9 = 0;
        let v10 = v7 / 4;
        a26ba90ad8ce9a778(arg0, arg1, arg2, arg4, arg3, 0, arg6 - v5, v9, true, 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::aa97ca27b48d72d63(arg1), 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::ab4cce892f91e179d(arg1), arg8, true, true, arg5, arg9);
        a26ba90ad8ce9a778(arg0, arg1, arg2, arg4, arg3, 1, arg6 + v5, v9, false, 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::aa97ca27b48d72d63(arg1), 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::ab4cce892f91e179d(arg1), arg8, true, true, arg5, arg9);
        if (0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::a7f1f6920b2de2e7c(arg1)) {
            a26ba90ad8ce9a778(arg0, arg1, arg2, arg4, arg3, 2, arg6 - v7, v10, true, 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::ab38de150e2840b48(arg1), 0, arg8, true, false, arg5, arg9);
            a26ba90ad8ce9a778(arg0, arg1, arg2, arg4, arg3, 3, arg6 + v7, v10, false, 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::a9eb34d40c591e724(arg1), 0, arg8, true, false, arg5, arg9);
        };
    }

    fun a76d79b90ace82d17(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order) : A78ebf2415cd19e52 {
        A78ebf2415cd19e52{
            order_id          : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(arg0),
            price             : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(arg0),
            aeca93d50e3d2504a : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(arg0),
            filled_quantity   : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(arg0),
            expiry_timestamp  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(arg0),
        }
    }

    public(friend) fun a7b7e6cc5534d020a(arg0: &mut A8eaa8c1bdbc9ed0a, arg1: &0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::a9d9f98ebd95b9dad(arg1, arg2);
        if (arg5 <= v0) {
            return
        };
        let v1 = arg5 - v0;
        arg5 = v1;
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 2))) {
            let v2 = 0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, 2);
            let v3 = 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::ac89fc20276c7e30c(arg1, v1, 0x1::option::borrow<A78ebf2415cd19e52>(v2).price);
            ad74522dc26a12b72(arg2, arg3, arg4, v2, v3, arg6, arg7);
            let v4 = 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::a9d9f98ebd95b9dad(arg1, arg2);
            if (v1 <= v4) {
                return
            };
            arg5 = v1 - v4;
        };
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 0))) {
            let v5 = 0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, 0);
            let v6 = 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::ac89fc20276c7e30c(arg1, arg5, 0x1::option::borrow<A78ebf2415cd19e52>(v5).price);
            ad74522dc26a12b72(arg2, arg3, arg4, v5, v6, arg6, arg7);
        };
    }

    public(friend) fun a7e4799d1951fe624(arg0: &mut A8eaa8c1bdbc9ed0a, arg1: &0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::ab78d0325509532d4(arg1, arg2);
        if (arg5 <= v0) {
            return
        };
        let v1 = arg5 - v0;
        arg5 = v1;
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 3))) {
            let v2 = 0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, 3);
            ad74522dc26a12b72(arg2, arg3, arg4, v2, v1, arg6, arg7);
            let v3 = 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::ab78d0325509532d4(arg1, arg2);
            if (v1 <= v3) {
                return
            };
            arg5 = v1 - v3;
        };
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 1))) {
            let v4 = 0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, 1);
            ad74522dc26a12b72(arg2, arg3, arg4, v4, arg5, arg6, arg7);
        };
    }

    public(friend) fun a95d889fec9e5f721(arg0: &0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a783956f993d811bc::A0ea878587b719a64, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>, arg3: &0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::aaeb58f742bb7d09d::Aacc01655d0dfbab1, arg4: u64, arg5: &0x2::clock::Clock) : A8eaa8c1bdbc9ed0a {
        let v0 = 0x1::vector::empty<0x1::option::Option<A78ebf2415cd19e52>>();
        let v1 = 0;
        while (v1 < 4) {
            0x1::vector::push_back<0x1::option::Option<A78ebf2415cd19e52>>(&mut v0, 0x1::option::none<A78ebf2415cd19e52>());
            v1 = v1 + 1;
        };
        while (!0x1::vector::is_empty<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&arg2)) {
            let v2 = 0x1::vector::pop_back<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&mut arg2);
            if (0x2::clock::timestamp_ms(arg5) > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(&v2)) {
                continue
            };
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::client_order_id(&v2) < 4) {
                0x1::option::fill<A78ebf2415cd19e52>(0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::client_order_id(&v2)), a76d79b90ace82d17(&v2));
            };
        };
        let v3 = 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
        let v4 = 0;
        while (v4 < 4) {
            if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&v0, v4))) {
                let v5 = 0x1::option::borrow<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&v0, v4));
                let v6 = v3 + v5.aeca93d50e3d2504a;
                v3 = v6 - v5.filled_quantity;
            };
            v4 = v4 + 1;
        };
        A8eaa8c1bdbc9ed0a{
            a0c4b816b0a50ba9c : v0,
            ab814e822c301efb4 : 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::aaeb58f742bb7d09d::ab814e822c301efb4(arg3),
            a021d28fd92bb1654 : 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::aaeb58f742bb7d09d::a021d28fd92bb1654(arg3),
            ad24db9c79e9012ee : v3 + 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1), arg4),
        }
    }

    public(friend) fun aa98af7d37398f210(arg0: &A8eaa8c1bdbc9ed0a) : u64 {
        let v0 = arg0.ab814e822c301efb4;
        let v1 = v0;
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 0))) {
            let v2 = 0x1::option::borrow<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 0)).price;
            if (v2 > v0) {
                v1 = v2;
            };
        };
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 2))) {
            let v3 = 0x1::option::borrow<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 2)).price;
            if (v3 > v1) {
                v1 = v3;
            };
        };
        v1
    }

    fun ad74522dc26a12b72(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x1::option::Option<A78ebf2415cd19e52>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<A78ebf2415cd19e52>(arg3), 13906835213725466623);
        let v0 = 0x1::option::borrow_mut<A78ebf2415cd19e52>(arg3);
        if (0x2::clock::timestamp_ms(arg5) > v0.expiry_timestamp) {
            return
        };
        let v1 = v0.aeca93d50e3d2504a - v0.filled_quantity;
        let (_, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        if (v1 > arg4 + v4 + v3) {
            let v5 = v0.filled_quantity + 0x44e1320d532f978f5fde8dd63f62525c9fda1cdd40f3f76ab516982db9ddd8d6::a10868438248226c1::add75d004ccb35065(v1 - arg4, v3);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::modify_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, v0.order_id, v5, arg5, arg6);
            v0.aeca93d50e3d2504a = v5;
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, v0.order_id, arg5, arg6);
            0x1::option::extract<A78ebf2415cd19e52>(arg3);
        };
    }

    // decompiled from Move bytecode v6
}

