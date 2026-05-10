module 0x1d19943e39f50755ad7b83c7f139c57de26d2d8e6ba4a0c3d9b0bdb01c42268a::r {
    struct LL<T0> {
        r: T0,
        a: u64,
    }

    struct SwapEvent has copy, drop {
        dex: u8,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
    }

    struct ProfitEvent<phantom T0> has copy, drop {
        profit: u64,
        recipient: address,
    }

    public fun assert_min_out(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 6);
    }

    public fun bluefin_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, true, true, v0, 4295048017);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        0x2::balance::destroy_zero<T0>(arg2);
        emit_swap(19, true, v0, 0x2::balance::value<T1>(&v5));
        v5
    }

    public fun bluefin_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, false, true, v0, 79226673515401279992447579054);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        0x2::balance::destroy_zero<T1>(arg2);
        emit_swap(19, false, v0, 0x2::balance::value<T0>(&v5));
        v5
    }

    public fun bluefin_flash_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, true, false, arg2, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>{
            r : v3,
            a : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3),
        };
        (v4, v1)
    }

    public fun bluefin_flash_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, false, false, arg2, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>{
            r : v3,
            a : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3),
        };
        (v4, v0)
    }

    public fun bluefin_repay_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let LL {
            r : v0,
            a : v1,
        } = arg3;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, v1), 0x2::balance::zero<T1>(), v0);
        arg2
    }

    public fun bluefin_repay_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: LL<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let LL {
            r : v0,
            a : v1,
        } = arg3;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v1), v0);
        arg2
    }

    public fun cetus_dependency_marker<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
    }

    fun emit_swap(arg0: u8, arg1: bool, arg2: u64, arg3: u64) {
        let v0 = SwapEvent{
            dex        : arg0,
            a2b        : arg1,
            amount_in  : arg2,
            amount_out : arg3,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public fun turbos_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, 0x2::coin::from_balance<T0>(arg2, arg4));
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v1, v0, 0, 4295048016, true, 0x2::tx_context::sender(arg4), 18446744073709551615, arg3, arg1, arg4);
        0x2::coin::destroy_zero<T0>(v3);
        let v4 = 0x2::coin::into_balance<T1>(v2);
        emit_swap(17, true, v0, 0x2::balance::value<T1>(&v4));
        v4
    }

    public fun turbos_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, 0x2::coin::from_balance<T1>(arg2, arg4));
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v1, v0, 0, 79226673515401279992447579055, true, 0x2::tx_context::sender(arg4), 18446744073709551615, arg3, arg1, arg4);
        0x2::coin::destroy_zero<T1>(v3);
        let v4 = 0x2::coin::into_balance<T0>(v2);
        emit_swap(17, false, v0, 0x2::balance::value<T0>(&v4));
        v4
    }

    public fun xz<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 >= arg1, 2);
        let v1 = ProfitEvent<T0>{
            profit    : v0,
            recipient : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProfitEvent<T0>>(v1);
        0x2::coin::from_balance<T0>(arg0, arg2)
    }

    // decompiled from Move bytecode v7
}

