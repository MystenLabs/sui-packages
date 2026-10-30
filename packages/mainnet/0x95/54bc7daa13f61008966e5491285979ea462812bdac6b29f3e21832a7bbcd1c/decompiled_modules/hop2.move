module 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::hop2 {
    public fun cetus_2hop_ab_ab<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u128, arg6: u128, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_positive_min_out(arg4);
        let (v0, v1) = 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::dex::cetus_swap_a_to_b<T0, T1>(arg0, arg1, arg3, 1, arg5, arg7);
        let v2 = v0;
        hop1_check(0x2::balance::value<T1>(&v2));
        let (v3, v4) = 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::dex::cetus_swap_a_to_b<T1, T2>(arg0, arg2, v2, arg4, arg6, arg7);
        (v3, v1, v4)
    }

    public fun cetus_2hop_ab_ba<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u128, arg6: u128, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_positive_min_out(arg4);
        let (v0, v1) = 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::dex::cetus_swap_a_to_b<T0, T1>(arg0, arg1, arg3, 1, arg5, arg7);
        let v2 = v0;
        hop1_check(0x2::balance::value<T1>(&v2));
        let (v3, v4) = 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::dex::cetus_swap_b_to_a<T2, T1>(arg0, arg2, v2, arg4, arg6, arg7);
        (v3, v1, v4)
    }

    public fun cetus_2hop_ba_ab<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u128, arg6: u128, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_positive_min_out(arg4);
        let (v0, v1) = 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::dex::cetus_swap_b_to_a<T1, T0>(arg0, arg1, arg3, 1, arg5, arg7);
        let v2 = v0;
        hop1_check(0x2::balance::value<T1>(&v2));
        let (v3, v4) = 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::dex::cetus_swap_a_to_b<T1, T2>(arg0, arg2, v2, arg4, arg6, arg7);
        (v3, v1, v4)
    }

    public fun cetus_2hop_ba_ba<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u128, arg6: u128, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_positive_min_out(arg4);
        let (v0, v1) = 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::dex::cetus_swap_b_to_a<T1, T0>(arg0, arg1, arg3, 1, arg5, arg7);
        let v2 = v0;
        hop1_check(0x2::balance::value<T1>(&v2));
        let (v3, v4) = 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::dex::cetus_swap_b_to_a<T2, T1>(arg0, arg2, v2, arg4, arg6, arg7);
        (v3, v1, v4)
    }

    fun hop1_check(arg0: u64) {
        assert!(arg0 > 0, 170);
    }

    // decompiled from Move bytecode v7
}

