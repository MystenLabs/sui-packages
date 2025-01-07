module 0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::hop_router {
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

    public entry fun buy_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg2: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = arg4 * arg0.buy_fee / 10000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg4, 2);
        let (v1, v2) = 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::buy_returns<T0>(arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg4 - v0, arg7), 18446744073709551615, arg5, 0x2::tx_context::sender(arg7), arg7);
        let v3 = v2;
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<T0>(v3, 0x2::tx_context::sender(arg7));
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg7));
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0, arg7), arg0.admin);
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<0x2::sui::SUI>(arg3, 0x2::tx_context::sender(arg7));
        let v4 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg7),
            amount_in  : arg4 - v0,
            amount_out : 0x2::coin::value<T0>(&v3),
        };
        0x2::event::emit<BuyEvent<T0>>(v4);
        let v5 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v5);
        let v6 = OrderCompletedEvent{order_id: arg6};
        0x2::event::emit<OrderCompletedEvent>(v6);
    }

    public entry fun buy_exact_in_by_usdc<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg4: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg5) >= arg6, 2);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, true, true, arg6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg9);
        let v3 = v2;
        let v4 = v1;
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, 0x2::tx_context::sender(arg10), arg10);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v3), arg10)), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg5, 0x2::tx_context::sender(arg10));
        let v6 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg10);
        let v7 = v5 * arg0.buy_fee / 10000;
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v6, v7, arg10), arg0.admin);
        let (v8, v9) = 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::buy_returns<T0>(arg3, arg4, 0x2::coin::split<0x2::sui::SUI>(&mut v6, v5 - v7, arg10), 18446744073709551615, arg7, 0x2::tx_context::sender(arg10), arg10);
        let v10 = v9;
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<T0>(v10, 0x2::tx_context::sender(arg10));
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<0x2::sui::SUI>(v8, 0x2::tx_context::sender(arg10));
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<0x2::sui::SUI>(v6, 0x2::tx_context::sender(arg10));
        let v11 = BuyByUSDCEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg10),
            amount_in  : arg6 - v7,
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

    public entry fun sell_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg2: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) >= arg4, 2);
        let v0 = 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::sell_returns<T0>(arg1, arg2, 0x2::coin::split<T0>(&mut arg3, arg4, arg7), arg5, arg7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = v1 * arg0.sell_fee / 10000;
        assert!(v1 - v2 >= arg5, 1);
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg7));
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg7));
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v2, arg7), arg0.admin);
        let v3 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg7),
            amount_in  : arg4,
            amount_out : v1 - v2,
        };
        0x2::event::emit<SellEvent<T0>>(v3);
        let v4 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v2,
        };
        0x2::event::emit<FeeCollectedEvent>(v4);
        let v5 = OrderCompletedEvent{order_id: arg6};
        0x2::event::emit<OrderCompletedEvent>(v5);
    }

    public entry fun sell_exact_in_for_usdc<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg4: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg5) >= arg6, 2);
        let v0 = 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::sell_returns<T0>(arg3, arg4, 0x2::coin::split<T0>(&mut arg5, arg6, arg10), arg7, arg10);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = v1 * arg0.sell_fee / 10000;
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v2, arg10), arg0.admin);
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<T0>(arg5, 0x2::tx_context::sender(arg10));
        let v3 = v1 - v2;
        assert!(v3 >= arg7, 1);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, false, true, v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg9);
        let v7 = v6;
        let v8 = v4;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v7), arg10)), v7);
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v8, 0x2::tx_context::sender(arg10), arg10);
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_balance<0x2::sui::SUI>(v5, 0x2::tx_context::sender(arg10), arg10);
        0xc0b4f80b3f969e53b67a08c254d47bbd8d1aa888750e4abe43ca384a7271f664::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg10));
        let v9 = SellForUSDCEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg10),
            amount_in  : arg6,
            amount_out : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v8),
        };
        0x2::event::emit<SellForUSDCEvent<T0>>(v9);
        let v10 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v2,
        };
        0x2::event::emit<FeeCollectedEvent>(v10);
        let v11 = OrderCompletedEvent{order_id: arg8};
        0x2::event::emit<OrderCompletedEvent>(v11);
    }

    // decompiled from Move bytecode v6
}

