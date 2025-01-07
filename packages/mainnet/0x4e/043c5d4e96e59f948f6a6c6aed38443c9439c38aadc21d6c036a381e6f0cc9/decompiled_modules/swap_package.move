module 0x4e043c5d4e96e59f948f6a6c6aed38443c9439c38aadc21d6c036a381e6f0cc9::swap_package {
    struct CoinWallet<phantom T0> has key {
        id: 0x2::object::UID,
        token: 0x2::balance::Balance<T0>,
    }

    struct WhiteList has key {
        id: 0x2::object::UID,
        address_list: vector<address>,
    }

    struct PoolSimpleInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        tick_spacing: u32,
    }

    struct PoolSimpleInfoEvent has copy, drop {
        pool_id: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        tick_spacing: u32,
    }

    public fun swap<T0, T1>(arg0: &WhiteList, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut CoinWallet<T0>, arg4: &mut CoinWallet<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg12);
        let v0 = if (arg5) {
            arg7
        } else {
            0
        };
        let v1 = if (!arg5) {
            arg7
        } else {
            0
        };
        let v2 = 0x2::coin::take<T0>(&mut arg3.token, v0, arg12);
        let v3 = 0x2::coin::take<T1>(&mut arg4.token, v1, arg12);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg5, arg6, arg7, arg9, arg10);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = if (arg5) {
            0x2::balance::value<T1>(&v8)
        } else {
            0x2::balance::value<T0>(&v9)
        };
        assert!(v10 > arg8, 2);
        let (v11, v12) = if (arg5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7), arg12)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7), arg12)))
        };
        0x2::coin::join<T1>(&mut v3, 0x2::coin::from_balance<T1>(v8, arg12));
        0x2::coin::join<T0>(&mut v2, 0x2::coin::from_balance<T0>(v9, arg12));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v11, v12, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, arg11);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun test(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: vector<0x2::object::ID>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg1, arg2, arg3);
        let v1 = 0;
        loop {
            v1 = v1 + 1;
            if (v1 > 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>(&v0)) {
                break
            };
            let v2 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>(&mut v0);
            let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::coin_types(&v2);
            let v5 = PoolSimpleInfoEvent{
                pool_id      : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_id(&v2),
                pool_key     : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_key(&v2),
                coin_type_a  : v3,
                coin_type_b  : v4,
                tick_spacing : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::tick_spacing(&v2),
            };
            0x2::event::emit<PoolSimpleInfoEvent>(v5);
        };
    }

    // decompiled from Move bytecode v6
}

