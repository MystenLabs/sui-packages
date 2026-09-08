module 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v2_execution {
    public fun maybe_bay_x_to_y<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg1)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_uncorrelated<T2>(), 500);
        0x1::option::some<0x2::coin::Coin<T1>>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_x_for_coin_y<T0, T1, T2>(arg0, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1), 0, arg2))
    }

    public fun maybe_bay_y_to_x<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg1)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_uncorrelated<T2>(), 500);
        0x1::option::some<0x2::coin::Coin<T0>>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_y_for_coin_x<T0, T1, T2>(arg0, 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg1), 0, arg2))
    }

    public fun maybe_flowx<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg1)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        0x1::option::some<0x2::coin::Coin<T1>>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1), arg2))
    }

    public fun maybe_interest_x_to_y<T0, T1, T2>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<0x2::coin::Coin<T1>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T2>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T2>>()
        };
        assert!(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::is_volatile<T0>(), 500);
        0x1::option::some<0x2::coin::Coin<T2>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::swap_token_x<T0, T1, T2>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg2), 0, arg3))
    }

    public fun maybe_interest_y_to_x<T0, T1, T2>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<0x2::coin::Coin<T2>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T2>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T2>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        assert!(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::is_volatile<T0>(), 500);
        0x1::option::some<0x2::coin::Coin<T1>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::swap_token_y<T0, T1, T2>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<T2>>(arg2), 0, arg3))
    }

    public fun maybe_suidex_x_to_y<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::Router, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg2: &mut 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        0x1::option::some<0x2::coin::Coin<T1>>(0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::swap_exact_tokens0_for_tokens1_composable<T0, T1>(arg0, arg1, arg2, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg4), 1, arg3, arg5))
    }

    public fun maybe_suidex_y_to_x<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::Router, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg2: &mut 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x1::option::Option<0x2::coin::Coin<T1>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::swap_exact_tokens1_for_tokens0_composable<T0, T1>(arg0, arg1, arg2, 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg4), 1, arg3, arg5))
    }

    public fun maybe_suiswap_x_to_y<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, v0);
        let (v2, v3) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg0, v1, 0x2::coin::value<T0>(&v0), arg1, arg3);
        0x2::coin::destroy_zero<T0>(v2);
        0x1::option::some<0x2::coin::Coin<T1>>(v3)
    }

    public fun maybe_suiswap_y_to_x<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<0x2::coin::Coin<T1>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg2);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, v0);
        let (v2, v3) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg0, v1, 0x2::coin::value<T1>(&v0), arg1, arg3);
        0x2::coin::destroy_zero<T1>(v2);
        0x1::option::some<0x2::coin::Coin<T0>>(v3)
    }

    // decompiled from Move bytecode v7
}

