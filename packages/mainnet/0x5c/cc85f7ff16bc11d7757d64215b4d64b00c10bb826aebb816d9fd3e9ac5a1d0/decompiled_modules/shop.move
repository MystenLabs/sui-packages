module 0x5ccc85f7ff16bc11d7757d64215b4d64b00c10bb826aebb816d9fd3e9ac5a1d0::shop {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct GorillaShop<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        employees: 0x2::table::Table<address, bool>,
    }

    struct GorillaShopCreated has copy, drop {
        id: 0x2::object::ID,
    }

    public fun add_new_gorillas<T0>(arg0: &OwnerCap, arg1: &mut GorillaShop<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::remove<address>(&mut arg2, v0);
            if (!0x2::table::contains<address, bool>(&arg1.employees, v1)) {
                0x2::table::add<address, bool>(&mut arg1.employees, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public fun bananas<T0>(arg0: &OwnerCap, arg1: &GorillaShop<T0>) : u64 {
        0x2::balance::value<T0>(&arg1.balance)
    }

    public fun blue_move_swap<T0, T1>(arg0: &mut GorillaShop<T0>, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg6: &mut 0x2::tx_context::TxContext) {
        check_shop_balance<T0>(arg0, arg1, arg6);
        if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            let (_, v1) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::token_balances<T0, T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::get_pool<T0, T1>(arg5));
            assert!(v1 >= arg4, 4);
        } else {
            let (v2, _) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::token_balances<T1, T0>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::get_pool<T1, T0>(arg5));
            assert!(v2 >= arg4, 4);
        };
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input<T0, T1>(arg1, 0x2::coin::take<T0>(&mut arg0.balance, arg1, arg6), arg2, arg5, arg6);
    }

    fun cetus_flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, arg3, arg5, arg6);
        let v3 = v2;
        (0x2::coin::from_balance<T0>(v0, arg7), 0x2::coin::from_balance<T1>(v1, arg7), v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3))
    }

    fun cetus_repay_flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = if (arg2) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5), arg6)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5), arg6)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v0, v1, arg5);
        (arg3, arg4)
    }

    public fun cetus_swap_a_b<T0, T1>(arg0: &mut GorillaShop<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        check_shop_balance<T0>(arg0, arg6, arg10);
        let (_, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg2);
        let (_, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg3);
        let (_, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg4);
        let (_, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg5);
        if (0x2::balance::value<T1>(v1) >= arg8) {
            inner_cetus_swap_a_b<T0, T1>(arg0, arg1, arg2, arg6, arg7, arg8, arg9, arg10);
        } else if (0x2::balance::value<T1>(v3) >= arg8) {
            inner_cetus_swap_a_b<T0, T1>(arg0, arg1, arg3, arg6, arg7, arg8, arg9, arg10);
        } else if (0x2::balance::value<T1>(v5) >= arg8) {
            inner_cetus_swap_a_b<T0, T1>(arg0, arg1, arg4, arg6, arg7, arg8, arg9, arg10);
        } else {
            assert!(0x2::balance::value<T1>(v7) >= arg8, 4);
            inner_cetus_swap_a_b<T0, T1>(arg0, arg1, arg5, arg6, arg7, arg8, arg9, arg10);
        };
    }

    public fun cetus_swap_b_a<T0, T1>(arg0: &mut GorillaShop<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        check_shop_balance<T1>(arg0, arg6, arg10);
        let (_, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg2);
        let (_, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg3);
        let (_, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg4);
        let (_, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg5);
        if (0x2::balance::value<T1>(v1) >= arg8) {
            inner_cetus_swap_b_a<T0, T1>(arg0, arg1, arg2, arg6, arg7, arg8, arg9, arg10);
        } else if (0x2::balance::value<T1>(v3) >= arg8) {
            inner_cetus_swap_b_a<T0, T1>(arg0, arg1, arg3, arg6, arg7, arg8, arg9, arg10);
        } else if (0x2::balance::value<T1>(v5) >= arg8) {
            inner_cetus_swap_b_a<T0, T1>(arg0, arg1, arg4, arg6, arg7, arg8, arg9, arg10);
        } else {
            assert!(0x2::balance::value<T1>(v7) >= arg8, 4);
            inner_cetus_swap_b_a<T0, T1>(arg0, arg1, arg5, arg6, arg7, arg8, arg9, arg10);
        };
    }

    public fun check_shop_balance<T0>(arg0: &GorillaShop<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.employees, 0x2::tx_context::sender(arg2)), 0);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 2);
    }

    public fun create_gorilla_shop<T0>(arg0: &OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GorillaShop<T0>{
            id        : 0x2::object::new(arg1),
            balance   : 0x2::balance::zero<T0>(),
            employees : 0x2::table::new<address, bool>(arg1),
        };
        let v1 = GorillaShopCreated{id: 0x2::object::id<GorillaShop<T0>>(&v0)};
        0x2::event::emit<GorillaShopCreated>(v1);
        0x2::transfer::share_object<GorillaShop<T0>>(v0);
    }

    public fun deposit_bananas<T0>(arg0: &OwnerCap, arg1: &mut GorillaShop<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg3));
    }

    public fun hopfun_swap<T0>(arg0: &mut GorillaShop<0x2::sui::SUI>, arg1: &0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::MemeConfig, arg2: &mut 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::BondingCurve<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_shop_balance<0x2::sui::SUI>(arg0, arg3, arg4);
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::meme::buy<T0>(arg2, arg1, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg3, arg4), 1000000000000000, 0, 0x2::tx_context::sender(arg4), arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun inner_cetus_swap_a_b<T0, T1>(arg0: &mut GorillaShop<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_shop_balance<T0>(arg0, arg3, arg7);
        let (v0, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg2);
        assert!(0x2::balance::value<T0>(v0) >= arg5, 4);
        let v2 = 0x2::coin::take<T0>(&mut arg0.balance, arg3, arg7);
        let (v3, v4, v5, _) = cetus_flash_swap<T0, T1>(arg1, arg2, true, arg3, arg4, 4295048016, arg6, arg7);
        let v7 = 0x2::coin::zero<T1>(arg7);
        let (v8, v9) = cetus_repay_flash_swap<T0, T1>(arg1, arg2, true, v2, v7, v5, arg7);
        transfer_or_destroy_coin<T0>(v8, arg7);
        transfer_or_destroy_coin<T1>(v9, arg7);
        0x2::coin::destroy_zero<T0>(v3);
        transfer_or_destroy_coin<T1>(v4, arg7);
    }

    fun inner_cetus_swap_b_a<T0, T1>(arg0: &mut GorillaShop<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::take<T1>(&mut arg0.balance, arg3, arg7);
        let (v1, v2, v3, _) = cetus_flash_swap<T0, T1>(arg1, arg2, false, arg3, arg4, 79226673515401279992447579055, arg6, arg7);
        let v5 = 0x2::coin::zero<T0>(arg7);
        let (v6, v7) = cetus_repay_flash_swap<T0, T1>(arg1, arg2, false, v5, v0, v3, arg7);
        transfer_or_destroy_coin<T0>(v6, arg7);
        transfer_or_destroy_coin<T1>(v7, arg7);
        0x2::coin::destroy_zero<T1>(v2);
        transfer_or_destroy_coin<T0>(v1, arg7);
    }

    fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun turbo_swap_a_b<T0, T1, T2, T3, T4, T5>(arg0: &mut GorillaShop<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T4>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T5>, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) {
        check_shop_balance<T0>(arg0, arg5, arg11);
        let (v0, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T2>(arg1);
        let (v2, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T3>(arg2);
        let (v4, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T4>(arg3);
        let (v6, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T5>(arg4);
        if (v0 >= arg7) {
            let v8 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v8, 0x2::coin::take<T0>(&mut arg0.balance, arg5, arg11));
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg1, v8, arg5, arg6, arg8, true, 0x2::tx_context::sender(arg11), 0x2::clock::timestamp_ms(arg9) + 86400, arg9, arg10, arg11);
        } else if (v2 >= arg7) {
            let v9 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v9, 0x2::coin::take<T0>(&mut arg0.balance, arg5, arg11));
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T3>(arg2, v9, arg5, arg6, arg8, true, 0x2::tx_context::sender(arg11), 0x2::clock::timestamp_ms(arg9) + 86400, arg9, arg10, arg11);
        } else if (v4 >= arg7) {
            let v10 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v10, 0x2::coin::take<T0>(&mut arg0.balance, arg5, arg11));
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T4>(arg3, v10, arg5, arg6, arg8, true, 0x2::tx_context::sender(arg11), 0x2::clock::timestamp_ms(arg9) + 86400, arg9, arg10, arg11);
        } else {
            assert!(v6 >= arg7, 4);
            let v11 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v11, 0x2::coin::take<T0>(&mut arg0.balance, arg5, arg11));
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T5>(arg4, v11, arg5, arg6, arg8, true, 0x2::tx_context::sender(arg11), 0x2::clock::timestamp_ms(arg9) + 86400, arg9, arg10, arg11);
        };
    }

    public fun turbo_swap_b_a<T0, T1, T2, T3, T4, T5>(arg0: &mut GorillaShop<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T3>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T4>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T5>, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) {
        check_shop_balance<T1>(arg0, arg5, arg11);
        let (v0, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T2>(arg1);
        let (v2, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T3>(arg2);
        let (v4, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T4>(arg3);
        let (v6, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T5>(arg4);
        if (v0 >= arg7) {
            let v8 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v8, 0x2::coin::take<T1>(&mut arg0.balance, arg5, arg11));
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T2>(arg1, v8, arg5, arg6, arg8, true, 0x2::tx_context::sender(arg11), 0x2::clock::timestamp_ms(arg9) + 86400, arg9, arg10, arg11);
        } else if (v2 >= arg7) {
            let v9 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v9, 0x2::coin::take<T1>(&mut arg0.balance, arg5, arg11));
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T3>(arg2, v9, arg5, arg6, arg8, true, 0x2::tx_context::sender(arg11), 0x2::clock::timestamp_ms(arg9) + 86400, arg9, arg10, arg11);
        } else if (v4 >= arg7) {
            let v10 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v10, 0x2::coin::take<T1>(&mut arg0.balance, arg5, arg11));
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T4>(arg3, v10, arg5, arg6, arg8, true, 0x2::tx_context::sender(arg11), 0x2::clock::timestamp_ms(arg9) + 86400, arg9, arg10, arg11);
        } else {
            assert!(v6 >= arg7, 4);
            let v11 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v11, 0x2::coin::take<T1>(&mut arg0.balance, arg5, arg11));
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T5>(arg4, v11, arg5, arg6, arg8, true, 0x2::tx_context::sender(arg11), 0x2::clock::timestamp_ms(arg9) + 86400, arg9, arg10, arg11);
        };
    }

    public fun withdraw_bananas<T0>(arg0: &OwnerCap, arg1: &mut GorillaShop<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

