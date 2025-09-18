module 0x26a27c20ef9887127d501884cf7687034d0f35a0ec6ea92726608561a15ad906::clmm {
    struct ClmmSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    fun flash_swap<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: u64, arg3: bool, arg4: bool, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2) = 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::flash_swap<T0, T1>(arg0, arg1, arg3, arg4, arg2, arg5, arg6);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg4) {
            arg2
        } else {
            v6
        };
        let v8 = ClmmSwapEvent{
            pool         : 0x2::object::id<0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>>(arg1),
            amount_in    : v7,
            amount_out   : 0x2::balance::value<T0>(&v5) + 0x2::balance::value<T1>(&v4),
            a2b          : arg3,
            by_amount_in : arg4,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<ClmmSwapEvent>(v8);
        (0x2::coin::from_balance<T0>(v5, arg7), 0x2::coin::from_balance<T1>(v4, arg7), v3, v6)
    }

    fun repay_flash_swap<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = if (arg2) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::swap_pay_amount<T0, T1>(&arg5), arg6)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::swap_pay_amount<T0, T1>(&arg5), arg6)))
        };
        0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::repay_flash_swap<T0, T1>(arg0, arg1, v0, v1, arg5);
        (arg3, arg4)
    }

    public fun swap_a2b<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (v1, v2, v3, v4) = flash_swap<T0, T1>(arg0, arg1, v0, true, true, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::tick_math::min_sqrt_price(), arg3, arg4);
        assert!(v4 == v0, 0);
        let v5 = 0x2::coin::zero<T1>(arg4);
        let (v6, v7) = repay_flash_swap<T0, T1>(arg0, arg1, true, arg2, v5, v3, arg4);
        0x26a27c20ef9887127d501884cf7687034d0f35a0ec6ea92726608561a15ad906::utils::transfer_or_destroy_coin<T0>(v6, arg4);
        0x26a27c20ef9887127d501884cf7687034d0f35a0ec6ea92726608561a15ad906::utils::transfer_or_destroy_coin<T1>(v7, arg4);
        0x2::coin::destroy_zero<T0>(v1);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (v1, v2, v3, v4) = flash_swap<T0, T1>(arg0, arg1, v0, false, true, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::tick_math::max_sqrt_price(), arg3, arg4);
        assert!(v4 == v0, 0);
        0x2::coin::destroy_zero<T1>(v2);
        let v5 = 0x2::coin::zero<T0>(arg4);
        let (v6, v7) = repay_flash_swap<T0, T1>(arg0, arg1, false, v5, arg2, v3, arg4);
        0x26a27c20ef9887127d501884cf7687034d0f35a0ec6ea92726608561a15ad906::utils::transfer_or_destroy_coin<T0>(v6, arg4);
        0x26a27c20ef9887127d501884cf7687034d0f35a0ec6ea92726608561a15ad906::utils::transfer_or_destroy_coin<T1>(v7, arg4);
        v1
    }

    // decompiled from Move bytecode v6
}

