module 0x61a9ef15434fa948d848339ad05fc4e74cc19a5e93086e3eaa7338b2e89b0981::cetusdlmm {
    struct CetusDlmmSwapEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    fun flash<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: u64, arg4: bool, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>) {
        if (0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner>(arg2) == @0x59ae16f6c42f578063c2da9b9c0173fe58120ceae08e40fd8212c8eceb80bb86) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, arg4, true, arg3, arg0, arg5, arg6, arg7)
        } else {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, arg4, true, arg3, arg0, arg5, arg6, arg7)
        }
    }

    fun repay<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        if (0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner>(arg1) == @0x59ae16f6c42f578063c2da9b9c0173fe58120ceae08e40fd8212c8eceb80bb86) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, arg2, arg3, arg4, arg5);
        } else {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::coin::into_balance<T0>(arg3);
        let (v2, v3, v4) = flash<T0, T1>(arg0, arg1, arg2, v0, true, arg4, arg5, arg6);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::destroy_zero<T0>(v2);
        repay<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v5)), 0x2::balance::zero<T1>(), v5, arg4);
        0x61a9ef15434fa948d848339ad05fc4e74cc19a5e93086e3eaa7338b2e89b0981::utils::transfer_or_destroy_balance<T0>(v1, arg6);
        let v7 = CetusDlmmSwapEvent{
            pool_id      : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1),
            amount_in    : v0,
            amount_out   : 0x2::balance::value<T1>(&v6),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<CetusDlmmSwapEvent>(v7);
        0x2::coin::from_balance<T1>(v6, arg6)
    }

    public fun swap_b2a<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: 0x2::coin::Coin<T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg3);
        let v1 = 0x2::coin::into_balance<T1>(arg3);
        let (v2, v3, v4) = flash<T0, T1>(arg0, arg1, arg2, v0, false, arg4, arg5, arg6);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::destroy_zero<T1>(v3);
        repay<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v5)), v5, arg4);
        0x61a9ef15434fa948d848339ad05fc4e74cc19a5e93086e3eaa7338b2e89b0981::utils::transfer_or_destroy_balance<T1>(v1, arg6);
        let v7 = CetusDlmmSwapEvent{
            pool_id      : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1),
            amount_in    : v0,
            amount_out   : 0x2::balance::value<T0>(&v6),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<CetusDlmmSwapEvent>(v7);
        0x2::coin::from_balance<T0>(v6, arg6)
    }

    // decompiled from Move bytecode v7
}

