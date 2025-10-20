module 0xa8d2ffe094040bff51bc999dbfbc4dc7e9a7610af23ed6a0a2d83f290efc99ac::jk {
    struct P has copy, drop {
        profit: u64,
    }

    public fun d3a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::Fund, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::swap_exact_base_for_quote<T0, T1>(arg2, arg1, 0x2::coin::from_balance<T0>(arg3, arg4), 0, arg0, arg4);
        transfer_or_destory<T0>(v0, arg4);
        0x2::coin::into_balance<T1>(v1)
    }

    public fun d3b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::Fund, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::swap_exact_quote_for_base<T0, T1>(arg2, arg1, 0x2::coin::from_balance<T1>(arg3, arg4), 0, arg0, arg4);
        transfer_or_destory<T1>(v1, arg4);
        0x2::coin::into_balance<T0>(v0)
    }

    fun transfer_or_destory<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun xz<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = P{profit: v0};
        0x2::event::emit<P>(v1);
        assert!(v0 >= arg2, 14680078);
        0x2::coin::join<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg3));
    }

    // decompiled from Move bytecode v6
}

