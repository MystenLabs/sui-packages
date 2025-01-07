module 0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::fun_7k_router {
    struct FeeObject has key {
        id: 0x2::object::UID,
        buy_fee: u64,
        sell_fee: u64,
        admin: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuyEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct BuyByUSDCEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct SellEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct SellForUSDCEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct OrderCompletedEvent has copy, drop {
        order_id: 0x1::string::String,
    }

    public entry fun buy_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg7: 0x1::string::String, arg8: &0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::Config, arg9: &mut 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::vault::Vault, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 2);
        let v0 = arg3 * arg0.buy_fee / 10000;
        let v1 = 0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg3 - v0, arg10);
        let (v2, v3) = 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::buy_<T0>(arg1, &mut v1, true, arg4, arg5, arg6, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::value<T0>(&v5);
        assert!(v6 >= arg4, 1);
        if (0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::value<T0>(&v4) == 0) {
            0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::destroy_zero<T0>(v4);
        } else {
            0x2::transfer::public_transfer<0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::LockedCoin<T0>>(v4, 0x2::tx_context::sender(arg10));
        };
        0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::settle::settle<0x2::sui::SUI, T0>(arg8, arg9, arg3 - v0, &mut v5, arg4, v6, 0x1::option::none<address>(), 0, arg10);
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<T0>(v5, 0x2::tx_context::sender(arg10));
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg10));
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg10));
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg10), arg0.admin);
        let v7 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg10),
            amount_in  : arg3 - v0,
            amount_out : v6,
        };
        0x2::event::emit<BuyEvent<T0>>(v7);
        let v8 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v8);
        let v9 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v9);
    }

    public entry fun buy_exact_in_by_usdc<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg9: 0x1::string::String, arg10: &0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::Config, arg11: &mut 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::vault::Vault, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4) >= arg5, 2);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, true, true, arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg7);
        let v3 = v2;
        let v4 = v1;
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, 0x2::tx_context::sender(arg12), arg12);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v3), arg12)), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, 0x2::tx_context::sender(arg12));
        let v6 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg12);
        let v7 = v5 * arg0.buy_fee / 10000;
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v6, v7, arg12), arg0.admin);
        let v8 = 0x2::coin::split<0x2::sui::SUI>(&mut v6, v5 - v7, arg12);
        let (v9, v10) = 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::buy_<T0>(arg3, &mut v8, true, arg6, arg7, arg8, arg12);
        let v11 = v10;
        let v12 = v9;
        let v13 = 0x2::coin::value<T0>(&v12);
        assert!(v13 >= arg6, 1);
        if (0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::value<T0>(&v11) == 0) {
            0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::destroy_zero<T0>(v11);
        } else {
            0x2::transfer::public_transfer<0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::LockedCoin<T0>>(v11, 0x2::tx_context::sender(arg12));
        };
        0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::settle::settle<0x2::sui::SUI, T0>(arg10, arg11, v5 - v7, &mut v12, arg6, v13, 0x1::option::none<address>(), 0, arg12);
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<T0>(v12, 0x2::tx_context::sender(arg12));
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<0x2::sui::SUI>(v8, 0x2::tx_context::sender(arg12));
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<0x2::sui::SUI>(v6, 0x2::tx_context::sender(arg12));
        let v14 = BuyByUSDCEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg12),
            amount_in  : arg5,
            amount_out : v13,
        };
        0x2::event::emit<BuyByUSDCEvent<T0>>(v14);
        let v15 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v7,
        };
        0x2::event::emit<FeeCollectedEvent>(v15);
        let v16 = OrderCompletedEvent{order_id: arg9};
        0x2::event::emit<OrderCompletedEvent>(v16);
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut FeeObject, arg2: address) {
        arg1.admin = arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeObject{
            id       : 0x2::object::new(arg0),
            buy_fee  : 100,
            sell_fee : 100,
            admin    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    public entry fun sell_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::Config, arg7: &mut 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::vault::Vault, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 2);
        let v0 = 0x2::coin::split<T0>(&mut arg2, arg3, arg8);
        let v1 = 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::sell_<T0>(arg1, &mut v0, true, arg4, arg8);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        let v3 = v2 * arg0.sell_fee / 10000;
        assert!(v2 - v3 >= arg4, 1);
        0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::settle::settle<T0, 0x2::sui::SUI>(arg6, arg7, arg3, &mut v1, arg4, v2 - v3, 0x1::option::none<address>(), 0, arg8);
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg8));
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg8));
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg8));
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v3, arg8), arg0.admin);
        let v4 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg8),
            amount_in  : arg3,
            amount_out : v2 - v3,
        };
        0x2::event::emit<SellEvent<T0>>(v4);
        let v5 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v3,
        };
        0x2::event::emit<FeeCollectedEvent>(v5);
        let v6 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v6);
    }

    public entry fun sell_exact_in_for_usdc<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: &0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::Config, arg9: &mut 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::vault::Vault, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg4) >= arg5, 2);
        let v0 = 0x2::coin::split<T0>(&mut arg4, arg5, arg11);
        let v1 = 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::sell_<T0>(arg3, &mut v0, true, arg6, arg11);
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg11));
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<T0>(arg4, 0x2::tx_context::sender(arg11));
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        let v3 = v2 * arg0.sell_fee / 10000;
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v3, arg11), arg0.admin);
        0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::settle::settle<T0, 0x2::sui::SUI>(arg8, arg9, arg5, &mut v1, arg6, v2 - v3, 0x1::option::none<address>(), 0, arg11);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, false, true, v2 - v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg10);
        let v7 = v6;
        let v8 = v4;
        let v9 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v8);
        assert!(v9 >= arg6, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v7), arg11)), v7);
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v8, 0x2::tx_context::sender(arg11), arg11);
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_balance<0x2::sui::SUI>(v5, 0x2::tx_context::sender(arg11), arg11);
        0xa9eba4e6e2f1d9942ff10d3703d58295e90fc508f02703b50d193c2804250815::utils::send_coin<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg11));
        let v10 = SellForUSDCEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg11),
            amount_in  : arg5,
            amount_out : v9,
        };
        0x2::event::emit<SellForUSDCEvent<T0>>(v10);
        let v11 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v3,
        };
        0x2::event::emit<FeeCollectedEvent>(v11);
        let v12 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v12);
    }

    // decompiled from Move bytecode v6
}

