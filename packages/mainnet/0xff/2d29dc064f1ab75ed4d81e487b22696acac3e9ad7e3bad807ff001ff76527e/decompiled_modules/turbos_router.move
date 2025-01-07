module 0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::turbos_router {
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

    public entry fun buy_exact_in<T0, T1, T2>(arg0: &FeeObject, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: bool, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = arg4 * arg0.buy_fee / 10000;
        let v1 = arg4 - v0;
        if (arg10) {
            assert!(0x2::coin::value<T0>(&arg2) >= arg4, 3);
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T0>(0x2::coin::split<T0>(&mut arg2, v0, arg12), arg0.admin);
        } else {
            assert!(0x2::coin::value<T1>(&arg3) >= arg4, 3);
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T1>(0x2::coin::split<T1>(&mut arg3, v0, arg12), arg0.admin);
        };
        if (arg10) {
            let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, arg2);
            let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, v2, v1, arg5, arg6, true, 0x2::tx_context::sender(arg12), arg7, arg8, arg9, arg12);
            let v5 = v3;
            let v6 = 0x2::coin::value<T1>(&v5);
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T0>(v4, 0x2::tx_context::sender(arg12));
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T1>(v5, 0x2::tx_context::sender(arg12));
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T1>(arg3, 0x2::tx_context::sender(arg12));
            assert!(v6 >= arg5, 4);
            let v7 = BuyEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg12),
                amount_in  : v1,
                amount_out : v6,
            };
            0x2::event::emit<BuyEvent<T1>>(v7);
        } else {
            let v8 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v8, arg3);
            let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, v8, v1, arg5, arg6, true, 0x2::tx_context::sender(arg12), arg7, arg8, arg9, arg12);
            let v11 = v9;
            let v12 = 0x2::coin::value<T0>(&v11);
            assert!(v12 >= arg5, 4);
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T1>(v10, 0x2::tx_context::sender(arg12));
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T0>(v11, 0x2::tx_context::sender(arg12));
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg12));
            let v13 = BuyEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg12),
                amount_in  : v1,
                amount_out : v12,
            };
            0x2::event::emit<BuyEvent<T0>>(v13);
        };
        let v14 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v14);
        let v15 = OrderCompletedEvent{order_id: arg11};
        0x2::event::emit<OrderCompletedEvent>(v15);
    }

    public entry fun buy_exact_in_by_usdc_first<T0, T1>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, T0, T1>, arg4: u64, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: u64, arg7: u128, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg5) >= arg4, 3);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, true, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg9);
        let v3 = v2;
        let v4 = v1;
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, 0x2::tx_context::sender(arg12), arg12);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v3), arg12)), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg5, 0x2::tx_context::sender(arg12));
        let v6 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg12);
        let v7 = v5 * arg0.buy_fee / 10000;
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v6, v7, arg12), arg0.admin);
        let v8 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v8, v6);
        let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<0x2::sui::SUI, T0, T1>(arg3, v8, v5 - v7, arg6, arg7, true, 0x2::tx_context::sender(arg12), arg8, arg9, arg10, arg12);
        let v11 = v9;
        let v12 = 0x2::coin::value<T0>(&v11);
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<0x2::sui::SUI>(v10, 0x2::tx_context::sender(arg12));
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T0>(v11, 0x2::tx_context::sender(arg12));
        assert!(v12 >= arg6, 4);
        let v13 = BuyByUSDCEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg12),
            amount_in  : arg4,
            amount_out : v12,
        };
        0x2::event::emit<BuyByUSDCEvent<T0>>(v13);
        let v14 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v7,
        };
        0x2::event::emit<FeeCollectedEvent>(v14);
        let v15 = OrderCompletedEvent{order_id: arg11};
        0x2::event::emit<OrderCompletedEvent>(v15);
    }

    public entry fun buy_exact_in_by_usdc_second<T0, T1>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg4: u64, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: u64, arg7: u128, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg5) >= arg4, 3);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, true, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg9);
        let v3 = v2;
        let v4 = v1;
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, 0x2::tx_context::sender(arg12), arg12);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v3), arg12)), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg5, 0x2::tx_context::sender(arg12));
        let v6 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg12);
        let v7 = v5 * arg0.buy_fee / 10000;
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v6, v7, arg12), arg0.admin);
        let v8 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v8, v6);
        let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, 0x2::sui::SUI, T1>(arg3, v8, v5 - v7, arg6, arg7, true, 0x2::tx_context::sender(arg12), arg8, arg9, arg10, arg12);
        let v11 = v9;
        let v12 = 0x2::coin::value<T0>(&v11);
        assert!(v12 >= arg6, 4);
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<0x2::sui::SUI>(v10, 0x2::tx_context::sender(arg12));
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T0>(v11, 0x2::tx_context::sender(arg12));
        let v13 = BuyByUSDCEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg12),
            amount_in  : arg4,
            amount_out : v12,
        };
        0x2::event::emit<BuyByUSDCEvent<T0>>(v13);
        let v14 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v7,
        };
        0x2::event::emit<FeeCollectedEvent>(v14);
        let v15 = OrderCompletedEvent{order_id: arg11};
        0x2::event::emit<OrderCompletedEvent>(v15);
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

    public entry fun sell_exact_in<T0, T1, T2>(arg0: &FeeObject, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: bool, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg10) {
            assert!(0x2::coin::value<T0>(&arg2) >= arg4, 3);
            let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, arg2);
            let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, v1, arg4, arg5, arg6, true, 0x2::tx_context::sender(arg12), arg7, arg8, arg9, arg12);
            let v4 = v2;
            let v5 = 0x2::coin::value<T1>(&v4);
            assert!(v5 >= arg5, 4);
            let v6 = v5 * arg0.sell_fee / 10000;
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T1>(0x2::coin::split<T1>(&mut v4, v6, arg12), arg0.admin);
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T1>(v4, 0x2::tx_context::sender(arg12));
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T0>(v3, 0x2::tx_context::sender(arg12));
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T1>(arg3, 0x2::tx_context::sender(arg12));
            let v7 = SellEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg12),
                amount_in  : arg4,
                amount_out : v5 - v6,
            };
            0x2::event::emit<SellEvent<T0>>(v7);
            v6
        } else {
            assert!(0x2::coin::value<T1>(&arg3) >= arg4, 3);
            let v8 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v8, arg3);
            let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, v8, arg4, arg5, arg6, true, 0x2::tx_context::sender(arg12), arg7, arg8, arg9, arg12);
            let v11 = v9;
            let v12 = 0x2::coin::value<T0>(&v11);
            assert!(v12 >= arg5, 4);
            let v13 = v12 * arg0.sell_fee / 10000;
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T0>(0x2::coin::split<T0>(&mut v11, v13, arg12), arg0.admin);
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T0>(v11, 0x2::tx_context::sender(arg12));
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T1>(v10, 0x2::tx_context::sender(arg12));
            0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg12));
            let v14 = SellEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg12),
                amount_in  : arg4,
                amount_out : v12 - v13,
            };
            0x2::event::emit<SellEvent<T1>>(v14);
            v13
        };
        let v15 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v15);
        let v16 = OrderCompletedEvent{order_id: arg11};
        0x2::event::emit<OrderCompletedEvent>(v16);
    }

    public entry fun sell_exact_in_for_usdc_first<T0, T1>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u128, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg4) >= arg5, 3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg4);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<0x2::sui::SUI, T0, T1>(arg3, v0, arg5, 0, arg7, true, 0x2::tx_context::sender(arg12), arg8, arg9, arg10, arg12);
        let v3 = v1;
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T0>(v2, 0x2::tx_context::sender(arg12));
        let v5 = v4 * arg0.sell_fee / 10000;
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v5, arg12), arg0.admin);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, false, true, v4 - v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg9);
        let v9 = v8;
        let v10 = v6;
        let v11 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v9), arg12)), v9);
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v10, 0x2::tx_context::sender(arg12), arg12);
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_balance<0x2::sui::SUI>(v7, 0x2::tx_context::sender(arg12), arg12);
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<0x2::sui::SUI>(v3, 0x2::tx_context::sender(arg12));
        assert!(v11 >= arg6, 4);
        let v12 = SellForUSDCEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg12),
            amount_in  : arg5,
            amount_out : v11,
        };
        0x2::event::emit<SellForUSDCEvent<T0>>(v12);
        let v13 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v5,
        };
        0x2::event::emit<FeeCollectedEvent>(v13);
        let v14 = OrderCompletedEvent{order_id: arg11};
        0x2::event::emit<OrderCompletedEvent>(v14);
    }

    public entry fun sell_exact_in_for_usdc_second<T0, T1>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u128, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg4) >= arg5, 3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg4);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, 0x2::sui::SUI, T1>(arg3, v0, arg5, arg6, arg7, true, 0x2::tx_context::sender(arg12), arg8, arg9, arg10, arg12);
        let v3 = v1;
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        assert!(v4 >= arg6, 4);
        let v5 = v4 * arg0.sell_fee / 10000;
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v5, arg12), arg0.admin);
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<T0>(v2, 0x2::tx_context::sender(arg12));
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, false, true, v4 - v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg9);
        let v9 = v8;
        let v10 = v6;
        let v11 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v9), arg12)), v9);
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v10, 0x2::tx_context::sender(arg12), arg12);
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_balance<0x2::sui::SUI>(v7, 0x2::tx_context::sender(arg12), arg12);
        0xff2d29dc064f1ab75ed4d81e487b22696acac3e9ad7e3bad807ff001ff76527e::utils::send_coin<0x2::sui::SUI>(v3, 0x2::tx_context::sender(arg12));
        assert!(v11 >= arg6, 4);
        let v12 = SellForUSDCEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg12),
            amount_in  : arg5,
            amount_out : v11,
        };
        0x2::event::emit<SellForUSDCEvent<T0>>(v12);
        let v13 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v5,
        };
        0x2::event::emit<FeeCollectedEvent>(v13);
        let v14 = OrderCompletedEvent{order_id: arg11};
        0x2::event::emit<OrderCompletedEvent>(v14);
    }

    // decompiled from Move bytecode v6
}

