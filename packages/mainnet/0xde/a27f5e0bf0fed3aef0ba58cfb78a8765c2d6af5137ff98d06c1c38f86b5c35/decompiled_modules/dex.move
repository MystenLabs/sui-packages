module 0xdea27f5e0bf0fed3aef0ba58cfb78a8765c2d6af5137ff98d06c1c38f86b5c35::dex {
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

    public fun buy<T0>(arg0: &0xdea27f5e0bf0fed3aef0ba58cfb78a8765c2d6af5137ff98d06c1c38f86b5c35::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xdea27f5e0bf0fed3aef0ba58cfb78a8765c2d6af5137ff98d06c1c38f86b5c35::config::assert_version(arg0);
        assert!(arg4 > 0, 200);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= arg4, 202);
        let v0 = router_fee(arg0, arg4);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v0, arg7), 0xdea27f5e0bf0fed3aef0ba58cfb78a8765c2d6af5137ff98d06c1c38f86b5c35::config::fee_recipient(arg0));
        };
        let v1 = arg4 - v0;
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, false, true, v1, 79226673515401279992447579055, arg6);
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
            trader           : 0x2::tx_context::sender(arg7),
            is_buy           : true,
            sui_amount       : v7,
            token_amount     : v8,
            router_fee       : v0,
            sqrt_price_after : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg2),
            timestamp_ms     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<DexTrade>(v9);
        0x2::coin::from_balance<T0>(v6, arg7)
    }

    fun router_fee(arg0: &0xdea27f5e0bf0fed3aef0ba58cfb78a8765c2d6af5137ff98d06c1c38f86b5c35::config::Config, arg1: u64) : u64 {
        (((arg1 as u128) * (0xdea27f5e0bf0fed3aef0ba58cfb78a8765c2d6af5137ff98d06c1c38f86b5c35::config::router_fee_bps(arg0) as u128) / (0xdea27f5e0bf0fed3aef0ba58cfb78a8765c2d6af5137ff98d06c1c38f86b5c35::config::bps() as u128)) as u64)
    }

    public fun sell<T0>(arg0: &0xdea27f5e0bf0fed3aef0ba58cfb78a8765c2d6af5137ff98d06c1c38f86b5c35::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xdea27f5e0bf0fed3aef0ba58cfb78a8765c2d6af5137ff98d06c1c38f86b5c35::config::assert_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 200);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, true, true, v0, 4295048016, arg5);
        let v4 = v3;
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v4);
        assert!(v5 <= v0, 203);
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut arg3), v5), 0x2::balance::zero<0x2::sui::SUI>(), v4);
        if (0x2::coin::value<T0>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
        let v6 = 0x2::coin::from_balance<0x2::sui::SUI>(v2, arg6);
        let v7 = 0x2::coin::value<0x2::sui::SUI>(&v6);
        let v8 = router_fee(arg0, v7);
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v6, v8, arg6), 0xdea27f5e0bf0fed3aef0ba58cfb78a8765c2d6af5137ff98d06c1c38f86b5c35::config::fee_recipient(arg0));
        };
        let v9 = 0x2::coin::value<0x2::sui::SUI>(&v6);
        assert!(v9 > 0, 200);
        assert!(v9 >= arg4, 201);
        let v10 = DexTrade{
            pool_id          : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2),
            trader           : 0x2::tx_context::sender(arg6),
            is_buy           : false,
            sui_amount       : v7,
            token_amount     : v5,
            router_fee       : v8,
            sqrt_price_after : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg2),
            timestamp_ms     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<DexTrade>(v10);
        v6
    }

    // decompiled from Move bytecode v7
}

