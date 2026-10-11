module 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::dex {
    struct DexTrade has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        router_fee: u64,
        sqrt_price_after: u128,
        timestamp_ms: u64,
    }

    public fun buy<T0>(arg0: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg7);
        buy_as<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7)
    }

    public(friend) fun buy_as<T0>(arg0: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::assert_version(arg0);
        assert!(arg4 > 0, 200);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= arg4, 202);
        let v0 = router_fee(arg0, arg4);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v0, arg8), 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::fee_recipient(arg0));
        };
        let v1 = arg4 - v0;
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, false, true, v1, 79226673515401279992447579055, arg7);
        let v5 = v4;
        let v6 = v2;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v5);
        assert!(v7 <= v1, 203);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg3), v7), v5);
        let v8 = 0x2::balance::value<T0>(&v6);
        assert!(v8 > 0, 200);
        assert!(v8 >= arg5, 201);
        let v9 = DexTrade{
            pool_id          : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2),
            trader           : arg6,
            is_buy           : true,
            sui_amount       : v7,
            token_amount     : v8,
            router_fee       : v0,
            sqrt_price_after : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg2),
            timestamp_ms     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<DexTrade>(v9);
        0x2::coin::from_balance<T0>(v6, arg8)
    }

    fun router_fee(arg0: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg1: u64) : u64 {
        (((arg1 as u128) * (0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::router_fee_bps(arg0) as u128) / (0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::bps() as u128)) as u64)
    }

    public fun sell<T0>(arg0: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = &mut arg3;
        if (0x2::coin::value<T0>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
        sell_as<T0>(arg0, arg1, arg2, v1, 0x2::coin::value<T0>(&arg3), arg4, v0, arg5, arg6)
    }

    public(friend) fun sell_as<T0>(arg0: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::assert_version(arg0);
        assert!(arg4 > 0, 200);
        assert!(0x2::coin::value<T0>(arg3) >= arg4, 202);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, true, true, arg4, 4295048016, arg7);
        let v3 = v2;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(v4 <= arg4, 203);
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg3), v4), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        let v5 = 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg8);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        let v7 = router_fee(arg0, v6);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v7, arg8), 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::fee_recipient(arg0));
        };
        let v8 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        assert!(v8 > 0, 200);
        assert!(v8 >= arg5, 201);
        let v9 = DexTrade{
            pool_id          : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2),
            trader           : arg6,
            is_buy           : false,
            sui_amount       : v6,
            token_amount     : v4,
            router_fee       : v7,
            sqrt_price_after : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg2),
            timestamp_ms     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<DexTrade>(v9);
        v5
    }

    // decompiled from Move bytecode v7
}

