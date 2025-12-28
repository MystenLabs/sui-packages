module 0x3e27d9a771aad9a1f4c6a1c03d0424df68cb1be1b62bd7a86e64d7d930f6eec0::rebalancer {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        bal_usdc: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        bal_m: 0x2::balance::Balance<T0>,
        has_position: bool,
        pos_tick_lower: u32,
        pos_tick_upper: u32,
        last_sqrt_price_x64: u128,
    }

    fun assert_owner(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x381fa7b8c35ef12b989638c01e3d46ab9839736fdc13bff0bff5b4505a907c80, 1);
    }

    fun assert_pool<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>>(arg0);
        assert!(0x2::object::id_to_address(&v0) == @0x9aedfbd1a64798b83a0d70d4432327c6372207aa2ff60ed828b799a634054411, 6);
    }

    fun compute_tick_bounds(arg0: u32) : (u32, u32) {
        let v0 = if (arg0 > 2) {
            arg0 - 2
        } else {
            0
        };
        (v0, arg0 + 2)
    }

    public entry fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x381fa7b8c35ef12b989638c01e3d46ab9839736fdc13bff0bff5b4505a907c80, 1);
        let v0 = Vault<T0>{
            id                  : 0x2::object::new(arg0),
            bal_usdc            : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            bal_m               : 0x2::balance::zero<T0>(),
            has_position        : false,
            pos_tick_lower      : 0,
            pos_tick_upper      : 0,
            last_sqrt_price_x64 : 0,
        };
        0x2::transfer::public_transfer<Vault<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun deposit_magma<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::balance::join<T0>(&mut arg0.bal_m, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposit_usdc<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.bal_usdc, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
    }

    fun ll_close_stored_position<T0>(arg0: &mut Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::dynamic_object_field::remove<u8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, 0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let (v2, v3) = if (v1 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, &mut v0, v1, arg3)
        } else {
            (0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::balance::zero<T0>())
        };
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, &v0, false);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v5, v6);
        0x2::balance::join<T0>(&mut v4, v7);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.bal_usdc, v5);
        0x2::balance::join<T0>(&mut arg0.bal_m, v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, v0);
        arg0.has_position = false;
        arg0.pos_tick_lower = 0;
        arg0.pos_tick_upper = 0;
    }

    fun ll_open_position_store_inside_vault<T0>(arg0: &mut Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.has_position, 4);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, arg3, arg4, arg7);
        let v1 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.bal_usdc);
        let v2 = 0x2::balance::value<T0>(&arg0.bal_m);
        assert!(v1 > 0 || v2 > 0, 5);
        let v3 = if (arg6) {
            v1
        } else {
            v2
        };
        assert!(v3 > 0, 5);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, &mut v0, v3, arg6, arg5);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(&v4);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.bal_usdc) >= v5, 5);
        assert!(0x2::balance::value<T0>(&arg0.bal_m) >= v6, 5);
        let v7 = if (v5 == 0) {
            0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        } else {
            0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.bal_usdc, v5)
        };
        let v8 = if (v6 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.bal_m, v6)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg1, arg2, v7, v8, v4);
        0x2::dynamic_object_field::add<u8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, 0, v0);
        arg0.has_position = true;
        arg0.pos_tick_lower = arg3;
        arg0.pos_tick_upper = arg4;
    }

    public entry fun rebalance<T0>(arg0: &mut Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>, arg3: &0x2::clock::Clock, arg4: bool, arg5: bool, arg6: u128, arg7: u32, arg8: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg8);
        assert_pool<T0>(arg2);
        arg0.last_sqrt_price_x64 = arg6;
        if (arg0.has_position) {
            ll_close_stored_position<T0>(arg0, arg1, arg2, arg3);
        };
        if (arg4) {
            return
        };
        let (v0, v1) = compute_tick_bounds(arg7);
        ll_open_position_store_inside_vault<T0>(arg0, arg1, arg2, v0, v1, arg3, arg5, arg8);
    }

    public entry fun withdraw_magma<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bal_m, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_usdc<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.bal_usdc, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

