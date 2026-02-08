module 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::cross_adapter {
    public fun cetus_flipped_swap_bluefin_open<T0, T1>(arg0: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::TraderAccount, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T0>, arg6: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T1>, arg7: bool, arg8: u64, arg9: u64, arg10: u32, arg11: u32, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::assert_owner(arg0, arg14);
        if (arg8 > 0) {
            let v0 = !arg7;
            let v1 = if (v0) {
                4295048016 + 1
            } else {
                79226673515401279992447579055 - 1
            };
            0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::cetus_adapter::swap_in_vault<T1, T0>(arg0, arg3, arg4, arg6, arg5, v0, true, arg8, arg9, v1, arg13, arg14);
        };
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::bluefin_adapter::add_liquidity_v3<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg10, arg11, arg12, arg13, arg14);
    }

    public fun cetus_flipped_swap_bluefin_rebalance<T0, T1>(arg0: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::TraderAccount, arg1: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T0>, arg7: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T1>, arg8: &0x2::clock::Clock, arg9: bool, arg10: u64, arg11: u64, arg12: u32, arg13: u32, arg14: bool, arg15: &mut 0x2::tx_context::TxContext) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::bluefin_adapter::burn_position_v2<T0, T1>(arg1, arg2, arg3, arg6, arg7, arg8);
        if (arg10 > 0) {
            let v0 = !arg9;
            let v1 = if (v0) {
                4295048016 + 1
            } else {
                79226673515401279992447579055 - 1
            };
            0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::cetus_adapter::swap_in_vault<T1, T0>(arg0, arg4, arg5, arg7, arg6, v0, true, arg10, arg11, v1, arg8, arg15);
        };
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::bluefin_adapter::add_liquidity_v3<T0, T1>(arg0, arg2, arg3, arg6, arg7, arg12, arg13, arg14, arg8, arg15);
    }

    public fun cetus_swap_bluefin_open<T0, T1>(arg0: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::TraderAccount, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T0>, arg6: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T1>, arg7: bool, arg8: u64, arg9: u64, arg10: u32, arg11: u32, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::assert_owner(arg0, arg14);
        if (arg8 > 0) {
            let v0 = if (arg7) {
                4295048016 + 1
            } else {
                79226673515401279992447579055 - 1
            };
            0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::cetus_adapter::swap_in_vault<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, true, arg8, arg9, v0, arg13, arg14);
        };
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::bluefin_adapter::add_liquidity_v3<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg10, arg11, arg12, arg13, arg14);
    }

    public fun cetus_swap_bluefin_rebalance<T0, T1>(arg0: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::TraderAccount, arg1: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T0>, arg7: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T1>, arg8: &0x2::clock::Clock, arg9: bool, arg10: u64, arg11: u64, arg12: u32, arg13: u32, arg14: bool, arg15: &mut 0x2::tx_context::TxContext) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::bluefin_adapter::burn_position_v2<T0, T1>(arg1, arg2, arg3, arg6, arg7, arg8);
        if (arg10 > 0) {
            let v0 = if (arg9) {
                4295048016 + 1
            } else {
                79226673515401279992447579055 - 1
            };
            0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::cetus_adapter::swap_in_vault<T0, T1>(arg0, arg4, arg5, arg6, arg7, arg9, true, arg10, arg11, v0, arg8, arg15);
        };
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::bluefin_adapter::add_liquidity_v3<T0, T1>(arg0, arg2, arg3, arg6, arg7, arg12, arg13, arg14, arg8, arg15);
    }

    public fun mmt_flipped_swap_bluefin_open<T0, T1>(arg0: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::TraderAccount, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T0>, arg6: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T1>, arg7: bool, arg8: u64, arg9: u64, arg10: u32, arg11: u32, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::assert_owner(arg0, arg14);
        if (arg8 > 0) {
            let v0 = !arg7;
            let v1 = if (v0) {
                4295048016 + 1
            } else {
                79226673515401279992447579055 - 1
            };
            0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::mmt_adapter::swap_in_vault<T1, T0>(arg0, arg3, arg6, arg5, v0, true, arg8, arg9, v1, arg13, arg4, arg14);
        };
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::bluefin_adapter::add_liquidity_v3<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg10, arg11, arg12, arg13, arg14);
    }

    public fun mmt_flipped_swap_bluefin_rebalance<T0, T1>(arg0: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::TraderAccount, arg1: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T0>, arg7: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T1>, arg8: &0x2::clock::Clock, arg9: bool, arg10: u64, arg11: u64, arg12: u32, arg13: u32, arg14: bool, arg15: &mut 0x2::tx_context::TxContext) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::bluefin_adapter::burn_position_v2<T0, T1>(arg1, arg2, arg3, arg6, arg7, arg8);
        if (arg10 > 0) {
            let v0 = !arg9;
            let v1 = if (v0) {
                4295048016 + 1
            } else {
                79226673515401279992447579055 - 1
            };
            0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::mmt_adapter::swap_in_vault<T1, T0>(arg0, arg4, arg7, arg6, v0, true, arg10, arg11, v1, arg8, arg5, arg15);
        };
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::bluefin_adapter::add_liquidity_v3<T0, T1>(arg0, arg2, arg3, arg6, arg7, arg12, arg13, arg14, arg8, arg15);
    }

    public fun mmt_swap_bluefin_open<T0, T1>(arg0: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::TraderAccount, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T0>, arg6: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T1>, arg7: bool, arg8: u64, arg9: u64, arg10: u32, arg11: u32, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::assert_owner(arg0, arg14);
        if (arg8 > 0) {
            let v0 = if (arg7) {
                4295048016 + 1
            } else {
                79226673515401279992447579055 - 1
            };
            0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::mmt_adapter::swap_in_vault<T0, T1>(arg0, arg3, arg5, arg6, arg7, true, arg8, arg9, v0, arg13, arg4, arg14);
        };
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::bluefin_adapter::add_liquidity_v3<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg10, arg11, arg12, arg13, arg14);
    }

    public fun mmt_swap_bluefin_rebalance<T0, T1>(arg0: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::account::TraderAccount, arg1: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T0>, arg7: &mut 0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::vault::Vault<T1>, arg8: &0x2::clock::Clock, arg9: bool, arg10: u64, arg11: u64, arg12: u32, arg13: u32, arg14: bool, arg15: &mut 0x2::tx_context::TxContext) {
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::bluefin_adapter::burn_position_v2<T0, T1>(arg1, arg2, arg3, arg6, arg7, arg8);
        if (arg10 > 0) {
            let v0 = if (arg9) {
                4295048016 + 1
            } else {
                79226673515401279992447579055 - 1
            };
            0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::mmt_adapter::swap_in_vault<T0, T1>(arg0, arg4, arg6, arg7, arg9, true, arg10, arg11, v0, arg8, arg5, arg15);
        };
        0x1eafada0672ad3939134223bca1638124b1bd5512bf88398cf3bbc451b983c8c::bluefin_adapter::add_liquidity_v3<T0, T1>(arg0, arg2, arg3, arg6, arg7, arg12, arg13, arg14, arg8, arg15);
    }

    // decompiled from Move bytecode v6
}

