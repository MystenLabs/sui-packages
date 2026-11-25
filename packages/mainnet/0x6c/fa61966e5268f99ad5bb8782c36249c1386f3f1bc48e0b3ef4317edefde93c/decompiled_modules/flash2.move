module 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::flash2 {
    public fun bluefin_cetus_aa<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u128, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::start_a2b_lim<T0, T1>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::swap_a2b_lim<T1, T0>(arg3, arg4, v0, arg5, arg10);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::finish_a2b<T0, T1>(arg0, arg1, v2, v1, arg8, arg9);
    }

    public fun bluefin_cetus_ab<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u128, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::start_a2b_lim<T0, T1>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::swap_b2a_lim<T0, T1>(arg3, arg4, v0, arg5, arg10);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::finish_a2b<T0, T1>(arg0, arg1, v2, v1, arg8, arg9);
    }

    public fun bluefin_cetus_ba<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: u128, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::start_b2a_lim<T1, T0>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::swap_a2b_lim<T1, T0>(arg3, arg4, v0, arg5, arg10);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::finish_b2a<T1, T0>(arg0, arg1, v2, v1, arg8, arg9);
    }

    public fun bluefin_cetus_bb<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: u128, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::start_b2a_lim<T1, T0>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::swap_b2a_lim<T0, T1>(arg3, arg4, v0, arg5, arg10);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::finish_b2a<T1, T0>(arg0, arg1, v2, v1, arg8, arg9);
    }

    public fun bluefin_momentum_ab<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u128, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: u128, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::start_a2b_lim<T0, T1>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::momentum::swap_b2a_lim<T0, T1>(arg3, v0, arg4, arg10, arg5, arg11);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::finish_a2b<T0, T1>(arg0, arg1, v2, v1, arg8, arg9);
    }

    public fun bluefin_momentum_ba<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: u128, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: u128, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::start_b2a_lim<T1, T0>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::momentum::swap_a2b_lim<T1, T0>(arg3, v0, arg4, arg10, arg5, arg11);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::finish_b2a<T1, T0>(arg0, arg1, v2, v1, arg8, arg9);
    }

    public fun cetus_bluefin_aa<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u128, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::start_a2b_lim<T0, T1>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::swap_a2b_lim<T1, T0>(arg3, arg4, v0, arg5, arg10);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::finish_a2b<T0, T1>(arg0, arg1, v2, v1, arg8, arg9);
    }

    public fun cetus_bluefin_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u128, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::start_a2b_lim<T0, T1>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::swap_b2a_lim<T0, T1>(arg3, arg4, v0, arg5, arg10);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::finish_a2b<T0, T1>(arg0, arg1, v2, v1, arg8, arg9);
    }

    public fun cetus_bluefin_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u128, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::start_b2a_lim<T1, T0>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::swap_a2b_lim<T1, T0>(arg3, arg4, v0, arg5, arg10);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::finish_b2a<T1, T0>(arg0, arg1, v2, v1, arg8, arg9);
    }

    public fun cetus_bluefin_bb<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u128, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::start_b2a_lim<T1, T0>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::bluefin::swap_b2a_lim<T0, T1>(arg3, arg4, v0, arg5, arg10);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::finish_b2a<T1, T0>(arg0, arg1, v2, v1, arg8, arg9);
    }

    public fun cetus_cetus_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u128, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: bool, arg6: u64, arg7: u64, arg8: address, arg9: &0x2::clock::Clock) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::start_a2b_lim<T0, T1>(arg0, arg1, arg5, arg6, arg2, arg9);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::swap_b2a_lim<T0, T1>(arg0, arg3, v0, arg4, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg8);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::finish_a2b<T0, T1>(arg0, arg1, v2, v1, arg7, arg8);
    }

    public fun cetus_cetus_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u128, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u128, arg5: bool, arg6: u64, arg7: u64, arg8: address, arg9: &0x2::clock::Clock) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::start_b2a_lim<T1, T0>(arg0, arg1, arg5, arg6, arg2, arg9);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::swap_a2b_lim<T1, T0>(arg0, arg3, v0, arg4, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg8);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::finish_b2a<T1, T0>(arg0, arg1, v2, v1, arg7, arg8);
    }

    public fun cetus_momentum_aa<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u128, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: u128, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::start_a2b_lim<T0, T1>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::momentum::swap_a2b_lim<T1, T0>(arg3, v0, arg4, arg10, arg5, arg11);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::finish_a2b<T0, T1>(arg0, arg1, v2, v1, arg8, arg9);
    }

    public fun cetus_momentum_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u128, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: u128, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::start_a2b_lim<T0, T1>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::momentum::swap_b2a_lim<T0, T1>(arg3, v0, arg4, arg10, arg5, arg11);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::finish_a2b<T0, T1>(arg0, arg1, v2, v1, arg8, arg9);
    }

    public fun cetus_momentum_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u128, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: u128, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::start_b2a_lim<T1, T0>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::momentum::swap_a2b_lim<T1, T0>(arg3, v0, arg4, arg10, arg5, arg11);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::finish_b2a<T1, T0>(arg0, arg1, v2, v1, arg8, arg9);
    }

    public fun cetus_momentum_bb<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u128, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: u128, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: bool, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::start_b2a_lim<T1, T0>(arg0, arg1, arg6, arg7, arg2, arg10);
        let (v2, v3) = 0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::momentum::swap_b2a_lim<T0, T1>(arg3, v0, arg4, arg10, arg5, arg11);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::settle::send<T1>(v3, arg9);
        0x6cfa61966e5268f99ad5bb8782c36249c1386f3f1bc48e0b3ef4317edefde93c::cetus::finish_b2a<T1, T0>(arg0, arg1, v2, v1, arg8, arg9);
    }

    // decompiled from Move bytecode v7
}

