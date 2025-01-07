module 0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::cetus_router {
    struct FeeObject has key {
        id: 0x2::object::UID,
        buy_fee: u64,
        sell_fee: u64,
        admin: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
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

    public fun buy_exact_in_by_usdc_first<T0>(arg0: &mut FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg4;
        let (v1, v2) = swap_usdc_to_sui(arg1, arg2, v0, arg5, arg7, arg9);
        let v3 = v1;
        let v4 = &mut v3;
        let (v5, v6) = transfer_fee(v4, v2, arg0, arg9);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg1, arg3, true, true, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg7);
        let v10 = v9;
        let v11 = v8;
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<0x2::sui::SUI>(v7, 0x2::tx_context::sender(arg9), arg9);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v10);
        assert!(v12 == v5, 3);
        let v13 = 0x2::balance::value<T0>(&v11);
        assert!(v13 >= arg6, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg1, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v12, arg9)), 0x2::balance::zero<T0>(), v10);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<T0>(v11, 0x2::tx_context::sender(arg9), arg9);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, 0x2::tx_context::sender(arg9));
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_coin<0x2::sui::SUI>(v3, 0x2::tx_context::sender(arg9));
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

    public fun buy_exact_in_by_usdc_second<T0>(arg0: &mut FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg4;
        let (v1, v2) = swap_usdc_to_sui(arg1, arg2, v0, arg5, arg7, arg9);
        let v3 = v1;
        let v4 = &mut v3;
        let (v5, v6) = transfer_fee(v4, v2, arg0, arg9);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg1, arg3, false, true, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg7);
        let v10 = v9;
        let v11 = v7;
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<0x2::sui::SUI>(v8, 0x2::tx_context::sender(arg9), arg9);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v10);
        assert!(v12 == v5, 3);
        let v13 = 0x2::balance::value<T0>(&v11);
        assert!(v13 >= arg6, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v12, arg9)), v10);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<T0>(v11, 0x2::tx_context::sender(arg9), arg9);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, 0x2::tx_context::sender(arg9));
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_coin<0x2::sui::SUI>(v3, 0x2::tx_context::sender(arg9));
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

    public entry fun buy_exact_in_first<T0>(arg0: &mut FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = arg4 * arg0.buy_fee / 10000;
        let v1 = arg4 - v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0, arg8)));
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg1, arg2, true, true, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg6);
        let v5 = v4;
        let v6 = v3;
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg8), arg8);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v5);
        assert!(v7 == v1, 3);
        let v8 = 0x2::balance::value<T0>(&v6);
        assert!(v8 >= arg5, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg1, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v7, arg8)), 0x2::balance::zero<T0>(), v5);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<T0>(v6, 0x2::tx_context::sender(arg8), arg8);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_coin<0x2::sui::SUI>(arg3, 0x2::tx_context::sender(arg8));
        let v9 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg8),
            amount_in  : v1,
            amount_out : v8,
        };
        0x2::event::emit<BuyEvent<T0>>(v9);
        let v10 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v10);
        let v11 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v11);
    }

    public entry fun buy_exact_in_second<T0>(arg0: &mut FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = arg4 * arg0.buy_fee / 10000;
        let v1 = arg4 - v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0, arg8)));
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, false, true, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg6);
        let v5 = v4;
        let v6 = v2;
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<0x2::sui::SUI>(v3, 0x2::tx_context::sender(arg8), arg8);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v5);
        assert!(v7 == v1, 3);
        let v8 = 0x2::balance::value<T0>(&v6);
        assert!(v8 >= arg5, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v7, arg8)), v5);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<T0>(v6, 0x2::tx_context::sender(arg8), arg8);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_coin<0x2::sui::SUI>(arg3, 0x2::tx_context::sender(arg8));
        let v9 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg8),
            amount_in  : v1,
            amount_out : v8,
        };
        0x2::event::emit<BuyEvent<T0>>(v9);
        let v10 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v10);
        let v11 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v11);
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
            balance  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    public entry fun sell_exact_in_first<T0>(arg0: &mut FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg1, arg2, false, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg6);
        let v3 = v2;
        let v4 = v0;
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<T0>(v1, 0x2::tx_context::sender(arg8), arg8);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v3);
        assert!(v5 == arg4, 3);
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        let v7 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg8);
        let v8 = v6 * arg0.sell_fee / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v8, arg8)));
        assert!(v6 - v8 >= arg5, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg1, arg2, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v5, arg8)), v3);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg8));
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_coin<0x2::sui::SUI>(v7, 0x2::tx_context::sender(arg8));
        let v9 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg8),
            amount_in  : arg4,
            amount_out : v6 - v8,
        };
        0x2::event::emit<SellEvent<T0>>(v9);
        let v10 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v8,
        };
        0x2::event::emit<FeeCollectedEvent>(v10);
        let v11 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v11);
    }

    public fun sell_exact_in_for_usdc_first<T0>(arg0: &mut FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg1, arg3, false, true, arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg7);
        let v3 = v2;
        let v4 = v0;
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<T0>(v1, 0x2::tx_context::sender(arg9), arg9);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v3);
        assert!(v5 == arg5, 3);
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg1, arg3, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v5, arg9)), v3);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_coin<T0>(arg4, 0x2::tx_context::sender(arg9));
        let v7 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg9);
        let v8 = v6 * arg0.sell_fee / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v8, arg9)));
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

    public fun sell_exact_in_for_usdc_second<T0>(arg0: &mut FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg1, arg3, true, true, arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg7);
        let v3 = v2;
        let v4 = v1;
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<T0>(v0, 0x2::tx_context::sender(arg9), arg9);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(v5 == arg5, 3);
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_coin<T0>(arg4, 0x2::tx_context::sender(arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v5, arg9)), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        let v7 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg9);
        let v8 = v6 * arg0.sell_fee / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v8, arg9)));
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

    public entry fun sell_exact_in_second<T0>(arg0: &mut FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, true, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg6);
        let v3 = v2;
        let v4 = v1;
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<T0>(v0, 0x2::tx_context::sender(arg8), arg8);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(v5 == arg4, 3);
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        let v7 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg8);
        let v8 = v6 * arg0.sell_fee / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v8, arg8)));
        assert!(v6 - v8 >= arg5, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v5, arg8)), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg8));
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_coin<0x2::sui::SUI>(v7, 0x2::tx_context::sender(arg8));
        let v9 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg8),
            amount_in  : arg4,
            amount_out : v6 - v8,
        };
        0x2::event::emit<SellEvent<T0>>(v9);
        let v10 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v8,
        };
        0x2::event::emit<FeeCollectedEvent>(v10);
        let v11 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v11);
    }

    fun swap_sui_to_usdc(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0, arg1, false, true, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg5);
        let v3 = v2;
        let v4 = v0;
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg6), arg6);
        let v5 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v4);
        assert!(v5 > arg4, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v3), arg6)), v3);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4, 0x2::tx_context::sender(arg6), arg6);
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg6));
        v5
    }

    fun swap_usdc_to_sui(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg2: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2) >= arg3, 1);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0, arg1, true, true, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg4);
        let v3 = v2;
        let v4 = v1;
        0xa0411342899bb36bff6521db722ff9d9e5c29ada1706407c25781d5a998db472::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, 0x2::tx_context::sender(arg5), arg5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0, arg1, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v3), arg5)), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        (0x2::coin::from_balance<0x2::sui::SUI>(v4, arg5), 0x2::balance::value<0x2::sui::SUI>(&v4))
    }

    fun transfer_fee(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut FeeObject, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = arg1 * arg2.buy_fee / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg0, v0, arg3)));
        (arg1 - v0, v0)
    }

    // decompiled from Move bytecode v6
}

