module 0x64a9a1612701f1bc816b4dc3ef3be6d839056a426bf233680933d5abdca65997::d {
    public fun sxy<T0, T1>(arg0: &mut 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::Fund, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, 0, arg3, arg4);
        0x64a9a1612701f1bc816b4dc3ef3be6d839056a426bf233680933d5abdca65997::u::tod<T0>(v0, 0x2::tx_context::sender(arg4));
        v1
    }

    public fun syx<T0, T1>(arg0: &mut 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::Fund, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x951a01360d85b06722edf896852bf8005b81cdb26375235c935138987f629502::sponsored::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, 0, arg3, arg4);
        0x64a9a1612701f1bc816b4dc3ef3be6d839056a426bf233680933d5abdca65997::u::tod<T1>(v1, 0x2::tx_context::sender(arg4));
        v0
    }

    // decompiled from Move bytecode v6
}

