module 0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::move_pump_router {
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

    public entry fun buy_exact_out<T0>(arg0: &FeeObject, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy_returns<T0>(arg1, arg2, arg3, arg4, arg6, arg8);
        let v2 = v0;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2) - v3;
        let v5 = v4 * arg0.buy_fee / 10000;
        assert!(v3 >= v5, 3);
        assert!(v4 + v5 <= arg5, 2);
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg8));
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg8));
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v5, arg8), arg0.admin);
        let v6 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg8),
            amount_in  : v4,
            amount_out : arg4,
        };
        0x2::event::emit<BuyEvent<T0>>(v6);
        let v7 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v5,
        };
        0x2::event::emit<FeeCollectedEvent>(v7);
        let v8 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v8);
    }

    public entry fun buy_exact_out_by_usdc<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, true, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg7);
        let v4 = v3;
        let v5 = v2;
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1, 0x2::tx_context::sender(arg9), arg9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v4), arg9)), 0x2::balance::zero<0x2::sui::SUI>(), v4);
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, 0x2::tx_context::sender(arg9));
        let v6 = 0x2::coin::from_balance<0x2::sui::SUI>(v5, arg9);
        let v7 = 0x2::balance::value<0x2::sui::SUI>(&v5) * arg0.buy_fee / 10000;
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v6, v7, arg9), arg0.admin);
        let (v8, v9) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy_returns<T0>(arg3, v6, arg5, arg6, arg7, arg9);
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<T0>(v9, 0x2::tx_context::sender(arg9));
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<0x2::sui::SUI>(v8, 0x2::tx_context::sender(arg9));
        let v10 = BuyByUSDCEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg9),
            amount_in  : v0,
            amount_out : arg6,
        };
        0x2::event::emit<BuyByUSDCEvent<T0>>(v10);
        let v11 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v7,
        };
        0x2::event::emit<FeeCollectedEvent>(v11);
        let v12 = OrderCompletedEvent{order_id: arg8};
        0x2::event::emit<OrderCompletedEvent>(v12);
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

    public entry fun sell_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 3);
        let (v0, v1) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg1, 0x2::coin::split<T0>(&mut arg2, arg3, arg7), arg4, arg5, arg7);
        let v2 = v0;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        let v4 = v3 * arg0.sell_fee / 10000;
        assert!(v3 - v4 >= arg4, 1);
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg7));
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg7));
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg7));
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v4, arg7), arg0.admin);
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

    public entry fun sell_exact_in_for_usdc<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg4) >= arg5, 3);
        let (v0, v1) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg3, 0x2::coin::split<T0>(&mut arg4, arg5, arg9), arg6, arg7, arg9);
        let v2 = v0;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        let v4 = v3 * arg0.sell_fee / 10000;
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<T0>(arg4, 0x2::tx_context::sender(arg9));
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg9));
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v4, arg9), arg0.admin);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, false, true, v3 - v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg7);
        let v8 = v7;
        let v9 = v5;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v8), arg9)), v8);
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v9, 0x2::tx_context::sender(arg9), arg9);
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_balance<0x2::sui::SUI>(v6, 0x2::tx_context::sender(arg9), arg9);
        0x53694d990aaab9647311959993c8d30a47422eadf5bc71c67f9e4085fa02e349::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg9));
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

