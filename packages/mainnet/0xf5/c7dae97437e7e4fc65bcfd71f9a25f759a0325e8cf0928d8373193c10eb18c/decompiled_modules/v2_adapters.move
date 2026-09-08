module 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v2_adapters {
    public fun bayswap<T0, T1, T2>(arg0: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LiquidityPool<T1, T2, T0>, arg1: bool) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop {
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_uncorrelated<T0>(), 200);
        let (v0, v1, _) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_amounts<T1, T2, T0>(arg0);
        let (v3, v4) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_fees_config<T1, T2, T0>(arg0);
        if (arg1) {
            0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::v2_hop((v0 as u128), (v1 as u128), v3, v4)
        } else {
            0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::v2_hop((v1 as u128), (v0 as u128), v3, v4)
        }
    }

    public fun bayswap_storage<T0, T1, T2>(arg0: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: bool) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop {
        bayswap<T0, T1, T2>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::borrow_pool<T1, T2, T0>(arg0), arg1)
    }

    public fun flowx_container_x_to_y<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop {
        flowx_x_to_y<T0, T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg0))
    }

    public fun flowx_container_y_to_x<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop {
        flowx_y_to_x<T0, T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg0))
    }

    public fun flowx_x_to_y<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(arg0);
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::v2_hop((v0 as u128), (v1 as u128), 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(arg0), 10000)
    }

    public fun flowx_y_to_x<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(arg0);
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::v2_hop((v1 as u128), (v0 as u128), 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(arg0), 10000)
    }

    public fun interest<T0, T1, T2>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::Pool<T0, T1, T2>, arg1: bool) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop {
        assert!(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::is_volatile<T0>(), 200);
        let (v0, v1, _) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::get_amounts<T0, T1, T2>(arg0);
        if (arg1) {
            0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::v2_hop((v0 as u128), (v1 as u128), 3, 1000)
        } else {
            0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::v2_hop((v1 as u128), (v0 as u128), 3, 1000)
        }
    }

    public fun interest_storage<T0, T1, T2>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: bool) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop {
        interest<T0, T1, T2>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::borrow_pool<T0, T1, T2>(arg0), arg1)
    }

    public fun suidex_x_to_y<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop {
        let (v0, v1, _) = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::get_reserves<T0, T1>(arg0);
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::v2_hop(to_u128(v0), to_u128(v1), 30, 10000)
    }

    public fun suidex_y_to_x<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop {
        let (v0, v1, _) = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::get_reserves<T0, T1>(arg0);
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::v2_hop(to_u128(v1), to_u128(v0), 30, 10000)
    }

    fun suiswap<T0, T1>(arg0: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: bool) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop {
        assert!(0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_pool_type<T0, T1>(arg0) == 100, 200);
        let (v0, v1, _) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::get_amounts<T0, T1>(arg0);
        let v3 = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_direction<T0, T1>(arg0);
        assert!(v3 == 200 || v3 == 201, 201);
        let (v4, v5, v6, v7) = if (arg1 && v3 == 200 || v3 == 201) {
            let v8 = 1000000000000;
            (v8 - (10000 - 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_admin<T0, T1>(arg0)) * (10000 - 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_th<T0, T1>(arg0)) * (10000 - 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_lp<T0, T1>(arg0)), v8, 0, 1)
        } else {
            let v9 = 100000000;
            (0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_lp<T0, T1>(arg0), 10000, v9 - (10000 - 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_admin<T0, T1>(arg0)) * (10000 - 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_th<T0, T1>(arg0)), v9)
        };
        let (v10, v11) = if (arg1) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::v2_hop_split_fee((v10 as u128), (v11 as u128), v4, v5, v6, v7)
    }

    public fun suiswap_x_to_y<T0, T1>(arg0: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop {
        suiswap<T0, T1>(arg0, true)
    }

    public fun suiswap_y_to_x<T0, T1>(arg0: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop {
        suiswap<T0, T1>(arg0, false)
    }

    fun to_u128(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 202);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v7
}

