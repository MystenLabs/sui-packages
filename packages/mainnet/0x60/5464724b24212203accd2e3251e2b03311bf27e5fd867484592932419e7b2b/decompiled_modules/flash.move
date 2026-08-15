module 0xefb37677c5c43eb19e019186f0769be08dd42ab18ab1ba7d8dd0a8021d32ede1::flash {
    public fun bluefin_flash_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock) : 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>> {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>()
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg2, true, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::principal(arg0), 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T1>(arg0, 0, v1, arg3);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3))
    }

    public fun bluefin_flash_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock) : 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>> {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>()
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg2, false, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::principal(arg0), 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T0>(arg0, 0, v0, arg3);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3))
    }

    public fun bluefin_repay_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>>) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::close<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(arg3);
            return
        };
        let (v0, v1) = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::open<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(arg3);
        let v2 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take_final<T0>(arg0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v2, v1), 0x2::balance::zero<T1>(), v0);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::settle<T0>(arg0, v2);
    }

    public fun bluefin_repay_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>>) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::close<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(arg3);
            return
        };
        let (v0, v1) = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::open<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(arg3);
        let v2 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take_final<T1>(arg0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, v1), v0);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::settle<T1>(arg0, v2);
    }

    public fun cetus_flash_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: u64, arg5: &0x2::clock::Clock) : 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>> {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>()
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, arg3, true, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::principal(arg0), 4295048016, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T1>(arg0, 0, v1, arg4);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3))
    }

    public fun cetus_flash_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: u64, arg5: &0x2::clock::Clock) : 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>> {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>()
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, arg3, false, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::principal(arg0), 79226673515401279992447579055, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T0>(arg0, 0, v0, arg4);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3))
    }

    public fun cetus_repay_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>>) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::close<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(arg4);
            return
        };
        let (v0, v1) = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::open<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(arg4);
        let v2 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take_final<T0>(arg0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg1, arg2, arg3, 0x2::balance::split<T0>(&mut v2, v1), 0x2::balance::zero<T1>(), v0);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::settle<T0>(arg0, v2);
    }

    public fun cetus_repay_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>>) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::close<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(arg4);
            return
        };
        let (v0, v1) = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::open<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(arg4);
        let v2 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take_final<T1>(arg0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, v1), v0);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::settle<T1>(arg0, v2);
    }

    public fun deepbook_borrow_base<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>> {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>()
        };
        let v0 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::principal(arg0);
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, v0, arg2);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::seed<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v2, v0)
    }

    public fun deepbook_borrow_quote<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>> {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>()
        };
        let v0 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::principal(arg0);
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, v0, arg2);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::seed<T1>(arg0, 0x2::coin::into_balance<T1>(v1));
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v2, v0)
    }

    public fun deepbook_repay_base<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::close<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(arg2);
            return
        };
        let (v0, v1) = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::open<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(arg2);
        let v2 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take_final<T0>(arg0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v1), arg3), v0);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::settle<T0>(arg0, v2);
    }

    public fun deepbook_repay_quote<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::close<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(arg2);
            return
        };
        let (v0, v1) = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::open<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(arg2);
        let v2 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take_final<T1>(arg0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, v1), arg3), v0);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::settle<T1>(arg0, v2);
    }

    public fun dlmm_flash_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>> {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>()
        };
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap_with_partner<T0, T1>(arg3, arg4, true, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::principal(arg0), arg1, arg2, arg6, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T1>(arg0, 0, v1, arg5);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(v3, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v3))
    }

    public fun dlmm_flash_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>> {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>()
        };
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap_with_partner<T0, T1>(arg3, arg4, false, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::principal(arg0), arg1, arg2, arg6, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T0>(arg0, 0, v0, arg5);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(v3, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v3))
    }

    public fun dlmm_repay_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg4: 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>>) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::close<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(arg4);
            return
        };
        let (v0, v1) = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::open<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(arg4);
        let v2 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take_final<T0>(arg0);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap_with_partner<T0, T1>(arg2, arg3, 0x2::balance::split<T0>(&mut v2, v1), 0x2::balance::zero<T1>(), v0, arg1);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::settle<T0>(arg0, v2);
    }

    public fun dlmm_repay_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg4: 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>>) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::close<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(arg4);
            return
        };
        let (v0, v1) = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::open<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>>(arg4);
        let v2 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take_final<T1>(arg0);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap_with_partner<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, v1), v0, arg1);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::settle<T1>(arg0, v2);
    }

    public fun magma_flash_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock) : 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>> {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>()
        };
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::principal(arg0), 4295048016, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T1>(arg0, 0, v1, arg3);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v3))
    }

    public fun magma_flash_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock) : 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>> {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>()
        };
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::principal(arg0), 79226673515401279992447579055, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T0>(arg0, 0, v0, arg3);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(v3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v3))
    }

    public fun magma_repay_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>>) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::close<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(arg3);
            return
        };
        let (v0, v1) = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::open<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(arg3);
        let v2 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take_final<T0>(arg0);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v2, v1), 0x2::balance::zero<T1>(), v0);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::settle<T0>(arg0, v2);
    }

    public fun magma_repay_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x1::option::Option<0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::LL<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>>) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::close<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(arg3);
            return
        };
        let (v0, v1) = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll::open<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>>(arg3);
        let v2 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take_final<T1>(arg0);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, v1), v0);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::settle<T1>(arg0, v2);
    }

    // decompiled from Move bytecode v7
}

