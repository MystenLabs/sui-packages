module 0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::bluemove_router {
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

    public entry fun buy_exact_in<T0>(arg0: &FeeObject, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * arg0.buy_fee / 10000;
        let v1 = arg1 - v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1, 1);
        let v2 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<0x2::sui::SUI, T0>(v1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg6), arg3, arg4, arg6);
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_coin<T0>(v2, 0x2::tx_context::sender(arg6));
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg6));
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg6), arg0.admin);
        let v3 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg6),
            amount_in  : v1,
            amount_out : 0x2::coin::value<T0>(&v2),
        };
        0x2::event::emit<BuyEvent<T0>>(v3);
        let v4 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v4);
        let v5 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v5);
    }

    public entry fun buy_exact_in_usdc<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4) >= arg3, 1);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, true, true, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg8);
        let v3 = v2;
        let v4 = v1;
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, 0x2::tx_context::sender(arg9), arg9);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v3), arg9)), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, 0x2::tx_context::sender(arg9));
        let v6 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg9);
        let v7 = v5 * arg0.buy_fee / 10000;
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v6, v7, arg9), arg0.admin);
        let v8 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<0x2::sui::SUI, T0>(v5 - v7, v6, arg5, arg6, arg9);
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_coin<T0>(v8, 0x2::tx_context::sender(arg9));
        let v9 = BuyByUSDCEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg9),
            amount_in  : arg3,
            amount_out : 0x2::coin::value<T0>(&v8),
        };
        0x2::event::emit<BuyByUSDCEvent<T0>>(v9);
        let v10 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v7,
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
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    public entry fun sell_exact_in<T0>(arg0: &FeeObject, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg1, 1);
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, 0x2::sui::SUI>(arg1, 0x2::coin::split<T0>(&mut arg2, arg1, arg6), arg3, arg4, arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = v1 * arg0.sell_fee / 10000;
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg6));
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg6));
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v2, arg6), arg0.admin);
        let v3 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg6),
            amount_in  : arg1,
            amount_out : v1 - v2,
        };
        0x2::event::emit<SellEvent<T0>>(v3);
        let v4 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v2,
        };
        0x2::event::emit<FeeCollectedEvent>(v4);
        let v5 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v5);
    }

    public entry fun sell_exact_in_usdc<T0>(arg0: &FeeObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg4) >= arg3, 1);
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, 0x2::sui::SUI>(arg3, 0x2::coin::split<T0>(&mut arg4, arg3, arg9), arg5, arg6, arg9);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = v1 * arg0.sell_fee / 10000;
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_coin<T0>(arg4, 0x2::tx_context::sender(arg9));
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v2, arg9), arg0.admin);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, false, true, v1 - v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg8);
        let v6 = v5;
        let v7 = v3;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v6), arg9)), v6);
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v7, 0x2::tx_context::sender(arg9), arg9);
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_balance<0x2::sui::SUI>(v4, 0x2::tx_context::sender(arg9), arg9);
        0xdb4cd21837e9c3ead85eb315ddfbe3e419cb6c39cd681ca59ac47fdfbe7b895d::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg9));
        let v8 = SellForUSDCEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg9),
            amount_in  : arg3,
            amount_out : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v7),
        };
        0x2::event::emit<SellForUSDCEvent<T0>>(v8);
        let v9 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v2,
        };
        0x2::event::emit<FeeCollectedEvent>(v9);
        let v10 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v10);
    }

    // decompiled from Move bytecode v6
}

