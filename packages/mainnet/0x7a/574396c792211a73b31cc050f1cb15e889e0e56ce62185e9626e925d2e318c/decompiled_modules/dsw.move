module 0x7a574396c792211a73b31cc050f1cb15e889e0e56ce62185e9626e925d2e318c::dsw {
    public fun d3a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::Fund, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::swap_exact_base_for_quote<T0, T1>(arg2, arg1, 0x2::coin::from_balance<T0>(arg3, arg4), 0, arg0, arg4);
        transfer_or_destory<T0>(v0, arg4);
        0x2::coin::into_balance<T1>(v1)
    }

    fun transfer_or_destory<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

