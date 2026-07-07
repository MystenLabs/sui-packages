module 0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::cetus_ops {
    struct TrapBaitBought has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        sui_in: u64,
        token_out: u64,
    }

    struct TrapDumpSold has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        token_in: u64,
        sui_out: u64,
    }

    fun repay_flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: bool, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = if (arg3) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg6), arg7)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg6), arg7)))
        };
        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg2) == @0x639b5e433da31739e800cd085f356e64cae222966d0f1b11bd9dc76b322ff58b) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v0, v1, arg6);
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, v0, v1, arg6);
        };
        (arg4, arg5)
    }

    public fun bait_buy_cetus<T0>(arg0: &mut 0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::assert_authorized(arg0, arg7);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2);
        let v1 = 0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::withdraw_coin<0x2::sui::SUI>(arg0, arg4, arg7);
        let v2 = swap_b2a<T0>(arg0, arg1, arg2, arg3, v1, arg5, arg6, arg7);
        0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::deposit_coin<T0>(arg0, v2);
        let v3 = TrapBaitBought{
            vault_id  : 0x2::object::id<0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::Vault>(arg0),
            pool_id   : v0,
            sui_in    : 0x2::coin::value<0x2::sui::SUI>(&v1),
            token_out : 0x2::coin::value<T0>(&v2),
        };
        0x2::event::emit<TrapBaitBought>(v3);
    }

    fun deposit_optional<T0>(arg0: &mut 0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::Vault, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::deposit_coin<T0>(arg0, arg1);
        };
    }

    fun destroy_balance_zero<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun dump_sell_cetus<T0>(arg0: &mut 0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::assert_authorized(arg0, arg6);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2);
        let v1 = 0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::withdraw_coin<T0>(arg0, arg4, arg6);
        let v2 = swap_a2b<T0>(arg0, arg1, arg2, arg3, v1, arg5, arg6);
        0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::deposit_coin<0x2::sui::SUI>(arg0, v2);
        let v3 = TrapDumpSold{
            vault_id : 0x2::object::id<0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::Vault>(arg0),
            pool_id  : v0,
            token_in : 0x2::coin::value<T0>(&v1),
            sui_out  : 0x2::coin::value<0x2::sui::SUI>(&v2),
        };
        0x2::event::emit<TrapDumpSold>(v3);
    }

    fun flash_swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: u64, arg4: bool, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2) = flash_swap_balances<T0, T1>(arg0, arg1, arg2, arg3, true, arg4, arg5, arg6);
        let v3 = v2;
        destroy_balance_zero<T0>(v0);
        (0x2::coin::from_balance<T1>(v1, arg7), v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3))
    }

    fun flash_swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: u64, arg4: bool, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2) = flash_swap_balances<T0, T1>(arg0, arg1, arg2, arg3, false, arg4, arg5, arg6);
        let v3 = v2;
        destroy_balance_zero<T1>(v1);
        (0x2::coin::from_balance<T0>(v0, arg7), v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3))
    }

    fun flash_swap_balances<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: u64, arg4: bool, arg5: bool, arg6: u128, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg2) == @0x639b5e433da31739e800cd085f356e64cae222966d0f1b11bd9dc76b322ff58b) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg3, arg6, arg7)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg3, arg6, arg7)
        }
    }

    fun repay_flash_swap_a2b<T0, T1>(arg0: &mut 0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T1>(arg6);
        let (v1, v2) = repay_flash_swap<T0, T1>(arg1, arg2, arg3, true, arg4, v0, arg5, arg6);
        deposit_optional<T1>(arg0, v2);
        v1
    }

    fun repay_flash_swap_b2a<T0, T1>(arg0: &mut 0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::coin::Coin<T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T0>(arg6);
        let (v1, v2) = repay_flash_swap<T0, T1>(arg1, arg2, arg3, false, v0, arg4, arg5, arg6);
        deposit_optional<T0>(arg0, v1);
        v2
    }

    fun swap_a2b<T0>(arg0: &mut 0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg4);
        let (v1, v2, v3) = flash_swap_a2b<T0, 0x2::sui::SUI>(arg1, arg2, arg3, v0, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg5, arg6);
        assert!(v3 == v0, 13906834668264685570);
        let v4 = repay_flash_swap_a2b<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, v2, arg6);
        deposit_optional<T0>(arg0, v4);
        v1
    }

    fun swap_b2a<T0>(arg0: &mut 0xffab8270d8972c691c8e2a614aa346fd106b9db1b2438af539054cfc184bf09f::vault::Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        let (v1, v2, v3) = flash_swap_b2a<T0, 0x2::sui::SUI>(arg1, arg2, arg3, v0, true, arg5, arg6, arg7);
        assert!(v3 == v0, 13906834784228802562);
        let v4 = repay_flash_swap_b2a<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, v2, arg7);
        deposit_optional<0x2::sui::SUI>(arg0, v4);
        v1
    }

    // decompiled from Move bytecode v7
}

