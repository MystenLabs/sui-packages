module 0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::turbospump_router {
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

    public entry fun buy_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3 * arg0.buy_fee / 10000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 2);
        let v1 = arg3 - v0;
        let (v2, v3) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::buy_with_return<T0>(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg7), v1, arg4, true, arg5, arg7);
        let v4 = v3;
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<T0>(v4, 0x2::tx_context::sender(arg7));
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg7));
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg7), arg0.admin);
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg7));
        let v5 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg7),
            amount_in  : v1,
            amount_out : 0x2::coin::value<T0>(&v4),
        };
        0x2::event::emit<BuyEvent<T0>>(v5);
        let v6 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v6);
        let v7 = OrderCompletedEvent{order_id: arg6};
        0x2::event::emit<OrderCompletedEvent>(v7);
    }

    public entry fun buy_exact_in_by_usdc<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4) >= arg5, 2);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, true, true, arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg7);
        let v3 = v2;
        let v4 = v1;
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, 0x2::tx_context::sender(arg9), arg9);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v3), arg9)), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, 0x2::tx_context::sender(arg9));
        let v6 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg9);
        let v7 = v5 * arg0.buy_fee / 10000;
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v6, v7, arg9), arg0.admin);
        let (v8, v9) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::buy_with_return<T0>(arg3, v6, v5 - v7, arg6, true, arg7, arg9);
        let v10 = v9;
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<T0>(v10, 0x2::tx_context::sender(arg9));
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<0x2::sui::SUI>(v8, 0x2::tx_context::sender(arg9));
        let v11 = BuyByUSDCEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg9),
            amount_in  : arg5,
            amount_out : 0x2::coin::value<T0>(&v10),
        };
        0x2::event::emit<BuyByUSDCEvent<T0>>(v11);
        let v12 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v7,
        };
        0x2::event::emit<FeeCollectedEvent>(v12);
        let v13 = OrderCompletedEvent{order_id: arg8};
        0x2::event::emit<OrderCompletedEvent>(v13);
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

    public entry fun sell_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 2);
        let (v0, v1) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::sell_with_return<T0>(arg1, 0x2::coin::split<T0>(&mut arg2, arg3, arg7), arg3, arg4, true, arg5, arg7);
        let v2 = v0;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        let v4 = v3 * arg0.sell_fee / 10000;
        assert!(v3 - v4 >= arg4, 1);
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg7));
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg7));
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg7));
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v4, arg7), arg0.admin);
        let v5 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg7),
            amount_in  : arg3,
            amount_out : v3 - v4,
        };
        0x2::event::emit<SellEvent<T0>>(v5);
        let v6 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v4,
        };
        0x2::event::emit<FeeCollectedEvent>(v6);
        let v7 = OrderCompletedEvent{order_id: arg6};
        0x2::event::emit<OrderCompletedEvent>(v7);
    }

    public entry fun sell_exact_in_for_usdc<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg4) >= arg5, 2);
        let (v0, v1) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::sell_with_return<T0>(arg3, 0x2::coin::split<T0>(&mut arg4, arg5, arg9), arg5, arg6, true, arg7, arg9);
        let v2 = v0;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        let v4 = v3 * arg0.sell_fee / 10000;
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<T0>(arg4, 0x2::tx_context::sender(arg9));
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg9));
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v4, arg9), arg0.admin);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, false, true, v3 - v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg7);
        let v8 = v7;
        let v9 = v5;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v8), arg9)), v8);
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v9, 0x2::tx_context::sender(arg9), arg9);
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_balance<0x2::sui::SUI>(v6, 0x2::tx_context::sender(arg9), arg9);
        0xdd8d828f0e88cb53b5219079c6bff879b482733f7b92e99472fbee160f026d6d::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg9));
        let v10 = SellForUSDCEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg9),
            amount_in  : arg5,
            amount_out : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v9),
        };
        0x2::event::emit<SellForUSDCEvent<T0>>(v10);
        let v11 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v4,
        };
        0x2::event::emit<FeeCollectedEvent>(v11);
        let v12 = OrderCompletedEvent{order_id: arg8};
        0x2::event::emit<OrderCompletedEvent>(v12);
    }

    // decompiled from Move bytecode v6
}

