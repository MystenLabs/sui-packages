module 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::route_wrappers {
    public fun cetus_cetus_cetus<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: u256, arg4: u128, arg5: u64) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::OptimizeResult {
        let v0 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T0, T1>(arg0, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T1, T2>(arg1, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T2, T0>(arg2, true));
        if (!0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::passes_marginal_gate(&v0, arg3)) {
            return 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::coarse_rejection()
        };
        let v2 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>();
        let v3 = &mut v2;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T0, T1>(arg0, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T1, T2>(arg1, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T2, T0>(arg2, true));
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::optimize_staged(v0, v2, arg4, arg5)
    }

    public fun cetus_cetus_cetus_progressive<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u256, arg4: u128, arg5: u64, arg6: u64) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::OptimizeResult {
        let v0 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T0, T1>(arg0, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T1, T2>(arg1, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T0, T2>(arg2, false));
        if (!0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::passes_marginal_gate(&v0, arg3)) {
            return 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::coarse_rejection()
        };
        let (v2, v3) = 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_progressive_start<T0, T1>(arg0, true);
        let v4 = v3;
        let (v5, v6) = 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_progressive_start<T1, T2>(arg1, true);
        let v7 = v6;
        let (v8, v9) = 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_progressive_start<T0, T2>(arg2, false);
        let v10 = v9;
        let v11 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>();
        let v12 = &mut v11;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v12, v2);
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v12, v5);
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v12, v8);
        let v13 = 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::coefficient_state_staged(v0, v11, arg4, arg5);
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::resume_coefficients(&mut v13);
        let v14 = 0;
        let v15;
        loop {
            if (!0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::progress_needs_boundary(&v13) || v14 == arg6) {
                return 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::progress_result(&v13)
            };
            v15 = 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::progress_result(&v13);
            let v16 = 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::needs_more_hop(&v15);
            let v17 = v16 == 0 && 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_progressive_has_more(&v4) || v16 == 1 && 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_progressive_has_more(&v7) || v16 == 2 && 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_progressive_has_more(&v10);
            if (!v17) {
                return v15
            };
            let v18 = if (v16 == 0) {
                0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_progressive_next<T0, T1>(arg0, &mut v4)
            } else if (v16 == 1) {
                0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_progressive_next<T1, T2>(arg1, &mut v7)
            } else if (v16 == 2) {
                0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_progressive_next<T0, T2>(arg2, &mut v10)
            } else {
                break
            };
            0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::progress_append_boundaries(&mut v13, v16, v18);
            v14 = v14 + 1;
            0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::resume_coefficients(&mut v13);
        };
        v15
    }

    public fun cetus_triangle_sorted<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u256, arg4: u128, arg5: u64) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::OptimizeResult {
        let v0 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T0, T1>(arg0, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T1, T2>(arg1, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T0, T2>(arg2, false));
        if (!0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::passes_marginal_gate(&v0, arg3)) {
            return 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::coarse_rejection()
        };
        let v2 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>();
        let v3 = &mut v2;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T0, T1>(arg0, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T1, T2>(arg1, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T0, T2>(arg2, false));
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::optimize_staged(v0, v2, arg4, arg5)
    }

    public fun cetus_triangle_sorted_reverse<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u256, arg4: u128, arg5: u64) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::OptimizeResult {
        let v0 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T0, T2>(arg2, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T1, T2>(arg1, false));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T0, T1>(arg0, false));
        if (!0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::passes_marginal_gate(&v0, arg3)) {
            return 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::coarse_rejection()
        };
        let v2 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>();
        let v3 = &mut v2;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T0, T2>(arg2, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T1, T2>(arg1, false));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T0, T1>(arg0, false));
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::optimize_staged(v0, v2, arg4, arg5)
    }

    public fun cetus_two_pool_roundtrip<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u256, arg3: u128, arg4: u64) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::OptimizeResult {
        let v0 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T0, T1>(arg0, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T0, T1>(arg1, false));
        if (!0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::passes_marginal_gate(&v0, arg2)) {
            return 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::coarse_rejection()
        };
        let v2 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>();
        let v3 = &mut v2;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T0, T1>(arg0, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T0, T1>(arg1, false));
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::optimize_staged(v0, v2, arg3, arg4)
    }

    public fun flowx_cetus_flowx<T0, T1, T2>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: u256, arg3: u128, arg4: u64) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::OptimizeResult {
        let v0 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v2_adapters::flowx_container_x_to_y<T0, T1>(arg0));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T1, T2>(arg1, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v2_adapters::flowx_container_x_to_y<T2, T0>(arg0));
        if (!0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::passes_marginal_gate(&v0, arg2)) {
            return 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::coarse_rejection()
        };
        let v2 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>();
        let v3 = &mut v2;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::reuse_current_stage());
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T1, T2>(arg1, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::reuse_current_stage());
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::optimize_staged(v0, v2, arg3, arg4)
    }

    public fun flowx_cetus_momentum_flowx<T0, T1, T2, T3>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg3: u256, arg4: u128, arg5: u64) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::OptimizeResult {
        let v0 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v2_adapters::flowx_container_x_to_y<T0, T1>(arg0));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T1, T2>(arg1, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::momentum_current<T2, T3>(arg2, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v2_adapters::flowx_container_x_to_y<T3, T0>(arg0));
        if (!0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::passes_marginal_gate(&v0, arg3)) {
            return 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::coarse_rejection()
        };
        let v2 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>();
        let v3 = &mut v2;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::reuse_current_stage());
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T1, T2>(arg1, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::momentum_after_gate<T2, T3>(arg2, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::reuse_current_stage());
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::optimize_staged(v0, v2, arg4, arg5)
    }

    public fun flowx_container_cetus_roundtrip<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u256, arg3: u128, arg4: u64) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::OptimizeResult {
        let v0 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v2_adapters::flowx_container_x_to_y<T0, T1>(arg0));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T1, T0>(arg1, true));
        if (!0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::passes_marginal_gate(&v0, arg2)) {
            return 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::coarse_rejection()
        };
        let v2 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>();
        let v3 = &mut v2;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::reuse_current_stage());
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T1, T0>(arg1, true));
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::optimize_staged(v0, v2, arg3, arg4)
    }

    public fun flowx_container_cetus_roundtrip_reverse<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u256, arg3: u128, arg4: u64) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::OptimizeResult {
        let v0 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v2_adapters::flowx_container_y_to_x<T0, T1>(arg0));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T1, T0>(arg1, false));
        if (!0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::passes_marginal_gate(&v0, arg2)) {
            return 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::coarse_rejection()
        };
        let v2 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>();
        let v3 = &mut v2;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::reuse_current_stage());
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T1, T0>(arg1, false));
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::optimize_staged(v0, v2, arg3, arg4)
    }

    public fun fullsail_fullsail_cetus<T0, T1, T2>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u256, arg4: u128, arg5: u64) : 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::OptimizeResult {
        let v0 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::fullsail_current<T0, T1>(arg0, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::fullsail_current<T1, T2>(arg1, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::Hop>(v1, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_current<T0, T2>(arg2, false));
        if (!0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::passes_marginal_gate(&v0, arg3)) {
            return 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::coarse_rejection()
        };
        let v2 = 0x1::vector::empty<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>();
        let v3 = &mut v2;
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::fullsail_after_gate<T0, T1>(arg0, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::fullsail_after_gate<T1, T2>(arg1, true));
        0x1::vector::push_back<0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::StagedHop>(v3, 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::v3_adapters::cetus_after_gate<T0, T2>(arg2, false));
        0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::optimizer::optimize_staged(v0, v2, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

