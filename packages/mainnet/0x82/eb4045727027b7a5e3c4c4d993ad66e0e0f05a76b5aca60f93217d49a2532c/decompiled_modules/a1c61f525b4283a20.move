module 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a1c61f525b4283a20 {
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

    public(friend) fun a027c74de64f71d0f(arg0: &A8eaa8c1bdbc9ed0a, arg1: &0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::A0ea878587b719a64, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        let v0 = 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::ab78d0325509532d4(arg1, arg2);
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

    fun a26ba90ad8ce9a778(arg0: &mut A8eaa8c1bdbc9ed0a, arg1: &0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg5: &mut 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg12: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg16: u64, arg17: u64, arg18: u64, arg19: bool, arg20: u64, arg21: u64, arg22: &0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::aaeb58f742bb7d09d::Aacc01655d0dfbab1, arg23: bool, arg24: bool, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
        let v3 = arg17;
        if (arg23) {
            v3 = 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::aaeb58f742bb7d09d::ad2b2505b5ae4a829(arg22, arg1, arg17, arg19, v0);
        };
        let v4 = 0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, arg16);
        if (0x1::option::is_some<A78ebf2415cd19e52>(v4)) {
            let v5 = 0x1::option::borrow<A78ebf2415cd19e52>(v4);
            if (v5.price >= v3 - arg18 && v5.price <= v3 + arg18) {
                let v6 = v5.expiry_timestamp;
                if (v6 > 0x2::clock::timestamp_ms(arg25) && v6 - 0x2::clock::timestamp_ms(arg25) > 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::aaa372af3148e91d6(arg1) / 2) {
                    return
                };
            };
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, v5.order_id, arg25, arg26);
            0x1::option::extract<A78ebf2415cd19e52>(v4);
        };
        if (0x2::tx_context::gas_price(arg26) > 3000) {
            return
        };
        let v7 = a2719df4ae928c371(arg0, arg1, arg2, arg20 + 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::ad3e462cd25333e7f(arg17, v3) * 1000 / v3 / 10000 * arg21 / 1000, arg19);
        let v8 = v7;
        if (arg19) {
            let v9 = v3 / v0 * v0;
            let v10 = v9;
            let v11 = 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::a0dd9168687113963(arg1, arg2, v7, v9);
            v8 = v11;
            if (arg24) {
                a7b7e6cc5534d020a(arg0, arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::abe7ab0b8cf6b9d08(arg1, v11, v3), arg25, arg26);
            };
            let v12 = 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::ac89fc20276c7e30c(arg1, 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::a9d9f98ebd95b9dad(arg1, arg2), v3);
            if (v11 > v12) {
                v8 = v12;
            };
            let v13 = a12ebe31e44811936(arg0);
            if (v9 >= v13) {
                v10 = v13 - v0;
            };
            let v14 = v8 / v1 * v1;
            if (v10 > 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::a82053465eda9bdc4(arg1)) {
                return
            };
            if (v14 < v2) {
                return
            };
            let v15 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, arg16, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v10, v14, true, false, 0x2::clock::timestamp_ms(arg25) + 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::aaa372af3148e91d6(arg1), arg25, arg26);
            0x1::option::fill<A78ebf2415cd19e52>(0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, arg16), a1dfacedd162259df(&v15));
        } else {
            if (arg24) {
                a7e4799d1951fe624(arg0, arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v7, arg25, arg26);
            };
            let v16 = 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::ab78d0325509532d4(arg1, arg2);
            if (v7 > v16) {
                v8 = v16;
            };
            let v17 = (v3 + v0 - 1) / v0 * v0;
            let v18 = v17;
            let v19 = v8 / v1 * v1;
            if (v19 < v2) {
                return
            };
            let v20 = aa98af7d37398f210(arg0);
            if (v17 <= v20) {
                v18 = v20 + v0;
            };
            if (v18 < 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::af5b451c97d6b5192(arg1)) {
                return
            };
            let v21 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, arg16, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v18, v19, false, false, 0x2::clock::timestamp_ms(arg25) + 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::aaa372af3148e91d6(arg1), arg25, arg26);
            0x1::option::fill<A78ebf2415cd19e52>(0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, arg16), a1dfacedd162259df(&v21));
        };
    }

    public(friend) fun a2719df4ae928c371(arg0: &A8eaa8c1bdbc9ed0a, arg1: &0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::A0ea878587b719a64, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: bool) : u64 {
        if (arg0.ad24db9c79e9012ee == 0) {
            return arg3
        };
        let v0 = a027c74de64f71d0f(arg0, arg1, arg2);
        let v1 = v0;
        if (v0 > arg0.ad24db9c79e9012ee) {
            v1 = arg0.ad24db9c79e9012ee;
        };
        let v2 = if (arg4) {
            1000 + 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::a24721a1521e81292(arg1) - 2 * 1000 * v1 / arg0.ad24db9c79e9012ee * 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::a24721a1521e81292(arg1) / 1000
        } else {
            1000 + 2 * 1000 * v1 / arg0.ad24db9c79e9012ee * 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::a24721a1521e81292(arg1) / 1000 - 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::a24721a1521e81292(arg1)
        };
        arg3 * v2 / 1000
    }

    public(friend) fun a38a80653e93a075b(arg0: &mut A8eaa8c1bdbc9ed0a, arg1: &0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg12: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg16: &0x2::clock::Clock, arg17: u64, arg18: u64, arg19: &0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::aaeb58f742bb7d09d::Aacc01655d0dfbab1, arg20: &mut 0x2::tx_context::TxContext) {
        if (!0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::a7cea368357b7d971(arg1)) {
            return
        };
        if (arg18 >= 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::a3a9b9d10c7fad14a(arg1)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg2, arg3, arg16, arg20);
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
        let v3 = arg17 / 10000;
        let v4 = v3 * 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::a028c32870d59a6e8(arg1) / 1000;
        let v5 = v4;
        let v6 = v3 * 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::ad66eeaefed209b0f(arg1) / 1000;
        let v7 = v6;
        if (arg18 > 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::a31f95bf83694efb8(arg1)) {
            let v8 = 10000 + 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::a95922dffece9e7da(arg1) * (arg18 - 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::a31f95bf83694efb8(arg1));
            v5 = v4 * v8 / 10000;
            v7 = v6 * v8 / 10000;
        };
        let v9 = 0;
        let v10 = v7 / 4;
        a26ba90ad8ce9a778(arg0, arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0, arg17 - v5, v9, true, 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::aa97ca27b48d72d63(arg1), 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::ab4cce892f91e179d(arg1), arg19, true, true, arg16, arg20);
        a26ba90ad8ce9a778(arg0, arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 1, arg17 + v5, v9, false, 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::aa97ca27b48d72d63(arg1), 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::ab4cce892f91e179d(arg1), arg19, true, true, arg16, arg20);
        if (0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::a7f1f6920b2de2e7c(arg1)) {
            a26ba90ad8ce9a778(arg0, arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 2, arg17 - v7, v10, true, 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::ab38de150e2840b48(arg1), 0, arg19, true, false, arg16, arg20);
            a26ba90ad8ce9a778(arg0, arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 3, arg17 + v7, v10, false, 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::a9eb34d40c591e724(arg1), 0, arg19, true, false, arg16, arg20);
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

    public(friend) fun a7b7e6cc5534d020a(arg0: &mut A8eaa8c1bdbc9ed0a, arg1: &0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg12: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::a9d9f98ebd95b9dad(arg1, arg2);
        let v1 = v0;
        if (arg16 <= v0) {
            return
        };
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 2))) {
            let v2 = 0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, 2);
            let v3 = 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::ac89fc20276c7e30c(arg1, arg16 - v0, 0x1::option::borrow<A78ebf2415cd19e52>(v2).price);
            ad74522dc26a12b72(arg2, arg3, arg4, v2, v3, arg17, arg18);
            let v4 = 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::a9d9f98ebd95b9dad(arg1, arg2);
            v1 = v4;
            if (arg16 <= v4) {
                return
            };
        };
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 0))) {
            let v5 = 0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, 0);
            let v6 = 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::ac89fc20276c7e30c(arg1, arg16 - v1, 0x1::option::borrow<A78ebf2415cd19e52>(v5).price);
            ad74522dc26a12b72(arg2, arg3, arg4, v5, v6, arg17, arg18);
            if (arg16 <= 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::a9d9f98ebd95b9dad(arg1, arg2)) {
                return
            };
        };
        0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::acbdd009a143591b1::a94cdf867cab7cc5c(arg1, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, 0, arg17, arg18);
    }

    public(friend) fun a7e4799d1951fe624(arg0: &mut A8eaa8c1bdbc9ed0a, arg1: &0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::ad9e4d11aecc532fa::Ad1f26f3c041612f2, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg12: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::ab78d0325509532d4(arg1, arg2);
        let v1 = v0;
        if (arg16 <= v0) {
            return
        };
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 3))) {
            let v2 = 0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, 3);
            ad74522dc26a12b72(arg2, arg3, arg4, v2, arg16 - v0, arg17, arg18);
            let v3 = 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::ab78d0325509532d4(arg1, arg2);
            v1 = v3;
            if (arg16 <= v3) {
                return
            };
        };
        if (0x1::option::is_some<A78ebf2415cd19e52>(0x1::vector::borrow<0x1::option::Option<A78ebf2415cd19e52>>(&arg0.a0c4b816b0a50ba9c, 1))) {
            let v4 = 0x1::vector::borrow_mut<0x1::option::Option<A78ebf2415cd19e52>>(&mut arg0.a0c4b816b0a50ba9c, 1);
            ad74522dc26a12b72(arg2, arg3, arg4, v4, arg16 - v1, arg17, arg18);
            if (arg16 <= 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::ab78d0325509532d4(arg1, arg2)) {
                return
            };
        };
        0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::acbdd009a143591b1::a94cdf867cab7cc5c(arg1, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0, arg16, arg17, arg18);
    }

    public(friend) fun a95d889fec9e5f721(arg0: &0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a783956f993d811bc::A0ea878587b719a64, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>, arg3: &0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::aaeb58f742bb7d09d::Aacc01655d0dfbab1, arg4: u64, arg5: &0x2::clock::Clock) : A8eaa8c1bdbc9ed0a {
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
        let v3 = 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::ab78d0325509532d4(arg0, arg1);
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
            ab814e822c301efb4 : 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::aaeb58f742bb7d09d::ab814e822c301efb4(arg3),
            a021d28fd92bb1654 : 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::aaeb58f742bb7d09d::a021d28fd92bb1654(arg3),
            ad24db9c79e9012ee : v3 + 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg1), arg4),
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
        assert!(0x1::option::is_some<A78ebf2415cd19e52>(arg3), 13906835501488275455);
        let v0 = 0x1::option::borrow_mut<A78ebf2415cd19e52>(arg3);
        if (0x2::clock::timestamp_ms(arg5) > v0.expiry_timestamp) {
            return
        };
        let v1 = v0.aeca93d50e3d2504a - v0.filled_quantity;
        let (_, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        if (v1 > arg4 + v4 + v3) {
            let v5 = v0.filled_quantity + 0x82eb4045727027b7a5e3c4c4d993ad66e0e0f05a76b5aca60f93217d49a2532c::a10868438248226c1::add75d004ccb35065(v1 - arg4, v3);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::modify_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, v0.order_id, v5, arg5, arg6);
            v0.aeca93d50e3d2504a = v5;
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, v0.order_id, arg5, arg6);
            0x1::option::extract<A78ebf2415cd19e52>(arg3);
        };
    }

    // decompiled from Move bytecode v6
}

