module 0x2b5f8a7cb5ab884ee4f2bd72025146c562f9f81be852562f2aecbc61c57bba46::qm {
    public fun aa<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::balance::Balance<T1>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0x2::coin::into_balance<T2>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T1>(arg6, arg7), 0, 0, arg7))
    }

    public fun f3a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: u64, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg3);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, true, true, 0x2::balance::value<T0>(&arg4), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price(), arg2, arg0, arg5);
        0x2::balance::destroy_zero<T0>(v1);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v3, arg4, 0x2::balance::zero<T1>(), arg2, arg5);
        v2
    }

    public fun f3b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg3);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, false, true, 0x2::balance::value<T1>(&arg4), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price(), arg2, arg0, arg5);
        0x2::balance::destroy_zero<T1>(v2);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v3, 0x2::balance::zero<T0>(), arg4, arg2, arg5);
        v1
    }

    public fun fa<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), arg2))
    }

    public fun fb<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T1, T0>(arg0, 0x2::coin::from_balance<T1>(arg1, arg2), arg2))
    }

    public fun fsa<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg1, arg2, arg3, true, true, 0x2::balance::value<T0>(&arg6), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick_math::min_sqrt_price(), arg4, arg5, arg0);
        0x2::balance::destroy_zero<T0>(v0);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg3, arg6, 0x2::balance::zero<T1>(), v2);
        v1
    }

    public fun fsb<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg1, arg2, arg3, false, true, 0x2::balance::value<T1>(&arg6), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick_math::max_sqrt_price(), arg4, arg5, arg0);
        0x2::balance::destroy_zero<T1>(v1);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg3, 0x2::balance::zero<T0>(), arg6, v2);
        v0
    }

    public fun moa<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&arg3), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg0, arg2, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v2, arg3, 0x2::balance::zero<T1>(), arg2, arg4);
        v1
    }

    public fun mob<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&arg3), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg0, arg2, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v2, 0x2::balance::zero<T0>(), arg3, arg2, arg4);
        v0
    }

    public fun ta<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::from_balance<T0>(arg1, arg4));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v0, 0x2::balance::value<T0>(&arg1), 0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), true, @0x0, 18446744073709551615, arg2, arg3, arg4);
        0x2::coin::destroy_zero<T0>(v2);
        0x2::coin::into_balance<T1>(v1)
    }

    public fun tb<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, 0x2::coin::from_balance<T1>(arg1, arg4));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v0, 0x2::balance::value<T1>(&arg1), 0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), true, @0x0, 18446744073709551615, arg2, arg3, arg4);
        0x2::coin::destroy_zero<T1>(v2);
        0x2::coin::into_balance<T0>(v1)
    }

    // decompiled from Move bytecode v6
}

