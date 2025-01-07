module 0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::cetus_router {
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

    struct BuyByUsdcEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct SellEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct SellForUsdcEvent<phantom T0> has copy, drop {
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

    public entry fun buy_exact_in<T0, T1>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: bool, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = arg5 * arg0.buy_fee / 10000;
        let v1 = arg5 - v0;
        if (arg9) {
            0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<T0>(0x2::coin::split<T0>(&mut arg3, v0, arg11), arg0.admin);
        } else {
            0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<T1>(0x2::coin::split<T1>(&mut arg4, v0, arg11), arg0.admin);
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg9, true, v1, arg7, arg8);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        assert!(v8 == v1, 3);
        let (v9, v10, v11) = if (arg9) {
            (0x2::balance::value<T1>(&v6), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v8, arg11)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::value<T0>(&v7), 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v8, arg11)))
        };
        assert!(v9 >= arg6, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v10, v11, v5);
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v7, arg11));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v6, arg11));
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg11));
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg11));
        if (arg9) {
            let v12 = BuyEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg11),
                amount_in  : v1,
                amount_out : v9,
            };
            0x2::event::emit<BuyEvent<T1>>(v12);
        } else {
            let v13 = BuyEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg11),
                amount_in  : v1,
                amount_out : v9,
            };
            0x2::event::emit<BuyEvent<T0>>(v13);
        };
        let v14 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v14);
        let v15 = OrderCompletedEvent{order_id: arg10};
        0x2::event::emit<OrderCompletedEvent>(v15);
    }

    public fun buy_exact_in_by_usdc_first<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg4;
        let (v1, v2) = swap_usdc_to_sui(arg1, arg2, v0, arg5, arg7, arg9);
        let v3 = v1;
        let v4 = &mut v3;
        let (v5, v6) = transfer_fee(v4, v2, arg0, arg9);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg1, arg3, true, true, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg7);
        let v10 = v9;
        let v11 = v8;
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_balance<0x2::sui::SUI>(v7, 0x2::tx_context::sender(arg9), arg9);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v10);
        assert!(v12 == v5, 3);
        let v13 = 0x2::balance::value<T0>(&v11);
        assert!(v13 >= arg6, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg1, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v12, arg9)), 0x2::balance::zero<T0>(), v10);
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v11, arg9), 0x2::tx_context::sender(arg9));
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, 0x2::tx_context::sender(arg9));
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<0x2::sui::SUI>(v3, 0x2::tx_context::sender(arg9));
        let v14 = BuyByUsdcEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg9),
            amount_in  : arg5,
            amount_out : v13,
        };
        0x2::event::emit<BuyByUsdcEvent<T0>>(v14);
        let v15 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v6,
        };
        0x2::event::emit<FeeCollectedEvent>(v15);
        let v16 = OrderCompletedEvent{order_id: arg8};
        0x2::event::emit<OrderCompletedEvent>(v16);
    }

    public fun buy_exact_in_by_usdc_second<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg4;
        let (v1, v2) = swap_usdc_to_sui(arg1, arg2, v0, arg5, arg7, arg9);
        let v3 = v1;
        let v4 = &mut v3;
        let (v5, v6) = transfer_fee(v4, v2, arg0, arg9);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg1, arg3, false, true, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg7);
        let v10 = v9;
        let v11 = v7;
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_balance<0x2::sui::SUI>(v8, 0x2::tx_context::sender(arg9), arg9);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v10);
        assert!(v12 == v5, 3);
        let v13 = 0x2::balance::value<T0>(&v11);
        assert!(v13 >= arg6, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v12, arg9)), v10);
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v11, arg9), 0x2::tx_context::sender(arg9));
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, 0x2::tx_context::sender(arg9));
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<0x2::sui::SUI>(v3, 0x2::tx_context::sender(arg9));
        let v14 = BuyByUsdcEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg9),
            amount_in  : arg5,
            amount_out : v13,
        };
        0x2::event::emit<BuyByUsdcEvent<T0>>(v14);
        let v15 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v6,
        };
        0x2::event::emit<FeeCollectedEvent>(v15);
        let v16 = OrderCompletedEvent{order_id: arg8};
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

    public entry fun sell_exact_in<T0, T1>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: bool, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg9, true, arg5, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(v6 == arg5, 3);
        let (v7, v8, v9) = if (arg9) {
            (0x2::balance::value<T1>(&v4), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v6, arg11)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::value<T0>(&v5), 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v6, arg11)))
        };
        let v10 = v7 * arg0.sell_fee / 10000;
        if (arg9) {
            0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, v10), arg11), arg0.admin);
        } else {
            0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v10), arg11), arg0.admin);
        };
        assert!(v7 - v10 >= arg6, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v8, v9, v3);
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v5, arg11));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v4, arg11));
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg11));
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg11));
        if (arg9) {
            let v11 = SellEvent<T0>{
                recipient  : 0x2::tx_context::sender(arg11),
                amount_in  : arg5,
                amount_out : v7 - v10,
            };
            0x2::event::emit<SellEvent<T0>>(v11);
        } else {
            let v12 = SellEvent<T1>{
                recipient  : 0x2::tx_context::sender(arg11),
                amount_in  : arg5,
                amount_out : v7 - v10,
            };
            0x2::event::emit<SellEvent<T1>>(v12);
        };
        let v13 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v10,
        };
        0x2::event::emit<FeeCollectedEvent>(v13);
        let v14 = OrderCompletedEvent{order_id: arg10};
        0x2::event::emit<OrderCompletedEvent>(v14);
    }

    public fun sell_exact_in_for_usdc_first<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg1, arg3, false, true, arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg7);
        let v3 = v2;
        let v4 = v0;
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_balance<T0>(v1, 0x2::tx_context::sender(arg9), arg9);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v3);
        assert!(v5 == arg5, 3);
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<T0>(arg4, 0x2::tx_context::sender(arg9));
        let v7 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg9);
        let v8 = v6 * arg0.sell_fee / 10000;
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v8, arg9), arg0.admin);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg1, arg3, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v5, arg9)), v3);
        let v9 = swap_sui_to_usdc(arg1, arg2, v7, v6 - v8, arg6, arg7, arg9);
        let v10 = SellForUsdcEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg9),
            amount_in  : arg5,
            amount_out : v9,
        };
        0x2::event::emit<SellForUsdcEvent<T0>>(v10);
        let v11 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v8,
        };
        0x2::event::emit<FeeCollectedEvent>(v11);
        let v12 = OrderCompletedEvent{order_id: arg8};
        0x2::event::emit<OrderCompletedEvent>(v12);
    }

    public fun sell_exact_in_for_usdc_second<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg1, arg3, true, true, arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg7);
        let v3 = v2;
        let v4 = v1;
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_balance<T0>(v0, 0x2::tx_context::sender(arg9), arg9);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(v5 == arg5, 3);
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<T0>(arg4, 0x2::tx_context::sender(arg9));
        let v7 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg9);
        let v8 = v6 * arg0.sell_fee / 10000;
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v8, arg9), arg0.admin);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v5, arg9)), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        let v9 = swap_sui_to_usdc(arg1, arg2, v7, v6 - v8, arg6, arg7, arg9);
        let v10 = SellForUsdcEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg9),
            amount_in  : arg5,
            amount_out : v9,
        };
        0x2::event::emit<SellForUsdcEvent<T0>>(v10);
        let v11 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v8,
        };
        0x2::event::emit<FeeCollectedEvent>(v11);
        let v12 = OrderCompletedEvent{order_id: arg8};
        0x2::event::emit<OrderCompletedEvent>(v12);
    }

    fun swap_sui_to_usdc(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0, arg1, false, true, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg5);
        let v3 = v2;
        let v4 = v0;
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg6), arg6);
        let v5 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v4);
        assert!(v5 > arg4, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v3), arg6)), v3);
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4, 0x2::tx_context::sender(arg6), arg6);
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg6));
        v5
    }

    fun swap_usdc_to_sui(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg2: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2) >= arg3, 1);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0, arg1, true, true, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg4);
        let v3 = v2;
        let v4 = v1;
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, 0x2::tx_context::sender(arg5), arg5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0, arg1, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v3), arg5)), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        (0x2::coin::from_balance<0x2::sui::SUI>(v4, arg5), 0x2::balance::value<0x2::sui::SUI>(&v4))
    }

    fun transfer_fee(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &FeeObject, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = arg1 * arg2.buy_fee / 10000;
        0x728c1e725b820521c701f4f2aa244059ef47369ff04033658430f071337bb86f::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg0, v0, arg3), arg2.admin);
        (arg1 - v0, v0)
    }

    // decompiled from Move bytecode v6
}

