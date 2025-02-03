module 0xce90717ec5f301c84c0be83893ab8cb64e6fe574f627c040b16ec4b1f87fbb6::openocean {
    struct CetusSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        partner_id: 0x2::object::ID,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    fun flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: u64, arg4: bool, arg5: bool, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2) = if (0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg2) == @0x639b5e433da31739e800cd085f356e64cae222966d0f1b11bd9dc76b322ff58b) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg3, arg6, arg7)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg3, arg6, arg7)
        };
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg5) {
            arg3
        } else {
            v6
        };
        let v8 = CetusSwapEvent{
            pool         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            amount_in    : v7,
            amount_out   : 0x2::balance::value<T0>(&v5) + 0x2::balance::value<T1>(&v4),
            a2b          : arg4,
            by_amount_in : arg5,
            partner_id   : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg2),
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<CetusSwapEvent>(v8);
        (0x2::coin::from_balance<T0>(v5, arg8), 0x2::coin::from_balance<T1>(v4, arg8), v3, v6)
    }

    public fun flash_swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2, v3) = flash_swap<T0, T1>(arg0, arg1, arg2, arg3, true, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg5, arg6);
        0xce90717ec5f301c84c0be83893ab8cb64e6fe574f627c040b16ec4b1f87fbb6::utils::transfer_or_destroy_coin<T0>(v0, arg6);
        (v1, v2, v3)
    }

    public fun flash_swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2, v3) = flash_swap<T0, T1>(arg0, arg1, arg2, arg3, false, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg5, arg6);
        0xce90717ec5f301c84c0be83893ab8cb64e6fe574f627c040b16ec4b1f87fbb6::utils::transfer_or_destroy_coin<T1>(v1, arg6);
        (v0, v2, v3)
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

    public fun repay_flash_swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T1>(arg5);
        let (v1, v2) = repay_flash_swap<T0, T1>(arg0, arg1, arg2, true, arg3, v0, arg4, arg5);
        0xce90717ec5f301c84c0be83893ab8cb64e6fe574f627c040b16ec4b1f87fbb6::utils::transfer_or_destroy_coin<T1>(v2, arg5);
        v1
    }

    public fun repay_flash_swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::coin::Coin<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let (v1, v2) = repay_flash_swap<T0, T1>(arg0, arg1, arg2, false, v0, arg3, arg4, arg5);
        0xce90717ec5f301c84c0be83893ab8cb64e6fe574f627c040b16ec4b1f87fbb6::utils::transfer_or_destroy_coin<T0>(v1, arg5);
        v2
    }

    public fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let (v1, v2, v3, v4) = flash_swap<T0, T1>(arg0, arg1, arg2, v0, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg4, arg5);
        assert!(v4 == v0, 0);
        let v5 = repay_flash_swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, v3, arg5);
        0xce90717ec5f301c84c0be83893ab8cb64e6fe574f627c040b16ec4b1f87fbb6::utils::transfer_or_destroy_coin<T0>(v5, arg5);
        0x2::coin::destroy_zero<T0>(v1);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg3);
        let (v1, v2, v3, v4) = flash_swap<T0, T1>(arg0, arg1, arg2, v0, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg4, arg5);
        assert!(v4 == v0, 0);
        0x2::coin::destroy_zero<T1>(v2);
        let v5 = repay_flash_swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, v3, arg5);
        0xce90717ec5f301c84c0be83893ab8cb64e6fe574f627c040b16ec4b1f87fbb6::utils::transfer_or_destroy_coin<T1>(v5, arg5);
        v1
    }

    // decompiled from Move bytecode v6
}

